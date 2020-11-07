package yours.front.controller;




//前台Controller

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.info.SysInfo;
import yours.info.TaskInfo;
import yours.pojo.FrontTask;
import yours.pojo.FrontUser;
import yours.front.service.FrontTaskService;
import yours.front.service.FrontUserService;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class FrontController {
    @Autowired
    private FrontUserService frontUserService;
    @Autowired
    private FrontTaskService frontTaskService;

    /** 视频上传页 */
    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    public String upload(Model model) {
        return "front/upload";
    }

    /**获取登录页*/
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLogin(Model model) {
        model.addAttribute("loginFlag", "login");
        return "login";
    }
    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson doLogin(String id, String password, HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        if (MineStringUtils.IsNullOrWhiteSpace(id)
                || (id = id.trim()).length() < 4) {
            ajaxJson.setMsg("id长度不小于4位!");
            return ajaxJson;
        }
        if (MineStringUtils.IsNullOrWhiteSpace(password)
                || (password = password.trim()).length() < 4) {
            ajaxJson.setMsg("密码长度不小于4位!");
            return ajaxJson;
        }
        try {
            FrontUser one = frontUserService.login(id, password);
            //获取签到信息
            FrontTask dateTask = frontTaskService.findTask(id, 0);
            if(dateTask !=null){
                //日期判断
                long start = MineCommonUtils.getTodayStartTime();
                long end = MineCommonUtils.getTodayEndTime();//System.currentTimeMillis();
                long time = dateTask.getDate().getTime();
                if(time<=end && time >=start){
                    if(dateTask.getNowNum()>=TaskInfo.getAllTask().get(0).getMaxNum()){
                        one.setMarked(true);
                    }
                }
            }
            // 存入session
            session.setAttribute(SysInfo.FRONT_USER_SESSION_NAME, one);
            ajaxJson.setSuccess(true);
            msg = "登录成功!";
        } catch (MsgException e) {
            msg = e.getMessage();
        } catch (Exception e) {
            msg = "登录发生异常";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }

    /**获取注册页*/
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String getRegister(Model model) {
        model.addAttribute("registerFlag", "register");
        return "login";
    }
    @RequestMapping(value = "/register", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson doRegister(FrontUser one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        if (one == null) {
            msg = "参数缺失!";
        }
        if (MineStringUtils.IsNullOrWhiteSpace(one.getId())
                || (one.getId().trim()).length() < 4) {
            msg = "ID长度不小于4位!";
        }
        one.setId(one.getId().trim());
        if (MineStringUtils.IsNullOrWhiteSpace(one.getPassword())
                || (one.getPassword().trim()).length() < 4) {
            msg = "密码长度不小于4位!";
        }
        one.setPassword(one.getPassword().trim());
        if (MineStringUtils.IsNullOrWhiteSpace(one.getEmail())) {
            msg = "邮箱不可为空!";
        }
        if (MineStringUtils.hasKey(one.getId(), SysInfo.FRONT_USER_ID_BAN_STRS)
                || SysInfo.SYSTEM_DATABASE_ID.equalsIgnoreCase(one.getId())) {
            msg = "ID包含非法字符!";
        }
        if (MineStringUtils.hasKey(one.getPassword(), SysInfo.FRONT_USER_ID_BAN_STRS)) {
            msg = "密码包含非法字符!";
        }
        if (!MineStringUtils.IsNullOrEmpty(msg)) {
            ajaxJson.setMsg(msg);
            return ajaxJson;
        }
        try {
            String result = frontUserService.register(one);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "注册成功!";
            }else{
                msg = result;
            }
        }catch (Exception e) {
            msg = "注册失败，系统异常！";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }

    /**注销 */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String getLogout(HttpSession session) {
        // 销毁session
        session.removeAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        session.removeAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
        return "redirect:login";//重定向
    }
}

