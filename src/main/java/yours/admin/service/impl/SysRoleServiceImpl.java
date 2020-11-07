package yours.admin.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yours.admin.service.SysRoleService;
import yours.dao.QueryMapper;
import yours.dao.ShipMapper;
import yours.dao.SysResourceMapper;
import yours.dao.SysRoleMapper;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.SysResource;
import yours.pojo.SysRole;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class SysRoleServiceImpl implements SysRoleService {

    private static final Log logger = LogFactory.getLog(SysRoleServiceImpl.class);
    @Autowired
    private SysRoleMapper sysRoleMapper;
    @Autowired
    private SysResourceMapper sysResourceMapper;
    @Autowired
    private QueryMapper queryMapper;
    @Autowired
    private ShipMapper shipMapper;

    @Override
    public String add(SysRole one) throws Exception {
        String errMsg = null;
        if (one == null) {
            errMsg = "添加系统角色校验失败:实体为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        // 使用uuid自动生成id
        String uuid = MineCommonUtils.getUUID_NoHyphen();
        one.setId(uuid);
        if (logger.isDebugEnabled()) {
            logger.debug("添加系统角色,自动生成id:" + uuid);
        }
        // 采用动态插入语句
        if (sysRoleMapper.insertSelective(one) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("添加系统角色成功:" + one.toString());
            }
        }else{
            errMsg = "添加系统角色失败!";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String update(SysRole one) throws Exception {
        String errMsg = null;
        if (one == null || MineStringUtils.IsNullOrWhiteSpace(one.getId())) {
            errMsg = "更新系统资源角色校验失败:实体为空或id为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        // 采用动态更新语句
        if (sysRoleMapper.updateByPrimaryKeySelective(one) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("更新系统角色信息成功:id=" + one.getId());
            }
        }else{
            errMsg = "更新系统角色信息失败！";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String delete(String id) throws Exception {
        String errMsg = null;
        if (MineStringUtils.IsNullOrWhiteSpace(id)) {
            errMsg = "根据id删除系统角色校验失败:id为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        if (sysRoleMapper.deleteByPrimaryKey(id) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("根据id删除系统角色成功,id:" + id);
            }
        } else {
            errMsg = "根据id删除系统角色失败,id:" + id;
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public SysRole findOneById(String id) throws MsgException,Exception {
        if (MineStringUtils.IsNullOrWhiteSpace(id)) {
            String str = "根据id查询系统角色校验失败:id为空!";
            logger.debug(str);
            throw new MsgException(str);
        }
        SysRole one = sysRoleMapper.selectByPrimaryKey(id);
        if (one == null) {
            if (logger.isDebugEnabled()) {
                logger.debug("根据id查询系统角色失败:id非法:" + id);
            }
        } else {
            if (logger.isDebugEnabled()) {
                logger.debug("根据id查询系统角色成功");
            }
        }
        return one;
    }

    @Override
    public PageInfo<SysRole> findSomeByQueryHandler(QueryHandler queryHandler)
            throws Exception {
        List<SysRole> list = queryMapper.querySysRole(queryHandler);
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
                logger.debug("构造PageInfo,分页信息:rootSize=" + rootSize
                        + ",nowPage=" + nowPage + ",pageSize=" + pageSize);
            }
        }
        PageInfo<SysRole> pageInfo = new PageInfo<SysRole>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }

    @Override
    @Transactional(rollbackFor = { SQLException.class,RuntimeException.class})
    public String updateRoleResourceShip(String id, Set<String> sysResourceIds)
            throws Exception {
        String errMsg = null;
        if (sysRoleMapper.selectByPrimaryKey(id) == null) {
            errMsg = "updateRoleResourceShip:id不存在!";
            logger.warn(errMsg);
            return errMsg;
        }
        //删除旧映射
        shipMapper.delRoleResourceShipWithSysRoleId(id);
        int size=0;
        if(sysResourceIds!=null&&(size=sysResourceIds.size())>0){
            int rows = shipMapper.addRoleResourceShipsByRoleIdAndResourceIds(id, sysResourceIds);
            if(rows!=size){
                errMsg = "updateRoleResourceShip:插入新映射失败,影响行数不正确！";
                logger.warn(errMsg);
            }
        }
        return errMsg;
    }

    @Override
    public Set<SysResource> findResources(String id) throws MsgException,Exception{
        if (sysRoleMapper.selectByPrimaryKey(id) == null) {
            String str = "findResources:角色id不存在！";
            logger.debug(str);
            throw new MsgException(str);
        }
        //手动构建set，只查询一名角色下属资源
        Set<String> set = new HashSet<String>();
        set.add(id);
        List<SysResource> list = sysResourceMapper.findWithSysRoleIds(set, true);
        return MineCommonUtils.convertListToSet(list);
    }
}
