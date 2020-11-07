package yours.dao;

import yours.pojo.FrontVideo;

import java.util.List;

public interface FrontVideoMapper  extends BaseMapper<FrontVideo> {
    public List<FrontVideo> selectByName(String name);
}