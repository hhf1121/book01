package dao;

import java.util.List;

import pojo.listNo;

public interface listNoMapper {

	//��ѯ���ݸ���Ȩ�޶�ȡ�б�
	List<listNo> QueryListByYseNo(Integer yesNo);
	
}
