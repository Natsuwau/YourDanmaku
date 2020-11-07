package yours.admin.realms;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import yours.admin.service.SysResourceService;
import yours.admin.service.SysRoleService;
import yours.admin.service.SysUserService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.SysResource;
import yours.pojo.SysRole;
import yours.pojo.SysUser;
import yours.utils.MineCommonUtils;

import java.util.Set;

/**
 * 系统用户Realm
 */
public class SysUserRealm extends AuthorizingRealm {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private SysResourceService sysResourceService;
    // 授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals) {
        SysUser one = (SysUser) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        try {
            String id = one.getId();
            Set<SysRole> sysRoles =null;
            Set<SysResource> sysResources = null;
            if(SysInfo.SYSUSER_SUPER_ADMIN.equals(id)){//超级管理员，获取所有可用角色,资源
                QueryHandler roleQH = QueryHandler.create();
                roleQH.andColumnEqual("sro_state", "1").set();
                PageInfo<SysRole> allPageRoles = sysRoleService.findSomeByQueryHandler(roleQH);
                sysRoles = MineCommonUtils.convertListToSet(allPageRoles.getBasePageList());
                QueryHandler resourcesQH = QueryHandler.create();
                resourcesQH.andColumnEqual("sre_state", "1").set();
                PageInfo<SysResource> allPageallResources = sysResourceService.findSomeByQueryHandler(resourcesQH);
                sysResources =MineCommonUtils.convertListToSet(allPageallResources.getBasePageList());
            }else{
                sysRoles = sysUserService.findSysRoles(one.getId());
                sysResources = sysUserService.findResources(one.getId());
            }
            one.setRoles(sysRoles);
            one.setResources(sysResources);
            Set<String> roles = MineCommonUtils.getSysRoleNamesBySysRoles(sysRoles);
            //添加角色，权限
            if(roles!=null&&roles.size()>0){
                authorizationInfo.addRoles(roles);
                Set<String> permissions = MineCommonUtils.getSysResourcePermissionsBySysResources(sysResources);
                if(permissions!=null&&permissions.size()>0){
                    authorizationInfo.addStringPermissions(permissions);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return authorizationInfo;
    }

    // 认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken token) throws AuthenticationException {
        String sysUserId = (String)token.getPrincipal();
        SimpleAuthenticationInfo authenticationInfo = null;
        SysUser one = null;
        try {
            one = sysUserService.findOneById(sysUserId);
        } catch (Exception e) {
            System.err.println(e.getMessage());
            throw new AuthenticationException();
        }
        if(one==null){
            throw new UnknownAccountException("账号不存在!");
        }
        if(one.getState()!=1){
            throw new LockedAccountException("账号被锁定!");
        }
        //1). principal: 认证的实体信息. 可以是 username, 也可以是数据表对应的用户的实体类对象.
        Object principal = one;
        //2). credentials: 密码.
        Object credentials =one.getPassword();
        //3). realmName: 当前 realm 对象的 name. 调用父类的 getName() 方法即可
        String realmName = getName();
        //4). 盐值. 使用用户id
        ByteSource credentialsSalt = ByteSource.Util.bytes(one.getId());
        authenticationInfo = new SimpleAuthenticationInfo(principal, credentials, credentialsSalt, realmName);
        return authenticationInfo;
    }

}
