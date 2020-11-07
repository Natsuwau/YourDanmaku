package yours.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class EncodingFilter implements Filter {
    private String encodeType = null;

    @Override
    public void destroy() {
        // TODO 自动生成的方法存根
        System.out.println("编码过滤器已销毁。。。");
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp,
                         FilterChain chain) throws IOException, ServletException {
        // 设置编码
        req.setCharacterEncoding(this.encodeType);
        resp.setCharacterEncoding(this.encodeType);
        HttpServletRequest request = (HttpServletRequest) req;
        System.out.println(">>>调用Encoding过滤器---[来源URL:"
                + request.getHeader("Referer") + "]---[请求URL:"
                + request.getRequestURL() + "]");
        chain.doFilter(req, resp);
        // System.out.println("**********doFilter()方法执行后**********");
    }

    @Override
    public void init(FilterConfig config) throws ServletException {
        // TODO 自动生成的方法存根
        System.out.println("编码过滤器完成初始化。。。");
        this.encodeType = config.getInitParameter("encodeType");
        if (encodeType == null) {
            System.out.println("配置编码读取错误:使用默认【utf-8】编码");
            encodeType = "utf-8";
        }

    }

}
