package yours.front.service;

import yours.pojo.FrontDanmaku;

import java.util.List;

public interface FrontDanmakuService extends BaseService<FrontDanmaku> {

    /**查询指定视频下的弹幕*/
    public List<FrontDanmaku> findByVideoId(String vid) throws Exception;
}
