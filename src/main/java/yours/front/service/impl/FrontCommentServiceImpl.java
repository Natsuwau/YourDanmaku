package yours.front.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yours.dao.FrontCommentMapper;
import yours.dao.QueryMapper;
import yours.front.service.FrontCommentService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontComment;
import yours.utils.MineStringUtils;

import java.util.List;
@Service
public class FrontCommentServiceImpl extends BaseServiceImpl<FrontComment>
            implements FrontCommentService {

    private static final Log logger = LogFactory.getLog(FrontCommentServiceImpl.class);
    @Autowired
    private QueryMapper queryMapper;

    private FrontCommentMapper frontCommentMapper;
    @Autowired
    public void setFrontCommentMapper(FrontCommentMapper frontCommentMapper) {
        this.frontCommentMapper = frontCommentMapper;
        super.setBaseMapper(frontCommentMapper);//给BaseServiceImpl赋值
    }


    @Override
    public PageInfo<FrontComment> findSomeByQueryHandler(
            QueryHandler queryHandler) throws Exception {
        List<FrontComment> list = queryMapper.queryFrontComment(queryHandler);
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
        PageInfo<FrontComment> pageInfo = new PageInfo<FrontComment>((int) rootSize,
                nowPage, pageSize);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }


    @Override
    public PageInfo<FrontComment> findSomeByVid(String vid, ParamBag info) throws Exception {
        if (MineStringUtils.IsNullOrEmpty(vid)
                ||info==null
                ||info.getNowPage()==null
                ||info.getPageSize()==null){
            throw new Exception("参数有误");
        }
        Integer nowPage=info.getNowPage();
        Integer size=info.getPageSize();
        if (nowPage<0){
            nowPage=1;
        }
        if (size<1){
            size=SysInfo.PAGE_INFO_DEFAULT_SIZE;
        }
        long rootSize=0;

        List<FrontComment> list=frontCommentMapper.selectByVidWithUserInfo(vid,
                (nowPage-1)*size, size);

        rootSize=queryMapper.findLastRows();
        PageInfo<FrontComment>pageInfo=new PageInfo<>((int)rootSize,nowPage,size);
        pageInfo.setBasePageList(list);
        return pageInfo;
    }



}
