package dao;

import java.util.List;

import pojo.upLoadfile;

public interface upLoadfileMapper {

	//����
	int AddFile(upLoadfile uploadfile);
	
	//ɾ��
	int DeleteFile(upLoadfile uploadfile);
	
	//�鿴
	List<upLoadfile> getList(upLoadfile uploadfile);
	
	//����id����Ϣ
	upLoadfile upLoadfileById(Integer id);
}
