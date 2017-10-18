package service;

import java.util.List;

import pojo.listNo;

public interface listNoService {
	// 查询数据根据权限读取列表
	List<listNo> QueryListByYseNo(Integer yesNo);
}
