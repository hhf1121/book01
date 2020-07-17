package service;

import java.util.List;

import pojo.upLoadfile;

public interface upLoadfileService {

	// 增加
	int AddFile(upLoadfile uploadfile);

	// 删除
	int DeleteFile(upLoadfile uploadfile);

	// 查看
	List<upLoadfile> getList(upLoadfile uploadfile);

	upLoadfile upLoadfileById(Integer id);
}
