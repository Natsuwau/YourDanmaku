package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.front.service.FrontFavoriteService;
import yours.front.service.FrontVideoService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontFavorite;
import yours.pojo.FrontVideo;
import yours.utils.AjaxJson;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpServletRequest;

/**
 * 视频管理controller
 */
@Controller
@RequestMapping("/cms/frontVideo")
public class SysFrontVideoController {
    @Autowired
    private FrontVideoService frontVideoService ;
    @Autowired
    private FrontFavoriteService frontFavoriteService;

    @RequiresPermissions("frontVideo:checkList")
    @RequestMapping(value = "/checkList", method = RequestMethod.GET)//待审核list
    public String checkList(ParamBag paramBag, HttpServletRequest request) {
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), paramBag.getPageSize());
        String searchKey = paramBag.getSearchKey();
        qh.andColumnEqual("fv_state","0");
        if (!MineStringUtils.IsNullOrEmpty(searchKey)) {
            searchKey = searchKey.trim();
            request.setAttribute("searchKey", searchKey);
            qh.andColumnLikeWithGroup("fv_desc", searchKey)
                    .orColumnEqual("fv_id", searchKey)
                    .orColumnEqual("fu_id", searchKey)
                    .orColumnEqual("fv_scope", searchKey)
                    .endGroup();
        }
        //时间范围限制
        qh.andColumnDateBetween("fv_uploadTime", paramBag.getStartTime(), paramBag.getEndTime());
        // 排序方式
        qh.OrderByDESC("fv_uploadTime").set();
        PageInfo<FrontVideo> pageInfo=null;
        try {
            pageInfo = frontVideoService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontVideo/checkList";
    }

    //审核通过list
    @RequiresPermissions("frontVideo:passList")
    @RequestMapping(value = "/passList", method = RequestMethod.GET)
    public String okList(ParamBag paramBag, HttpServletRequest request) {
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), paramBag.getPageSize());
        String searchKey = paramBag.getSearchKey();
        qh.andColumnEqual("fv_state","1");
        if (!MineStringUtils.IsNullOrEmpty(searchKey)) {
            searchKey = searchKey.trim();
            request.setAttribute("searchKey", searchKey);
            qh.andColumnLikeWithGroup("fv_desc", searchKey)
                    .orColumnEqual("fv_id", searchKey)
                    .orColumnEqual("fu_id", searchKey)
                    .orColumnEqual("fv_scope", searchKey)
                    .endGroup();
        }
        //时间范围限制
        qh.andColumnDateBetween("fv_uploadTime", paramBag.getStartTime(), paramBag.getEndTime());
        // 排序方式
        qh.OrderByDESC("fv_uploadTime").set();
        PageInfo<FrontVideo> pageInfo=null;
        try {
            pageInfo = frontVideoService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontVideo/passList";
    }
    //禁用list
    @RequiresPermissions("frontVideo:banList")
    @RequestMapping(value = "/banList", method = RequestMethod.GET)
    public String banList(ParamBag paramBag, HttpServletRequest request) {
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), paramBag.getPageSize());
        String searchKey = paramBag.getSearchKey();
        qh.andColumnEqual("fv_state","-1");
        if (!MineStringUtils.IsNullOrEmpty(searchKey)) {
            searchKey = searchKey.trim();
            request.setAttribute("searchKey", searchKey);
            qh.andColumnLikeWithGroup("fv_desc", searchKey)
                    .orColumnEqual("fv_id", searchKey)
                    .orColumnEqual("fu_id", searchKey)
                    .orColumnEqual("fv_scope", searchKey)
                    .endGroup();
        }
        //时间范围限制
        qh.andColumnDateBetween("fv_uploadTime", paramBag.getStartTime(), paramBag.getEndTime());
        // 排序方式
        qh.OrderByDESC("fv_uploadTime").set();
        PageInfo<FrontVideo> pageInfo=null;
        try {
            pageInfo = frontVideoService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontVideo/banList";
    }
    @RequiresPermissions("frontVideo:recommendList")
    @RequestMapping(value = "/recommendList", method = RequestMethod.GET)
    public String recommendList(ParamBag paramBag, HttpServletRequest request) {
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), paramBag.getPageSize());
        String searchKey = paramBag.getSearchKey();
        qh.andColumnEqual("F.fu_id", SysInfo.SYSTEM_DATABASE_ID);
        if (!MineStringUtils.IsNullOrEmpty(searchKey)) {
            searchKey = searchKey.trim();
            request.setAttribute("searchKey", searchKey);
            qh.andColumnEqual("F.fv_id", searchKey);
        }
        qh.set();
        PageInfo<FrontVideo> pageInfo=null;
        try {
            pageInfo = frontFavoriteService.findFavoriteVideosByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontVideo/recommendList";
    }
    @RequestMapping(value = "/recommendAdd", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson recommendAdd(String  vid) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(vid)){
            ajaxJson.setMsg("参数非法!");
            return ajaxJson;
        }
        try {
            FrontFavorite temp = new FrontFavorite();
            temp.setFrontUserId(SysInfo.SYSTEM_DATABASE_ID);
            temp.setFrontVideoId(vid.trim());
            temp.setId(null);//id服务层生成
            temp.setState(1);
            String resultMsg = frontFavoriteService.addWithAutoId(temp);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("添加发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }
    @RequestMapping(value = "/recommendDel", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson recommendDel(String id) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("参数非法!");
            return ajaxJson;
        }
        try {
            String resultMsg = frontFavoriteService.delete(id);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("删除发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }
    /**获取指定id详情页面*/
    @RequestMapping(value = "/oneInfo", method = RequestMethod.GET)
    public String getOneInfo(String id, Model model) {
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
    public String videoShow(String id,Model model) {
        try {
            FrontVideo one = frontVideoService.findOneById(id);
            model.addAttribute("one",one);
        } catch (MsgException e) {
            model.addAttribute("errorMsg",e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            model.addAttribute("errorMsg","发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return "some/simpleVideoShow";
    }
    @RequestMapping(value = "/banVideo", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson banVideo(String id) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("切换状态失败，ID为空!");
            return ajaxJson;
        }
        try {
            String resultMsg = frontVideoService.updateState(id, -1, FrontVideo.class);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("切换状态失败,发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }
    @RequestMapping(value = "/checkVideo", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson checkVideo(String id,String state) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("切换状态失败，ID为空!");
            return ajaxJson;
        }
        String[] states ={"-1","1"};
        if(MineStringUtils.IsNullOrWhiteSpace(state)||!MineStringUtils.strIsInStrArr(state, states)){
            ajaxJson.setMsg("切换状态失败，state非法!");
            return ajaxJson;
        }
        try {
            String resultMsg = frontVideoService.updateState(id, Integer.parseInt(state), FrontVideo.class);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("切换状态失败,发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }

}
