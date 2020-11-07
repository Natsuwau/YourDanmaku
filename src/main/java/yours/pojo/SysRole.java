package yours.pojo;


import yours.utils.MineStringUtils;

import java.io.Serializable;

//系统角色类
public class SysRole implements Serializable {

    private static final long serialVersionUID = 4470197210698060089L;

    private String id;

    private String name;

    private String desc;

    private Integer state;



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

    @Override
    public String toString() {
        return "SysRole{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", desc='" + desc + '\'' +
                ", state=" + state +
                '}';
    }
}
