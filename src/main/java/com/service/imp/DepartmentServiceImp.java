package com.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mapper.DepartmentMapper;
import com.pojo.Department;
import com.service.DepartmentService;


@Service("departmentService")
public class DepartmentServiceImp implements DepartmentService {

	@Resource
	DepartmentMapper departmentMapper;

	@Override
	public List<Department> getDepts() {
		return departmentMapper.selectByExample(null);
	}
	


}
