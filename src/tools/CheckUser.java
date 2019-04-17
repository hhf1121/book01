package tools;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pojo.UserSSO;

public class CheckUser {
	private final static String NAME="name";
	
	private final static String PASSWORD="password";

	public static boolean CheckLogin(UserSSO user){
		if(NAME.equals(user.getName())&&PASSWORD.equals(user.getPassword())){
			return true;
		}
		return false;
	}
	
	public static boolean CheckCookie(HttpServletResponse rq,HttpServletRequest rs){
		Cookie[] cookies = rs.getCookies();
		if(cookies!=null){
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("name")&&cookie.getValue().equals("sso")){
					return true;
				}
			}
		}
		return false;
	}
	
	
}
