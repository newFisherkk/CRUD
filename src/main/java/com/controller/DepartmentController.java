package com.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pojo.Department;
import com.pojo.Msg;
import com.service.DepartmentService;

/**
 * 处理部门下拉列表
 * @author Administrator
 *
 */

@Controller
@RequestMapping
public class DepartmentController {
	
	@Resource
	private DepartmentService departmentService;
	
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		System.out.println(departmentService);
		List<Department> list =departmentService.getDepts();
		return Msg.succ().add("depts",list);
	}
	
	
}
