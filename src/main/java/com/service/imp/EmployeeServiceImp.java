package com.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mapper.EmployeeMapper;
import com.pojo.Employee;
import com.pojo.EmployeeExample;
import com.pojo.EmployeeExample.Criteria;
import com.service.EmployeeService;


@Service("employeeService")
public class EmployeeServiceImp implements EmployeeService {
	
	@Resource
	EmployeeMapper employeeMapper;
	
	
	@Override
	public List<Employee> getAll() {
		System.out.println(employeeMapper);
		return employeeMapper.selectByExampleWithDept(null);
	}


	@Override
	public int saveEmp(Employee employee) {
		return employeeMapper.insertSelective(employee);
	}


	@Override
	public boolean checkUser(String empName) {
		 EmployeeExample example=new EmployeeExample();
		 Criteria createCriteria = example.createCriteria();
		 createCriteria.andEmpNameEqualTo(empName);
		 long a=employeeMapper.countByExample(example);
		 //如过查到了数据，就发现就相等的，a>0结果为false,否则为true
		return a==0;
	}


	@Override
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}


	@Override
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}


	@Override
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}


	@Override
	public void deleteBatch(List<Integer> str_ids) {
		EmployeeExample example=new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(str_ids);
		employeeMapper.deleteByExample(example);
	}



	
}
