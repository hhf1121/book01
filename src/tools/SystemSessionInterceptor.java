package tools;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class SystemSessionInterceptor implements HandlerInterceptor {
    private static final String LOGIN_URL="/jsp/login.jsp";

    private final Log log = LogFactory.getLog(this.getClass());

    /**
     * 方法执行后，渲染之前。
     * 异常，不会执行
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {


    }

    /**
     * 视图渲染后。即使异常，也会执行
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception ex)
            throws Exception {

    }

    /**
     * 在处理方法之前执行
     * @param request  获取request属性
     * @param response
     * @param handler  封装了当前方法的信息
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session=request.getSession(true);
       //handler
        try{
            HandlerMethod method=(HandlerMethod) handler;
            log.info("类名："+method.getBean().getClass().getName());
            log.info("方法名："+method.getMethod().getName());
            log.info("参数：");
            if(handler instanceof HandlerMethod){
                HandlerMethod handlerMethod = (HandlerMethod)handler;
                MethodParameter[] methodParameters = handlerMethod.getMethodParameters();
                for(MethodParameter methodParameter : methodParameters){
                    log.info(methodParameter.getParameterName());
                }
            }
            //session中获取用户名信息
            Object obj = session.getAttribute("currentUser");
            if (obj==null||"".equals(obj.toString())) {
                log.info("未登录");
                response.sendRedirect(request.getContextPath()+LOGIN_URL);
                return false;
            }else {
                log.info("当前用户session过期时间："+session.getMaxInactiveInterval());
                log.info("已登录");
                session.setMaxInactiveInterval(30*60);//session续期：30分钟
            }
        }catch (Exception e){
            log.error(e.getMessage());
        }
        return true;
    }
}
