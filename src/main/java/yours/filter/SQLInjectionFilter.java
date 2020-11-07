package yours.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.*;

/**
 * 过滤提交表单中的有安全隐患的字符串，以防止SQL注入
 *
 * 使用方法：在Filter映射中加入2个参数 参数1：dataFields，用于指定被过滤掉的词汇，用空格分开，例如：delete insert
 * 参数2：formFields，需要过滤的表单参数名，用空格分开，例如：user pass
 *
 */

public class SQLInjectionFilter implements Filter {

    /**
     * 过滤器初始化参数
     */
    private FilterConfig filterConfig = null;

    /**
     * 敏感字字典
     */
    private static LinkedList<Pair> wordMap = null;

    /**
     * 构造器
     */
    public SQLInjectionFilter() {
    }

    /**
     * 从Servlet参数中读取Words替换规则并存入wordMap中
     *
     * @param request
     * @param response
     * @throws IOException
     * @throws ServletException
     */
    private void doBeforeProcessing(ServletRequest request,
                                    ServletResponse response) throws IOException, ServletException {

        System.out.println("SQL注入防范过滤器（处理前）===============");
        if (wordMap == null) {
            wordMap = new LinkedList<Pair>();
            Enumeration<?> enums = filterConfig.getInitParameterNames();
            while (enums.hasMoreElements()) {
                String key = (String) enums.nextElement();
                String value = filterConfig.getInitParameter(key);
                if (key.equals("dataFields")) {
                    for (String s : value.split(" ")) {
                        wordMap.add(new Pair(s, ""));
                    }
                } else {
                    wordMap.add(new Pair(key, value));
                    key = null;
                    value = null;
                }
            }

            // 其他不好在Filter中过滤的符号，也可以顺便解决数据库入库时候的非法符号
            wordMap.add(new Pair("\"", "&quot;"));// 双引号
            wordMap.add(new Pair("\'", "''"));// 单引号用''替代
            wordMap.add(new Pair("&", "&amp;"));// &
            // 替换掉所有的HTML和JS、CSS标签
            wordMap.add(new Pair("<", "&lt;"));
            wordMap.add(new Pair(">", "&gt;"));
        }
    }

    private void doAfterProcessing(ServletRequest request,
                                   ServletResponse response) throws IOException, ServletException {

    }

    /**
     * 过滤规则
     *
     */
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        //指定过滤list结尾url
        String[] x = req.getRequestURL().toString().split("[?]")[0].split("/");
        String endStr = "";
        if(x.length>=1){
            endStr = x[x.length-1];
        }
        endStr = endStr.toUpperCase();
        if(!endStr.endsWith("LIST")){//list 结尾
            chain.doFilter(request, response);
            return;
        }
        System.out.println(">>>["+endStr+"]结尾,触发SQLInjectionFilter---[来源URL:"
                + req.getHeader("Referer") + "]---[请求URL:"
                + req.getRequestURL() + "]");
        //System.out.println(endStr);

        // 前置处理：读取替换规则并保存到wordMap中
        doBeforeProcessing(request, response);

        // 使用替换规则重新包装请求参数
        Throwable problem = null;
        try {
            // 过滤参数
            request = new NewWrapper((HttpServletRequest) request, wordMap);

            // 放行
            chain.doFilter(request, response);
        } catch (Throwable t) {
            problem = t;
            t.printStackTrace();
        }

        // 执行目标方法之后执行的操作
        doAfterProcessing(request, response);
        if (problem != null) {
            if (problem instanceof ServletException)
                throw (ServletException) problem;
            if (problem instanceof IOException)
                throw (IOException) problem;
            sendProcessingError(problem, response);
        }
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    public void destroy() {
        System.out.println("SQL Filter Destroy====================");
    }

    /**
     * 过滤器初始化方法，得到过滤器的初始化参数
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        System.out.println("SQL注入过滤器初始化====================");
    }

    public String toString() {
        if (filterConfig == null)
            return ("SQLInjectionFilter()");
        StringBuffer sb = new StringBuffer("SQLInjectionFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); // NOI18N
                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); // NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}

/**
 * 键值对
 *
 *
 */
class Pair {
    public String key;
    public String value;

    public Pair(String k, String v) {
        key = k;
        value = v;
    }
}

class NewWrapper extends HttpServletRequestWrapper {
    private LinkedList<Pair> wordMap;

    public NewWrapper(HttpServletRequest req, LinkedList<Pair> map) {
        super(req);
        wordMap = map;
    }

    @Override
    public Map<String, String[]> getParameterMap() {
        try {
            Map<String, String[]> params = super.getParameterMap();
            if (params != null) {
                Set<String> keyset = params.keySet();
                for (String key : keyset) {
                    String[] paramvalues = params.get(key);
                    for (int i = 0; i < paramvalues.length; i++) {
                        Iterator<Pair> itr = wordMap.listIterator();
                        while (itr.hasNext()) {
                            Pair p = itr.next();
                            paramvalues[i] = paramvalues[i].replaceAll(p.key,
                                    p.value);
                        }
                        paramvalues[i] = paramvalues[i].trim();
                    }
                }
            }
            return params;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public String getParameter(String str) {
        try {
            String param = super.getParameter(str);
            Iterator<Pair> itr = wordMap.listIterator();
            while (itr.hasNext()) {
                Pair p = itr.next();
                param = param.replaceAll(p.key, p.value);
            }
            System.out.println(param.trim()
                    + "==============getParameter trim()");
            return param.trim();
        } catch (Exception e) {
            return null;
        }
    }
}