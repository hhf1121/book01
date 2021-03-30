package service;

import java.util.List;

import javax.annotation.Resource;

import com.dangdang.ddframe.job.reg.base.CoordinatorRegistryCenter;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

import dao.UserMapper;
import pojo.User;
import task.RunTask;

@Service
public class userServiceImpl implements userService, InitializingBean {

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

	// 修改信息
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
	public int getUserCount(String name, Integer yes,String registerTime) {
		// TODO Auto-generated method stub
		return userMapper.getUserCount(name, yes,registerTime);
	}

	@Override
	public List<User> getUserList(String name, Integer yes,String registerTime, Integer indexPage, Integer pagesize) {
		// TODO Auto-generated method stub
		return userMapper.getUserList(name, yes,registerTime, indexPage, pagesize);
	}

	@Override
	public int deleteById(String[] IdList) {
		// TODO Auto-generated method stub
		return userMapper.deleteById(IdList);
	}

	@Override
	public User getUserById(String id) {
		return userMapper.getUserById(id);
	}

	@Override
	public List<String> queryAllUserName() {
		return userMapper.queryAllUserName();
	}

    @Override
    public List<User> queryListByUserName(List<String> codes) {
        return userMapper.queryListByUserName(codes);
    }

    @Override
    public int insertList(List<User> users) {
        return userMapper.insertList(users);
    }

    @Override
    public int updateUserById(User user) {
        return userMapper.updateUserById(user);
    }

    @Override
	public void afterPropertiesSet() throws Exception {
	    //启动定时任务elastic-job
//		CoordinatorRegistryCenter coordinatorRegistryCenter = RunTask.initZK();
//		RunTask.startTask(coordinatorRegistryCenter);
	}
}
