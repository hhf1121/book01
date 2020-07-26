package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.BookMapper;
import pojo.Book;

@Service
public class bookServiceImpl implements bookService {

	@Resource
	private BookMapper bookMapper;
	
	
	@Override
	public List<Book> getList(String name, String author, Integer indexPage, Integer PageSize) {
		// TODO Auto-generated method stub
		return bookMapper.getList(name, author, indexPage, PageSize);
	}

	@Override
	public int CountBooks(String name, String author) {
		// TODO Auto-generated method stub
		return bookMapper.CountBooks(name, author);
	}

	@Override
	public int upDateCountById(Integer id) {
		// TODO Auto-generated method stub
		return bookMapper.upDateCountById(id);
	}

	@Override
	public int downDateCountById(Integer id) {
		// TODO Auto-generated method stub
		return bookMapper.downDateCountById(id);
	}

	@Override
	public Book QueryUserById(Book book) {
		// TODO Auto-generated method stub
		return bookMapper.QueryUserById(book);
	}

	@Override
	public Book QueryCountById(Book book) {
		// TODO Auto-generated method stub
		return bookMapper.QueryCountById(book);
	}

	@Override
	public int addBook(Book book) {
		// TODO Auto-generated method stub
		return bookMapper.addBook(book);
	}

	@Override
	public int deleteBook(Book book) {
		// TODO Auto-generated method stub
		return bookMapper.deleteBook(book);
	}

	@Override
	public Book QueryCC(Book book) {
		// TODO Auto-generated method stub
		return bookMapper.QueryCC(book);
	}

	@Override
	public Book getExits(Book book) {
		return bookMapper.getExits(book);
	}

}
