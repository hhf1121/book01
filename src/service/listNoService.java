package service;

import java.util.List;

import pojo.listNo;

public interface listNoService {
	// ��ѯ���ݸ���Ȩ�޶�ȡ�б�
	List<listNo> QueryListByYseNo(Integer yesNo);
}
