package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.borrowMapper;
import pojo.Borrow;
import service.borrowService;

@Service
public class borrowServiceImpl implements borrowService {

	@Resource
	private borrowMapper borrowMapper;

	@Override
	public int AddBorrow(Borrow borrow) {
		// TODO Auto-generated method stub
		return borrowMapper.AddBorrow(borrow);
	}

	@Override
	public int upDateCountById(Long id) {
		// TODO Auto-generated method stub
		return borrowMapper.upDateCountById(id);
	}

	@Override
	public Borrow QueryBorrowBy2id(Borrow borrow) {
		return borrowMapper.QueryBorrowBy2id(borrow);
	}

	@Override
	public int QueryBorrowCount(Long id) {
		// TODO Auto-generated method stub
		return borrowMapper.QueryBorrowCount(id);
	}

	@Override
	public List<Borrow> QueryBorrow(Long id, Integer currentPage, Integer pageSize) {
		// TODO Auto-generated method stub
		return borrowMapper.QueryBorrow(id, currentPage, pageSize);
	}

	@Override
	public int deleteBorrow(Long userId, Integer bookId) {
		// TODO Auto-generated method stub
		return borrowMapper.deleteBorrow(userId, bookId);
	}
}
