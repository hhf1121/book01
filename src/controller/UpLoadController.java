package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
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

@Controller
@RequestMapping("/upLoad")
public class UpLoadController {

	@Resource
	private upLoadfileService uploadfileService;
	@Resource
	private  userService userService;

	// �ļ��ϴ�
	@RequestMapping(value = "/uploadFile.html", method = RequestMethod.POST)
	public String addUploadfile(@RequestParam("path") MultipartFile uploadfile, Model model,
			HttpServletRequest request) {
		String idpath = null;
		// �ж��ļ��Ƿ�Ϊ��
		if (!uploadfile.isEmpty()) {
			String path = request.getSession().getServletContext()
					.getRealPath("statics" + File.separator + "uploadfiles");//�ļ����·��
			//File.separator   ���Զ�ʶ��ϵͳ���˾京�壺������һ��/statics/uploadfiles�ļ���
			String oldFileName = uploadfile.getOriginalFilename();// ԭ�ļ���
			String prefix = FilenameUtils.getExtension(oldFileName);// ԭ�ļ���׺
			int filesize = 5000000;//�����ļ���С��
			System.err.println("uploadFile path ============== > " + path);
			System.err.println("uploadFile oldFileName ============== > " + oldFileName);
			System.err.println("uploadFile prefix============> " + prefix);
			System.err.println("uploadFile size============> " + uploadfile.getSize());
			if (uploadfile.getSize() > filesize) {// �ϴ���С���ó��� 500k
				System.err.println("------------------------------------guoda!");
				request.setAttribute("infoxx", " * �ϴ���С���ó��� 500k");
				return "Filelist";
			} else if (prefix.equalsIgnoreCase("txt")) {// �ϴ�ͼƬ��ʽ
				String fileName = System.currentTimeMillis() + RandomUtils.nextInt(1000000) + "_Personal.txt";
				System.err.println("new fileName======== " + uploadfile.getName());
				File targetFile = new File(path, fileName);
				if (!targetFile.exists()) {
					targetFile.mkdirs();
				}
				try {
					// �����ļ�
					uploadfile.transferTo(targetFile);
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("infoxx", " * �ϴ�ʧ�ܣ�");
					return "Filelist";
				}
				idpath = path + File.separator + fileName;//�ϴ��ļ�ȫ·��+�ļ�����
				upLoadfile upload=new upLoadfile();
				upload.setUserid(((User) request.getSession().getAttribute("currentUser")).getId());
				upload.setCreateDate(new Timestamp(new Date().getTime()));
				upload.setPath(idpath);
				upload.setUpName(oldFileName);
				int x = uploadfileService.AddFile(upload);
				if (x > 0) {
//					model.addAttribute("infoxx", "�ϴ��ɹ�");
					return "redirect:/upLoad/Filelist.html";
				} else {
					model.addAttribute("infoxx", "�ϴ�ʧ��");
					return "Filelist";
				}
			} else {
				System.err.println("---------------------------��ʽ���ԣ�����");
				model.addAttribute("infoxx", " * �ϴ�ͼƬ��ʽ����ȷ");
				return "Filelist";
			}
		} else {
			System.err.println("---------------------------�ļ�Ϊ�գ�����");
			model.addAttribute("infoxx", "����ѡ��Ϸ����ϴ��ļ�");
			return "Filelist";
		}
	}

	
	//��ȡ�б�
	@RequestMapping(value = "/Filelist.html")
	public String getlistfile(HttpSession session, Model model) {
		User u = (User) session.getAttribute("currentUser");
		upLoadfile uploadfile = new upLoadfile();
		System.err.println(u.getId()+"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
		User ux=userService.QueryUserById(u);
		if(ux.getYes()==3){
			System.err.println("����Ա......................");
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
			model.addAttribute("infoup", "��ȡ�����б�ʧ��");
			return "main";
		}
	}
	
	
	//���أ�
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
	
	
	//ɾ���ļ���
	@RequestMapping(value="/deleteFile.html")
	@ResponseBody
	public Object deleteFile(@RequestParam(value="id")Integer id){
		String result="";
		String path=uploadfileService.upLoadfileById(id).getPath();
		System.err.println(path);
		File file=new File(path);
		if(file.delete()){
			System.err.println("......................aaaa");
			upLoadfile u=new upLoadfile();
			u.setId(id);
			if(uploadfileService.DeleteFile(u)>0){
				result="success";
			}
		}
		return result;
	} 

	//�鿴�ļ�����
	@RequestMapping(value="fileshow.html",produces={"text/html;charset=utf-8"})
	@ResponseBody
	public Object getShow(@RequestParam("id") String id) throws Exception{
		System.err.println("�鿴�ļ�����������������������������������������");
		upLoadfile load=uploadfileService.upLoadfileById(Integer.parseInt(id));
		String show=load.getPath();
		StringBuffer info=new StringBuffer();
		File file = new File(show);
	    InputStream is = new FileInputStream(file);
	    BufferedReader br=new BufferedReader(new InputStreamReader(is));
	    String str=null;
	    while(((str=br.readLine())!=null)){
	    	info.append(str);
	    }
	    br.close();
	    is.close();
		return info.toString();
	}
	
	 
}
