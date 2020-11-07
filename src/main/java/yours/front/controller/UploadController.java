package yours.front.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import yours.front.service.FrontVideoService;
import yours.info.SysInfo;
import yours.pojo.FrontUser;
import yours.pojo.FrontVideo;
import yours.pojo.FrontVideoType;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;


/**
 * 上传控制方法

 */
@Controller
@RequestMapping("/upload")
public class UploadController {
    @Autowired
    private FrontVideoService frontVideoService;

    /** 步骤一:上传视频文件 */
    @RequestMapping(value = "/stepOne", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson stepOne(MultipartFile videoFile,
                            HttpServletRequest request, HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontUser user = (FrontUser) session
                .getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        FrontVideo tempVideo = (FrontVideo) session
                .getAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
        if (user == null) {
            msg = "上传需要先登录!";
        }
        if (videoFile == null) {
            msg = "上传数据为空!";
        }
        if (!MineStringUtils.IsNullOrEmpty(msg)) {
            ajaxJson.setMsg(msg);
            return ajaxJson;
        }
        if (tempVideo == null) {
            tempVideo = new FrontVideo();
            tempVideo.setFrontUserId(user.getId());
        }
        try {
            // 允许类型
            String[] allowedSuffixs = { "mp4", "flv","webm"};
            // 处理文件
            // 获取视频上传真实目录
            String path = request.getServletContext().getRealPath(
                    SysInfo.VIDEO_UPLOAD_NEW_DIRECTORY);
            System.out.println(path);
            String newFileName = MineCommonUtils.upLoadFileForStringMVC(path,
                    SysInfo.FRONT_VIDEO_PREFIX, allowedSuffixs, videoFile);
            //计算视频长度
            double time = MineCommonUtils.getVideoDuration(path,newFileName);
            // 存入session
            tempVideo.setDuration(time);
            tempVideo.setUrl(newFileName);
            tempVideo.setScope("@all");//确保可以预览
            session.setAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME, tempVideo);
            ajaxJson.setSuccess(true);
            msg = "视频上传成功!";
            // 设置新视频
            ajaxJson.setObj(newFileName);
        } catch (Exception e) {
            if(e.getMessage()==null){
                msg = "上传视频发生异常:" + e.getClass().getName();
            }else{
                msg = "上传视频发生异常:" + e.getMessage();
            }
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }

    /** 步骤二:上传视频附加图片文件 */
    @RequestMapping(value = "/stepTwo/{imagePrefix}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson stepTwo(MultipartFile imageFile,@PathVariable("imagePrefix") String imagePrefix,
                            HttpServletRequest request, HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontVideo tempVideo = (FrontVideo) session
                .getAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
        if (tempVideo == null
                || MineStringUtils.IsNullOrWhiteSpace(tempVideo.getUrl())) {
            msg = "请先完成步骤一:上传视频!";
        }
        String[] strs = { SysInfo.FRONT_VIDEO_PIC_PREFIX,
                SysInfo.FRONT_VIDEO_COVER_PREFIX };
        if (!MineStringUtils.strIsInStrArrIgnoreCase(imagePrefix, strs)) {
            msg = "参数非法!";
        }
        if (imageFile == null) {
            msg = "上传数据为空!";
        }
        if (!MineStringUtils.IsNullOrEmpty(msg)) {
            ajaxJson.setMsg(msg);
            return ajaxJson;
        }
        String imgBasePath = request.getScheme() + "://"+ request.getServerName() + ":"
                + request.getServerPort()
                + "/data/img/";
        try {
            // 允许图像类型
            String[] allowedSuffixs = { "png", "jpg", "jpeg" };
            String newImageName = MineCommonUtils.upLoadFileForStringMVC(
                    SysInfo.IMG_UPLOAD_DIRECTORY, imagePrefix, allowedSuffixs,
                    imageFile);
            if (SysInfo.FRONT_VIDEO_PIC_PREFIX.equals(imagePrefix)) {//设置tempVideo对应属性
                tempVideo.setPicUrl(newImageName);
            }else{
                tempVideo.setCoverUrl(newImageName);
            }
            session.setAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME, tempVideo);
            ajaxJson.setSuccess(true);
            msg = "图片上传成功!";
            ajaxJson.setObj(imgBasePath + newImageName);// 返回图片路径
        } catch (Exception e) {
            if(e.getMessage()==null){
                msg = "图片上传发生异常:" + e.getClass().getName();
            }else{
                msg = "图片上传发生异常:" + e.getMessage();
            }
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    /** 步骤三:接收视频属性并添加到数据库 */
    @RequestMapping(value = "/stepThree", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson stepThree(FrontVideo one,HttpServletRequest request, HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        FrontVideo tempVideo = (FrontVideo) session
                .getAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
        if (tempVideo == null
                || MineStringUtils.IsNullOrWhiteSpace(tempVideo.getUrl())) {
            msg = "请先完成步骤一:上传视频!";
        }
        if (tempVideo == null
                || MineStringUtils.IsNullOrWhiteSpace(tempVideo.getCoverUrl())
                || MineStringUtils.IsNullOrWhiteSpace(tempVideo.getPicUrl())) {
            msg = "请先完成步骤二:上传视频附加图片!";
        }
        String scopes[]= {"@all","@user"};
        if (one == null
                || MineStringUtils.IsNullOrWhiteSpace(one.getName())
                || MineStringUtils.IsNullOrWhiteSpace(one.getType())
                || MineStringUtils.IsNullOrWhiteSpace(one.getScope())
                || !MineStringUtils.strIsInStrArrIgnoreCase(one.getScope(), scopes)
                || !MineStringUtils.strIsInStrArrIgnoreCase(one.getType(), FrontVideoType.TYPES)
                || MineStringUtils.IsNullOrWhiteSpace(one.getDesc())) {
            msg = "参数非法!";
        }
        if (!MineStringUtils.IsNullOrEmpty(msg)) {
            ajaxJson.setMsg(msg);
            return ajaxJson;
        }
        x:try {
            tempVideo.setName(one.getName());
            tempVideo.setType(one.getType());
            tempVideo.setScope(one.getScope());
            tempVideo.setDesc(one.getDesc());
            tempVideo.setUploadTime(new Date());
            tempVideo.setState(0);
            //校验视频名称
            if(frontVideoService.findOneByName(one.getName())!=null){
                msg = "视频名称已存在!";
                break x;
            }
            String result = frontVideoService.addWithAutoId(tempVideo);
            if(MineStringUtils.IsNullOrEmpty(result)){
                msg = "视频信息保存成功，视频上传操作已全部完成!";
                ajaxJson.setSuccess(true);
                //清空对应session
                session.removeAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
            }else{
                msg = result;
            }
        } catch (Exception e) {
            if(e.getMessage()==null){
                msg = "视频新信息保存发生异常:" + e.getClass().getName();
            }else{
                msg = "视频新信息保存发生异常:" + e.getMessage();
            }
            e.printStackTrace();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
    @RequestMapping(value = "/videoShow", method = RequestMethod.GET)
    public String videoShow(Model model, HttpSession session) {
        FrontUser user = (FrontUser) session
                .getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        FrontVideo tempVideo = (FrontVideo) session
                .getAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
        if(user==null){
            model.addAttribute("errorMsg","用户尚未登录!");
        }
        if (tempVideo == null
                || MineStringUtils.IsNullOrWhiteSpace(tempVideo.getUrl())) {
            model.addAttribute("errorMsg","资源不存在!");
        }else if(!user.getId().equals(tempVideo.getFrontUserId())){
            model.addAttribute("errorMsg","该用户尚未上传临时视频!");
            session.removeAttribute(SysInfo.FRONT_TEMP_VIDEO_SESSION_NAME);
        }else{
            model.addAttribute("one",tempVideo);
        }
        return "some/simpleVideoShow";
    }
}
