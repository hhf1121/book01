package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.UserMapper;
import pojo.User;

@Service
public class userServiceImpl implements userService {

	@Resource
	private UserMapper userMapper;

	@Override
	public int addUser(User user) {
		return userMapper.addUser(user);
	}

	@Override
	public User QueryUser(User user) {
		return userMapper.QueryUser(user);
	}

	// ÐÞ¸ÄÐÅÏ¢
	public int ModifyUser(User user) {
		return userMapper.ModifyUser(user);
	}

	@Override
	public User QueryUserById(User user) {
		// TODO Auto-generated method stub
		return userMapper.QueryUserById(user);
	}

	@Override
	public User BakePass(User user) {
		// TODO Auto-generated method stub
		return userMapper.BakePass(user);
	}

	@Override
	public int ifExist(String userName) {
		// TODO Auto-generated method stub
		return userMapper.ifExist(userName);
	}

	@Override
	public int getUserCount(String name, Integer yes) {
		// TODO Auto-generated method stub
		return userMapper.getUserCount(name, yes);
	}

	@Override
	public List<User> getUserList(String name, Integer yes, Integer indexPage, Integer pagesize) {
		// TODO Auto-generated method stub
		return userMapper.getUserList(name, yes, indexPage, pagesize);
	}

	@Override
	public int deleteById(String[] IdList) {
		// TODO Auto-generated method stub
		return userMapper.deleteById(IdList);
	}

}
