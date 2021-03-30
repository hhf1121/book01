package dao;

import java.util.List;

import pojo.Role;

public interface RoleMapper {

	//查询
	List<Role>  Querylist(Role role);

    List<Role> queryAllRole();

}
