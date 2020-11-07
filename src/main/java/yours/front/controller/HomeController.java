package yours.front.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import yours.front.service.FrontFavoriteService;
import yours.front.service.FrontVideoService;
import yours.info.PageInfo;
import yours.info.QueryHandler;
import yours.info.SysInfo;
import yours.pojo.FrontVideo;

import java.util.List;


@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private FrontVideoService frontVideoService;

    @Autowired
    private FrontFavoriteService frontFavoriteService;



    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home(Model model) {
        List<FrontVideo> recommendList = null;// 推荐视频
        List<FrontVideo> hotList = null;// 热门
        List<FrontVideo> hotListX = null;// 热门
        List<FrontVideo> hotListY = null;// 热门
        List<FrontVideo> likeList = null;// 喜欢
        List<FrontVideo> newList = null;// 最新
        PageInfo<FrontVideo> tempPageInfo = null;
        try {
            QueryHandler qh = QueryHandler.create()
                    .andColumnEqual("F.fu_id", SysInfo.SYSTEM_DATABASE_ID)
                    .andColumnEqual("V.fv_state", "1").limit(1, 3)
                    .OrderByDESC("V.fv_uploadTime").set();
            tempPageInfo = frontFavoriteService
                    .findFavoriteVideosByQueryHandler(qh);
            recommendList = tempPageInfo.getBasePageList();

            qh.clear().andColumnEqual("fv_state", "1").limit(1, 8)
                    .OrderByDESC("fv_hits").set();
            tempPageInfo = frontVideoService.findSomeByQueryHandler(qh);
            hotList = tempPageInfo.getBasePageList();

            qh.clear().andColumnEqual("fv_state", "1").limit(1, 4)
                    .OrderByDESC("fv_like").set();
            tempPageInfo = frontVideoService.findSomeByQueryHandler(qh);
            likeList = tempPageInfo.getBasePageList();

            qh.clear().andColumnEqual("fv_state", "1").limit(1, 4)
                    .OrderByDESC("fv_uploadTime").set();
            tempPageInfo = frontVideoService.findSomeByQueryHandler(qh);
            newList = tempPageInfo.getBasePageList();

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("recommendList", recommendList);
        int size = 0;
        if(hotList!=null&&(size=hotList.size())<=4){
            hotListX=hotList.subList(0, size);
        }else if(hotList!=null&&hotList.size()>4){
            hotListX=hotList.subList(0, 4);
            hotListY=hotList.subList(4, size);
        }
        model.addAttribute("hotListX", hotListX);
        model.addAttribute("hotListY", hotListY);
        model.addAttribute("likeList", likeList);
        model.addAttribute("newList", newList);
        return "front/home";
    }
}
