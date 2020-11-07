package yours.front.service;

import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.pojo.FrontComment;

public interface FrontCommentService extends BaseService<FrontComment> {

    public PageInfo<FrontComment> findSomeByVid(String vid, ParamBag  pageInfo)throws Exception;


}
