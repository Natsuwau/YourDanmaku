package yours.dao;

import org.apache.ibatis.annotations.Param;

import java.util.Set;

/**
 * 映射关系数据处理DAO*/

public interface ShipMapper {

    /**
     * 删除指定系统用户id所有角色映射关系
     * @param sysUserId 用户id
     * @return 影响行数
     */
    int delUserRoleShipWithSysUserId(String sysUserId);

    /**
     * 删除指定系统角色id所有用户映射关系
     * @param sysRoleId 角色id
     * @return 影响行数
     */
    int delUserRoleShipWithSysRoleId(String sysRoleId);

    /**
     * 设置指定id用户下的角色映射关系
     * @param sysUserId 用户id
     * @param roleIds 角色id列表
     * @return 影响行数
     */
    int addUserRoleShipsByUserIdAndRoleIds(@Param("sysUserId")String sysUserId, @Param("roleIds") Set<String> roleIds);


    /**
     * 删除指定系统角色id所有资源映射关系
     * @param sysRoleId 角色id
     * @return 影响行数
     */
    int delRoleResourceShipWithSysRoleId(String sysRoleId);

    /**
     * 删除指定系统资源id所有角色映射关系
     * @param sysResourceId 资源id
     * @return 影响行数
     */
    int delRoleResourceShipWithSysResourceId(String sysResourceId);

    /**
     * 设置指定id角色下的资源映射关系
     * @param sysRoleId  角色id
     * @param resourceIds 资源id列表
     * @return 影响行数
     */
    int addRoleResourceShipsByRoleIdAndResourceIds(@Param("sysRoleId")String sysRoleId,@Param("resourceIds")Set<String> resourceIds);
}
