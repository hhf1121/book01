package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import pojo.User;
import pojo.upLoadfile;
import service.upLoadfileService;
import service.userService;
import tools.ResultUtils;

@Controller
@RequestMapping("/upLoad")
public class UpLoadController {

	@Resource
	private upLoadfileService uploadfileService;
	@Resource
	private  userService userService;

	// 文件上传
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> addUploadfile(@RequestParam("myuploadfile") MultipartFile myuploadfile, Model model,
								HttpServletRequest request) {
		Map<String,Object> result=new HashMap<>();
		String idpath = null;
		// 判断文件是否为空
		if (!myuploadfile.isEmpty()) {
			String path = request.getSession().getServletContext()
					.getRealPath("statics" + File.separator + "uploadfiles");//文件存放路径
			//File.separator   ：自动识别系统。此句含义：创建了一个/statics/uploadfiles文件夹
			String oldFileName = myuploadfile.getOriginalFilename();// 原文件名
			String prefix = FilenameUtils.getExtension(oldFileName);// 原文件后缀
			int filesize = 5000000;//设置文件大小。
			System.err.println("uploadFile path ============== > " + path);
			System.err.println("uploadFile oldFileName ============== > " + oldFileName);
			System.err.println("uploadFile prefix============> " + prefix);
			System.err.println("uploadFile size============> " + myuploadfile.getSize());
			if (myuploadfile.getSize() > filesize) {// 上传大小不得超过 500k
				result.put("data", " * 上传大小不得超过 500k");
				result.put("success",false);
				return result;
			} else if (prefix.equalsIgnoreCase("txt")) {// 上传图片格式
				String fileName = System.currentTimeMillis() + RandomUtils.nextInt(1000000) + "_Personal.txt";
				System.err.println("new fileName======== " + myuploadfile.getName());
				File targetFile = new File(path, fileName);
				if (!targetFile.exists()) {
					targetFile.mkdirs();
				}
				try {
					// 保存文件
					myuploadfile.transferTo(targetFile);
				} catch (Exception e) {
					e.printStackTrace();
					result.put("data", " * 上传失败");
					result.put("success",false);
					return result;
				}
				idpath = path + File.separator + fileName;//上传文件全路径+文件名。
				upLoadfile upload=new upLoadfile();
				upload.setUserid(((User) request.getSession().getAttribute("currentUser")).getId());
				upload.setCreateDate(new Timestamp(new Date().getTime()));
				upload.setPath(idpath);
				upload.setUpName(oldFileName);
				int x = uploadfileService.AddFile(upload);
				if (x > 0) {
//					model.addAttribute("infoxx", "上传成功");
					result.put("data", " * 上传成功");
					result.put("success",true);
					return result;
				} else {
					result.put("data", " * 上传失败");
					result.put("success",false);
					return result;
				}
			} else {
				System.err.println("---------------------------格式不对！》》");
				result.put("data", " * 上传文件格式不正确：txt");
				result.put("success",false);
				return result;
			}
		} else {
			System.err.println("---------------------------文件为空！》》");
			result.put("data", " * 必须选择合法的上传文件");
			result.put("success",false);
			return result;
		}
	}


