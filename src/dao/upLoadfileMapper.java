package dao;

import java.util.List;

import pojo.upLoadfile;

public interface upLoadfileMapper {

	//增加
	int AddFile(upLoadfile uploadfile);

	//删除
	int DeleteFile(upLoadfile uploadfile);

	//查看
	List<upLoadfile> getList(upLoadfile uploadfile);

	//根据id查信息
	upLoadfile upLoadfileById(Integer id);
}
