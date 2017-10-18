package service;

import java.util.List;

import pojo.Book;

public interface bookService {
	// ��ȡ�б�
	List<Book> getList(String name, String author, Integer indexPage, Integer PageSize);

	// �鼮����
	int CountBooks(String name, String author);

	// �޸�
	int upDateCountById(Integer id);

	int downDateCountById(Integer id);

	// ����id��
	Book QueryUserById(Book book);

	Book QueryCountById(Book book);

	// �����鼮
	int addBook(Book book);

	// ɾ���鼮��
	int deleteBook(Book book);

	// ��ѯ��档
	Book QueryCC(Book book);
}
