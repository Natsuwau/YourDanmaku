package yours.dao;

import org.apache.ibatis.annotations.Param;
import yours.pojo.SysRole;

import java.util.List;

public interface SysRoleMapper {

    /**
     * 根据系统用户id查询对应角色信息，可选择查询活跃角色,即state=1的角色
     * @param uid 系统用户id
     * @param onlyActive state=1
     * @return 对应信息
     */
    List<SysRole> findWithSysUserId(@Param("suid")String uid, @Param("onlyActive")boolean onlyActive);

    /**
     * 通过系统用户id，获取所属角色id列表
     * @param uid 系统用户id
     * @return 所属角色id列表
     */
    List<String> findIdsWithSysUserId(@Param("suid")String uid,@Param("onlyActive")boolean onlyActive);
    // 以下为自动生成的方法——————————————————————————————————————

    int deleteByPrimaryKey(String id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);


}