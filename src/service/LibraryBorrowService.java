package service;

import java.util.List;


import pojo.LibraryBorrow;

public interface LibraryBorrowService {
	// ����
	int Add(LibraryBorrow lb);

	// ��ѯ
	List<LibraryBorrow> Query(LibraryBorrow lb);

	// ������
	int QueryCountByName2(String userName,String bookName);

	// ������
	List<LibraryBorrow> QueryByAllList(String userName,String bookName,
			Integer indexpage,Integer pageSize);
}
