package dao;

import java.util.List;

/***
 * ���ı�
 */

import org.apache.ibatis.annotations.Param;

import pojo.Borrow;



public interface borrowMapper {

	// ����
	int AddBorrow(Borrow borrow);

	// ��ѯ
	Borrow QueryBorrowBy2id(Borrow borrow);
	
	//�޸�
	int upDateCountById(Long id);

	//����
	int QueryBorrowCount(Long id);
	
	//��ѯ�����û����ĵ��б�(��ҳ)
	List<Borrow> QueryBorrow(@Param("id") Long id,@Param("currentPage")Integer currentPage,@Param("pageSize")Integer pageSize);
	
	//ɾ��
	int deleteBorrow(@Param("userId")Long userId,@Param("bookId")Integer bookId);
	
}
