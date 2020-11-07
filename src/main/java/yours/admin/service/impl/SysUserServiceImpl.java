package yours.admin.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yours.admin.service.SysUserService;
import yours.dao.*;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.SysResource;
import yours.pojo.SysRole;
import yours.pojo.SysUser;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

@Service
public class SysUserServiceImpl implements SysUserService {

    private static final Log logger = LogFactory.getLog(SysUserServiceImpl.class);
    @Autowired
    private SysUserMapper sysUserMapper;
    @Autowired
    private SysRoleMapper sysRoleMapper;
    @Autowired
    private SysResourceMapper sysResourceMapper;
    @Autowired
    private QueryMapper queryMapper;
    @Autowired
    private ShipMapper shipMapper;

    @Override
    public String add(SysUser one) throws Exception {
        String errMsg = null;
        if (one == null || MineStringUtils.IsNullOrWhiteSpace(one.getId())) {
            errMsg = "添加系统用户校验失败:实体为空或id为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        // 密码非空校验
        if (MineStringUtils.IsNullOrWhiteSpace(one.getPassword())) {
            errMsg = "添加系统用户校验失败:密码为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        // 密码加密处理,使用shiro的加盐值MD5加密,盐值为用户id
        String md5Password = MineCommonUtils.getShiroMD5(one.getId(),
                SysInfo.SHIRO_MD5_HASHITERATIONS, one.getPassword());
        if (logger.isDebugEnabled()) {
            logger.debug("添加系统用户密码已加密:"+one.getPassword()+">>>"+md5Password);
        }
        one.setPassword(md5Password);
        // 验证用户id是否已存在
        if (sysUserMapper.selectByPrimaryKey(one.getId()) == null) {
            // 采用动态插入语句
            if (sysUserMapper.insertSelective(one) == 1) {
                if (logger.isDebugEnabled()) {
                    logger.debug("添加系统用户成功:"+one.toString());
                }
                return null;
            }else{
                errMsg = "添加系统用户失败!";
                logger.debug(errMsg);
            }
        } else {
            errMsg = "添加系统用户异常:用户id重复_"+one.getId();
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String update(SysUser one) throws Exception {
        String errMsg = null;
        if (one == null || MineStringUtils.IsNullOrWhiteSpace(one.getId())) {
            errMsg = "更新系统用户信息校验失败:实体为空或id为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        one.setPassword(null);
        one.setIcon(null);
        // 采用动态更新语句
        if (sysUserMapper.updateByPrimaryKeySelective(one) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("更新系统用户信息成功:id="+one.getId());
            }
        }else{
            errMsg = "更新系统用户信息失败！";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    /**
     * 删除方法不实现,更新信息中的状态变为0，即为账号冻结
     */
    @Override
    public String delete(String id) throws Exception {
        if (logger.isDebugEnabled()) {
            logger.debug("系统用户删除方法未实现!");
        }
        throw new UnsupportedOperationException();
    }

    @Override
    public SysUser findOneById(String id) throws MsgException,Exception {
        if (MineStringUtils.IsNullOrWhiteSpace(id)) {
            String str = "校验失败:id为空!";
            logger.debug(str);
            throw new MsgException(str);
        }
        SysUser one = sysUserMapper.selectByPrimaryKey(id);
        if(one==null){
            if (logger.isDebugEnabled()) {
                logger.debug("根据id查询系统用户失败:id非法:"+id);
            }
        }else{
            if (logger.isDebugEnabled()) {
                logger.debug("根据id查询系统用户成功");
            }
        }
        return one;
    }

    @Override
    public PageInfo<SysUser> findSomeByQueryHandler(QueryHandler queryHandler)
            throws Exception {
        List<SysUser> list = queryMapper.querySysUser(queryHandler);
        long rootSize = 0;
        int nowPage = 1;
        int pageSize = SysInfo.PAGE_INFO_DEFAULT_SIZE;
        if (queryHandler == null || queryHandler.getLimitSentence() == null) {// 没分页
            if (logger.isDebugEnabled()) {
                logger.debug("构造PageInfo:未指定分页信息...");
            }
            if (list != null) {
                rootSize = list.size();
            }
        } else {
            nowPage = queryHandler.getPageNumber();
            pageSize = queryHandler.getPageSize();
            // 获取总记录数
            rootSize = queryMapper.findLastRows();
            if (logger.isDebugEnabled()) {
                logger.debug("构造PageInfo,分页信息:rootSize=" + rootSize + ",nowPage="
                        + nowPage + ",pageSize=" + pageSize);
            }
        }
        //循环查找用户对应角色信息
        for (SysUser sysUser : list) {
            List<SysRole> sysRoles = sysRoleMapper.findWithSysUserId(sysUser.getId(), true);
            sysUser.setRoles(MineCommonUtils.convertListToSet(sysRoles));
        }
        PageInfo<SysUser> pageInfo = new PageInfo<SysUser>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }

    @Override
    public String changePassword(String id, String oldPassword,
                                 String newPassword) throws Exception {
        String errMsg = null;
        //验证id是否存在
        SysUser one = sysUserMapper.selectByPrimaryKey(id);
        if (one == null) {
            errMsg = "修改密码:id不存在！";
            logger.debug(errMsg);
            return errMsg;
        }
        //对比旧密码
        String oldMD5Password = MineCommonUtils.getShiroMD5(id,
                SysInfo.SHIRO_MD5_HASHITERATIONS, oldPassword);
        if(one.getPassword().equals(oldMD5Password)){
            String newMD5Password = MineCommonUtils.getShiroMD5(id,
                    SysInfo.SHIRO_MD5_HASHITERATIONS, newPassword);
            SysUser temp = new SysUser();
            temp.setId(id);
            temp.setPassword(newMD5Password);
            if(sysUserMapper.updateByPrimaryKeySelective(temp)==1){
                if (logger.isDebugEnabled()) {
                    logger.debug("更新密码成功!");
                }
            }else{
                errMsg = "修改密码:新密码更新失败!";
                logger.debug(errMsg);
            }
        }else{
            errMsg = "修改密码:旧密码验证失败!";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String changeIcon(String id, String newIconUrl) throws Exception {
        String errMsg = null;
        //验证id是否存在
        SysUser one = sysUserMapper.selectByPrimaryKey(id);
        if (one == null) {
            errMsg = "修改密码:id不存在！";
            logger.debug(errMsg);
            return errMsg;
        }
        SysUser temp = new SysUser();
        temp.setId(id);
        temp.setIcon(newIconUrl);
        if(sysUserMapper.updateByPrimaryKeySelective(temp)==1){
            if (logger.isDebugEnabled()) {
                logger.debug("更新头像成功!");
            }
        }else{
            errMsg = "更新头像失败!";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String resetPassword(String id) throws Exception {
        String errMsg = null;
        //验证id是否存在
        SysUser one = sysUserMapper.selectByPrimaryKey(id);
        if (one == null) {
            errMsg = "重置密码:id不存在！";
            logger.debug(errMsg);
            return errMsg;
        }
        String md5DefaultPassword = MineCommonUtils.getShiroMD5(id,
                SysInfo.SHIRO_MD5_HASHITERATIONS, SysInfo.SYSUSER_DEFAULT_PASSWORD);
        SysUser temp = new SysUser();
        temp.setId(id);
        temp.setPassword(md5DefaultPassword);
        if(sysUserMapper.updateByPrimaryKeySelective(temp)==1){
            if (logger.isDebugEnabled()) {
                logger.debug("重置密码成功!");
            }
        }else{
            errMsg = "重置密码失败!";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    //事务注解，因为涉及到先删除，后添加 可能会回滚
    @Transactional(rollbackFor = { SQLException.class, RuntimeException.class })
    public String updateUserRoleShip(String id, Set<String> sysRoleIds)
            throws Exception {
        String errMsg = null;
        //验证id是否存在
        if (sysUserMapper.selectByPrimaryKey(id) == null) {
            errMsg = "updateUserRoleShip:id不存在！";
            logger.debug(errMsg);
            return errMsg;
        }
        //先删除旧映射
        shipMapper.delUserRoleShipWithSysUserId(id);
        //再插入新映射
        int size=0;
        if(sysRoleIds!=null&&(size=sysRoleIds.size())>0){
            int rows = shipMapper.addUserRoleShipsByUserIdAndRoleIds(id, sysRoleIds);
            if(rows!=size){
                errMsg = "updateUserRoleShip:插入新映射失败,影响行数不正确！";
                logger.debug(errMsg);
            }
        }
        return errMsg;
    }

    @Override
    public Set<SysRole> findSysRoles(String id) throws MsgException,Exception {
        if (sysUserMapper.selectByPrimaryKey(id) == null) {
            String str = "findRoles:用户id不存在！";
            logger.debug(str);
            throw new MsgException(str);
        }
        List<SysRole> list = sysRoleMapper.findWithSysUserId(id, true);
        return MineCommonUtils.convertListToSet(list);
    }

    @Override
    public Set<SysResource> findResources(String id) throws MsgException,Exception {
        if (sysUserMapper.selectByPrimaryKey(id) == null) {
            String str = "findResources:用户id不存在！";
            logger.debug(str);
            throw new MsgException(str);
        }
        List<String> sysRoles = sysRoleMapper.findIdsWithSysUserId(id, true);
        if(sysRoles==null||sysRoles.size()<1){
            return null;
        }
        List<SysResource> list = sysResourceMapper.findWithSysRoleIds(MineCommonUtils.convertListToSet(sysRoles), true);
        return MineCommonUtils.convertListToSet(list);
    }
}
