package yours.pojo;


import yours.utils.MineStringUtils;

import java.util.Date;

//上传视频类
public class FrontVideo extends BasePojo {
    private String frontUserId;

    private String name;

    private String url;

    private String picUrl;

    private String coverUrl;

    private String desc;

    private String scope;

    private Date uploadTime;

    private Double duration;

    private String type;

    private String tags;

    private Integer like;

    private Long hits;

    private String opinions;

    private String frontFavoriteId;

    public String getFrontUserId() {
        return frontUserId;
    }

    public void setFrontUserId(String frontUserId) {
        this.frontUserId = frontUserId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }

    public Double getDuration() {
        return duration;
    }

    public void setDuration(Double duration) {
        this.duration = duration;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public Integer getLike() {
        return like;
    }

    public void setLike(Integer like) {
        this.like = like;
    }

    public Long getHits() {
        return hits;
    }

    public void setHits(Long hits) {
        this.hits = hits;
    }

    public String getOpinions() {
        return opinions;
    }

    public void setOpinions(String opinions) {
        this.opinions = opinions;
    }

    public String getFrontFavoriteId() {
        return frontFavoriteId;
    }

    public void setFrontFavoriteId(String frontFavoriteId) {
        this.frontFavoriteId = frontFavoriteId;
    }

    //返回类型名
    public String getTypeName(){
        return FrontVideoType.convertTypeCodeToName(this.type);
    }
    //返回时间长度
    public String getDurationStr(){
        return MineStringUtils.formatTimeStr(duration);
    }

    @Override
    public String toString() {
        return "FrontVideo{" +
                "frontUserId='" + frontUserId + '\'' +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", picUrl='" + picUrl + '\'' +
                ", coverUrl='" + coverUrl + '\'' +
                ", desc='" + desc + '\'' +
                ", scope='" + scope + '\'' +
                ", uploadTime=" + uploadTime +
                ", duration=" + duration +
                ", type='" + type + '\'' +
                ", tags='" + tags + '\'' +
                ", like=" + like +
                ", hits=" + hits +
                ", opinions='" + opinions + '\'' +
                ", frontFavoriteId='" + frontFavoriteId + '\'' +
                ", id='" + id + '\'' +
                ", state=" + state +
                '}';
    }
}
