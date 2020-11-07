package yours.admin.service;

import yours.pojo.SysResource;
import yours.pojo.SysRole;
import yours.pojo.SysUser;
import yours.utils.MsgException;

import java.util.Set;

/**
 * 系统用户服务
 */
public interface SysUserService  extends BaseService<SysUser>{

    /**
     * 修改密码操作
     * @param id 用户id
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 修改结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String changePassword(String id,String oldPassword,String newPassword) throws Exception;

    /**
     *	重置密码操作
     * @param id 用户id
     * @return 修改结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String resetPassword(String id) throws Exception;
    /**
     * 修改头像
     * @param id 用户id
     * @param newIconUrl 新头像路径
     * @return 修改结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String changeIcon(String id,String newIconUrl) throws Exception;


    /**
     * 修改指定id用户所属角色
     * @param id 系统用户id
     * @param sysRoleIds 角色id列表
     * @return 修改结果,null表示成功,其他为错误信息
     * @throws Exception
     */
    public String updateUserRoleShip(String id, Set<String> sysRoleIds) throws Exception;


    /**
     * 获取 指定id用户所属角色信息
     * @param id 系统用户id
     * @return 角色信息
     * @throws MsgException,Exception
     */
    public Set<SysRole> findSysRoles(String id) throws MsgException,Exception;


    /**
     * 获取 指定id用户所属资源信息
     * @param id 系统用户id
     * @return 资源信息
     * @throws MsgException,Exception
     */
    public Set<SysResource> findResources(String id) throws MsgException,Exception;
}
