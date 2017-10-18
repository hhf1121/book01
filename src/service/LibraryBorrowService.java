package service;

import java.util.List;


import pojo.LibraryBorrow;

public interface LibraryBorrowService {
	// 增加
	int Add(LibraryBorrow lb);

	// 查询
	List<LibraryBorrow> Query(LibraryBorrow lb);

	// 查总数
	int QueryCountByName2(String userName,String bookName);

	// 查总数
	List<LibraryBorrow> QueryByAllList(String userName,String bookName,
			Integer indexpage,Integer pageSize);
}
