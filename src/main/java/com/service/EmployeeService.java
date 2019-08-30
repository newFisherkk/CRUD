package com.service;

import java.util.List;

import com.pojo.Employee;

public interface EmployeeService {

	List<Employee> getAll();
	
	int saveEmp(Employee employee);

	boolean checkUser(String empName);

	Employee getEmp(Integer id);

	void updateEmp(Employee employee);

	void deleteEmp(Integer id);

	void deleteBatch(List<Integer> str_ids);

}
