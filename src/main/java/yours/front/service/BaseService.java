package yours.front.service;

import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.pojo.BasePojo;
import yours.utils.MsgException;

public interface BaseService<T extends BasePojo> {

    //增加一个实体并自动生成uuid作为id

    public String addWithAutoId(T one)throws Exception;

    //增加一个实体

    public String add(T one) throws Exception;


    //更新一个实体

    public String update(T one)throws Exception;

    //更新一个实体State[会校验id,和state的值]

    public String updateState(String id,Integer state,Class<T> tClass)throws Exception;

    //删除一个实体

    public String delete(String id) throws Exception;

    //通过id查询实体

    public T findOneById(String id) throws MsgException,Exception;

    //通过查询条件查询实体分页列表

    public PageInfo<T> findSomeByQueryHandler(QueryHandler queryHandler)throws Exception;


}
