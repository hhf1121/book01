package controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.ModelAndView;
import pojo.Book;
import pojo.Borrow;
import pojo.LibraryBorrow;
import pojo.User;
import service.LibraryBorrowService;
import service.bookService;
import service.borrowService;
import service.userService;
import tools.Page;

@Controller
@RequestMapping("/borrow")
public class borrowController {

	@Resource
	private borrowService  borrowService;
	@Resource
	private bookService bookService;
	@Resource
	private userService userService;
	@Resource
	private LibraryBorrowService libraryBorrowService;


	@RequestMapping(value="/addBorrow.html",method=RequestMethod.GET)
	@ResponseBody
	public String addBorrow(HttpSession session,@RequestParam("bookid")String bookid,
							@RequestParam("userid")String userid){
		Integer bid=Integer.parseInt(bookid);
		Long uid=Long.parseLong(userid);
		User user=new User();
		user.setId(uid);
		String userName=(userService.QueryUserById(user)).getName();
		Book book=new Book();
		book.setId(bid);
		String bookName=(bookService.QueryUserById(book)).getName();
		Borrow borrow=new Borrow();
		borrow.setBookId(bid);
		borrow.setUserId(uid);
		System.err.println(bookName+".....>>"+userName);
		borrow.setBookName(bookName);
		borrow.setUserName(userName);
		int x=borrowService.AddBorrow(borrow);
		if(x>0){
			//成功
			return "true";
		}else{
			//失败
			return "false";
		}
	}


	/*备份。。。
	 *
	 * @RequestMapping(value="/addBorrow.html",method=RequestMethod.GET)
	public String addBorrow(HttpSession session,@RequestParam("bookid")String bookid,
			@RequestParam("userid")String userid){
		Integer bid=Integer.parseInt(bookid);
		Integer uid=Integer.parseInt(userid);
		User user=new User();
		user.setId(uid);
		String userName=(userService.QueryUserById(user)).getName();
		Book book=new Book();
		book.setId(bid);
		String bookName=(bookService.QueryUserById(book)).getName();
		Borrow borrow=new Borrow();
		borrow.setBookId(bid);
		borrow.setUserId(uid);
		System.err.println(bookName+".....>>"+userName);
		borrow.setBookName(bookName);
		borrow.setUserName(userName);
		int x=borrowService.AddBorrow(borrow);
		if(x>0){
			session.setAttribute("info",bookName+"借阅成功！");
			session.removeAttribute("infox");
			return "redirect:/book/booklist.html";
		}else{
			session.setAttribute("info","借阅失败！");
			return "redirect:/book/booklist.html";
		}
		}*/

	// 打开页面。
	@RequestMapping(value = "/borrowlist.html")
	public ModelAndView borrowlist(Model model, HttpSession session) {
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("borrowlist");
		return modelAndView;
	}


	//借阅表
	@RequestMapping(value="/getBorrowlist",method= RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> getList(HttpSession session, Page page){
		Map<String,Object> result=new HashMap<>();
		Object currentUser = session.getAttribute("currentUser");
		long id=((User)currentUser).getId();
		String name = ((User) currentUser).getName();
		int count=borrowService.QueryBorrowCount(id);//总数。
		int PageSize = Integer.parseInt(page.getRows());// 页面容量
		int currentPage = Integer.parseInt(page.getPage());// 当前页
		int xx = (currentPage - 1) * PageSize;
		List<Borrow>borrowlist=borrowService.QueryBorrow(id, xx, PageSize);
		for (Borrow borrow : borrowlist) {
			borrow.setName(name);
		}
		System.err.println(borrowlist);
		result.put("rows",borrowlist);
		result.put("total",count);
		result.put("success",true);
		return result;
	}


	//删除
	@RequestMapping(value="/delete.html")
	@ResponseBody
	public String deleteBorrow(HttpSession session,@RequestParam("uid")String userid,
							   @RequestParam("bid")String bookid){
		Long userId=Long.parseLong(userid);
		Integer bookId=Integer.parseInt(bookid);
		Borrow borrow=new Borrow();
		borrow.setBookId(bookId);
		borrow.setUserId(userId);
		Borrow b=borrowService.QueryBorrowBy2id(borrow);
		LibraryBorrow lb=new LibraryBorrow();
		lb.setBookId(bookId);
		lb.setBookName(b.getBookName());
		lb.setUserId(userId);
		lb.setUserName(b.getUserName());
		lb.setBakeTime(new Timestamp(new Date().getTime()));
		lb.setBorrowTime(b.getBorrowTime());
		int y=libraryBorrowService.Add(lb);//添加到历史表中
		if(y>0){
			int z=bookService.downDateCountById(bookId);//更新图书数量。
//			int xxx=1/0;//抛异常、测试事务。
			int x=borrowService.deleteBorrow(userId, bookId);//删除借阅表中的数据。
			if(x>0&&z>0){
//				session.setAttribute("infob", "归还"+b.getBookName()+"成功");
				return "true";
			}else{
//				session.setAttribute("infob", "归还书籍失败/记录已放入历史中...");
				return "false";
			}
		}else{
//			session.setAttribute("infob", "归还书籍失败/请重试...");
			return "noData";
		}
	}
}
