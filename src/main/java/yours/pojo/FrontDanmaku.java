package yours.pojo;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class FrontDanmaku extends  BasePojo{
    @JsonProperty(value = "_id")
    private String id;

    private String frontUserId;

    private String frontVideoId;

    private Double time;

    private String text;

    private String color;

    private String type;

    @JsonProperty(value = "__v")
    private Integer v;

    private Date createTime;

    private List<String>player;//弹幕视频id

    @Override
    public String getId() {
        return id;
    }

    @Override
    public void setId(String id) {
        this.id = id;
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

    public void setFrontVideoId(String fontVideoId) {
        this.frontVideoId = fontVideoId;
    }

    public Double getTime() {
        return time;
    }

    public void setTime(Double time) {
        this.time = time;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getV() {
        return v;
    }

    public void setV(Integer v) {
        this.v = v;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<String> getPlayer() {
        return player;
    }

    public void setPlayer(List<String> player) {
        this.player = player;
    }

    @Override
    public String toString() {
        return "FrontDanmaku{" +
                "id='" + id + '\'' +
                ", frontUserId='" + frontUserId + '\'' +
                ", fontVideoId='" + frontVideoId + '\'' +
                ", time=" + time +
                ", text='" + text + '\'' +
                ", color='" + color + '\'' +
                ", type='" + type + '\'' +
                ", v=" + v +
                ", createTime=" + createTime +
                ", player=" + player +
                ", id='" + id + '\'' +
                ", state=" + state +
                '}';
    }
public static FrontDanmaku parseDanmakuFromMap(Map<String,Object> map)throws Exception
{
    FrontDanmaku one=null;
    if (map!=null)
    {
        one=new FrontDanmaku();
        Object temp=map.get("color");
        one.setColor(temp==null?null:temp.toString());
        temp=map.get("type");
        one.setType(temp==null?null:temp.toString());
        temp=map.get("text");
        one.setText(temp==null?null:temp.toString());
        List<String>player=null;
        temp=map.get("player");
        String pOne=(temp==null?null:temp.toString());
        if (pOne!=null)
        {
            player=new ArrayList<>();
            player.add(pOne);
        }
        one.setFrontVideoId(pOne);//设置视频id0
        one.setPlayer(player);
        temp=map.get("time");
        String timeStr=(temp==null?null:temp.toString());
        one.setTime(Double.parseDouble(timeStr));
    }
    return one;
}


}
