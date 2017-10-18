package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface UserMapper {

	//ע��
	int addUser(User user);
	
	//��¼����֤�˺����롣
	User QueryUser(User user);
	
	//�޸���Ϣ
	int ModifyUser(User user);
	
	//����id
	User QueryUserById(User user);
	
	//�һ�����
	User BakePass(User user);
	
	//�˺��Ƿ����
	int ifExist(String userName);
	
	//������
	int getUserCount(@Param("name")String name,@Param("yes")Integer yes);
	
	//��ҳ���б�
	List<User> getUserList(@Param("name")String name,@Param("yes")Integer yes,@Param("indexPage")Integer indexPage,@Param("pagesize")Integer pagesize);
	//����idɾ�������
	int deleteById(@Param("StringList")String [] IdList);
}
