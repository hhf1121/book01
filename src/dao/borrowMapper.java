package dao;

import java.util.List;

/***
 * 借阅表
 */

import org.apache.ibatis.annotations.Param;

import pojo.Borrow;



public interface borrowMapper {

	// 增加
	int AddBorrow(Borrow borrow);

	// 查询
	Borrow QueryBorrowBy2id(Borrow borrow);
	
	//修改
	int upDateCountById(Long id);

	//总数
	int QueryBorrowCount(Long id);
	
	//查询单个用户借阅的列表(分页)
	List<Borrow> QueryBorrow(@Param("id") Long id,@Param("currentPage")Integer currentPage,@Param("pageSize")Integer pageSize);
	
	//删除
	int deleteBorrow(@Param("userId")Long userId,@Param("bookId")Integer bookId);
	
}
