package controller;

import java.io.Closeable;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.sf.json.JSONObject;
import pojo.User;
import service.userService;

@Controller
public class ssoController {

	@Resource
	private userService userService;

	//http://192.168.50.247:8080/book/borrow/borrowlist.html
	@RequestMapping("/sso.html")
	public String getSuccess(HttpServletRequest requests,HttpServletRequest response,String token){
		User user=new User();
		CloseableHttpClient httpCilent = HttpClients.createDefault();//Creates CloseableHttpClient instance with default configuration.
		HttpGet httpGet = new HttpGet("http://192.168.50.189/galaxy-user-business/sys/user/ssoValidate?token="+token);
		try {
			HttpResponse execute = httpCilent.execute(httpGet);
			System.out.println(execute.getStatusLine().getStatusCode());//状态
			String stringJson = EntityUtils.toString(execute.getEntity());//返回实体
			System.out.println(stringJson);
			//解析实体
			JSONObject fromObject = JSONObject.fromObject(stringJson.toString());
			Object objectJson = fromObject.get("data");
			JSONObject objectStr = JSONObject.fromObject(objectJson);
			String password = (String) objectStr.get("password");
			String username = (String) objectStr.get("username");
			String shortName = (String) objectStr.get("shortName");
			String address = (String) objectStr.get("address");
			user.setPassWord(password);
			user.setUserName(username);
			user.setName(shortName);
			user.setAddress(address);
			//查询用户
			user =userService.QueryUser(user)==null?user:userService.QueryUser(user);
			if(user==null){
				//注册
				int addUser = userService.addUser(user);
				if(addUser>0){
					System.err.println("自动注册成功");
				}
			}
//		    User user= (User)JSONObject.toBean(object,User.class);
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				((Closeable) httpCilent).close();//释放资源
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String url="/borrow/borrowlist.html";

		HttpSession session = requests.getSession();
		session.setAttribute("currentUser", user);
		return "redirect:"+url;
	}

}
