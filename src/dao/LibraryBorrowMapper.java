package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.LibraryBorrow;

public interface LibraryBorrowMapper {

	// 增加
	int Add(LibraryBorrow lb);

	// 查询
	List<LibraryBorrow> Query(LibraryBorrow lb);

	// 查总数
	int QueryCountByName2(@Param("userName") String userName, @Param("bookName") String bookName);

	// 分页
	List<LibraryBorrow> QueryByAllList(@Param("userName") String userName, @Param("bookName") String bookName,
									   @Param("IndexPage") Integer indexpage, @Param("pageSize") Integer pageSize);
}
