package yours.front.service;


import yours.pojo.FrontTask;
import yours.utils.MsgException;

public interface FrontTaskService extends BaseService<FrontTask> {

    //做任务

    public String doTask(String uid,int taskIndex,int dValue)throws Exception;

    //根据任务索引和用户id获取任务信息
    public FrontTask findTask(String uid,int taskIndex) throws MsgException,Exception;
}
