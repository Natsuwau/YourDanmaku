package yours.admin.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yours.admin.service.SysResourceService;
import yours.dao.QueryMapper;
import yours.dao.SysResourceMapper;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.SysResource;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import java.util.List;

@Service
public class SysResourceServiceImpl implements SysResourceService {

    private static final Log logger = LogFactory.getLog(SysRoleServiceImpl.class);
    @Autowired
    private SysResourceMapper sysResourceMapper;
    @Autowired
    private QueryMapper queryMapper;

    @Override
    public String add(SysResource one) throws Exception {
        String errMsg = null;
        if (one == null ) {
            errMsg="添加系统资源校验失败:实体为空.";
            logger.debug(errMsg);
            return errMsg;
        }
        //使用uuid自动生成id
        String uuid= MineCommonUtils.getUUID_NoHyphen();
        one.setId(uuid);
        if (logger.isDebugEnabled()) {
            logger.debug("添加系统资源,自动生成id:"+uuid);
        }
        // 初始化状态码为1,表示可用
        one.setState(1);
        // 采用动态插入语句
        if (sysResourceMapper.insertSelective(one) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("添加系统资源成功:"+one.toString());
            }
        }else{
            errMsg = "添加系统资源失败.";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String update(SysResource one) throws Exception {
        String errMsg = null;
        if (one == null || MineStringUtils.IsNullOrWhiteSpace(one.getId())) {
            errMsg = "更新系统资源信息校验失败:实体为空或id为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        // 采用动态更新语句
        if (sysResourceMapper.updateByPrimaryKeySelective(one) == 1) {
            if (logger.isDebugEnabled()) {
                logger.debug("更新系统资源信息成功:id="+one.getId());
            }
        }else{
            errMsg = "更新系统资源信息失败！";
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public String delete(String id) throws Exception {
        String errMsg = null;
        if (MineStringUtils.IsNullOrWhiteSpace(id)) {
            errMsg = "根据id删除系统资源校验失败:id为空!";
            logger.debug(errMsg);
            return errMsg;
        }
        if(sysResourceMapper.deleteByPrimaryKey(id)==1){
            if (logger.isDebugEnabled()) {
                logger.debug("根据id删除系统资源成功,id:"+id);
            }
        }else{
            errMsg = "根据id删除系统资源失败,id:"+id;
            logger.debug(errMsg);
        }
        return errMsg;
    }

    @Override
    public SysResource findOneById(String id) throws MsgException,Exception {
        if (MineStringUtils.IsNullOrWhiteSpace(id)) {
            String str = "根据id查询系统资源校验失败:id为空!";
            logger.debug(str);
            throw new MsgException(str);
        }
        SysResource one = sysResourceMapper.selectByPrimaryKey(id);
        if(one==null){
            if (logger.isDebugEnabled()) {
                logger.debug("根据id查询系统资源失败:id非法:"+id);
            }
        }else{
            if (logger.isDebugEnabled()) {
                logger.debug("根据id查询系统资源成功");
            }
        }
        return one;
    }

    @Override
    public PageInfo<SysResource> findSomeByQueryHandler(
            QueryHandler queryHandler) throws Exception {
        List<SysResource> list = queryMapper.querySysResource(queryHandler);
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
        PageInfo<SysResource> pageInfo = new PageInfo<SysResource>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }

}