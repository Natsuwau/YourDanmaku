package yours.dao;

import yours.pojo.BasePojo;

//基础接口
public interface BaseMapper<T extends BasePojo> {

    public int deleteByPrimaryKey(String id);

    public int insert(T t);

    public int insertSelective(T t);

    public T selectByPrimaryKey(String id);

    public int updateByPrimaryKeySelective(T t);

    public int updateByPrimaryKey(T t);


}
