package yours.admin.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import yours.front.service.FrontHateWordService;
import yours.info.PageInfo;
import yours.info.ParamBag;
import yours.info.QueryHandler;
import yours.pojo.FrontHateWord;
import yours.utils.AjaxJson;
import yours.utils.MineStringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * 关键字屏蔽Controller
 * @author Mine
 * @since 2017年6月9日_下午11:42:45
 */

@Controller
@RequestMapping("/cms/frontHateWord")
public class SysFrontHateWordController {
    @Autowired
    private FrontHateWordService frontHateWordService;
    @RequiresPermissions("frontHateWord:list")
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
            qh.orColumnEqual("fh_id", searchKey)
                    .orColumnEqual("fh_level", searchKey)
                    .orColumnLike("fh_word", searchKey)
                    .orColumnLike("fh_target", searchKey);
        }
        // 排序方式
        qh.set();
        PageInfo<FrontHateWord> pageInfo=null;
        try {
            pageInfo = frontHateWordService.findSomeByQueryHandler(qh);
        } catch (Exception e) {
            request.setAttribute("errMsg", "发生异常:"+e.getMessage());
        }
        request.setAttribute("pageInfo", pageInfo);
        return "cms/frontHateWord/list";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson add(FrontHateWord one) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        if(one ==null
                || MineStringUtils.IsNullOrWhiteSpace(one.getWord())
                || MineStringUtils.IsNullOrWhiteSpace(one.getTarget())){
            ajaxJson.setMsg("参数非法!");
            return ajaxJson;
        }
        try {
            one.setId(null);//id服务层生成
            one.setLevel(1);
            one.setState(1);
            String resultMsg = frontHateWordService.addWithAutoId(one);
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
            String resultMsg = frontHateWordService.delete(id);
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

    @RequestMapping(value = "/pushNew", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson push(HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);

        try {
            FrontHateWord.initHateWordValiInfo(frontHateWordService, request);
            ajaxJson.setMsg("push成功!");
            ajaxJson.setSuccess(true);
            return ajaxJson;
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("push发生异常:"+e.getMessage());
        }
        return ajaxJson;
    }
}
