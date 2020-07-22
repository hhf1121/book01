package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import pojo.LibraryBorrow;
import pojo.User;
import service.LibraryBorrowService;
import service.bookService;
import tools.Page;

@Controller
@RequestMapping("/libraryborrow")
public class libraryborrowController {

    @Resource
    private LibraryBorrowService libraryBorrowService;

    // 个人历史记录
    @RequestMapping(value = "/librarylist.html")
    public String OneList(HttpSession session, Model model) {
        Object currentUser = session.getAttribute("currentUser");
        if(currentUser==null){
            return "login";
        }
        Long userID = ((User) currentUser).getId();
        LibraryBorrow lb = new LibraryBorrow();
        lb.setUserId(userID);
        List<LibraryBorrow> list = libraryBorrowService.Query(lb);
        for (LibraryBorrow library : list) {
            library.setTimelag((library.getBakeTime().getTime()-library.getBorrowTime().getTime())/3600000/24+"");
        }
        model.addAttribute("Librarylist", list);
        return "librarylist";
    }

    // 个人历史记录list-easyui分页
    @RequestMapping(value = "/getlibrarylist")
    @ResponseBody
    public  Map<String,Object> getlibrarylist(HttpSession session,Page page) {
        Map<String,Object> result=new HashMap<>();
        Object currentUser = session.getAttribute("currentUser");
        Long userID = ((User) currentUser).getId();
        Long countSize = libraryBorrowService.Countlibrarys(userID);// 总条数
        Page page1 = new Page();
        page1.setCountSize(countSize.intValue());
        int PageSize = Integer.parseInt(page.getRows());// 页面容量
        int currentPage = Integer.parseInt(page.getPage());// 当前页
        int xx = (currentPage - 1) * PageSize;
        List<LibraryBorrow> booklist = libraryBorrowService.getLibraryList(userID, xx, PageSize);
        for (LibraryBorrow library : booklist) {
            library.setReadDays((library.getBakeTime().getTime()-library.getBorrowTime().getTime())/3600000/24+"");
        }
        result.put("rows",booklist);
        result.put("total",countSize);
        result.put("success",true);
        return result;
    }


    // 管理员查看所有的记录
    @RequestMapping(value = "/alllibrarylist.html")
    public String OneList(Model model, @RequestParam(value = "bookName", required = false) String bookName,
                          @RequestParam(value = "userName", required = false) String userName,
                          @RequestParam(value = "pageIndex", required = false) String indexPage) {
        Page page = new Page();
        int PageSize = page.getPageSize();//页面容量。
        int currentPage = page.getCurrentPage();//当前页面。
        int CountSize = libraryBorrowService.QueryCountByName2(userName, bookName);//总条数
        page.setCountSize(CountSize);
        int pageCount = page.getPageCount();//页数。
        if (null != indexPage) {
            currentPage = Integer.parseInt(indexPage);
        }
        int x = (currentPage - 1) * PageSize;
        List<LibraryBorrow> list = libraryBorrowService.QueryByAllList(userName, bookName, x, PageSize);
        model.addAttribute("Librarylist", list);
        model.addAttribute("bookName", bookName);
        model.addAttribute("userName", userName);
        model.addAttribute("totalPageCount", pageCount);
        model.addAttribute("pageNo", currentPage);
        model.addAttribute("totalCount", CountSize);
        return "alllibrarylist";
    }

}
