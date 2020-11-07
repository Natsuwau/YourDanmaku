package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.admin.service.SysResourceService;
import yours.admin.service.SysRoleService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.pojo.SysResource;
import yours.pojo.SysRole;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

/**
 * 系统角色Controller
 */
@Controller
@RequestMapping("/cms/sysRole")
public class SysRoleController {
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private SysResourceService sysResourceService;
    /**获取添加页面*/
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String getAdd() {
        return "cms/sysRole/add";
    }
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson add(SysRole one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null || MineStringUtils.IsNullOrWhiteSpace(one.getName())){
            ajaxJson.setMsg("添加失败，角色名为空!");
            return ajaxJson;
        }
        try {
            one.setId(null);//id服务层生成
            String resultMsg = sysRoleService.add(one);
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
    public String getEdit(String id, Model model) {
        SysRole one = null;
        String errMsg =null;
        try {
            one = sysRoleService.findOneById(id);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("one",one);
        return "cms/sysRole/edit";
    }
    @RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson edit(SysRole one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null || MineStringUtils.IsNullOrWhiteSpace(one.getId())){
            ajaxJson.setMsg("修改失败，ID为空!");
            return ajaxJson;
        }
        try {
            String resultMsg = sysRoleService.update(one);
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

    /**获取修改角色映射资源页面*/
    @RequestMapping(value = "/editResources", method = RequestMethod.GET)
    public String getEditResources(String id,Model model) {
        Set<SysResource> target =null;
        String errMsg =null;
        try {
            Set<SysResource> roleResources = sysRoleService.findResources(id);
            QueryHandler qh = QueryHandler.create();
            qh.andColumnEqual("sre_state", "1").set();
            PageInfo<SysResource> allPageallResources = sysResourceService.findSomeByQueryHandler(qh);
            List<SysResource> allResources = allPageallResources.getBasePageList();
            target = MineCommonUtils.markSysResourcesCheckedByPartInfo(allResources, roleResources);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("id",id);
        model.addAttribute("target",target);
        return "cms/sysRole/editResources";
    }

    @RequestMapping(value = "/editResources", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editResources(String id ,String[] resources) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("修改所拥有资源失败，ID为空!");
            return ajaxJson;
        }
        try {
            String resultMsg = sysRoleService.updateRoleResourceShip(id,MineCommonUtils.convertArrayToSet(resources));
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            ajaxJson.setMsg("修改所拥有资源发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return ajaxJson;
    }
    @RequiresPermissions("sysRole:list")
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
            qh.orColumnEqual("sro_id", searchKey)
                    .orColumnLike("sro_name", searchKey)
                    .orColumnLike("sro_desc", searchKey);
        }
        // 排序方式
        qh.OrderByASC("sro_id").set();
        PageInfo<SysRole> pageInfo=null;
        try {
            pageInfo = sysRoleService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/sysRole/list";
    }
}
