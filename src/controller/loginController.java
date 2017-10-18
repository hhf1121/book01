package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class loginController {

	@RequestMapping(value="/dologin.html")
	public String Dologin(){
		return "login";
	}
	
	@RequestMapping(value="/doindex.html")
	public String DoIndex(){
		return "index";
	}
	
	
	
}
