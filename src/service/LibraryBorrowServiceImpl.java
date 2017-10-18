package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.LibraryBorrowMapper;
import pojo.LibraryBorrow;
@Service
public class LibraryBorrowServiceImpl implements LibraryBorrowService {

	@Resource
	private LibraryBorrowMapper libraryBorrowMapper;
	
	
	@Override
	public int Add(LibraryBorrow lb) {
		// TODO Auto-generated method stub
		return libraryBorrowMapper.Add(lb);
	}

	@Override
	public List<LibraryBorrow> Query(LibraryBorrow lb) {
		// TODO Auto-generated method stub
		return libraryBorrowMapper.Query(lb);
	}

	@Override
	public int QueryCountByName2(String userName, String bookName) {
		// TODO Auto-generated method stub
		return libraryBorrowMapper.QueryCountByName2(userName, bookName);
	}

	@Override
	public List<LibraryBorrow> QueryByAllList(String userName, String bookName, Integer indexpage, Integer pageSize) {
		// TODO Auto-generated method stub
		return libraryBorrowMapper.QueryByAllList(userName, bookName, indexpage, pageSize);
	}

}
