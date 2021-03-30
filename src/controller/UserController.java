package controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import dto.UserColumnDto;
import dto.UserExportDto;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.sf.json.JSONObject;
import pojo.Book;
import pojo.Role;
import pojo.User;
import pojo.listNo;
import service.RoleService;
import service.listNoService;
import service.userService;
import tools.ExcelUtil;
import tools.Page;
import tools.ResultUtils;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private userService userService;
	@Resource
	private listNoService listNoService;
	@Resource
	private RoleService roleService;

    @Value("${system.filePath}")
    private String filePath;

	private final Log log = LogFactory.getLog(this.getClass());
	
	// 验证账号是否存在
	@RequestMapping(value = "/ifExist")
	@ResponseBody
	public Boolean ifExist(@RequestParam("userName") String userName) {
		System.err.println("..................ajax验证.....");
		if (userService.ifExist(userName) > 0) {
			return false;
		}
		return true;
	}

	@RequestMapping(value = "/adduser.html",method=RequestMethod.POST)
	public String addUser(User user, Model model,HttpServletRequest request,
			@RequestParam(value="pic",required=false) MultipartFile file) {
		String picPath="";
		if(!file.isEmpty()){
			System.err.println("------------------------头像文件上传");
			String Name=file.getOriginalFilename();//文件名
			String fileEndName=FilenameUtils.getExtension(Name);//后缀
//			String path="book01/resource/"+("statics"+File.separator+"uploadPath");//存储路径
			String path=filePath+"\\book01\\WebContent\\resource\\photo";//图片存放路径
			if(fileEndName.equalsIgnoreCase("jpg")||fileEndName.equalsIgnoreCase("png")
					||fileEndName.equalsIgnoreCase("jpeg")||fileEndName.equalsIgnoreCase("pneg")){
				String fileName=System.currentTimeMillis()+RandomUtils.nextInt(10000000)+"_pic.jpg";
				File f=new File(path);
				if(!f.exists()){
					f.mkdirs();
				}
				try {
					File newFile = new File(f.getAbsolutePath() + File.separator + fileName);
					file.transferTo(newFile);
					picPath=path+File.separator+fileName;//完整路径名字。
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
					model.addAttribute("error", "上传失败！！");
				}
			}else{
				model.addAttribute("error", "图片格式不对！");
				return "index";
			}
		}
		int x = 0;
		try {
			String showUrl="http://"+getHostAddress()+":"+request.getServerPort()+"\\book\\"+picPath.split("WebContent")[1];
//			picPath=picPath.equals("")? "": picPath;//截取路径、保存。
			user.setPicPath(showUrl);
			x = userService.addUser(user);
		} catch (Exception e) {
			System.err.println("用户注册失败！");
		}
		if (x > 0) {
			model.addAttribute("info", "注册成功！");
			return "login";
		} else {
			model.addAttribute("error", "注册失败！");
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
			System.err.println("jsr303验证失败");
			System.err.println(user.getPassWord());
			System.err.println(user.getUserName());
			System.err.println(br.toString());
			return "login";
		}*/
		System.out.println("打印信息："+user);
		User u = userService.QueryUser(user);

		if (u != null || (u = (User) session.getAttribute("currentUser")) != null) {
			session.setAttribute("currentUser", u);// 放进session中
			List<listNo> list = listNoService.QueryListByYseNo(u.getYes());
			String role = u.getYes() == 1 ? "普通会员" : "vip会员";
			if (u.getYes() == 3) {
				role = "管理员";
			}
			session.setAttribute("list", list);
			session.setAttribute("role", role);
			return "main";
		} else {
			model.addAttribute("info", "账号或密码错误");
			return "login";
		}
	}

	// 退出
	@RequestMapping(value = "/out.html")
	public String out(HttpSession session) {
		session.removeAttribute("currentUser");
		session.invalidate();
		return "login";
	}

	@RequestMapping(value = "/userlist.html")
	public String userlist(HttpSession session, Model model,String id) {
		model.addAttribute("userID",id);
		return "userlist";
	}

	// 更新用户信息
	@RequestMapping(value = "/upateUser")
	@ResponseBody
	public Map<String,Object> modifyUser(User user) {
		Map<String,Object> result=new HashMap<>();
		int x = userService.ModifyUser(user);
		if (x > 0) {
			result.put("data","信息更新成功");
			result.put("success",true);
			return result;
		} else {
			result.put("data","信息更新失败");
			result.put("success",false);
			return result;
		}
	}


	// 更新用户信息
	@RequestMapping(value = "/upateUserByUser")
	@ResponseBody
	public Map<String,Object> upateUserByUser(User user,HttpServletRequest request,@RequestParam(value="pic",required=false) MultipartFile file) {
		Map<String,Object> result=new HashMap<>();
		String picPath="";
		if(!file.isEmpty()){
			String Name=file.getOriginalFilename();//文件名
			String fileEndName=FilenameUtils.getExtension(Name);//后缀
//			String path="book01/resource/"+("statics"+File.separator+"uploadPath");//存储路径
			String path=filePath+"\\book01\\WebContent\\resource\\photo";//图片存放路径
			if(fileEndName.equalsIgnoreCase("jpg")||fileEndName.equalsIgnoreCase("png")
					||fileEndName.equalsIgnoreCase("jpeg")||fileEndName.equalsIgnoreCase("pneg")){
				String fileName=System.currentTimeMillis()+RandomUtils.nextInt(10000000)+"_pic.jpg";
				File f=new File(path,fileName);
				if(!f.exists()){
					f.mkdirs();
				}
				try {
					file.transferTo(f);
					picPath=path+File.separator+fileName;//完整路径名字。
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
					result.put("data","文件上传失败");
					result.put("success",false);
				}
			}else{
				result.put("data","图片格式不对");
				result.put("success",false);
			}
		}else {
			result.put("data","图片不能为空");
			result.put("success",false);
			return result;
		}
		int x = 0;
		try {
			String showUrl="http://"+getHostAddress()+":"+request.getServerPort()+"\\book\\"+picPath.split("WebContent")[1];
//			picPath=picPath.equals("")? "": picPath.substring(picPath.indexOf("statics"));//截取路径、保存。
			user.setPicPath(showUrl);
			x = userService.ModifyUser(user);
		} catch (Exception e) {
			result.put("data","系统出错");
			result.put("success",false);
		}
		if (x > 0) {
			result.put("data","信息更新成功");
			result.put("success",true);
			return result;
		} else {
			result.put("data","信息更新失败");
			result.put("success",false);
			return result;
		}
	}

	// 找回密码
	@RequestMapping(value = "/backPass")
	@ResponseBody
	public Map<String,Object> backPass(String name, String userName) {
		Map<String,Object> map=new HashMap<>();
		User user = new User();
		user.setUserName(userName);
		user.setName(name);
		String password = null;
		try {
			password = (userService.BakePass(user)).getPassWord();
			map.put("name1", name);
			map.put("userName1", userName);
			map.put("password1", password);
			return ResultUtils.getSuccessResult(map);
		} catch (Exception e) {
			map.put("info1", "您输入的信息不匹配,找回密码失败");
			return ResultUtils.getFailResult(map);
		}
	}

	//全部用户信息
	@RequestMapping(value = "/alluserlist.html")
	public String allList(Model model, @RequestParam(value="name",required=false) String name, 
			@RequestParam(value="yes",required=false) Integer yes,
			@RequestParam(value="registerTime",required=false) String registerTime,
			@RequestParam(value="pageIndex",required=false) String indexPage) {
		int countsize=userService.getUserCount(name, yes,registerTime);//总数
		Page page=new Page();
		page.setCountSize(countsize);
		int countPage=page.getPageCount();//总页数。
		int currentPage=page.getCurrentPage();//当前页。
		int pageSize=page.getPageSize();//页面容量。
		if(indexPage!=null){
			currentPage=Integer.parseInt(indexPage);
		}
		int x=(currentPage-1)*pageSize;
		List<User> userlist=userService.getUserList(name, yes,registerTime,x, pageSize);
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


	//全部用户信息
	@RequestMapping(value = "/getAlluserlist")
	@ResponseBody
	public Map<String,Object> allList(String name,Integer yes,String registerTime,Page page) {
		Map<String,Object> result=new HashMap<>();
		int countsize=userService.getUserCount(name, yes,registerTime);//总数
		Page page1 = new Page();
		page1.setCountSize(countsize);
		int PageSize = Integer.parseInt(page.getRows());// 页面容量
		int currentPage = Integer.parseInt(page.getPage());// 当前页
		int xx = (currentPage - 1) * PageSize;
		List<User> userlist=userService.getUserList(name, yes,registerTime,xx, PageSize);
		result.put("rows",userlist);
		result.put("total",countsize);
		result.put("success",true);
		return result;
	}


	@RequestMapping(value = "exportAlluserlist", method = RequestMethod.POST)
	@Transactional
	public void exportAlluserlist(UserExportDto dto, Page page, HttpServletResponse response, HttpServletRequest request) throws Exception {
	int countsize=userService.getUserCount(dto.getName(), dto.getYes(),dto.getRegisterTime());//总数
	if(countsize<1){
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write("没有任何数据可导出！");
		return;
	}
	try{
		String columnsStr = dto.getUserColums();
		if(columnsStr == null || columnsStr.isEmpty()){
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.getWriter().write("缺少字段配置参数！");
			return;
		}
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		List<UserColumnDto> siteOrgcolumnDtos = JSON.parseArray(columnsStr,UserColumnDto.class);
		for (UserColumnDto siteOrgcolumnDto : siteOrgcolumnDtos) {
			//筛选导出字段
			if(siteOrgcolumnDto.getIsExport() != null && siteOrgcolumnDto.getIsExport()){
				//判断是否需要添加Text取出中文
				if(siteOrgcolumnDto.getIsText() != null && siteOrgcolumnDto.getIsText()){
					map.put(siteOrgcolumnDto.getField() + "Text", siteOrgcolumnDto.getTitle());
				}else{
					map.put(siteOrgcolumnDto.getField(), siteOrgcolumnDto.getTitle());
				}
			}
		}
		List<User> userlist=userService.getUserList(dto.getName(), dto.getYes(),dto.getRegisterTime(),null, null);
		ExcelUtil.listToExcel(userlist, map, "优速网点合同信息", response);
	}catch (Exception e){
		log.error("导出用户失败", e);
		throw e;
	}

	return;
}
	
	//管理员查看用户信息。Rest风格。
	@RequestMapping(value = "/usershow/{id}", method = RequestMethod.GET)
	public String showUser(Model model, @PathVariable("id") Integer id) {
		User u = new User();
		u.setId(id.longValue());
		User User = userService.QueryUserById(u);
		Role role=new Role();
		List<Role> roleList=roleService.Querylist(role);
		if (User != null) {
			model.addAttribute("rolelist", roleList);
			model.addAttribute("user", User);
			return "userlistbyadmin";
		} else {
			model.addAttribute("userInfo", "获取信息失败");
			return "userlistbyadmin";
		}
	}
	
	
	@RequestMapping(value = "/usershowAjax.html", method = RequestMethod.GET,produces={"text/html;charset=UTF-8"})
	@ResponseBody
	//produces={"text/html;charset=UTF-8"}设置ajax返回之后中文乱码
	public Object showUserAJAX(@RequestParam("id") Integer id) {
		User u = new User();
		u.setId(id.longValue());
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
		String[] list =idlist.split(",");//用，拆分
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


	@RequestMapping(value="getUserById")
	@ResponseBody
	public Map<String,Object> getUserById(String id){
		Map<String,Object> result=new HashMap<>();
		User userById = userService.getUserById(id);
		if (null==userById){
			result.put("data",null);
			result.put("success",false);
		}else{
			result.put("data",userById);
			result.put("success",true);
		}
		return result;
	}


	private String getHostAddress(){
		String hostAddress = null;
		try {
			hostAddress = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			hostAddress="localhost";
		}
		return hostAddress;
	}

}
