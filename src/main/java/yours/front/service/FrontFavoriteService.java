package yours.front.service;

import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.pojo.FrontFavorite;
import yours.pojo.FrontUser;
import yours.pojo.FrontVideo;


//用户收藏夹服务
public interface FrontFavoriteService extends BaseService<FrontFavorite>{

    //通过查询条件收藏视频实体分页列表
    public PageInfo<FrontVideo> findFavoriteVideosByQueryHandler(QueryHandler queryHandler)throws Exception;

    //通过查询条件查询收藏用户实体分页列表
    public PageInfo<FrontUser> findFavoriteUsersByQueryHandler(QueryHandler queryHandler)throws Exception;

}
