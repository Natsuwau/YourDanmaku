package yours.front.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.front.service.*;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.SysInfo;
import yours.pojo.*;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MsgException;
import yours.utils.MineStringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**弹幕视频观看*/
@Controller
@RequestMapping("/single")
public class SingleController {
    @Autowired
    private FrontVideoService frontVideoService;
    @Autowired
    private FrontDanmakuService frontDanmakuService;
    @Autowired
    private FrontCommentService frontCommmentService;
    @Autowired
    private FrontHateWordService frontHateWordService;
    @Autowired
    private FrontTaskService frontTaskService;

    /**视频页*/
    @RequestMapping(value = "/{vid}", method = RequestMethod.GET)
    public String single(@PathVariable("vid")String vid,HttpServletRequest request, HttpSession session) {
        FrontVideo one = null;
        List<FrontVideo> relevantList =null;
        FrontUser user = (FrontUser) session.getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        String errorMsg = null;
        x:try {
            one = frontVideoService.findOneById(vid);
            if(one == null){
                errorMsg = "视频ID无效!";
                break x;
            }
            if(one.getState() != 1){
                errorMsg = "视频限制访问!";
                break x;
            }
            if("@USER".equalsIgnoreCase(one.getScope()) &&user==null){
                errorMsg = "会员专享视频，请先登录...";
                FrontVideo temp = new FrontVideo();
                temp.setName(one.getName());
                request.setAttribute("one", temp);
                break x;
            }
            relevantList = frontVideoService.findByKeys(MineStringUtils.getSimpleKeys(one.getName(),2),one.getId());
            //增加点击量
            long hits = frontVideoService.addOneHit(vid);
            one.setHits(hits);
            //如果用户登录，完成每日视频任务w
            if(user!=null){
                String result = frontTaskService.doTask(user.getId(), 1, 1);
                System.out.println(result);
            }
            request.setAttribute("one", one);
            request.setAttribute("relevantList", relevantList);
        } catch (MsgException e) {
            e.printStackTrace();
            errorMsg =  e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg =  "发生异常:"+e.getMessage();
        }
        request.setAttribute("errorMsg", errorMsg);
        return "front/single";
    }
    @RequestMapping(value = "/danmaku", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Map<String,Object> getDanmaku(String id,String max) {
        //根据id获取视频弹幕
        List<FrontDanmaku> danmakus = null;
        try {
            danmakus = frontDanmakuService.findByVideoId(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String,Object> danmakuBag=new HashMap<String, Object>();
        danmakuBag.put("code", 1);
        danmakuBag.put("danmaku", danmakus);
        return danmakuBag;
    }

    @RequestMapping(value = "/danmaku", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Map<String,Object> addDanmaku(HttpServletRequest request,HttpSession session) {
        String json=MineCommonUtils.readJSONStringByRequest(request);
        ObjectMapper oneJson = new ObjectMapper();
        String msg = "";
        FrontDanmaku one = null;
        try {
            Map<String,Object> map = oneJson.readValue(json, Map.class);
            one = FrontDanmaku.parseDanmakuFromMap(map);
            //执行屏蔽
            String text = FrontHateWord.doValiHateWord(frontHateWordService, request, one.getText());
            one.setText(text);
            FrontUser user = (FrontUser) session
                    .getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
            if(user!=null){
                one.setFrontUserId(user.getId());
            }
            if(user==null){//不登录只能使用基本弹幕
                one.setColor("#fff");
                one.setType("right");
            }
            if(user==null||user.getCoin()<200){//500硬币以下只能使用颜色
                one.setType("right");
            }

            String dId =MineCommonUtils.getUUID_NoHyphen();
            one.setId(dId);
            one.setCreateTime(new Date());
            one.setState(1);
            msg = frontDanmakuService.add(one);
        }catch (Exception e) {
            msg = "异常:"+e.getMessage();
            e.printStackTrace();
        }
        //新增一条弹幕
        Map<String,Object> danmakuBag =new HashMap<String, Object>();
        if(MineStringUtils.IsNullOrEmpty(msg)){
            danmakuBag.put("code", 1);
            danmakuBag.put("msg", msg);  //返回的错误信息
        }else{
            danmakuBag.put("code", 0);
            danmakuBag.put("data", one);
        }
        return danmakuBag;
    }

    @RequestMapping(value = "/comment", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson getComment(ParamBag paramBag,String vid) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if (paramBag != null) {
            paramBag.valiParam();
        }
        //根据id获取视频评论
        PageInfo<FrontComment> commentPageInfo = null;
        try {
            commentPageInfo = frontCommmentService.findSomeByVid(vid,paramBag);
            ajaxJson.setSuccess(true);
            ajaxJson.setObj(commentPageInfo);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }

    @RequestMapping(value = "/comment", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson addComment(String text,String vid,HttpServletRequest request,HttpSession session) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String msg = "";
        if (MineStringUtils.IsNullOrWhiteSpace(text)||MineStringUtils.IsNullOrWhiteSpace(vid)) {
            ajaxJson.setMsg("参数有误...");
            return ajaxJson;
        }
        FrontUser user = (FrontUser) session
                .getAttribute(SysInfo.FRONT_USER_SESSION_NAME);
        if (user == null) {
            msg = "需要先登录!";
        }
        try {
            //执行关键字屏蔽
            text = FrontHateWord.doValiHateWord(frontHateWordService, request, text);
            FrontComment temp = new FrontComment();
            temp.setContent(text);
            temp.setFrontVideoId(vid);
            temp.setFrontUserId(user.getId());
            temp.setTime(new Date());
            String result = frontCommmentService.addWithAutoId(temp);
            if(MineStringUtils.IsNullOrEmpty(result)){
                ajaxJson.setSuccess(true);
                msg = "评价成功!";
            }else{
                msg = result;
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "发生异常:"+e.getMessage();
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }
}
