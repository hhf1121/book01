package tools;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SystemSessionInterceptor implements HandlerInterceptor {
    private static final String LOGIN_URL="/jsp/login.jsp";
    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {


    }

    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception ex)
            throws Exception {

    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session=request.getSession(true);
        //session中获取用户名信息
        Object obj = session.getAttribute("currentUser");
        if (obj==null||"".equals(obj.toString())) {
            System.out.println("未登录");
            response.sendRedirect(request.getSession().getServletContext().getContextPath()+LOGIN_URL);
            return false;
        }else {
            System.out.println("当前用户session过期时间："+session.getMaxInactiveInterval());
            System.out.println("已登录");
            session.setMaxInactiveInterval(30*60);//session续期：30分钟
        }
        return true;
    }
}
