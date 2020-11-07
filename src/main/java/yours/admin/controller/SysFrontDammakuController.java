package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.front.service.FrontDanmakuService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.pojo.FrontDanmaku;
import yours.utils.AjaxJson;
import yours.utils.MineStringUtils;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/cms/frontDanmaku")
public class SysFrontDammakuController {
    @Autowired
    private FrontDanmakuService frontDanmakuService;
    @RequiresPermissions("frontDanmaku:list")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(ParamBag paramBag, HttpServletRequest request) {
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), paramBag.getPageSize());
        String searchKey = paramBag.getSearchKey();
        if (!MineStringUtils.IsNullOrEmpty(searchKey)) {
            searchKey = searchKey.trim();
            request.setAttribute("searchKey", searchKey);
            qh.orColumnEqual("fd_id", searchKey)
                    .orColumnLike("fd_text", searchKey);
        }
        // 排序方式
        qh.OrderByDESC("fd_createTime").set();
        PageInfo<FrontDanmaku> pageInfo = null;
        try {
            pageInfo = frontDanmakuService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:" + e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontDanmaku/list";
    }

@RequestMapping(value = "/del", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
@ResponseBody
public AjaxJson delete(String id) {
    AjaxJson ajaxJson = new AjaxJson();
    ajaxJson.setSuccess(false);
    if(MineStringUtils.IsNullOrWhiteSpace(id)){
        ajaxJson.setMsg("参数非法!");
        return ajaxJson;
    }
    try {
        String resultMsg = frontDanmakuService.delete(id);
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
}