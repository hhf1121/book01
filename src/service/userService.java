package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface userService {
	// ע��
	int addUser(User user);

	User QueryUser(User user);

	// �޸���Ϣ
	int ModifyUser(User user);

	// ����id
	User QueryUserById(User user);

	// �һ�����
	User BakePass(User user);

	// �˺��Ƿ����
	int ifExist(String userName);

	// ������
	int getUserCount(String name, Integer yes);

	// ��ҳ���б�
	List<User> getUserList(String name, Integer yes, Integer indexPage, Integer pagesize);

	int deleteById(String[] IdList);
}
