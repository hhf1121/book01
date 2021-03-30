package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.RoleMapper;
import pojo.Role;
@Service
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleMapper roleMapper;
	
	@Override
	public List<Role>  Querylist(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.Querylist(role);
	}

	@Override
	public List<Role> queryAllRole() {
		return roleMapper.queryAllRole();
	}

}
