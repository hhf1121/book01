package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Book;

public interface BookMapper {

	// 获取列表
	List<Book> getList(@Param("name") String name, @Param("author") String author,
			@Param("indexPage") Integer indexPage, @Param("PageSize") Integer PageSize);

	// 书籍总数
	int CountBooks(@Param("name") String name, @Param("author") String author);

	//改变书籍数量
	int upDateCountById(Integer id);

	int downDateCountById(Integer id);

	//根据id查
	Book QueryUserById(Book book);
	
	Book QueryCountById(Book book);
	
	//增加书籍
	int addBook(Book book);
	//删除书籍。
	int deleteBook(Book book);
	
	//查询库存。
	Book QueryCC(Book book);
	
}
