package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.front.service.FrontUserService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.pojo.FrontUser;
import yours.utils.AjaxJson;
import yours.utils.MineStringUtils;
import yours.utils.MsgException;

import javax.servlet.http.HttpServletRequest;

/**
 * 前台用户管理controller
 */
@Controller
@RequestMapping("/cms/frontUser")
public class SysFrontUserController {
    @Autowired
    private FrontUserService  frontUserService;
    @RequiresPermissions("frontUser:list")
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
            qh.orColumnEqual("fu_id", searchKey)
                    .orColumnLike("fu_signature", searchKey)
                    .orColumnLike("fu_name", searchKey)
                    .orColumnLike("fu_phone", searchKey)
                    .orColumnLike("fu_email", searchKey);
        }
        //时间范围限制
        qh.andColumnDateBetween("fu_regTime", paramBag.getStartTime(), paramBag.getEndTime());
        // 排序方式
        qh.OrderByDESC("fu_regTime").set();
        PageInfo<FrontUser> pageInfo=null;
        try {
            pageInfo = frontUserService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontUser/list";
    }

    /**获取指定id详情页面*/
    @RequestMapping(value = "/oneInfo", method = RequestMethod.GET)
    public String getOneInfo(String id,Model model) {
        FrontUser one = null;
        String errMsg =null;
        try {
            one = frontUserService.findOneById(id);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("one",one);
        return "cms/frontUser/single";
    }

    @RequestMapping(value = "/changeState", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson changeState(String id,String state) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(MineStringUtils.IsNullOrWhiteSpace(id)){
            ajaxJson.setMsg("切换状态失败，ID为空!");
            return ajaxJson;
        }
        String[] states ={"0","1"};
        if(MineStringUtils.IsNullOrWhiteSpace(state)||!MineStringUtils.strIsInStrArr(state, states)){
            ajaxJson.setMsg("切换状态失败，state非法!");
            return ajaxJson;
        }
        try {
            String resultMsg = frontUserService.updateState(id, Integer.parseInt(state) == 1 ? 0 :1 , FrontUser.class);
            if(resultMsg==null){
                ajaxJson.setSuccess(true);
                return ajaxJson;
            }else{
                ajaxJson.setMsg(resultMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg(" 切换状态失败异常:"+e.getMessage());
        }
        return ajaxJson;
    }

    /**获取修改硬币页面*/
    @RequestMapping(value = "/coinEdit", method = RequestMethod.GET)
    public String getCoinEdit(String id,Model model) {
        FrontUser one = null;
        String errMsg =null;
        try {
            one = frontUserService.findOneById(id);
        } catch (MsgException e) {
            e.printStackTrace();
            errMsg = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errMsg = "发生异常:"+e.getMessage();
        }
        model.addAttribute("errMsg",errMsg);
        model.addAttribute("one",one);
        return "cms/frontUser/coinEdit";
    }
    @RequestMapping(value = "/coinEdit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson coinEdit(String id,String coin ,String type,String num) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        String[] types = {"add","minus"};
        if(MineStringUtils.IsNullOrWhiteSpace(id)||
                MineStringUtils.IsNullOrWhiteSpace(coin)||
                MineStringUtils.IsNullOrWhiteSpace(type)||
                MineStringUtils.IsNullOrWhiteSpace(num)||
                !MineStringUtils.strIsInStrArrIgnoreCase(type, types)){
            ajaxJson.setMsg("修改失败，参数非法!");
            return ajaxJson;
        }
        x:try {
            int intCoin = Integer.parseInt(coin);
            int intNum = Integer.parseInt(num);
            int newCoin = "add".equalsIgnoreCase(type) ? (intCoin+intNum):(intCoin-intNum);
            if(newCoin<0){
                ajaxJson.setMsg("错误的改动数目!");
                break x;
            }
            FrontUser temp  = new FrontUser();
            temp.setId(id);
            temp.setCoin(newCoin);
            String resultMsg = frontUserService.update(temp);
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

}
