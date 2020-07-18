package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.ModelAndView;
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

	// 获取列表。
	@RequestMapping(value = "/booklist.html")
	public String getBookList(Model model, HttpSession session,
							  @RequestParam(value = "name", required = false) String name,
							  @RequestParam(value = "author", required = false) String author,
							  @RequestParam(value = "pageIndex", required = false) String indexPage) {
		Page page = new Page();
		int countSize = bookService.CountBooks(name, author);// 总条数
		page.setCountSize(countSize);
		int PageSize = page.getPageSize();// 页面容量
		int currentPage = page.getCurrentPage();// 当前页
		if (indexPage != null) {
			currentPage = Integer.parseInt(indexPage);
		}
		int xx = (currentPage - 1) * PageSize;
		List<Book> booklist = bookService.getList(name, author, xx, PageSize);
		model.addAttribute("booklist", booklist);
		model.addAttribute("name", name);// 回显
		model.addAttribute("author", author);
		model.addAttribute("pageNo", currentPage);
		model.addAttribute("totalPageCount", page.getPageCount());
		model.addAttribute("totalCount", countSize);
		return "booklist";
	}

	// 打开页面。
	@RequestMapping(value = "/booklist2.html")
	public ModelAndView getBookList2(Model model, HttpSession session) {
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("booklist2");
		return modelAndView;
	}

	// 获取数据
	@RequestMapping(value = "/getbookList",method= RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> getbookList(String name, String author,Page page) {
		Map<String,Object> result=new HashMap<>();
		Page page1 = new Page();
		int countSize = bookService.CountBooks(name, author);// 总条数
		page1.setCountSize(countSize);
		int PageSize = Integer.parseInt(page.getRows());// 页面容量
		int currentPage = Integer.parseInt(page.getPage());// 当前页
		int xx = (currentPage - 1) * PageSize;
		List<Book> booklist = bookService.getList(name, author, xx, PageSize);
		result.put("rows",booklist);
		result.put("total",countSize);
		result.put("success",true);
		return result;
	}



	// 借阅
	@RequestMapping(value = "/borrow.html")
	@ResponseBody
	public String getBorrow(@Param("bid") String bid, @Param("uid") String uid, HttpSession session) {
		// String bookId=id;//书的id
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
			// session.setAttribute("infox", "您已经借阅了"+bookName+"，不能重复借阅");
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
		int countSize = bookService.CountBooks(name, author);// 总条数
		page.setCountSize(countSize);
		int PageSize = page.getPageSize();// 页面容量
		int currentPage = page.getCurrentPage();// 当前页
		if (indexPage != null) {
			currentPage = Integer.parseInt(indexPage);
		}
		int xx = (currentPage - 1) * PageSize;
		List<Book> booklist = bookService.getList(name, author, xx, PageSize);
		model.addAttribute("booklist", booklist);
		model.addAttribute("name", name);// 回显
		model.addAttribute("author", author);
		model.addAttribute("pageNo", currentPage);
		model.addAttribute("totalPageCount", page.getPageCount());
		model.addAttribute("totalCount", countSize);
		return "allbooklist";
	}


	// 增加书籍
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
			model.addAttribute("addbookInfo","添加失败,不合法");
			return "addbook";
		}
	}

	//删除图书。
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
