package yours.pojo;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class FrontUser extends BasePojo{
    private String name;

    private String password;

    private String icon;

    private Integer sex;
    @DateTimeFormat(pattern = "yyyy-MM-dd")//springMVC日期转换
    private Date birthday;

    private String phone;

    private String email;

    private String address;

    private String signature;

    private Date regTime;

    private Integer coin;

    private Long markHistory;

    private boolean marked;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public Date getRegTime() {
        return regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

    public Integer getCoin() {
        return coin;
    }

    public void setCoin(Integer coin) {
        this.coin = coin;
    }

    public Long getMarkHistory() {
        return markHistory;
    }

    public void setMarkHistory(Long markHistory) {
        this.markHistory = markHistory;
    }

    public boolean isMarked() {
        return marked;
    }

    public void setMarked(boolean marked) {
        this.marked = marked;
    }

    @Override
    public String toString() {
        return "FrontUser{" +
                "name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", icon='" + icon + '\'' +
                ", sex=" + sex +
                ", birthday=" + birthday +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", signature='" + signature + '\'' +
                ", regTime=" + regTime +
                ", coin=" + coin +
                ", markHistory=" + markHistory +
                ", marked=" + marked +
                ", id='" + id + '\'' +
                ", state=" + state +
                '}';
    }
}
