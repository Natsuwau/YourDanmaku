package yours.info;

/**前台常用参数封装类，分页信息，搜索信息等*/

public class ParamBag {

    private Integer nowPage;
    private Integer pageSize;
    private Integer pageCount;
    private String  searchKey;

    private String startTime;
    private String endTime;

    public Integer getNowPage() {
        return nowPage;
    }
    public void setNowPage(Integer nowPage) {
        this.nowPage = nowPage;
    }
    public Integer getPageSize() {
        return pageSize;
    }
    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
    public Integer getPageCount() {
        return pageCount;
    }
    public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }
    public String getSearchKey() {
        return searchKey;
    }
    public void setSearchKey(String searchKey) {
        this.searchKey = (searchKey==null)?null:searchKey.trim();
    }
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    /**
     * 校验，并修正分页信息
     */
    public void valiParam(){
        if (nowPage == null) {
            nowPage = 1;
        }
        if (pageSize == null) {
            pageSize = SysInfo.PAGE_INFO_DEFAULT_SIZE;
        }
        if (pageCount != null && nowPage != null && pageCount < nowPage) {
            nowPage = pageCount;
        }
        searchKey = (searchKey==null)?null:searchKey.trim();
    }



}
