package yours.pojo;

import yours.utils.MineStringUtils;

import java.io.Serializable;

//系统资源类

public class SysResource implements Serializable {

    private static final long serialVersionUID = 4716884515815944383L;

    private String id;

    private String name;

    private String type;

    private String icon;

    private Integer priority;

    private Integer level;

    private String upLevelId;

    private String url;

    private String permission;

    private String other;

    private Integer state;

    //额外属性，数据库没有,用于标识拥有此资源
    private boolean checked=false;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getUpLevelId() {
        return upLevelId;
    }

    public void setUpLevelId(String upLevelId) {
        this.upLevelId = upLevelId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    @Override
    public String toString() {
        return "SysResource{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", icon='" + icon + '\'' +
                ", priority=" + priority +
                ", level=" + level +
                ", upLevelId='" + upLevelId + '\'' +
                ", url='" + url + '\'' +
                ", permission='" + permission + '\'' +
                ", other='" + other + '\'' +
                ", state=" + state +
                ", checked=" + checked +
                '}';
    }
}
