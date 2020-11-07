package yours.utils;


import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.EncoderException;
import it.sauronsoftware.jave.InputFormatException;
import it.sauronsoftware.jave.MultimediaInfo;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.web.multipart.MultipartFile;
import yours.pojo.SysResource;
import yours.pojo.SysRole;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.util.*;

public class MineCommonUtils {


    //获取一天开始时间

    public static long getTodayStartTime(){
        Calendar todayStart=Calendar.getInstance();
        todayStart.set(Calendar.HOUR_OF_DAY,0);
        todayStart.set(Calendar.MINUTE,0);
        todayStart.set(Calendar.SECOND,0);
        todayStart.set(Calendar.MILLISECOND,0);

        return todayStart.getTime().getTime();
    }

    //获取一天结束时间

    public static long getTodayEndTime(){
        Calendar todayEnd=Calendar.getInstance();
        todayEnd.set(Calendar.HOUR_OF_DAY,23);
        todayEnd.set(Calendar.MINUTE,59);
        todayEnd.set(Calendar.SECOND,59);
        todayEnd.set(Calendar.MILLISECOND,999);

        return todayEnd.getTime().getTime();
    }


    //获取uuid 删除"-" 并全部大写

    public static String getUUID_NoHyphen(){
        String s= UUID.randomUUID().toString();
        return s.replaceAll("\\-","").toUpperCase();
    }

    //获取shiro默认的MD5带盐字符串
    public static String getShiroMD5(String salt,int hashIterations,String str){
        ByteSource baSalt=ByteSource.Util.bytes(salt);
        return new SimpleHash("MD5",str,baSalt,hashIterations).toString();

    }
    /**
     * 基于SpringMVC的上传处理
     * @param fileParentPath 文件存放目录
     * @param prefix 新文件名前缀
     * @param allowedSuffixs 被允许的文件类型
     * @param file
     * @param request
     * @return 新文件名,失败为null]
     */
    public static String upLoadFileForStringMVC(String fileParentPath,
                                                String prefix,String[] allowedSuffixs, MultipartFile file) throws Exception{
        // 获取真实文件后缀
        String[] strArr = file.getOriginalFilename().split("\\.");
        // 如果资源不存在也会返回
        if (strArr == null || strArr.length < 2) {
            throw new Exception("接收文件发生错误!");
        }
        String suffix = strArr[strArr.length - 1];
        String newfileName = prefix + "_" + MineCommonUtils.getUUID_NoHyphen() + "." + suffix;
        // 判断后缀
        if (!MineStringUtils.strIsInStrArrIgnoreCase(suffix, allowedSuffixs)) {
            throw new Exception("错误的文件类型!");
        }
        File one = new File(new File(fileParentPath), newfileName);
        // System.out.println(one.getAbsolutePath());
        try {
            FileUtils.copyInputStreamToFile(file.getInputStream(), one);
            return newfileName;
        } catch (IOException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        throw new Exception("文件写入失败!");
    }


    /**
     * 删除一个文件
     * @param path 父目录 (非空)
     * @param fileName 文件名(非空)
     * @return 删除结果
     */
    public static boolean delFile(String path,String fileName){
        boolean flag = false;
        if(MineStringUtils.IsNullWhiteSpace(path)|| MineStringUtils.IsNullWhiteSpace(fileName)){
            return false;
        }
        try {
            File directory = new  File(path.trim());
            if(directory.isDirectory()){
                File f = new File(directory,fileName.trim());
                if(f.exists()){
                    if(f.delete()){
                        flag = true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }


    public static  String readJSONStringByRequest(HttpServletRequest request){
        StringBuffer json = new StringBuffer();
        String line = null;
        BufferedReader reader=null;
        try {
            reader = request.getReader();
            while((line = reader.readLine()) != null) {
                json.append(line);
            }
        }
        catch(Exception e) {
            if(reader!=null){try {
                reader.close();
            } catch (IOException e1) {
                e1.printStackTrace();
            }}
            e.printStackTrace();
        }
        return json.toString();
    }

    /**
     * 获取指定视频文件的时间长度
     * @param videoFile
     * @return
     * @throws InputFormatException
     * @throws EncoderException
     */
    public static double getVideoDuration(File videoFile) throws InputFormatException, EncoderException{
        Encoder encoder = new Encoder();
        MultimediaInfo m = encoder.getInfo(videoFile);
        return m.getDuration();
    }
    /** 获取指定视频文件的时间长度*/
    public static double getVideoDuration(String videoFilePath) throws Exception{
        File file = new File(videoFilePath);
        return getVideoDuration(file);
    }
    /** 获取指定视频文件的时间长度*/
    public static double getVideoDuration(String fileParentPath,String videoFireName) throws Exception{
        File file = new File(fileParentPath,videoFireName);
        return getVideoDuration(file);
    }

    /**
     * List&lt;T&gt; 转 Set&lt;T&gt;
     */
    public static <T> Set<T> convertListToSet(List<T> list){
        if(list==null||list.size()==0){
            return null;
        }
        Set<T> set=new HashSet<T>(list);
        return set;
    }


    /**
     * 根据所有角色信息列表获取对应name信息列表
     */
    public static  Set<String> getSysRoleNamesBySysRoles(Set<SysRole> sysRoles){
        if(sysRoles==null||sysRoles.size()==0){
            return null;
        }
        Set<String> names = new HashSet<String>();
        for (SysRole one : sysRoles) {
            names.add(one.getId());
        }
        return names;
    }


    /**
     * 根据所有资源信息列表获取对应权限字符串信息列表
     */
    public static  Set<String> getSysResourcePermissionsBySysResources(Set<SysResource> sysResources){
        if(sysResources==null||sysResources.size()==0){
            return null;
        }
        Set<String> permissions = new HashSet<String>();
        for (SysResource one : sysResources) {
            String permission=one.getPermission();
            if(!(permission==null||"".equals(permission))){
                permissions.add(permission);
            }

        }
        return permissions;
    }


    /**
     * 数组&lt;T&gt; 转 Set&lt;T&gt;
     */
    public static <T> Set<T> convertArrayToSet(T[] arr){
        if(arr==null||arr.length==0){
            return null;
        }
        Set<T> set=new HashSet<T>();
        for (T one : arr) {
            set.add(one);
        }
        return set;
    }


    /**
     * 将部分已拥有资源和全部资源合并，并设置对应资源为已拥有
     */
    public static Set<SysResource>  markSysResourcesCheckedByPartInfo(List<SysResource> all,Set<SysResource> part){
        Set<SysResource> target = new HashSet<SysResource>();
        if(part==null||part.size()<1){
            return MineCommonUtils.convertListToSet(all);
        }
        for (SysResource one : all) {
            A:for (SysResource two : part) {
                if(one.getId().equals(two.getId())){
                    one.setChecked(true);
                    break A;
                }
            }
            target.add(one);
        }
        return target;
    }


}
