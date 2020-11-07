package yours.pojo;

import yours.utils.MineStringUtils;

import java.io.Serializable;
import java.util.Set;

//系统用户类
public class SysUser implements Serializable {

    private static final long serialVersionUID = -6724130431020769387L;

    private String id;

    private String name;

    private String password;

    private String icon;

    private String desc;

    private Integer state;

    private Set<SysRole> roles;

    private Set<SysResource> resources;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = MineStringUtils.trim(id);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = MineStringUtils.trim(name);
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = MineStringUtils.trim(password);
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Set<SysRole> getRoles() {
        return roles;
    }

    public void setRoles(Set<SysRole> roles) {
        this.roles = roles;
    }

    public Set<SysResource> getResources() {
        return resources;
    }

    public void setResources(Set<SysResource> resources) {
        this.resources = resources;
    }

    @Override
    public String toString() {
        return "SysUser{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", icon='" + icon + '\'' +
                ", desc='" + desc + '\'' +
                ", state=" + state +
                ", roles=" + roles +
                ", resources=" + resources +
                '}';
    }
}
