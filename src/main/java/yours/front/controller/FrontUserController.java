package yours.front.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import yours.front.service.FrontTaskService;
import yours.front.service.FrontUserService;
import yours.front.service.FrontVideoService;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.info.TaskInfo;
import yours.pojo.FrontTask;
import yours.pojo.FrontUser;
import yours.pojo.FrontVideo;
import yours.pojo.FrontVideoType;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MsgException;
import yours.utils.MineStringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/space")
public class FrontUserController {

    @Autowired
    private FrontUserService frontUserService;
    @Autowired
    private FrontVideoService frontVideoService;
    @Autowired
    private FrontTaskService frontTaskService;

    /**修改信息*/
    @RequestMapping(value = "/{uid}/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson edit(@PathVariable("uid") String uid,FrontUser one,HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        if(MineStringUtils.IsNullOrWhiteSpace(uid)||!uid.equals(user.getId())){
            ajaxJson.setMsg("无法修改别人的信息！");
            return ajaxJson;
        }
        try {
            if(one!=null){
                one.setId(uid);
            }
            String result = frontUserService.update(one);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "信息更新成功!";
            }else{
                msg = result;
            }
        } catch (Exception e) {
            msg = "信息更新失败，发生异常！";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    /**修改密码*/
    @RequestMapping(value = "/{uid}/editPassword", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editPassword(@PathVariable("uid") String uid,String oldPassword,String newPassword,HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        if(!user.getId().equals(uid)){
            msg = "无法修改别人的密码！";
        }
        if(MineStringUtils.IsNullOrWhiteSpace(oldPassword)|| !MineStringUtils.lengthIsBetween(oldPassword, 4, 16)){
            msg = "旧密码非法！";
        }
        if(MineStringUtils.IsNullOrWhiteSpace(newPassword)|| !MineStringUtils.lengthIsBetween(oldPassword, 4, 16)){
            msg = "新密码非法！";
        }
        if (!MineStringUtils.IsNullOrEmpty(msg)) {
            ajaxJson.setMsg(msg);
            return ajaxJson;
        }
        try {
            String result = frontUserService.changePassword(uid, oldPassword, newPassword);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "密码修改成功!";
            }else{
                msg = result;
            }
        } catch (Exception e) {
            msg = "密码修改失败，发生异常！";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    /** 个人中心 */
    @RequestMapping(value = "/{uid}", method = RequestMethod.GET)
    public String space(@PathVariable("uid") String uid,HttpSession session,Model model) {
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        //个人信息
        FrontUser one = null;
        try {
            one = frontUserService.findOneById(uid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(one ==null){
            return "pages/404";
        }
        model.addAttribute("one", one);
        //'UP'视频信息
        List<FrontVideo> upVideoList = null;
        List<TaskInfo> TaskInfoList = null;
        QueryHandler qh = QueryHandler.create()
                .andColumnEqual("fv_state", "1")
                .andColumnEqual("fu_id", uid)
                .OrderByDESC("fv_uploadTime")
                .set();
        try {
            upVideoList = frontVideoService.findSomeByQueryHandler(qh).getBasePageList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("upVideoList", upVideoList);
        if(user==null || !user.getId().equals(uid)){//他人个人中心
            return "front/uSpace";
        }else{//自己个人中心
            List<FrontVideo> checkVideoList = null;
            List<FrontVideo> banVideoList = null;
            try {
                qh = QueryHandler.create().andColumnEqual("fv_state", "0")
                        .andColumnEqual("fu_id", uid)
                        .OrderByDESC("fv_uploadTime")
                        .set();
                checkVideoList = frontVideoService.findSomeByQueryHandler(qh).getBasePageList();
                qh = qh.clear().andColumnEqual("fv_state", "-1")
                        .andColumnEqual("fu_id", uid)
                        .OrderByDESC("fv_uploadTime")
                        .set();
                banVideoList = frontVideoService.findSomeByQueryHandler(qh).getBasePageList();
                //任务信息
                SimpleDateFormat sf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String startStr = sf.format(MineCommonUtils.getTodayStartTime());
                String endStr = sf.format(MineCommonUtils.getTodayEndTime());
                qh.clear().andColumnEqual("fu_id", uid)
                        .andColumnDateBetween("ft_date",startStr ,endStr ).set();
                List<FrontTask> temp = frontTaskService.findSomeByQueryHandler(qh).getBasePageList();
                TaskInfoList = TaskInfo.getAllTaskFromFrontTask(temp);
            } catch (Exception e) {
                e.printStackTrace();
            }
            model.addAttribute("taskInfoList", TaskInfoList);
            model.addAttribute("banVideoList", banVideoList);
            model.addAttribute("checkVideoList", checkVideoList);
            return "front/iSpace";
        }
    }
    /**签到*/
    @RequestMapping(value = "/{uid}/signOn", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson edit(@PathVariable("uid") String uid,HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        if(MineStringUtils.IsNullOrWhiteSpace(uid)||!uid.equals(user.getId())){
            ajaxJson.setMsg("无法给别人签到！");
            return ajaxJson;
        }
        x:try {
            //验证任务是否完成
            FrontTask dateTask = frontTaskService.findTask(uid, 0);
            if(dateTask !=null){
                long start = MineCommonUtils.getTodayStartTime();
                long end = MineCommonUtils.getTodayEndTime();//System.currentTimeMillis();
                long time = dateTask.getDate().getTime();
                if(time<=end && time >=start){//日期判断
                    if(dateTask.getNowNum()>=TaskInfo.getAllTask().get(0).getMaxNum()){
                        msg =  "任务已完成，无需再做...";
                        break x;
                    }
                }
            }
            String result = frontTaskService.doTask(uid, 0,1);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "签到成功!";
                //修改session信息
                user.setMarked(true);
                session.setAttribute(SysInfo.FRONT_USER_SESSION_NAME, user);
            }else{
                msg = result;
            }
        } catch (Exception e) {
            msg = "签到失败，发生异常！";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    /**改变视频状态*/									// produces 响应类型
    @RequestMapping(value = "/{uid}/changeVideoState", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson changeVideoState(@PathVariable("uid") String uid,String vid,String state,HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        if(MineStringUtils.IsNullOrWhiteSpace(vid)||MineStringUtils.IsNullOrWhiteSpace(state)){
            ajaxJson.setMsg("参数有误...");
            return ajaxJson;
        }
        if(MineStringUtils.IsNullOrWhiteSpace(uid)||!uid.equals(user.getId())){
            ajaxJson.setMsg("不要修改别人信息啦！");
            return ajaxJson;
        }
        x:try {
            Integer intState = Integer.parseInt(state);//转换state
            FrontVideo dataOne = frontVideoService.findOneById(vid);//获取指定视频
            if(dataOne==null){
                msg = "视频id有误...";
            }
            if(!uid.equals(dataOne.getFrontUserId())){//表示取消UP
                msg = "不要修改别人的视频啦...";
            }
            if((intState == -1 && dataOne.getState() != 1)
                    ||(intState == 0 && dataOne.getState() != -1)){//表示取消UP
                msg = "状态有误...";
            }
            if(!MineStringUtils.IsNullOrWhiteSpace(msg)){
                break x;
            }
            //执行修改
            String result = frontVideoService.updateState(vid, intState, FrontVideo.class);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "操作成功!";
            }else{
                msg = result;
            }
        } catch (Exception e) {
            msg = "操作失败，发生异常！";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    /**获取视频详情页面*/
    @RequestMapping(value = "/videoInfo", method = RequestMethod.GET)
    public String getOneInfo(String id,Model model,HttpSession session) {
        FrontVideo one = null;
        String errMsg =null;
        try {
            one = frontVideoService.findOneById(id);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("one",one);
        return "cms/frontVideo/single";
    }
    @RequestMapping(value = "/videoShow", method = RequestMethod.GET)
    public String videoShow(String id,Model model,HttpSession session) {
        try {
            FrontVideo one = frontVideoService.findOneById(id);
            model.addAttribute("one",one);
        } catch (MsgException e) {
            model.addAttribute("erroeMsg",e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            model.addAttribute("erroeMsg","发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return "some/simpleVideoShow";
    }
    @RequestMapping(value = "/videoEdit", method = RequestMethod.GET)
    public String videoEdit(String id,Model model,HttpSession session) {
        try {
            FrontVideo one = frontVideoService.findOneById(id);
            model.addAttribute("one",one);
        } catch (MsgException e) {
            model.addAttribute("erroeMsg",e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            model.addAttribute("erroeMsg","发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return "some/editVideo";
    }

    /**修改视频信息*/
    @RequestMapping(value = "/videoEdit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson videoEdit(FrontVideo one,HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        String scopes[]= {"@all","@user"};
        if (one == null
                ||MineStringUtils.IsNullOrWhiteSpace(one.getId())
                || MineStringUtils.IsNullOrWhiteSpace(one.getName())
                || !MineStringUtils.strIsInStrArrIgnoreCase(one.getScope(), scopes)
                || !MineStringUtils.strIsInStrArrIgnoreCase(one.getType(), FrontVideoType.TYPES)
                || MineStringUtils.IsNullOrWhiteSpace(one.getDesc())) {
            msg = "参数非法!";
        }
        try {
            FrontVideo dataOne = frontVideoService.findOneById(one.getId());//获取指定视频
            if(dataOne==null){
                msg = "视频id有误...";
            }
            if(!user.getId().equals(dataOne.getFrontUserId())){//表示取消UP
                msg = "不要修改别人的视频啦...";
            }
            if(dataOne.getState()!=1||dataOne.getState()!=-1){
                msg = "状态有误...";
            }
            FrontVideo temp = new FrontVideo();
            temp.setId(one.getId());
            temp.setName(one.getName());
            temp.setType(one.getType());
            temp.setScope(one.getScope());
            temp.setDesc(one.getDesc());
            if(dataOne.getState()==1){
                temp.setState(0);//已up视频更新后状态变为待审核
            }
            String result = frontVideoService.update(temp);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "信息更新成功!";
            }else{
                msg = result;
            }
        } catch (Exception e) {
            msg = "信息更新失败，发生异常！";
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    @RequestMapping(value = "/editIcon", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editIcon(MultipartFile imageFile,HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String imgBasePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + "/data/img/";
        //直接获取登录用户id
        FrontUser user = (FrontUser) request.getSession().getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        boolean updateSuccess = false;
        try {
            //允许图像类型
            String[] allowedSuffixs ={"png","jpg","jpeg"};
            //处理文件
            FrontUser oldOne = frontUserService.findOneById(user.getId());
            String newFileName = MineCommonUtils.upLoadFileForStringMVC(SysInfo.IMG_UPLOAD_DIRECTORY, SysInfo.FRONT_ICON_PREFIX, allowedSuffixs, imageFile);
            String resultMsg = frontUserService.changeIcon(user.getId(),newFileName);
            if(resultMsg==null){
                updateSuccess = true;
                String msg = "头像更新成功!";
                String oldIcon = oldOne.getIcon();
                if(!MineStringUtils.IsNullOrWhiteSpace(oldIcon)){
                    //删除旧图片
                    if(MineCommonUtils.delFile(SysInfo.IMG_UPLOAD_DIRECTORY, oldIcon)){
                        msg +="[#旧头像删除成功]";
                        //设置cmsUser新icon
                        user.setIcon(newFileName);
                    }else{
                        msg +="[#旧头像删除失败]";
                    }
                }
                ajaxJson.setSuccess(true);
                ajaxJson.setMsg(msg);
                //设置新图像
                ajaxJson.setObj(imgBasePath+newFileName);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            if(updateSuccess){
                ajaxJson.setMsg("修改头像成功,但删除旧头像发生异常:"+e.getMessage());
            }else{
                ajaxJson.setMsg("修改头像发生异常:"+e.getMessage());
            }
            e.printStackTrace();
        }
        return ajaxJson;
    }
}
