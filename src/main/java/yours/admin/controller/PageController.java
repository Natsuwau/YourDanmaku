package yours.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Page Controller
 */
@Controller
@RequestMapping("/pages")
public class PageController {

    /**
     * 获取CMS 401页面
     */
    @RequestMapping(value = "/401", method = RequestMethod.GET)
    public String getCMS401() {
        return "pages/401";
    }
    /**
     * 获取CMS 403页面
     */
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public String getCMS403() {
        return "pages/403";
    }

    /**
     * 获取CMS 404页面
     */
    @RequestMapping(value = "/404", method = RequestMethod.GET)
    public String getCMS404() {
        return "pages/404";
    }

    /**
     * 获取CMS 500页面
     */
    @RequestMapping(value = "/500", method = RequestMethod.GET)
    public String getCMS500() {
        return "pages/500";
    }

    /**
     * 获取功能尚在建设页
     */
    @RequestMapping(value = "/notFinish", method = RequestMethod.GET)
    public String notFinish() {
        return "pages/notFinish";
    }
}
