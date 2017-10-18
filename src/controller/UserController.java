package controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.sf.json.JSONObject;
import pojo.Role;
import pojo.User;
import pojo.listNo;
import service.RoleService;
import service.listNoService;
import service.userService;
import tools.Page;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private userService userService;
	@Resource
	private listNoService listNoService;
	@Resource
	private RoleService roleService;
	
	// ��֤�˺��Ƿ����
	@RequestMapping(value = "/ifExist")
	@ResponseBody
	public String ifExist(@RequestParam("userName") String userName) {
		System.err.println("..................ajax��֤.....");
		if (userService.ifExist(userName) > 0) {
			return "false";
		}
		return "true";
	}

	@RequestMapping(value = "/adduser.html",method=RequestMethod.POST)
	public String addUser(User user, Model model,HttpServletRequest request,
			@RequestParam(value="pic",required=false) MultipartFile file) {
		String picPath="";
		if(!file.isEmpty()){
			System.err.println("------------------------ͷ���ļ��ϴ�");
			String Name=file.getOriginalFilename();//�ļ���
			String fileEndName=FilenameUtils.getExtension(Name);//��׺
			String path=request.getSession().getServletContext().getRealPath("statics"+File.separator+"uploadPath");//�洢·��
			if(fileEndName.equalsIgnoreCase("jpg")||fileEndName.equalsIgnoreCase("png")
					||fileEndName.equalsIgnoreCase("jpeg")||fileEndName.equalsIgnoreCase("pneg")){
				String fileName=System.currentTimeMillis()+RandomUtils.nextInt(10000000)+"_pic.jpg";
				File f=new File(path,fileName);
				if(!f.exists()){
					f.mkdirs();
				}
				try {
					file.transferTo(f);
					picPath=path+File.separator+fileName;//����·�����֡�
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
					model.addAttribute("error", "�ϴ�ʧ�ܣ���");
				}
			}else{
				model.addAttribute("error", "ͼƬ��ʽ���ԣ�");
				return "index";
			}
		}
		int x = 0;
		try {
			picPath=picPath.equals("")? "": picPath.substring(picPath.indexOf("statics"));//��ȡ·�������档
			user.setPicPath(picPath);
			x = userService.addUser(user);
		} catch (Exception e) {
			System.err.println("�û�ע��ʧ�ܣ�");
		}
		if (x > 0) {
			model.addAttribute("info", "ע��ɹ���");
			return "login";
		} else {
			model.addAttribute("error", "ע��ʧ�ܣ�");
			return "index";
		}
	}

	@RequestMapping(value = "/login.html")
	public String Login(Model model, HttpSession session,
			@RequestParam(value = "userName", required = false) String userName,
			@RequestParam(value = "passWord", required = false) String passWord
			/*@Valid User user,BindingResult br*/) {
		User user = new User();
		user.setPassWord(passWord);
		user.setUserName(userName);
		/*if(br.hasErrors()){
			System.err.println("jsr303��֤ʧ��");
			System.err.println(user.getPassWord());
			System.err.println(user.getUserName());
			System.err.println(br.toString());
			return "login";
		}*/
		System.err.println(user);
		User u = userService.QueryUser(user);
		if (u != null || (u = (User) session.getAttribute("currentUser")) != null) {
			session.setAttribute("currentUser", u);// �Ž�session��
			List<listNo> list = listNoService.QueryListByYseNo(u.getYes());
			String role = u.getYes() == 1 ? "��ͨ��Ա" : "vip��Ա";
			if (u.getYes() == 3) {
				role = "����Ա";
			}
			session.setAttribute("list", list);
			session.setAttribute("role", role);
			return "main";
		} else {
			model.addAttribute("info", "�˺Ż��������");
			return "login";
		}
	}

	// �˳�
	@RequestMapping(value = "/out.html")
	public String out(HttpSession session) {
		session.removeAttribute("currentUser");
		session.invalidate();
		return "login";
	}

	@RequestMapping(value = "/userlist.html")
	public String userlist(HttpSession session, Model model) {
		User u = (User) session.getAttribute("currentUser");
		System.err.println(u);
		model.addAttribute("user", u);
		return "userlist";
	}

	// �����û���Ϣ
	@RequestMapping(value = "/upateUser.html")
	public String modifyUser(User user, Model model) {
		System.err.println(user);
		int x = userService.ModifyUser(user);
		if (x > 0) {
			model.addAttribute("info", "��Ϣ���³ɹ���");
			return "userlist";
		} else {
			model.addAttribute("info", "��Ϣ����ʧ�ܣ�");
			return "userlist";
		}
	}

	// �һ�����
	@RequestMapping(value = "/backPass.html")
	public String backPass(Model model, @RequestParam("name") String name, @RequestParam("userName") String userName) {
		User user = new User();
		user.setUserName(userName);
		user.setName(name);
		String password = null;
		try {
			password = (userService.BakePass(user)).getPassWord();
			System.err.println(".................................." + password);
			model.addAttribute("name1", name);
			model.addAttribute("userName1", userName);
			model.addAttribute("password1", password);
			return "login";
		} catch (Exception e) {
			model.addAttribute("info1", "���������Ϣ��ƥ��,�һ�����ʧ��");
			return "login";
		}
	}

	//ȫ���û���Ϣ
	@RequestMapping(value = "/alluserlist.html")
	public String allList(Model model, @RequestParam(value="name",required=false) String name, 
			@RequestParam(value="yes",required=false) Integer yes,
			@RequestParam(value="pageIndex",required=false) String indexPage) {
		int countsize=userService.getUserCount(name, yes);//����
		Page page=new Page();
		page.setCountSize(countsize);
		int countPage=page.getPageCount();//��ҳ����
		int currentPage=page.getCurrentPage();//��ǰҳ��
		int pageSize=page.getPageSize();//ҳ��������
		if(indexPage!=null){
			currentPage=Integer.parseInt(indexPage);
		}
		int x=(currentPage-1)*pageSize;
		List<User> userlist=userService.getUserList(name, yes,x, pageSize);
		List<Role> roleList=roleService.Querylist(new Role());
		model.addAttribute("userlist",userlist);
		model.addAttribute("rolelist",roleList);
		model.addAttribute("name",name);
		model.addAttribute("yes", yes);
		model.addAttribute("pageNo", currentPage);
		model.addAttribute("totalPageCount",countPage);
		model.addAttribute("totalCount",countsize);
		return "alluserlist";
	}

	
	//����Ա�鿴�û���Ϣ��Rest���
	@RequestMapping(value = "/usershow/{id}", method = RequestMethod.GET)
	public String showUser(Model model, @PathVariable("id") Integer id) {
		User u = new User();
		u.setId(id);
		User User = userService.QueryUserById(u);
		Role role=new Role();
		List<Role> roleList=roleService.Querylist(role);
		if (User != null) {
			model.addAttribute("rolelist", roleList);
			model.addAttribute("user", User);
			return "userlistbyadmin";
		} else {
			model.addAttribute("userInfo", "��ȡ��Ϣʧ��");
			return "userlistbyadmin";
		}
	}
	
	
	@RequestMapping(value = "/usershowAjax.html", method = RequestMethod.GET,produces={"text/html;charset=UTF-8"})
	@ResponseBody
	//produces={"text/html;charset=UTF-8"}����ajax����֮����������
	public Object showUserAJAX(@RequestParam("id") Integer id) {
		User u = new User();
		u.setId(id);
		User User = userService.QueryUserById(u);
//		Role role=new Role();
//		List<Role> roleList=roleService.Querylist(role);
		if (User != null) {
			return JSONObject.fromObject(User).toString();
		} else {
			return "false";
		}
	}
	
	@RequestMapping(value="deleteByIdList")
	@ResponseBody
	public Object deleteByIdList(@RequestParam("idList")String idlist){
		String result="";
		System.err.println(idlist);
		String[] list =idlist.split(",");//�ã����
//		System.out.println(Arrays.toString(list));
		int x=userService.deleteById(list);
		if(x>0){
			System.err.println("........................success");
			result="success";
		}else{
			System.err.println("........................false");
			result="false";
		}
		return result;
	}

}
