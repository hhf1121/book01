package service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface userService {
	// 注册
	int addUser(User user);

	User QueryUser(User user);

	// 修改信息
	int ModifyUser(User user);

	// 根据id
	User QueryUserById(User user);

	// 找回密码
	User BakePass(User user);

	// 账号是否存在
	int ifExist(String userName);

	// 总数。
	int getUserCount(String name, Integer yes);

	// 分页、列表。
	List<User> getUserList(String name, Integer yes, Integer indexPage, Integer pagesize);

	int deleteById(String[] IdList);
}
