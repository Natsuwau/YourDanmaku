package yours.admin.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import yours.admin.service.SysUserService;
import yours.info.SysInfo;
import yours.pojo.SysUser;
import yours.utils.AjaxJson;
import yours.utils.MineCommonUtils;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cms")
public class CMSController {

    @Autowired
    private SysUserService sysUserService;

    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson cmsDoLogin(String cmsId, String password,
                               String rememberMe, HttpSession session) {
        Subject currentUser = SecurityUtils.getSubject();
        AjaxJson ajaxJson = new AjaxJson();
        String msg = "";
        UsernamePasswordToken token = null;
        if (!currentUser.isAuthenticated()) {// 未认证
            token = new UsernamePasswordToken(cmsId,
                    password);
            if (!MineStringUtils.IsNullOrWhiteSpace(rememberMe)) {// 不为空即可
                token.setRememberMe(true);
            }
            try {
                currentUser.login(token);
            } catch (UnknownAccountException e) {
                ajaxJson.setSuccess(false);
                msg = "账号不存在!";
            } catch (LockedAccountException e) {
                ajaxJson.setSuccess(false);
                msg = "账号被锁定!";
            } catch (IncorrectCredentialsException e) {
                ajaxJson.setSuccess(false);
                msg = "密码不匹配!";
            } catch (ExcessiveAttemptsException e) {
                ajaxJson.setSuccess(false);
                msg = "尝试登录过于频繁!";
            } catch (AuthenticationException e) {
                ajaxJson.setSuccess(false);
                msg = "shiro认证异常!";
            } catch (Exception e) {
                ajaxJson.setSuccess(false);
                msg = "服务器内部异常:" + e.getMessage();
            }
        } else {
            // 已认证
            ajaxJson.setSuccess(true);
            SysUser cmsUser = (SysUser) currentUser.getPrincipal();
            if (cmsUser.getId().equals(cmsId)) {
                msg = "该账户已登录,是否立即跳转!";
            } else {
                currentUser.logout();
                currentUser.login(token);
            }
        }
        ajaxJson.setMsg(msg);
        return ajaxJson;
    }

    /**
     * 获取CMS登录页
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getCMSLogin() {
        return "CMS-login";
    }

    /**
     * CMS 注销
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String getCMSLogout() {
        SecurityUtils.getSubject().logout();
        return "CMS-login";
    }

    /**
     * 获取CMS首页
     */
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String getCMSIndex(Model model) {
        Subject currentUser = SecurityUtils.getSubject();
        SysUser cmsUser = (SysUser) currentUser.getPrincipal();
        model.addAttribute("cmsUser", cmsUser);//因为jsp页面标签取不到菜单信息
        return "cms/index";
    }

    @RequestMapping(value = "/u/edit", method = RequestMethod.GET)
    public String getCMSUserEdit(Model model) {
        Subject currentUser = SecurityUtils.getSubject();
        SysUser cmsUser = (SysUser) currentUser.getPrincipal();
        SysUser one = null;
        String errMsg = null;
        try {
            one = sysUserService.findOneById(cmsUser.getId());
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:" + e.getMessage();
        }
        model.addAttribute("errMsg", errMsg);
        model.addAttribute("user", one);
        return "cms/cmsUserEdit";
    }

    @RequestMapping(value = "/u/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson edit(SysUser one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if (one == null || (!valiId(one.getId()))) {
            ajaxJson.setMsg("修改失败，ID为空或与登录用户ID不一致!");
            return ajaxJson;
        }
        //不修改头像和密码,状态
        one.setIcon(null);
        one.setPassword(null);
        one.setState(null);
        try {
            String resultMsg = sysUserService.update(one);
            if (resultMsg == null) {
                ajaxJson.setSuccess(true);
                return ajaxJson;
            } else {
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            ajaxJson.setMsg("修改发生异常:" + e.getMessage());
            e.printStackTrace();
        }
        return ajaxJson;
    }

