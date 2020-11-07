package yours.admin.service;

import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.utils.MsgException;

/**
 * 公共服务接口
 */
public interface BaseService<T> {

    /**
     * 增加一个实体
     * @param one
     * @return 添加结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String add(T one) throws Exception;

    /**
     * 更新一个实体
     * @param one 更新后信息
     * @return 更新结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String update(T one) throws Exception;

    /**
     * 删除一个实体
     * @param id 实体id
     * @return 删除结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String delete(String id) throws Exception;

    /**
     * 通过id查询实体
     * @param id 实体id
     * @return 实体
     * @throws MsgException,Exception
     */
    public T findOneById(String id) throws MsgException,Exception;

    /**
     * 通过查询添加查询实体分页列表
     * @param queryHandler 查询条件
     * @return 分页结果
     * @throws MsgException,Exception
     */
    public PageInfo<T> findSomeByQueryHandler(QueryHandler queryHandler) throws Exception;
}
