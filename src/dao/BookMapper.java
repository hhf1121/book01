package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Book;

public interface BookMapper {

	// ��ȡ�б�
	List<Book> getList(@Param("name") String name, @Param("author") String author,
			@Param("indexPage") Integer indexPage, @Param("PageSize") Integer PageSize);

	// �鼮����
	int CountBooks(@Param("name") String name, @Param("author") String author);

	//�ı��鼮����
	int upDateCountById(Integer id);

	int downDateCountById(Integer id);

	//����id��
	Book QueryUserById(Book book);
	
	Book QueryCountById(Book book);
	
	//�����鼮
	int addBook(Book book);
	//ɾ���鼮��
	int deleteBook(Book book);
	
	//��ѯ��档
	Book QueryCC(Book book);
	
}