package yours.pojo;

import yours.front.service.FrontHateWordService;
import yours.info.PageInfo;
import yours.info.SysInfo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class FrontHateWord extends BasePojo {
    private String word;
    private String target;
    private Integer level;


    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    /**
     * 初始化关键字信息
     *
     * @param frontHateWordService
     * @param request
     * @throws Exception
     */
    public static List<FrontHateWord> initHateWordValiInfo(FrontHateWordService frontHateWordService, HttpServletRequest request) throws Exception {
        PageInfo<FrontHateWord> pageInfo = frontHateWordService.findSomeByQueryHandler(null);
        request.getSession().getServletContext().setAttribute(SysInfo.HATE_WORD_VALI_INFO_NAME, pageInfo.getBasePageList());
        return pageInfo.getBasePageList();
    }

    /**
     * 校验并替换屏蔽字
     *
     * @param request
     * @param str
     * @throws Exception
     */
    public static String doValiHateWord(FrontHateWordService frontHateWordService, HttpServletRequest request, String str) throws Exception {
        //获取信息
        List<FrontHateWord> info = (List<FrontHateWord>) request.getSession().getServletContext().getAttribute(SysInfo.HATE_WORD_VALI_INFO_NAME);
        if (info == null) {
            info = initHateWordValiInfo(frontHateWordService, request);
        }
        //执行替换
        for (FrontHateWord keyInfo : info) {
            str = str.replaceAll(keyInfo.getWord(), keyInfo.getTarget());
        }
        return str;
    }
}
