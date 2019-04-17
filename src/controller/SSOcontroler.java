package controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pojo.UserSSO;
import tools.CheckUser;



@Controller
@RequestMapping("/sso")
public class SSOcontroler {

	@RequestMapping(value="/login1",method=RequestMethod.GET)
	public String Login1(UserSSO user,HttpServletResponse rq,HttpServletRequest rs){
		if(CheckUser.CheckCookie(rq, rs)){
			return user.getUrl();
		}else if(CheckUser.CheckLogin(user)){
			Cookie cook=new Cookie("name", "sso");
			rq.addCookie(cook);
			return user.getUrl();
		}
		return "login1";
	}

	@RequestMapping(value = "/login2", method = RequestMethod.GET)
	public String Login2(UserSSO user, HttpServletResponse rq, HttpServletRequest rs) {
		if (CheckUser.CheckCookie(rq, rs)) {
			return user.getUrl();
		} else if (CheckUser.CheckLogin(user)) {
			Cookie cook = new Cookie("name", "sso");
			rq.addCookie(cook);
			return user.getUrl();
		}
		return "login2";
	}

}
