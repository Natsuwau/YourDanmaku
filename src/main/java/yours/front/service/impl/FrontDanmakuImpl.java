package yours.front.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yours.dao.FrontDanmakuMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontDanmakuService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontDanmaku;
import yours.utils.MineStringUtils;

import java.util.List;

@Service
public class FrontDanmakuImpl extends BaseServiceImpl<FrontDanmaku>
        implements FrontDanmakuService {

    private static final Log logger = LogFactory
            .getLog(FrontCommentServiceImpl.class);
    @Autowired
    private QueryMapper queryMapper;

    private FrontDanmakuMapper frontDanmakuMapper;

    @Autowired
    public void setFrontCommentMapper(FrontDanmakuMapper frontDanmakuMapper) {
        this.frontDanmakuMapper = frontDanmakuMapper;
        super.setBaseMapper(frontDanmakuMapper);// 给BaseServiceImpl赋值
    }

    @Override
    public PageInfo<FrontDanmaku> findSomeByQueryHandler(
            QueryHandler queryHandler) throws Exception {
        List<FrontDanmaku> list = queryMapper.queryFrontDanmaku(queryHandler);
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
        PageInfo<FrontDanmaku> pageInfo = new PageInfo<FrontDanmaku>(
                (int) rootSize, nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }



    @Override
    public List<FrontDanmaku> findByVideoId(String vid) throws Exception {
        if (MineStringUtils.IsNullWhiteSpace(vid)){
            return null;
        }
        vid=vid.trim();
        QueryHandler qh=QueryHandler.create()
                .andColumnEqual("fv_id",vid)
                .OrderByASC("fd_time").set();

        PageInfo<FrontDanmaku> pageInfo=findSomeByQueryHandler(qh);

        return pageInfo.getBasePageList();
    }
}
