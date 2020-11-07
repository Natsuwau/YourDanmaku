package yours.utils;

import java.util.Map;

public class AjaxJson {

    public boolean success;//请求是否成功

    private String msg=null;//提示信息

    private Object obj=null;//其他信息

    private Map<String,Object>attr;//其余参数

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

    public Map<String, Object> getAttr() {
        return attr;
    }

    public void setAttr(Map<String, Object> attr) {
        this.attr = attr;
    }

    @Override
    public String toString() {
        return "AjaxJson{" +
                "success=" + success +
                ", msg='" + msg + '\'' +
                ", obj=" + obj +
                ", attr=" + attr +
                '}';
    }
}
