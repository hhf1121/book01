package service;

import dao.BaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import pojo.MyTreeNode;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class IBaseService {

    @Autowired
    BaseMapper baseMapper;

    /**
     * 1.根据等级获取
     * 2.根据name过滤（父级）
     * @param level
     * @param name
     * @return
     */
    public List<MyTreeNode> getSelectDistrictByLevel(String level, String name) {
        String[] split = level.split(",");
        List<String> strings =new ArrayList<>(Arrays.asList(split));
        List<MyTreeNode> listByLevel = baseMapper.getListByLevel(strings);
        if(!StringUtils.isEmpty(name)){
            List<MyTreeNode> province=new ArrayList<>(listByLevel);
            province = province.stream().filter(o -> split[0].equals(o.getLevelType())&&o.getText().indexOf(name)!=-1).collect(Collectors.toList());
            MyTreeNode myTreeNode = province.get(0);
            listByLevel = listByLevel.stream().filter(o -> o.getParentCode().equals(myTreeNode.getCode()) || o.getCode().equals(myTreeNode.getCode())).collect(Collectors.toList());
        }
        Map<String,MyTreeNode> map=new HashMap<>();
        List<MyTreeNode> parents =new ArrayList<>();
        for (MyTreeNode myTreeNode : listByLevel) {
            map.put(myTreeNode.getCode(),myTreeNode);
            if(split[0].equals(myTreeNode.getLevelType())){
                parents.add(myTreeNode);
            }
        }
        for (MyTreeNode myTreeNode : listByLevel) {
            MyTreeNode parent = map.get(myTreeNode.getParentCode());
            if(parent!=null){
                parent.getChildren().add(myTreeNode);
            }
        }
        return parents;
    }

    public List<MyTreeNode> getComboboxData(String level, String name) {
        return baseMapper.getComboboxData(level,name);
    }
}
