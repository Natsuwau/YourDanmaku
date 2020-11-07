package yours.dao;

import org.apache.ibatis.annotations.Param;
import yours.pojo.FrontComment;

import java.util.List;

public interface FrontCommentMapper extends BaseMapper<FrontComment> {
    public List<FrontComment> selectByVidWithUserInfo(
            @Param("vid")String vid,
            @Param("pageIndex")Integer pageIndex,
            @Param("size")Integer size);
}