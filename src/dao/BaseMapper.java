package dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import pojo.MyTreeNode;

import java.util.List;

public interface BaseMapper {

//    @Select("select * from base_district where level_type != #{levels} ")
    public List<MyTreeNode> getListByLevel(@Param("lists") List<String> lists);

}
