package yours.front.service.impl;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yours.dao.FrontFavoriteMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontFavoriteService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontFavorite;
import yours.pojo.FrontUser;
import yours.pojo.FrontVideo;

import java.util.List;

/**收藏夹服务实现*/


@Service
public class FrontFavoriteServiceImpl extends BaseServiceImpl<FrontFavorite> implements FrontFavoriteService {

private static final Log logger=LogFactory.getLog(FrontFavoriteServiceImpl.class);

    @Autowired
    private QueryMapper queryMapper;

    private FrontFavoriteMapper frontFavoriteMapper;

    @Autowired
    public void setFrontFavoriteMapper(FrontFavoriteMapper frontFavoriteMapper){
        this.frontFavoriteMapper=frontFavoriteMapper;
        super.setBaseMapper(frontFavoriteMapper);//给BaseServiceImpl赋值
    }





    @Override
    public PageInfo<FrontFavorite> findSomeByQueryHandler(QueryHandler queryHandler) throws Exception {
        throw new UnsupportedOperationException();
    }

    @Override
    public PageInfo<FrontVideo> findFavoriteVideosByQueryHandler(QueryHandler queryHandler) throws Exception {

        List<FrontVideo> list=queryMapper.queryFavoriteVideos(queryHandler);
        long rootSize=0;
        int nowPage=1;
        int pageSize= SysInfo.PAGE_INFO_DEFAULT_SIZE;
        if (queryHandler==null||queryHandler.getLimitSentence()==null){
            if (logger.isDebugEnabled()){

                logger.debug("构造PageInfo:未指定分页信息。。。");
            }
            if (list!=null){
                rootSize=list.size();
            }

        }else {
            nowPage=queryHandler.getPageNumber();
            pageSize=queryHandler.getPageSize();
            //获取总记录数
            rootSize=queryMapper.findLastRows();

            if (logger.isDebugEnabled()){
                logger.debug("构造PageInfo,分页信息:rootSize=" + rootSize
                        + ",nowPage=" + nowPage + ",pageSize=" + pageSize);
            }
        }
        PageInfo<FrontVideo> pageInfo = new PageInfo<FrontVideo>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }


    @Override
    public PageInfo<FrontUser> findFavoriteUsersByQueryHandler(QueryHandler queryHandler) throws Exception {
        List<FrontUser> list = queryMapper.queryFavoriteUsers(queryHandler);
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
        PageInfo<FrontUser> pageInfo=new PageInfo<FrontUser>((int)rootSize,nowPage,pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }
}
