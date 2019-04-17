package controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Book;
import pojo.Borrow;
import service.bookService;
import service.borrowService;
import tools.Page;

@Controller
@RequestMapping("/book")
public class bookController {

	@Resource
	private bookService bookService;
	@Resource
	private borrowService borrowService;

	// ��ȡ�б�
	@RequestMapping(value = "/booklist.html")
	public String getBookList(Model model, HttpSession session,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "author", required = false) String author,
			@RequestParam(value = "pageIndex", required = false) String indexPage) {
		Page page = new Page();
		int countSize = bookService.CountBooks(name, author);// ������
		page.setCountSize(countSize);
		int PageSize = page.getPageSize();// ҳ������
		int currentPage = page.getCurrentPage();// ��ǰҳ
		if (indexPage != null) {
			currentPage = Integer.parseInt(indexPage);
		}
		int xx = (currentPage - 1) * PageSize;
		List<Book> booklist = bookService.getList(name, author, xx, PageSize);
		model.addAttribute("booklist", booklist);
		model.addAttribute("name", name);// ����
		model.addAttribute("author", author);
		model.addAttribute("pageNo", currentPage);
		model.addAttribute("totalPageCount", page.getPageCount());
		model.addAttribute("totalCount", countSize);
		return "booklist";
	}

	// ����
	@RequestMapping(value = "/borrow.html")
	@ResponseBody
	public String getBorrow(@Param("bid") String bid, @Param("uid") String uid, HttpSession session) {
		// String bookId=id;//���id
		Integer bidx = Integer.parseInt(bid);
		Long uidx = Long.parseLong(uid);
		Borrow borrowx = new Borrow();
		borrowx.setUserId(uidx);
		borrowx.setBookId(bidx);
		Book book = new Book();
		book.setId(bidx);
		String bookName = (bookService.QueryUserById(book)).getName();
		Borrow b = borrowService.QueryBorrowBy2id(borrowx);
		if (null != b) {
			// session.setAttribute("infox", "���Ѿ�������"+bookName+"�������ظ�����");
			// session.removeAttribute("info");
			return "false";
		} else {
			int x = bookService.upDateCountById(bidx);
			if (x > 0) {
				return "true";
			} else {
				return "noData";
			}
		}
	}

	@RequestMapping(value = "/ajax")
	@ResponseBody
	public String ajax(@RequestParam("bid") String id) {
		Book book = new Book();
		book.setId(Integer.parseInt(id));
		int count = (bookService.QueryCountById(book)).getCount();
		if (count > 0) {
			return "true";
		} else {
			return "false";
		}
	}

	@RequestMapping(value = "/allbooklist.html")
	public String getAllBookList(Model model, HttpSession session,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "author", required = false) String author,
			@RequestParam(value = "pageIndex", required = false) String indexPage) {
		Page page = new Page();
		int countSize = bookService.CountBooks(name, author);// ������
		page.setCountSize(countSize);
		int PageSize = page.getPageSize();// ҳ������
		int currentPage = page.getCurrentPage();// ��ǰҳ
		if (indexPage != null) {
			currentPage = Integer.parseInt(indexPage);
		}
		int xx = (currentPage - 1) * PageSize;
		List<Book> booklist = bookService.getList(name, author, xx, PageSize);
		model.addAttribute("booklist", booklist);
		model.addAttribute("name", name);// ����
		model.addAttribute("author", author);
		model.addAttribute("pageNo", currentPage);
		model.addAttribute("totalPageCount", page.getPageCount());
		model.addAttribute("totalCount", countSize);
		return "allbooklist";
	}

	
	// �����鼮
	@RequestMapping(value = "/addBook.html")
	public String addBook() {
		return "addbook";
	}
	@RequestMapping(value = "/SaveaddBook.html")
	public String SaveaddBook(Model model,Book book) {
		int x=bookService.addBook(book);
		if(x>0){
			return "redirect:/book/allbooklist.html";	
		}else{
			model.addAttribute("addbookInfo","���ʧ��,���Ϸ�");
			return "addbook";	
		}
	}
	
	//ɾ��ͼ�顣
	@RequestMapping(value="/deleteBook.html")
	@ResponseBody
	public String deleteBook(@RequestParam("bid")Integer id){
		Book book=new Book();
		book.setId(id);
		Book bb=bookService.QueryCC(book);
		if(bb.getCount()==bb.getCountSize()){
		int x=bookService.deleteBook(book);
		if(x>0)return "true";
		else return "xxx";
		}else{
			return "false";
		}
	}
	

}
