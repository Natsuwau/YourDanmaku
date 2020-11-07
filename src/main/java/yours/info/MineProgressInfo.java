package yours.info;

public class MineProgressInfo {
    private long readBytes;//已上传字节
    private long contentLength;//总字节
    private long nowItems;//正在处理第几个文件
    private long startTime;//上传开始时间
    private long nowTime;//当前服务器时间

    public long getReadBytes() {
        return readBytes;
    }
    public void setReadBytes(long readBytes) {
        this.readBytes = readBytes;
    }
    public long getContentLength() {
        return contentLength;
    }
    public void setContentLength(long contentLength) {
        this.contentLength = contentLength;
    }
    public long getNowItems() {
        return nowItems;
    }
    public void setNowItems(long nowItems) {
        this.nowItems = nowItems;
    }
    public long getStartTime() {
        return startTime;
    }
    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }
    public long getNowTime() {
        return nowTime;
    }
    public void setNowTime(long nowTime) {
        this.nowTime = nowTime;
    }
    @Override
    public String toString() {
        return "MineProgressInfo [readBytes=" + readBytes + ", contentLength="
                + contentLength + ", nowItems=" + nowItems + ", startTime="
                + startTime + ", nowTime=" + nowTime + "]";
    }
}