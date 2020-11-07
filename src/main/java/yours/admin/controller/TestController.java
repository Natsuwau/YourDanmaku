package yours.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import yours.info.SysInfo;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;

import javax.servlet.http.HttpServletRequest;



@Controller
@RequestMapping("/test")
public class TestController {

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String getTestUpdate() {
        return "cms/uploadTest";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson testUpdate(MultipartFile videoFile, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        try {
            //允许类型
            String[] allowedSuffixs ={"mp4","flv"};
            //处理文件
            //获取视频上传真实目录
            String path = request.getServletContext().getRealPath(SysInfo.VIDEO_UPLOAD_NEW_DIRECTORY);
            System.out.println(path);
            String newFileName = MineCommonUtils.upLoadFileForStringMVC(path, SysInfo.FRONT_VIDEO_PREFIX, allowedSuffixs, videoFile);
            ajaxJson.setSuccess(true);
            ajaxJson.setMsg("视频上传成功!");
            //设置新视频
            ajaxJson.setObj(newFileName);
            return ajaxJson;
        } catch (Exception e) {
            ajaxJson.setMsg("上传视频发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return ajaxJson;
    }
}
