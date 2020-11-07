package yours.front.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yours.dao.FrontHateWordMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontHateWordService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontHateWord;

import java.util.List;

@Service
public class FrontHateWordServiceImpl extends BaseServiceImpl<FrontHateWord>implements
        FrontHateWordService
{
    private static final Log logger = LogFactory
            .getLog(FrontHateWordServiceImpl.class);
    @Autowired
    private QueryMapper queryMapper;

    private FrontHateWordMapper frontHateWordMapper;

    @Autowired
    public void setFrontHateWordMapper(FrontHateWordMapper frontHateWordMapper) {
        this.frontHateWordMapper = frontHateWordMapper;
        super.setBaseMapper(frontHateWordMapper);// 给BaseServiceImpl赋值
    }

    @Override
    public PageInfo<FrontHateWord> findSomeByQueryHandler(QueryHandler queryHandler) throws Exception {
        List<FrontHateWord> list = queryMapper.queryFrontHateWord(queryHandler);
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
        PageInfo<FrontHateWord> pageInfo = new PageInfo<FrontHateWord>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }
}
