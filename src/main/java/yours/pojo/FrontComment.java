package yours.pojo;

import java.util.Date;

public class FrontComment extends BasePojo {
private String refId;
private String content;
private String frontUserId;
private String frontVideoId;
private Date time;
private FrontUser frontUser;

    public String getRefId() {
        return refId;
    }

    public void setRefId(String refId) {
        this.refId = refId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFrontUserId() {
        return frontUserId;
    }

    public void setFrontUserId(String frontUserId) {
        this.frontUserId = frontUserId;
    }

    public String getFrontVideoId() {
        return frontVideoId;
    }

    public void setFrontVideoId(String frontVideoId) {
        this.frontVideoId = frontVideoId;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public FrontUser getFrontUser() {
        return frontUser;
    }

    public void setFrontUser(FrontUser frontUser) {
        this.frontUser = frontUser;
    }

    @Override
    public String toString() {
        return "FrontComment{" +
                "refId='" + refId + '\'' +
                ", content='" + content + '\'' +
                ", frontUserId='" + frontUserId + '\'' +
                ", frontVideoId='" + frontVideoId + '\'' +
                ", time=" + time +
                ", frontUser=" + frontUser +
                ", id='" + id + '\'' +
                ", state=" + state +
                '}';
    }
}
