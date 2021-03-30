package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pojo.User;

public interface UserMapper {

	//注册
	int addUser(User user);

	//登录、验证账号密码。
	User QueryUser(User user);

	//修改信息
	int ModifyUser(User user);

	//根据id
	User QueryUserById(User user);

	//找回密码
	User BakePass(User user);

	//账号是否存在
	int ifExist(String userName);

	//总数。
	int getUserCount(@Param("name")String name,@Param("yes")Integer yes,@Param("registerTime")String registerTime);

	//分页、列表。
	List<User> getUserList(@Param("name")String name,@Param("yes")Integer yes,@Param("registerTime")String registerTime,@Param("indexPage")Integer indexPage,@Param("pagesize")Integer pagesize);
	//根据id删除多个。
	int deleteById(@Param("StringList")String [] IdList);

    User getUserById(String id);
}
