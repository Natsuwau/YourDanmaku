package yours.front.service.impl;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yours.dao.FrontTaskMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontTaskService;
import yours.front.service.FrontUserService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.info.TaskInfo;
import yours.pojo.FrontTask;
import yours.utils.MineCommonUtils;
import yours.utils.MsgException;
import yours.utils.MineStringUtils;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

//任务

@Service
public class FrontTaskServiceImpl extends BaseServiceImpl<FrontTask>implements
        FrontTaskService {

    private static final Log logger= LogFactory.getLog(FrontTaskServiceImpl.class);

    @Autowired
    private QueryMapper queryMapper;

    @Autowired
    private FrontUserService frontUserService;

    private FrontTaskMapper frontTaskMapper;

    @Autowired
    public  void setFrontTaskMapper(FrontTaskMapper frontTaskMapper){
        this.frontTaskMapper=frontTaskMapper;
        super.setBaseMapper(frontTaskMapper);
    }

    @Override
    public PageInfo<FrontTask> findSomeByQueryHandler(QueryHandler queryHandler) throws Exception {


        List<FrontTask> list = queryMapper.queryFrontTask(queryHandler);
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
        PageInfo<FrontTask> pageInfo = new PageInfo<FrontTask>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }



    @Override
    @Transactional(rollbackFor = {MsgException.class, SQLException.class,RuntimeException.class})
    public String doTask(String uid, int taskIndex, int dValue) throws Exception {
        if (MineStringUtils.IsNullWhiteSpace(uid)||taskIndex<0)
        {
            return "做任务：参数有误";
        }

        FrontTask one=null;

        //查询指定任务在不在表中

        QueryHandler qh=QueryHandler.create().andColumnEqual("fu_id",uid)
                .andColumnEqual("fu_index",taskIndex+"").set();

        List<FrontTask> list=queryMapper.queryFrontTask(qh);

        if (list==null|list.size()<1){
            one=new FrontTask();
            String uuid= MineCommonUtils.getUUID_NoHyphen();
            one.setId(uuid);
            one.setFrontUserId(uid);
            one.setIndex(taskIndex);
            one.setDate(new Date());
            one.setNowNum(dValue);
            one.setState(1);
            int col=frontTaskMapper.insert(one);
            if (col!=1){
                return "做任务:添加任务失败";
            }
        }else {
            one=list.get(0);
            long start= MineCommonUtils.getTodayStartTime();
            long end= MineCommonUtils.getTodayEndTime();
            long time=one.getDate().getTime();
            if (time<=end&&time>=start){
                if (one.getNowNum()>= TaskInfo.getAllTask().get(taskIndex).getMaxNum()){
                    return "做任务：任务已经完成，无需再做..";
                }
                else {
                    one.setDate(new Date());
                    one.setNowNum(one.getNowNum()+dValue);
                }

            }else {
                one.setDate(new Date());
                one.setNowNum(dValue);
            }
            int col=frontTaskMapper.updateByPrimaryKeySelective(one);
            if (col!=1){
                return "做任务：修改任务进度失败";
            }
        }
        //验证任务是否已完成
        TaskInfo ti=TaskInfo.getAllTask().get(taskIndex);
        if (one.getNowNum()>=ti.getMaxNum()){
            //完成，奖励硬币
            frontUserService.addCoin(uid,ti.getCoin());
        }

        return null;
    }

    @Override
    public FrontTask findTask(String uid, int taskIndex) throws MsgException, Exception {
       if (MineStringUtils.IsNullWhiteSpace(uid)||taskIndex<0){
           throw new MsgException("做任务:参数有误");
       }
       //查询指定任务在不在表中
        QueryHandler qh=QueryHandler.create().andColumnEqual("fu_id",uid)
                .andColumnEqual("fu_index",taskIndex+"").set();

       List<FrontTask> list=queryMapper.queryFrontTask(qh);

       if (list==null||list.size()<1){
           return null;
       }else {
           return list.get(0);
       }

    }
}
