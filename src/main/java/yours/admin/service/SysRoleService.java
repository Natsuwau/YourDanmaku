package yours.admin.service;

import yours.pojo.SysResource;
import yours.pojo.SysRole;
import yours.utils.MsgException;

import java.util.Set;


public interface SysRoleService extends BaseService<SysRole> {

    /**
     * 修改指定id角色所映射的资源关系
     * @param id 系统角色id
     * @param sysResourceIds 资源id列表
     * @return 修改结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String updateRoleResourceShip(String id, Set<String> sysResourceIds) throws Exception;

    /**
     * 获取 指定id角色所属资源信息
     * @param id 系统角色id
     * @return 资源信息
     * @throws MsgException,Exception
     */
    public Set<SysResource> findResources(String id) throws MsgException,Exception;

}
