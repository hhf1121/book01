package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.Borrow;

public interface borrowService {

	// ����
	int AddBorrow(Borrow borrow);

	// �޸�
	int upDateCountById(Long id);

	Borrow QueryBorrowBy2id(Borrow borrow);

	// ����
	int QueryBorrowCount(Long id);

	// ��ѯ�����û����ĵ��б�(��ҳ)
	List<Borrow> QueryBorrow(Long id, Integer currentPage, Integer pageSize);

	// ɾ��
	int deleteBorrow(Long userId,Integer bookId);
}
