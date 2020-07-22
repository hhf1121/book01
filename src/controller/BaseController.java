package controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.MyTreeNode;
import service.IBaseService;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/base")
public class BaseController {

    @Autowired
    private IBaseService baseService;

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


}
