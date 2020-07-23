package controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Book;
import pojo.MyTreeNode;
import service.IBaseService;
import service.bookService;
import tools.Page;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/base")
public class BaseController {

    @Autowired
    private IBaseService baseService;

    @Resource
    private service.bookService bookService;

    /**
     * 联动选择器、根据等级、一次性拉取数据
     * @param level
     * @return
     */
    @RequestMapping("/getSelectDistrictByLevel.json")
    @ResponseBody
    public List<MyTreeNode> getSelectDistrict(String level,String name){
        return baseService.getSelectDistrictByLevel(level,name);
    }

    /**
     * 模拟组合框数据
     * @param level
     * @return
     */
    @RequestMapping(value = "/getComboboxData",method = RequestMethod.GET)
    @ResponseBody
    public List<MyTreeNode> getComboboxData(String level,String name){
        return baseService.getComboboxData(level,name);
    }

    /**
     *  模拟表单提交
     * @return
     */
    @RequestMapping(value = "/submitForm",method = RequestMethod.POST)
    public String submitForm(String name, Date birthday,String lang){
        System.out.println(name);
        System.out.println(birthday);
        System.out.println(lang);
        return "isSubmitForm";
    }

    /**
     *  模拟easyui表单数据
     * @return
     */
    @RequestMapping(value = "/getEasyUIData",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getEasyUIData(String name,String author,Page page){
        Map<String,Object> result=new HashMap<>();
        Page page1 = new Page();
        int countSize = bookService.CountBooks(name, author);// 总条数
        page1.setCountSize(countSize);
        int PageSize = Integer.parseInt(page.getRows());// 页面容量
        int currentPage = Integer.parseInt(page.getPage());// 当前页
//        int PageSize=10;
//        int currentPage=1;
        int xx = (currentPage - 1) * PageSize;
        List<Book> booklist = bookService.getList(name, author, xx, PageSize);
        result.put("rows",booklist);
        result.put("total",countSize);
        result.put("success",true);
        return result;
//        return booklist;
    }


}
