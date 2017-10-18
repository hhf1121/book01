package service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.upLoadfileMapper;
import pojo.upLoadfile;

@Service
public class upLoadfileServiceImpl implements upLoadfileService{

	@Resource
	private upLoadfileMapper uploadfileMapper;
	
	
	
	@Override
	public int AddFile(upLoadfile uploadfile) {
		// TODO Auto-generated method stub
		return uploadfileMapper.AddFile(uploadfile);
	}

	@Override
	public int DeleteFile(upLoadfile uploadfile) {
		// TODO Auto-generated method stub
		return uploadfileMapper.DeleteFile(uploadfile);
	}

	@Override
	public List<upLoadfile> getList(upLoadfile uploadfile) {
		// TODO Auto-generated method stub
		return uploadfileMapper.getList(uploadfile);
	}

	@Override
	public upLoadfile upLoadfileById(Integer id) {
		// TODO Auto-generated method stub
		return uploadfileMapper.upLoadfileById(id);
	}

	
	
}