    @RequestMapping(value = "/u/editIcon", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editIcon(MultipartFile imageFile, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String imgBasePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + "/data/img/";
        //直接获取登录用户id
        Subject currentUser = SecurityUtils.getSubject();
        SysUser cmsUser = (SysUser) currentUser.getPrincipal();
        String id = cmsUser.getId();
        boolean updateSuccess = false;
        try {
            //允许图像类型
            String[] allowedSuffixs = {"png", "jpg", "jpeg"};
            //处理文件
            SysUser oldOne = sysUserService.findOneById(cmsUser.getId());
            String newFileName = MineCommonUtils.upLoadFileForStringMVC(SysInfo.IMG_UPLOAD_DIRECTORY, SysInfo.SYSUSER_ICON_PREFIX, allowedSuffixs, imageFile);
            String resultMsg = sysUserService.changeIcon(id, newFileName);
            if (resultMsg == null) {
                updateSuccess = true;
                String msg = "头像更新成功!";
                String oldIcon = oldOne.getIcon();
                if (!MineStringUtils.IsNullOrWhiteSpace(oldIcon)) {
                    //删除旧图片
                    if (MineCommonUtils.delFile(SysInfo.IMG_UPLOAD_DIRECTORY, oldIcon)) {
                        msg += "[#旧头像删除成功]";
                        //设置cmsUser新icon
                        cmsUser.setIcon(newFileName);
                    } else {
                        msg += "[#旧头像删除失败]";
                    }
                }
                ajaxJson.setSuccess(true);
                ajaxJson.setMsg(msg);
                //设置新图像
                ajaxJson.setObj(imgBasePath + newFileName);
                return ajaxJson;
            } else {
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            if (updateSuccess) {
                ajaxJson.setMsg("修改头像成功,但删除旧头像发生异常:" + e.getMessage());
            } else {
                ajaxJson.setMsg("修改头像发生异常:" + e.getMessage());
            }
            e.printStackTrace();
        }
        return ajaxJson;
    }

    @RequestMapping(value = "/u/editPWD", method = RequestMethod.GET)
    public String getCMSUserPWD() {
        return "cms/cmsUserPWD";
    }

    @RequestMapping(value = "/u/editPWD", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson editPassword(String id, String oldPassword, String newPassword) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if (MineStringUtils.IsNullOrWhiteSpace(newPassword)) {
            ajaxJson.setMsg("修改密码失败，新密码为空!");
        }
        if (MineStringUtils.IsNullOrWhiteSpace(oldPassword)) {
            ajaxJson.setMsg("修改密码失败，旧密码为空!");
        }
        if (!valiId(id)) {
            ajaxJson.setMsg("修改密码失败，ID为空或与登录用户ID不一致!");
        }
        x:
        try {
            if (ajaxJson.getMsg() != null) {
                break x;
            }
            String resultMsg = sysUserService.changePassword(id, oldPassword, newPassword);
            if (resultMsg == null) {
                ajaxJson.setSuccess(true);
                return ajaxJson;
            } else {
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("修改密码发生异常:" + e.getMessage());
        }
        return ajaxJson;
    }

    @RequestMapping(value = "/u", method = RequestMethod.GET)
    public String getCMSUserShow(Model model) {
        Subject currentUser = SecurityUtils.getSubject();
        SysUser cmsUser = (SysUser) currentUser.getPrincipal();
        model.addAttribute("cmsUser", cmsUser);
        return "cms/cmsUserShow";
    }

    /**
     * 获取CMS欢迎页
     */
    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public String getCMSWelcome() {
        return "cms/welcome";
    }

    private boolean valiId(String id) {
        if (MineStringUtils.IsNullOrWhiteSpace(id)) {
            return false;

        }
        id = id.trim();
        //获取当前session用户
        Subject currentUser = SecurityUtils.getSubject();
        Object objCmsUser = currentUser.getPrincipal();
        if (objCmsUser == null) {
            return false;
        }
        SysUser cmsUser = (SysUser) objCmsUser;
        if (!id.equals(cmsUser.getId())) {
            return false;
        }
        return true;
    }

}