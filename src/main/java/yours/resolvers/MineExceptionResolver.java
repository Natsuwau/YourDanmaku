package yours.resolvers;

import org.springframework.beans.TypeMismatchException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 异常处理Resolver ,用于接收强转类型发生的异常/其他异常到异常页面 HandlerExceptionResolver
 *
 */
public class MineExceptionResolver implements HandlerExceptionResolver {

    public MineExceptionResolver() {
        System.out.println("MineExceptionResolver------");
    }

    /*
     * @see
     * org.springframework.web.servlet.HandlerExceptionResolver#resolveException
     * (javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse, java.lang.Object,
     * java.lang.Exception)
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest request,
                                         HttpServletResponse response, Object handler, Exception ex) {
        String onePath = getendPath(request);
        System.out.println("[进入MineExceptionResolver异常处理]:异常栈信息>>>");
        ex.printStackTrace();
        if ((ex instanceof TypeMismatchException
                || ex instanceof MethodArgumentTypeMismatchException || ex instanceof NumberFormatException)
                && null != ex.getMessage()) {
            // 真坑。。。用了重定向request没有提示信息，用了转发用post方式又回不去
            return new ModelAndView("redirect:/" + onePath);
        }
        if(ex instanceof org.apache.shiro.authz.UnauthorizedException){//shiro 非法访问异常
            return new ModelAndView("pages/401");
        }
        ModelAndView x = new ModelAndView("pages/500");
        x.addObject("oneException", ex);
        x.addObject("xPath", request.getHeader("Referer"));
        return x;
    }

    private String getendPath(HttpServletRequest request) {
        String oldpath = request.getHeader("Referer");
        String rootpath = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + rootpath + "/";
        System.out.println("来源URL:" + oldpath);
        System.out.println("项目URL:" + basePath);
        if (oldpath == null) {
            return null;
        }
        int index = oldpath.indexOf(basePath);
        String oldControllerURL = null;
        if (index != -1) {
            oldControllerURL = oldpath.substring(index + basePath.length());
            System.out.println("处理后URL：" + oldControllerURL);
        }
        return oldControllerURL;
    }

}
