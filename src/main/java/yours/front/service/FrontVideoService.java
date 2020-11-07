package yours.front.service;

import yours.pojo.FrontVideo;
import yours.utils.MsgException;

import java.util.List;

public interface FrontVideoService extends BaseService<FrontVideo> {


    //通过名字查询视频
    public FrontVideo findOneByName(String name)throws Exception;

    //按照相关关键字查询视频
    public List<FrontVideo> findByKeys(List<String>keys,String banId)throws Exception;

    //增加一个点击量
    public long addOneHit(String vid)throws MsgException,Exception;

}
