package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Borrow;

public interface borrowService {

	// 增加
	int AddBorrow(Borrow borrow);

	// 修改
	int upDateCountById(Long id);

	Borrow QueryBorrowBy2id(Borrow borrow);

	// 总数
	int QueryBorrowCount(Long id);

	// 查询单个用户借阅的列表(分页)
	List<Borrow> QueryBorrow(Long id, Integer currentPage, Integer pageSize);

	// 删除
	int deleteBorrow(Long userId,Integer bookId);
}
