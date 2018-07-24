package cn.hqb.pets.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.hqb.pets.pojo.admin.TAdmin;

public class AdminInterceptor implements HandlerInterceptor {

	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		
		//获取请求的url
        String url = request.getRequestURI();
        System.out.println(url);
        //判断url是否是公开 地址（实际使用时将公开 地址配置配置文件中）
        //这里公开地址是登陆提交的地址
        if(url.indexOf("adminLogin")>=0){
            //如果进行登陆提交，放行
            return true;
        }
        if(url.indexOf("login")>=0){
            //如果进行登陆提交，放行
            return true;
        }
        if(url.indexOf("adminLogin")>=0){
            //如果进行登陆提交，放行
            return true;
        }
        
        //判断session
        HttpSession session  = request.getSession();
        //从session中取出用户身份信息
        TAdmin admin = (TAdmin) session.getAttribute("admin");
        
        if(admin != null){
            //身份存在，放行
            return true;
        }
        
        //执行这里表示用户身份需要认证，跳转登陆页面
        request.getRequestDispatcher("/WEB-INF/jsp/reglog/adminLogin.jsp").forward(request, response);
        
        //return false表示拦截，不向下执行
        //return true表示放行
		
		return false;
	}

}
