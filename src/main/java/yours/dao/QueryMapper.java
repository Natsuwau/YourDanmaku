package yours.dao;

import yours.info.QueryHandler;
import yours.pojo.*;

import java.util.List;

//封装一些特殊查询
public interface QueryMapper {

    /**
     * 条件获取系统用户信息
     */
    List<SysUser> querySysUser(QueryHandler queryHandler);

    /**
     * 条件获取系统角色信息
     */
    List<SysRole> querySysRole(QueryHandler queryHandler);

    /**
     * 条件获取系统资源信息
     */
    List<SysResource> querySysResource(QueryHandler queryHandler);

    /**
     * 条件获取前台用户信息
     */
    List<FrontUser> queryFrontUser(QueryHandler queryHandler);

    /**
     * 条件获取前台视频信息
     */
    List<FrontVideo> queryFrontVideo(QueryHandler queryHandler);

    /**
     * 条件获取前台弹幕信息
     */
    List<FrontDanmaku> queryFrontDanmaku(QueryHandler queryHandler);

    /**
     * 条件获取前台评论信息
     */
    List<FrontComment> queryFrontComment(QueryHandler queryHandler);

    /**
     * 条件获取前台任务信息
     */
    List<FrontTask> queryFrontTask(QueryHandler queryHandler);

    /**
     * 条件获取前台屏蔽关键字信息
     */
    List<FrontHateWord> queryFrontHateWord(QueryHandler queryHandler);

    /**
     * 条件获取前台收藏夹对应视频信息
     */
    List<FrontVideo> queryFavoriteVideos(QueryHandler queryHandler);

    /**
     * 条件获取前台收藏夹对应视频信息
     */
    List<FrontUser> queryFavoriteUsers(QueryHandler queryHandler);

    /**
     * 获取上次limit查询记录总数
     */
    long findLastRows();
}
