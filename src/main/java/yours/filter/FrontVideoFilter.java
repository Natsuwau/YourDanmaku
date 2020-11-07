package yours.filter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import yours.admin.service.SysUserService;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Component
public class FrontVideoFilter implements Filter {

    @Autowired
    private SysUserService sysUserService;

    public void setSysUserService(SysUserService sysUserService) {
        this.sysUserService = sysUserService;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("FrontVideoFifter(权限视频过滤器)已初始化...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest xRequest = (HttpServletRequest) request;
        String  targetUrl = xRequest.getRequestURL().toString();
        System.out.println(">>>FrontVideoFifter---[来源URL:"
                + xRequest.getHeader("Referer") + "]---[请求URL:"
                + xRequest.getRequestURL() + "]");
	/*	try {
			//截取视频id
//			String[] tempStrs  = targetUrl.split("/");
//			String id = null;
//			if(tempStrs!=null){
//				 id=tempStrs[tempStrs.length].split(".")[0];
//			}
//			System.out.println(id);
			//验证管理员是否登录
			//验证会员是否登录

		//	System.out.println(sysUserService.findOneById("admin"));
		} catch (MsgException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}*/
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("FrontVideoFifter(权限视频过滤器)已销毁...");
    }

}