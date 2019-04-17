package controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pojo.LibraryBorrow;
import pojo.User;
import service.LibraryBorrowService;
import tools.Page;

@Controller
@RequestMapping("/libraryborrow")
public class libraryborrowController {

	@Resource
	private LibraryBorrowService libraryBorrowService;

	// ������ʷ��¼
	@RequestMapping(value = "/librarylist.html")
	public String OneList(HttpSession session, Model model) {
		Long userID = ((User) session.getAttribute("currentUser")).getId();
		LibraryBorrow lb = new LibraryBorrow();
		lb.setUserId(userID);
		List<LibraryBorrow> list = libraryBorrowService.Query(lb);
		model.addAttribute("Librarylist", list);
		return "librarylist";
	}

	// ����Ա�鿴���еļ�¼
	@RequestMapping(value = "/alllibrarylist.html")
	public String OneList(Model model, @RequestParam(value = "bookName", required = false) String bookName,
			@RequestParam(value = "userName", required = false) String userName,
			@RequestParam(value = "pageIndex", required = false) String indexPage) {
		Page page=new Page();
		int PageSize=page.getPageSize();//ҳ��������
		int currentPage=page.getCurrentPage();//��ǰҳ�档
		int CountSize=libraryBorrowService.QueryCountByName2(userName, bookName);//������
		page.setCountSize(CountSize);
		int pageCount=page.getPageCount();//ҳ����
		if(null!=indexPage){
			currentPage=Integer.parseInt(indexPage);
		}
		int x=(currentPage-1)*PageSize;
		List<LibraryBorrow> list=libraryBorrowService.QueryByAllList(userName, bookName, x, PageSize);
		model.addAttribute("Librarylist", list);
		model.addAttribute("bookName", bookName);
		model.addAttribute("userName", userName);
		model.addAttribute("totalPageCount",pageCount);
		model.addAttribute("pageNo",currentPage);
		model.addAttribute("totalCount",CountSize);
		return "alllibrarylist";
	}

}
