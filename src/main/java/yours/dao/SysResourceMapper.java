package yours.dao;

import org.apache.ibatis.annotations.Param;
import yours.pojo.SysResource;

import java.util.List;
import java.util.Set;

public interface SysResourceMapper {

    /**
     * 根据系统角色id集合查询对应资源信息，可选择查询活跃资源,即state=1的资源
     * @param sysRoleIds 角色id列表，null时表示查询所有
     * @param onlyActive state=1
     * @return 对应信息
     */
    List<SysResource> findWithSysRoleIds(@Param("sysRoleIds") Set<String> sysRoleIds, @Param("onlyActive")boolean onlyActive);

    // 以下为自动生成的方法——————————————————————————————————————

    int deleteByPrimaryKey(String id);

    int insert(SysResource record);

    int insertSelective(SysResource record);

    SysResource selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysResource record);

    int updateByPrimaryKey(SysResource record);
}