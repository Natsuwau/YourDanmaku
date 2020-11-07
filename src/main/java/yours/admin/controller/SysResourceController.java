package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.admin.service.SysResourceService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.pojo.SysResource;
import yours.utils.AjaxJson;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 系统资源Controller

 */
@Controller
@RequestMapping("/cms/sysResource")
public class SysResourceController {
    @Autowired
    private SysResourceService sysResourceService;

    /**获取添加页面*/
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String getAdd(Model model) {
        List<SysResource> cataMenus =null;
        try {
            //获取所有目录菜单: level = 0
            QueryHandler qh = QueryHandler.create()
                    .andColumnEqual("sre_type", "menu")
                    .andColumnEqual("sre_level", "0")
                    .set();
            PageInfo<SysResource> menuPageInfo = sysResourceService.findSomeByQueryHandler(qh);
            if(menuPageInfo != null){
                cataMenus=menuPageInfo.getBasePageList();;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("cataMenus",cataMenus);
        return "cms/sysResource/add";
    }
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson add(SysResource one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null || MineStringUtils.IsNullOrWhiteSpace(one.getName())){
            ajaxJson.setMsg("添加失败，资源名为空!");
            return ajaxJson;
        }
        String [] arrays={"menu","button","common"};
        if(!MineStringUtils.strIsInStrArrIgnoreCase(one.getType(),arrays)){
            ajaxJson.setMsg("添加失败，资源类型非法!");
            return ajaxJson;
        }
        try {
            one.setId(null);//id服务层生成
            if("common".equalsIgnoreCase(one.getType())){
                one.setLevel(null);
                one.setUpLevelId(null);
            }
            if("button".equalsIgnoreCase(one.getType())){
                one.setLevel(null);
            }
            String resultMsg = sysResourceService.add(one);
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
    /**获取修改页面*/
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String getEdit(String id,Model model) {
        SysResource one = null;
        List<SysResource> cataMenus =null;
        String errMsg =null;
        try {
            one = sysResourceService.findOneById(id);
            QueryHandler qh = QueryHandler.create()
                    .andColumnEqual("sre_type", "menu")
                    .andColumnEqual("sre_level", "0")
                    .set();
            PageInfo<SysResource> menuPageInfo = sysResourceService.findSomeByQueryHandler(qh);
            if(menuPageInfo != null){
                cataMenus=menuPageInfo.getBasePageList();;
            }
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("cataMenus",cataMenus);
        model.addAttribute("one",one);
        return "cms/sysResource/edit";
    }
    @RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson edit(SysResource one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null || MineStringUtils.IsNullOrWhiteSpace(one.getId())){
            ajaxJson.setMsg("修改失败，ID为空!");
            return ajaxJson;
        }
        try {
            if(MineStringUtils.IsNullOrWhiteSpace(one.getIcon())){
                one.setIcon(null);
            }
            String resultMsg = sysResourceService.update(one);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            ajaxJson.setMsg("修改发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return ajaxJson;
    }

    /**获取指定id资源详情页面*/
    @RequestMapping(value = "/oneInfo", method = RequestMethod.GET)
    public String getOneInfo(String id,Model model) {
        SysResource one = null;
        String errMsg =null;
        try {
            one = sysResourceService.findOneById(id);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("one",one);
        return "cms/sysResource/single";
    }
    @RequiresPermissions("sysResource:list")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(ParamBag paramBag, HttpServletRequest request) {
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), paramBag.getPageSize());
        String searchKey = paramBag.getSearchKey();
        if (searchKey != null && !"".equals(searchKey)) {
            request.setAttribute("searchKey", searchKey);
            qh.orColumnEqual("sre_id", searchKey)
                    .orColumnLike("sre_name", searchKey)
                    .orColumnLike("sre_orther", searchKey);
        }
        // 排序方式
        qh.OrderByASC("sre_id").set();
        PageInfo<SysResource> pageInfo=null;
        try {
            pageInfo = sysResourceService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/sysResource/list";
    }
}
