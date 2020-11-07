package yours.front.controller;

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
import yours.pojo.FrontVideo;
import yours.pojo.FrontVideoType;
import yours.utils.AjaxJson;
import yours.utils.MineStringUtils;


/**
 * 搜索Controller
 * @author Mine
 * @since 2017年6月10日_上午10:50:07
 */
@Controller
@RequestMapping("/")
public class SearchController {
    @Autowired
    private FrontVideoService FrontVideoService;
    @Autowired
    private FrontFavoriteService frontFavoriteService;

    /** 获取搜索页 */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String search(ParamBag paramBag, Model model) {
        String title = "";
        String type = "";
        String key = paramBag.getSearchKey();
        if (MineStringUtils.IsNullWhiteSpace(key)) {
            title = "全部视频：";
            type = "#KEY";
        } else if (MineStringUtils.strIsInStrArrIgnoreCase(key,
                FrontVideoType.TYPES_PRO)) {
            title = "类别："+FrontVideoType.convertTypeCodeToName(key.replace("@", ""));
            type = "#TYPE";
        } else if (MineStringUtils.strIsInStrArrIgnoreCase(key,
                FrontVideoType.SHOW_TYPES)) {
            title = FrontVideoType.convertShowTypeCodeToName(key) + "：";
            type = "#SHOW";
        } else {
            title = "关键字[" + key + "]查询结果：";
            type = "#KEY";
        }
        // 保存查询信息
        model.addAttribute("paramBag", paramBag);
        model.addAttribute("title", title);
        model.addAttribute("type", type);
        return "front/search";
    }

    /** ajax获取信息 */
    @RequestMapping(value = "/search", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public AjaxJson ajaxSearch(ParamBag paramBag, String type) {
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setSuccess(false);
        switch (type.toUpperCase()) {
            case "#SHOW":
                searchWithShow(paramBag, ajaxJson);
                break;
            case "#KEY":
                searchWithKey(paramBag, ajaxJson);
                break;
            case "#TYPE":
                searchWithType(paramBag, ajaxJson);
                break;
            default:
                ajaxJson.setMsg("错误的参数...");
                break;
        }
        return ajaxJson;
    }

    /** 关键字展示等 */
    private void searchWithKey(ParamBag paramBag, AjaxJson ajaxJson) {
        PageInfo<FrontVideo> pageInfo = null;
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), 4).andColumnEqual("fv_state", "1");
        String searchKey = paramBag.getSearchKey();
        if (!MineStringUtils.IsNullOrEmpty(searchKey)) {
            searchKey = searchKey.trim();
            qh.andColumnLikeWithGroup("fv_name", searchKey)
                    .orColumnLike("fv_desc", searchKey)
                    .endGroup();
        }
        qh.set();
        try {
            pageInfo = FrontVideoService.findSomeByQueryHandler(qh);
            ajaxJson.setSuccess(true);
            ajaxJson.setObj(pageInfo);
        } catch (Exception e) {
            ajaxJson.setMsg("发生异常："+e.getMessage());
            e.printStackTrace();
        }
    }

    /** 类型展示等 */
    private void searchWithType(ParamBag paramBag, AjaxJson ajaxJson) {
        PageInfo<FrontVideo> pageInfo = null;
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), 4);
        String type = paramBag.getSearchKey();
        if(!MineStringUtils.strIsInStrArrIgnoreCase(type, FrontVideoType.TYPES_PRO)){
            ajaxJson.setMsg("类型展示:错误的参数...");
            return ;
        }
        qh.andColumnEqual("fv_state", "1")
                .andColumnEqual("fv_type", type.replace("@", "").toUpperCase())
                .set();
        try {
            pageInfo = FrontVideoService.findSomeByQueryHandler(qh);
            ajaxJson.setSuccess(true);
            ajaxJson.setObj(pageInfo);
        } catch (Exception e) {
            ajaxJson.setMsg("发生异常："+e.getMessage());
            e.printStackTrace();
        }
    }

    /** 搜索热门等 */
    private void searchWithShow(ParamBag paramBag, AjaxJson ajaxJson) {
        PageInfo<FrontVideo> pageInfo = null;
        QueryHandler qh = QueryHandler.create();
        if (paramBag != null) {
            paramBag.valiParam();
        }
        qh.limit(paramBag.getNowPage(), 4);
        try {
            switch (paramBag.getSearchKey().toUpperCase()) {
                case "@HOT":
                    qh.andColumnEqual("fv_state", "1").OrderByDESC("fv_hits").set();
                    pageInfo = FrontVideoService.findSomeByQueryHandler(qh);
                    ajaxJson.setSuccess(true);
                    break;
                case "@LIKE":
                    qh.andColumnEqual("fv_state", "1").OrderByDESC("fv_like").set();
                    pageInfo = FrontVideoService.findSomeByQueryHandler(qh);
                    ajaxJson.setSuccess(true);
                    break;
                case "@NEW":
                    qh.andColumnEqual("fv_state", "1").OrderByDESC("fv_uploadTime").set();
                    pageInfo = FrontVideoService.findSomeByQueryHandler(qh);
                    ajaxJson.setSuccess(true);
                    break;
                case "@RECOMMEND":qh.andColumnEqual("F.fu_id", SysInfo.SYSTEM_DATABASE_ID)
                        .OrderByDESC("V.fv_uploadTime").set();
                    pageInfo = frontFavoriteService.findFavoriteVideosByQueryHandler(qh);
                    ajaxJson.setSuccess(true);
                    break;
                default:
                    ajaxJson.setMsg("显示更多:错误的参数...");
                    break;
            }
        } catch (Exception e) {
            ajaxJson.setMsg("发生异常："+e.getMessage());
            e.printStackTrace();
        }
        if(ajaxJson.isSuccess()){
            ajaxJson.setObj(pageInfo);
        }
    }
}
