package yours.info;

//分页工具类

import java.util.Arrays;
import java.util.List;

public class PageInfo<E>{

 private  boolean err=false;//记录获取子集或计算数据过程中是否存在错误

 private int  pageSize=0;//每页记录数

 private int pageCount=0;//页数

    private int nowPage=0;//当前页数

    private int rootListSize=0;//总记录数

    private int beginIndex=0;//开始位置 序号

    private int endIndex=0;//结束位置 序号

    private int[] pageSizeList=null;//页面大小选择list

    private int[]pageNoList=null;//页号选择list

    private int[] indexs=null;//索引数组

    private int[]nos=null;

    //存放分页后的list
    List<E> basePageList=null;


    //用于应对不同情况下所显示的跳页 list
    public void setDefaultPageNoList(){

        //数据异常或为空
        if (pageCount<1){
            pageNoList=new int[1];
            pageNoList[0]=-1;//-1表示未写入
            return;
        }
        pageNoList = new int[9];
        for (int i = 0; i < 9; i++) {
            pageNoList[i] = -1; // -1表示未写入
        }
        for (int i = 0; i < pageCount; i++) {
            if (i < 9) {
                pageNoList[i] = i + 1;
            }

        }

        if (pageCount>9){
            //可以确定首位和末位
            pageNoList[0]=1;
            pageNoList[8]=pageCount;

            if (nowPage >= 5 && nowPage < pageCount-3){

                //nowPage相关七个位置未占用时的情况

                pageNoList[1]=0;//省略号用0表示
                pageNoList[7]=0;

                int startOne=nowPage-2;
                System.out.println("当前页号:"+nowPage);
                for (int i=2;i<7;i++)
                {
                    pageNoList[i]=startOne;
                    startOne++;
                }

            }else {
                //nowPage相关七个位置被占用或没有时的情况

                if (nowPage<=4){
                    pageNoList[7]=0;
                    pageNoList[6]=0;
                }else {
                    pageNoList[1]=0;
                    pageNoList[2]=0;
                    int endOne=pageCount-5;
                    for (int i=3;i<8;i++)
                    {
                        pageNoList[i]=endOne;
                        endOne++;
                    }


                }

            }
        }

    }

    //默认设置5个选择 用于应对不同情况下的页面大小
public void setDefaultPageSizeList(){
        //数据异常或为空
    if (rootListSize<1)
    {
        pageSizeList=new int[1];
        pageSizeList=new int[1];
        pageSizeList[0]=1;
        return;
    }

    pageSizeList=new int[5];

    if (rootListSize<=5)
    {
        pageSizeList[0]=1;
        pageSizeList[1] = 2;
        pageSizeList[2] = 3;
        pageSizeList[3] = 4;
        pageSizeList[4] = 5;
    }else{
        if (rootListSize<=15){
            pageSizeList[0] = 1;
            pageSizeList[1] = 5;
            pageSizeList[2] = 10;
            pageSizeList[3] = 13;
            pageSizeList[4] = 15;
        }
        else {
            pageSizeList[0] = 5;
            pageSizeList[1] = 10;
            pageSizeList[2] = 15;
            pageSizeList[3] = 20;
            pageSizeList[4] = 25;
        }
    }


}


    //构建索引数组
    public int[] getIndexs(){
        if (pageSize<1){
            return null;
        }
        int size=endIndex-beginIndex+1;

        indexs=new int[size];

        for (int i=0;i<size;i++){

            indexs[i]=i+beginIndex-1;
        }

        return indexs;
    }


//构建编号数组
    public int[] getNos(){
        if (pageSize<1){
            return null;
        }
        int size=endIndex-beginIndex+1;
        nos=new int[size];

        for (int i=0;i<size;i++)
        {
            nos[i]=i+beginIndex;
        }
        return  nos;
    }


    //用于获取数据库获取的PageList
    public List<E>getBasePageList(){
        return basePageList;
    }

    //放入数据库获取的PageList到basePageList
    public void setBasePageList(List<E>basePageList){
        this.basePageList=basePageList;
    }

    public boolean hasPageListErr() {
        if (this.basePageList == null || basePageList.size() < 1) {
            return true;
        }
        return false;
    }

    public boolean isErr() {
        return err;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getPageCount() {
        return pageCount;
    }

    public int getNowPage() {
        return nowPage;
    }

    public int getRootListSize() {
        return rootListSize;
    }

    public int getBeginIndex() {
        return beginIndex;
    }

    public int getEndIndex() {
        return endIndex;
    }

    public int[] getPageSizeList() {
        return pageSizeList;
    }

    public int[] getPageNoList() {
        return pageNoList;
    }

    @Override
    public String toString() {
        return "PageInfo \n[pageFlag=" + err + ", pageSize=" + pageSize
                + ", pageCount=" + pageCount + ", nowPage=" + nowPage
                + ", rootListSize=" + rootListSize + ", \nsbeginIndex="
                + beginIndex + ", endIndex=" + endIndex + ", \npageSizeList="
                + Arrays.toString(pageSizeList) + ", \npageNoList="
                + Arrays.toString(pageNoList) + ", \nindexs="
                + Arrays.toString(this.getIndexs()) + ", \nnos="
                + Arrays.toString(this.getNos()) + ", \nbasePageList="
                + basePageList + "]";


    }



    //用于初始化PageInfo,指定源rootListSize,当前页,页面大小
    private void initByListSize(int oneRootListSize,int oneNowPage,int onePageSize)
    {
        if (oneRootListSize<1){
            System.out.println("oneRootSize is error!");
            //其余数据皆为异常状态
            setDefaultPageNoList();
            setDefaultPageSizeList();
            err=true;
            return;
        }
        //获取总记录数
        rootListSize=oneRootListSize;

        //设置当前页
        nowPage=oneNowPage;

        //设置页面大小
        pageSize=onePageSize;

        //验证pageSize大小是否合法||pageSize>rootListSize
        if (pageSize<1){
            err=true;
            pageSize=5;
        }

        //获取总页数
        pageCount=((rootListSize-1)/pageSize)+1;

        //验证nowPage页号是否合法
        if (nowPage<1){
            err=true;
            nowPage=1;
        }
        if (nowPage > pageCount) {
            err = true;
            nowPage = pageCount;
        }
        // 计算起始点
        beginIndex = (nowPage - 1) * pageSize + 1;
        // 计算结束点
        if ((nowPage * pageSize) > rootListSize) {
            endIndex = rootListSize; // 最后一个数据
        } else {
            endIndex = nowPage * pageSize;
        }
        // 设置默认 页号选择 list 和 页面大小选择list
        setDefaultPageNoList();
        setDefaultPageSizeList();

    }


    //通过rootListSize构造一个pageInfo,默认当前页为1,页面大小为5

    public PageInfo(int oneRootListSize){
        initByListSize(oneRootListSize,1,5);
    }

    //通过rootListSize构造一个pageInfo,并指定当前页和页面大小
    public PageInfo(int oneRootListSize,int oneNowPage,int onePageSize)
    {
        initByListSize(oneRootListSize,oneNowPage,onePageSize);
    }

    //通过rootListSize构造一个pageInfo,并指定当前页和页面大小,同时指定分页数据

    public PageInfo(int oneRootListSize, int oneNowPage, int onePageSize,
                    List<E> oneBasePageList) {
        initByListSize(oneRootListSize, oneNowPage, onePageSize);
        setBasePageList(oneBasePageList);
    }




}


