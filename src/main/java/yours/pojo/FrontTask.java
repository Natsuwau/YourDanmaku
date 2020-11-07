package yours.pojo;

import java.util.Date;

public class FrontTask extends BasePojo{
    private String frontUserId;

    private Integer nowNum;//当前进度

    private Date date;

    private Integer index;

    public String getFrontUserId() {
        return frontUserId;
    }

    public void setFrontUserId(String frontUserId) {
        this.frontUserId = frontUserId;
    }

    public Integer getNowNum() {
        return nowNum;
    }

    public void setNowNum(Integer nowNum) {
        this.nowNum = nowNum;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }
}
