package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.admin.service.SysRoleService;
import yours.admin.service.SysUserService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.SysRole;
import yours.pojo.SysUser;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

/**
 * 系统用户Controller
 */
@Controller
@RequestMapping("/cms/sysUser")
public class SysUserController {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysRoleService sysRoleService;

    /**获取添加页面*/
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String getAdd() {
        return "cms/sysUser/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson add(SysUser one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null || MineStringUtils.IsNullOrWhiteSpace(one.getId())){
            ajaxJson.setMsg("添加失败，ID为空!");
            return ajaxJson;
        }
        try {
            //密码设置为默认值
            one.setPassword(SysInfo.SYSUSER_DEFAULT_PASSWORD);
            String resultMsg = sysUserService.add(one);
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
        SysUser one = null;
        String errMsg =null;
        try {
            one = sysUserService.findOneById(id);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("one",one);
        return "cms/sysUser/edit";
    }
    @RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson edit(SysUser one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null || MineStringUtils.IsNullOrWhiteSpace(one.getId())){
            ajaxJson.setMsg("修改失败，ID为空!");
            return ajaxJson;
        }
        //不修改头像和密码
        one.setIcon(null);
        one.setPassword(null);
        try {
            String resultMsg = sysUserService.update(one);
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
    @RequestMapping(value = "/editPassword", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editPassword(String id,String oldPassword,String newPassword) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(newPassword)){
            ajaxJson.setMsg("修改密码失败，新密码为空!");
        }
        if(MineStringUtils.IsNullOrWhiteSpace(oldPassword)){
            ajaxJson.setMsg("修改密码失败，旧密码为空!");
        }
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("修改密码失败，ID为空!");
        }
        x:try {
            if(ajaxJson.getMsg()!=null){
                break x;
            }
            String resultMsg = sysUserService.changePassword(id, oldPassword, newPassword);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("修改密码发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }
    @RequestMapping(value = "/resetPassword", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson resetPassword(String id) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("重置密码失败，ID为空!");
            return ajaxJson;
        }
        try {
            String resultMsg = sysUserService.resetPassword(id);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg(" 重置密码发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }
    /**获取修改角色页面*/
    @RequestMapping(value = "/editRoles", method = RequestMethod.GET)
    public String getEditRoles(String id,Model model) {
        Set<SysRole> userRoles = null;
        List<SysRole> allRoles = null;
        String errMsg =null;
        try {
            userRoles = sysUserService.findSysRoles(id);
            //增加条件，角色状态为1
            QueryHandler qh = QueryHandler.create();
            qh.andColumnEqual("sro_state", "1").set();
            PageInfo<SysRole> allPageRoles = sysRoleService.findSomeByQueryHandler(qh);
            allRoles = allPageRoles.getBasePageList();
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("id",id);
        model.addAttribute("userRoles",userRoles);
        model.addAttribute("allRoles",allRoles);
        return "cms/sysUser/editRoles";
    }
    @RequestMapping(value = "/editRoles", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editRoles(String id ,String[] roles) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("修改角色失败，ID为空!");
            return ajaxJson;
        }
        if(SysInfo.SYSUSER_SUPER_ADMIN.equals(id)){
            ajaxJson.setMsg("超级管理员角色无法修改!");
            return ajaxJson;
        }
        try {
            String resultMsg = sysUserService.updateUserRoleShip(id, MineCommonUtils.convertArrayToSet(roles));
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            ajaxJson.setMsg("修改角色发生异常:"+e.getMessage());
            e.printStackTrace();
        }
        return ajaxJson;
    }
    @RequiresPermissions("sysUser:list")
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
            qh.orColumnEqual("su_id", searchKey)
                    .orColumnLike("su_name", searchKey)
                    .orColumnLike("su_desc", searchKey);
        }
        // 排序方式
        qh.OrderByASC("su_id").set();
        PageInfo<SysUser> pageInfo=null;
        try {
            pageInfo = sysUserService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/sysUser/list";
    }
}