	//读取列表。
	@RequestMapping(value = "/Filelist.html")
	public String getlistfile(HttpSession session, Model model) {
		Object currentUser = session.getAttribute("currentUser");
		if(currentUser==null){
			return "login";
		}
		User u = (User) session.getAttribute("currentUser");
		upLoadfile uploadfile = new upLoadfile();
		System.err.println(u.getId()+"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
		User ux=userService.QueryUserById(u);
		if(ux.getYes()==3){
			System.err.println("管理员......................");
			uploadfile.setUserid(null);
		}else{
			uploadfile.setUserid(u.getId());
		}
		List<upLoadfile> list = uploadfileService.getList(uploadfile);
		System.err.println(list);
		if (list != null ) {
			model.addAttribute("listss", list);
			model.addAttribute("user", ux);
			return "Filelist";
		} else {
			model.addAttribute("infoup", "获取共享列表失败");
			return "main";
		}
	}


    //读取列表。easyui
    @RequestMapping(value = "/getFilelist")
    @ResponseBody
    public Map<String,Object> getFilelist(HttpSession session) {
		Map<String,Object> result=new HashMap<>();
        User u = (User) session.getAttribute("currentUser");
        upLoadfile uploadfile = new upLoadfile();
        User ux=userService.QueryUserById(u);
        if(ux.getYes()==3){
            System.err.println("管理员......................");
            uploadfile.setUserid(null);
        }else{
            uploadfile.setUserid(u.getId());
        }
        List<upLoadfile> list = uploadfileService.getList(uploadfile);
		result.put("rows",list);
		result.put("success",true);
		return result;
    }

	//下载：
	@RequestMapping("/download.html")
	public ResponseEntity<byte[]> download(HttpServletRequest request,@RequestParam("file")String filex) throws IOException {
		System.err.println("......................................................");
		File file = new File(filex);
		byte[] body = null;
		InputStream is = new FileInputStream(file);
		body = new byte[is.available()];
		is.read(body);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attchement;filename=" + file.getName());
		HttpStatus statusCode = HttpStatus.OK;
		ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(body, headers, statusCode);
		return entity;
	}


	//删除文件。
	@RequestMapping(value="/deleteFile.html")
	@ResponseBody
	public Object deleteFile(@RequestParam(value="id")Integer id){
		String result="";
		String path=uploadfileService.upLoadfileById(id).getPath();
		System.err.println(path);
		File file=new File(path);
		if(file.delete()){
			upLoadfile u=new upLoadfile();
			u.setId(id);
			if(uploadfileService.DeleteFile(u)>0){
				result="success";
			}
		}else{
			upLoadfile u=new upLoadfile();
			u.setId(id);
			if(uploadfileService.DeleteFile(u)>0){
				result="success";
			}
		}
		return result;
	}

	//查看文件内容
	@RequestMapping(value="fileshow.html",produces={"text/html;charset=utf-8"})
	@ResponseBody
	public Map<String,Object> getShow(@RequestParam("id") String id,@RequestParam(value = "currentPage",required = false) String currentPage) throws Exception{
		Map<String,Object> reslut=new HashMap<>();
		System.err.println("查看文件。。。。。。。。。。。。。。。。。。。。");
		upLoadfile load=uploadfileService.upLoadfileById(Integer.parseInt(id));
		String show=load.getPath();
		StringBuffer info=new StringBuffer();
		File file = new File(show);
		InputStream is = new FileInputStream(file);
		BufferedReader br=new BufferedReader(new InputStreamReader(is));
		String str=null;
		Integer start=0;
		Integer pageSize=50;
		if(StringUtils.isEmpty(currentPage)){
		    start=1;
        }else {
            start=Integer.parseInt(currentPage);
        }
         start=(start-1)*pageSize;
		int i=0;
		int j=0;
		while(((str=br.readLine())!=null)){
		    if(i>=start){
                info.append(str);
                j++;
                if(j==pageSize){
                    break;
                }
            }
            i++;
		}
		br.close();
		is.close();
		reslut.put("content",new String(info.toString().getBytes("utf-8")));
		reslut.put("currentPage",StringUtils.isEmpty(currentPage)?0+"":currentPage+"");
		reslut.put("id",id);
		reslut.put("bookname",load.getUpName());
		return reslut;
	}



	//easyui单独文件上传接口
	@RequestMapping(value = "/loadingFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loadingUserImg(@RequestParam("file") MultipartFile file,HttpServletRequest request) {
		String result="";
		try{
			// 构建上传文件的存放 “文件夹” 路径
			String fileDirPath = new String("book01/resources/static/file");
			File fileDir = new File(fileDirPath);
			if(!fileDir.exists()){
				// 递归生成文件夹
				fileDir.mkdirs();
			}
			// 拿到文件名
			String filename = file.getOriginalFilename();
			int i = new Random().nextInt(100);
			String name=(System.currentTimeMillis()+i)+"@"+filename;
			// 输出文件夹绝对路径 – 这里的绝对路径是相当于当前项目的路径而不是“容器”路径
			System.out.println(fileDir.getAbsolutePath());
			File newFile = new File(fileDir.getAbsolutePath() + File.separator + name);
			System.out.println(newFile.getAbsolutePath());
			// 上传到 -》 “绝对路径”
			file.transferTo(newFile);
			return ResultUtils.getSuccessResult("http://"+getHostAddress()+":"+request.getServerPort()+"/resources/static/file"+File.separator+newFile.getName());
		}catch (Exception e ){
			return ResultUtils.getFailResult("上传文件异常！");
		}
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
