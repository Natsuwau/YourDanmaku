package yours.info;

import yours.pojo.FrontTask;

import java.util.ArrayList;
import java.util.List;

public class TaskInfo {
    private int maxNum;
    private String desc;
    private String name;
    private int coin;
    private FrontTask frontTask;


    public int getMaxNum() {
        return maxNum;
    }

    public void setMaxNum(int maxNum) {
        this.maxNum = maxNum;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCoin() {
        return coin;
    }

    public void setCoin(int coin) {
        this.coin = coin;
    }

    public FrontTask getFrontTask() {
        return frontTask;
    }

    public void setFrontTask(FrontTask frontTask) {
        this.frontTask = frontTask;
    }

    public  static List<TaskInfo> getAllTask(){
        List<TaskInfo> list=new ArrayList<>();
        TaskInfo temp=new TaskInfo();
        temp.setName("每日签到");
        temp.setFrontTask(new FrontTask());
        temp.setMaxNum(1);
        temp.setCoin(5);
        temp.setDesc("签到即可获取5个硬币");
        list.add(temp);
        temp=new TaskInfo();
        temp.setFrontTask(new FrontTask());
        temp.setMaxNum(5);
        temp.setCoin(10);
        temp.setDesc("观看五个视频后可获10个硬币");
        list.add(temp);
        return list;

 }
 public static List<TaskInfo>getAllTaskFromFrontTask(List<FrontTask> frontTaskLists)
 {
     List<TaskInfo> allTask=getAllTask();

     if (frontTaskLists==null){
         return allTask;

     }
     int size=frontTaskLists.size();
     for (int i=0;i<size;i++)
     {
         FrontTask one=frontTaskLists.get(i);
         allTask.get(one.getIndex()).setFrontTask(one);
     }
     return allTask;
 }



}
