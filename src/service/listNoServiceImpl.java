package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.listNoMapper;
import pojo.listNo;

@Service
public class listNoServiceImpl implements listNoService {

	@Resource
	private listNoMapper listNoMapper;
	
	@Override
	public List<listNo> QueryListByYseNo(Integer yesNo) {
		// TODO Auto-generated method stub
		return listNoMapper.QueryListByYseNo(yesNo);
	}

}
