package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Borrow;

public interface borrowService {

	// ����
	int AddBorrow(Borrow borrow);

	// �޸�
	int upDateCountById(Integer id);

	Borrow QueryBorrowBy2id(Borrow borrow);

	// ����
	int QueryBorrowCount(Integer id);

	// ��ѯ�����û����ĵ��б�(��ҳ)
	List<Borrow> QueryBorrow(Integer id, Integer currentPage, Integer pageSize);

	// ɾ��
	int deleteBorrow(Integer userId,Integer bookId);
}
