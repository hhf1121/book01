package service;

import java.util.List;

import pojo.upLoadfile;

public interface upLoadfileService {

	// ����
	int AddFile(upLoadfile uploadfile);

	// ɾ��
	int DeleteFile(upLoadfile uploadfile);

	// �鿴
	List<upLoadfile> getList(upLoadfile uploadfile);

	upLoadfile upLoadfileById(Integer id);
}
