package yours.utils;

import java.util.ArrayList;
import java.util.List;

public class MineStringUtils {
    //格式化时间长度
    public static String formatTimeStr(double duration)
    {
        int one=(int)(duration/1000);
        int h=one / (60 * 60);
        int two=one % (60 * 60);
        int m=two / 60;
        int s=two % 60;
        return h+":"+(m<10 ? "0"+m : m) + ":" + (s<10 ? "0"+s : s);
    }

    //去除前后空格 防止指针异常

    public static String trim(String str)
    {
        if (str != null){
            str=str.trim();
        }
        return str;
    }

    //判断字符串是否为空

    public static boolean IsNullWhiteSpace(String str){
        if (str==null){
            return true;
        }
        if ("".equals(str.trim())){
            return true;
        }
        return false;
    }



    //判断字符串是否为空

    public static boolean IsNullOrWhiteSpace(String str){
        if (str==null){
            return true;
        }
        if ("".equals(str.trim())){
            return true;
        }
        return false;
    }

   //判断字符串是否为空
    public  static boolean IsNullOrEmpty(String str)
    {
        if (str==null){
            return true;
        }
        if ("".equals(str))
        {
            return true;
        }
        return false;
    }



    //判断字符串之中是否是存在【字符串数组】中某一项,满足返回true,反之false,keys为null或长度为0返回false

    public static boolean hasKey(String str,String []keys)
    {
        if (str==null)
        {
            return true;
        }
        if (keys==null||keys.length<1)
        {
            return false;
        }
        for (String key:keys){
            if (str.indexOf(key)!=-1){
                return true;
            }
        }

        return false;
    }


    /**判断字符串长度是否合法，包含边界值*/
    public static boolean lengthIsBetween(String str,Integer minLength,Integer maxLength){
        if (str == null) {
            return true;
        }
        int length = str.length();
        if (minLength != null && maxLength != null) {
            if (minLength < 0 || minLength >= maxLength) {
                throw new RuntimeException("长度判断参数非法!");
            }
            if (length >= minLength && length <= maxLength) {
                return true;
            }
        } else if (minLength != null && maxLength == null) {
            if (length >= minLength) {
                return true;
            }
        } else if (minLength == null && maxLength != null) {
            if (length <= maxLength) {
                return true;
            }
        } else {
            throw new RuntimeException("长度判断参数非法!");
        }
        return false;

    }

    /**
     * 判断字符串是否存在于字符串数组中,不区分大小写，存在返回true，反之false; key字符串为null返回false
     *
     * @param str
     *            key字符串
     * @param strArr
     *            查询字符串数组
     * @return 验证结果
     */
    public static boolean strIsInStrArrIgnoreCase(String str, String[] strArr) {
        if (str == null) {
            return false;
        }
        for (String one : strArr) {
            if (str.equalsIgnoreCase(one)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 获取一个句子的关键字
     *
     * @param str
     *            源句子
     * @param keylength
     *            关键字长度
     * @return
     */
    public static List<String> getSimpleKeys(String str, int keylength) {
        if (MineStringUtils.IsNullWhiteSpace(str)) {
            return null;
        }
        if (keylength < 1) {
            return null;
        }
        str = str.replaceAll("\\s*", "");
        int length = str.length();

        List<String> target = new ArrayList<String>();
        if (keylength >= length) {
            target.add(str);
        }else{
            for (int i = 0; i <=(length - keylength); i++) {
                target.add(str.substring(i, i + keylength));
            }
        }
        return target;

    }


    /**
     * 判断字符串是否存在于字符串数组中，区分大小写，存在返回true，反之false; key字符串为null返回false
     *
     * @param str
     *            key字符串
     * @param strArr
     *            查询字符串数组
     * @return 验证结果
     */
    public static boolean strIsInStrArr(String str, String[] strArr) {
        if (str == null) {
            return false;
        }
        for (String one : strArr) {
            if (str.equals(one)) {
                return true;
            }
        }
        return false;
    }
}
