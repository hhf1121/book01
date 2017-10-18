package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.LibraryBorrow;

public interface LibraryBorrowMapper {

	// ����
	int Add(LibraryBorrow lb);

	// ��ѯ
	List<LibraryBorrow> Query(LibraryBorrow lb);

	// ������
	int QueryCountByName2(@Param("userName") String userName, @Param("bookName") String bookName);

	// ��ҳ
	List<LibraryBorrow> QueryByAllList(@Param("userName") String userName, @Param("bookName") String bookName,
			@Param("IndexPage") Integer indexpage, @Param("pageSize") Integer pageSize);
}
