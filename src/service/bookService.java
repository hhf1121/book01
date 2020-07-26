package service;

import java.util.List;

import pojo.Book;

public interface bookService {
	// 获取列表
	List<Book> getList(String name, String author, Integer indexPage, Integer PageSize);

	// 书籍总数
	int CountBooks(String name, String author);

	// 修改
	int upDateCountById(Integer id);

	int downDateCountById(Integer id);

	// 根据id查
	Book QueryUserById(Book book);

	Book QueryCountById(Book book);

	// 增加书籍
	int addBook(Book book);

	// 删除书籍。
	int deleteBook(Book book);

	// 查询库存。
	Book QueryCC(Book book);

	//是否存在
	Book getExits(Book book);
}
