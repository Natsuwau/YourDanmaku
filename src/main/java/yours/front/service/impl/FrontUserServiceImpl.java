package yours.front.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import yours.dao.FrontUserMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontUserService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontUser;

import yours.utils.MineCommonUtils;
import yours.utils.MsgException;
import yours.utils.MineStringUtils;

import java.util.Date;
import java.util.List;

@Service
public class FrontUserServiceImpl extends BaseServiceImpl<FrontUser> implements
        FrontUserService {

    private static final Log logger = LogFactory
            .getLog(FrontUserServiceImpl.class);
    @Autowired
    private QueryMapper queryMapper;

    private FrontUserMapper frontUserMapper;

    @Autowired
    public void setFrontUserMapper(FrontUserMapper frontUserMapper) {
        this.frontUserMapper = frontUserMapper;
        super.setBaseMapper(frontUserMapper);// 给BaseServiceImpl赋值
    }

    @Override
    public PageInfo<FrontUser> findSomeByQueryHandler(QueryHandler queryHandler)
            throws Exception {
        List<FrontUser> list = queryMapper.queryFrontUser(queryHandler);
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
        PageInfo<FrontUser> pageInfo = new PageInfo<FrontUser>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }

    @Override
    public String changePassword(String id, String oldPassword,
                                 String newPassword) throws Exception {
        String errMsg = null;
        // 验证id是否存在
        FrontUser one = frontUserMapper.selectByPrimaryKey(id);
        if (one == null) {
            errMsg = "修改密码:id不存在！";
            logger.debug(errMsg);
            return errMsg;
        }
        // 对比旧密码
        String oldMD5Password = MineCommonUtils.getShiroMD5(id,
                SysInfo.SHIRO_MD5_HASHITERATIONS, oldPassword);
        if (one.getPassword().equals(oldMD5Password)) {
            String newMD5Password = MineCommonUtils.getShiroMD5(id,
                    SysInfo.SHIRO_MD5_HASHITERATIONS, newPassword);
            FrontUser temp = new FrontUser();
            temp.setId(id);
            temp.setPassword(newMD5Password);
            if (frontUserMapper.updateByPrimaryKeySelective(temp) == 1) {
                if (logger.isDebugEnabled()) {
                    logger.debug("更新密码成功!");
                }
            } else {
                errMsg = "修改密码:新密码更新失败!";
                logger.debug(errMsg);
            }
        } else {
            errMsg = "修改密码:旧密码验证失败!";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String changeIcon(String id, String newIconUrl) throws Exception {
        String errMsg = null;
        // 验证id是否存在
        FrontUser one = frontUserMapper.selectByPrimaryKey(id);
        if (one == null) {
            errMsg = "修改密码:id不存在！";
            logger.debug(errMsg);
            return errMsg;
        }
        FrontUser temp = new FrontUser();
        temp.setId(id);
        temp.setIcon(newIconUrl);
        if (frontUserMapper.updateByPrimaryKeySelective(temp) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("更新头像成功!");
            }
        } else {
            errMsg = "更新头像失败!";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public FrontUser login(String id, String password) throws MsgException,
            Exception {
        String errMsg = null;
        // 验证id是否存在
        FrontUser one = frontUserMapper.selectByPrimaryKey(id);
        if (one == null) {
            errMsg = "登录失败:指定id用户不存在！";
            logger.debug(errMsg);
            throw new MsgException(errMsg);
        }
        // 验证账号是否被冻结
        if (one.getState() == 0) {
            errMsg = "登录失败:账户被冻结！";
            logger.debug(errMsg);
            throw new MsgException(errMsg);
        }
        // 校验密码
        String xMD5Password = MineCommonUtils.getShiroMD5(id,
                SysInfo.SHIRO_MD5_HASHITERATIONS, password);
        if (one.getPassword().equals(xMD5Password)) {
            return one;
        } else {
            errMsg = "登录失败:密码不匹配！";
            logger.debug(errMsg);
            throw new MsgException(errMsg);
        }
    }

    @Override
    public String register(FrontUser one) throws Exception {
        String errMsg = null;
        if (one == null || MineStringUtils.IsNullOrWhiteSpace(one.getId())
                || MineStringUtils.IsNullOrWhiteSpace(one.getEmail())
                || MineStringUtils.IsNullOrWhiteSpace(one.getPassword())) {
            errMsg = "注册失败:数据不完整！";
            logger.debug(errMsg);
            return errMsg;
        }
        // 验证id是否存在
        if (frontUserMapper.selectByPrimaryKey(one.getId()) != null) {
            errMsg = "注册失败:id已存在！";
            logger.debug(errMsg);
            return errMsg;

        }
        // 加密密码
        String xMD5Password = MineCommonUtils.getShiroMD5(one.getId(),
                SysInfo.SHIRO_MD5_HASHITERATIONS, one.getPassword());
        one.setPassword(xMD5Password);
        one.setRegTime(new Date());//注册时间
        one.setState(1);//状态
        // 插入操作
        if (frontUserMapper.insertSelective(one) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("注册成功!");
            }
        } else {
            errMsg = "注册失败:注册失败！";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public int addCoin(String uid,int dCoin) throws MsgException, Exception {
        FrontUser one = frontUserMapper.selectByPrimaryKey(uid);
        if(one==null||dCoin<1){
            throw new MsgException("参数有误");
        }
        if(one.getState()!=1){
            throw new MsgException("用户状态非法...");
        }
        FrontUser temp = new FrontUser();
        temp.setId(one.getId());
        int coin = one.getCoin()+dCoin;
        temp.setCoin(coin);
        String result =  super.update(temp);
        if(!MineStringUtils.IsNullOrEmpty(result)){
            throw new MsgException(result);
        }
        if (logger.isDebugEnabled()) {
            logger.debug("用户硬币增加成功");
        }
        return coin;
    }
}
