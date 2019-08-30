package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Employee;
import com.pojo.Msg;
import com.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Resource
	EmployeeService employeeService;
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value="pn",defaultValue="2")Integer pm){
		System.out.println("热部署"+pm);
		PageHelper.startPage(pm, 5);
		//这个需要加，不然新增保存的时候会乱序
		PageHelper.orderBy("emp_id asc");
		List list= employeeService.getAll();
		PageInfo page =new PageInfo(list,5);
		
		return Msg.succ().add("pageInfo",page);
	}
	
	
	//查询员工数据，分页查询
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		System.out.println(employeeService);
		//引入pageHelper插件 传入页码从第几页开始及每页大小
		PageHelper.startPage(pn, 5);
		//紧跟的查询就是一个分页查询，前面的或者下一个list都没有分页功能<-重点
		List<Employee> list=employeeService.getAll();
		//PageInf包装查询后的结果，只需要将PageInfo交给页面就行了,封装了详细的分页信息，及查询数据  5为连续显示的页数
		PageInfo<Employee> page =new PageInfo<>(list,5);
		model.addAttribute("pageInfo",page);
		
		return "Emplist";
	}
	
	/**
	 * 模态框表单保存员工数据,封装的数据要校验
	 * 支持JSR303校验
	 * 1、导入 Hibernate-Validator包
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		
		if(result.hasErrors()) {
			//校验失败，需要返回失败的错误信息
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error :errors) {
				System.out.println("错误的字段为："+error.getField());
				System.out.println("错误信息为:"+error.getDefaultMessage());
				map.put(error.getField(),error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			int code=employeeService.saveEmp(employee);
			System.out.println(code);
			return Msg.succ();
		}

	}
	
	//校验用户名是否重复     不带RequestParam String后面只能跟empName(与Requstparam传来的name一样） 
	//疑问  为啥request是post这里没有写post方法?????
	/**
	 * method 若是缺省没指定，并不是说它默认只处理 GET 方式的请求，而是它可以处理任何方式的 http method 类型的请求。
		指定 method 是为了细化映射 ( 缩小处理方法的映射范围 )，在 method 没有指定的情况下，它的映射范围是最大的。
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkUser")
	@ResponseBody
	public Msg checkUser(String empName) {
		//java中正则没有前后/   matches为String的方法
		String regx ="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"; 
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "后端检验：姓名为2-5位中文或者6-16位英文和数字的组合，可以有下划线");
		}
		
		System.out.println(empName);
		boolean flag=employeeService.checkUser(empName);
		if(flag) {
			return Msg.succ();
		}else {
			return Msg.fail().add("va_msg","用户名已存在");
		}
	}
	
	//根据id查询员工
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		
		Employee employee = employeeService.getEmp(id);
		return Msg.succ().add("emp", employee);
	}
	
	/**
	 * 更新员工数据  将id改为empId(重要)     即把empId传过来(mapper中的sql语句where条件里面看的是id相等就更新)
	 * 
	 * AJAX发送PUT请求引发的血案：
	 * 			如果直接发送ajax put的请求，除了empId,其余封装的数据全是null
	 * 			问题：请求体中有数据，但是Employee封装不上 
	 * 			sql语句就会出现 update tbl_emp where id=#{empId}  无set条件，肯定报sql异常
	 * 
	 *原因：
	 *     tomcat问题。一般来说，tomcat将请求体中的数据封装为map.  
	 *           如request.getParameter("empName")就会从这个map中取值
	 *     springmvc封装POJO对象的时候，会把POJO中每个属性的值 如request.getParameter("empName") 拿到
	 *     
	 *     Root problem:tomcat一看是put请求就不会封装请求体中的数据为map，只有POST形式的请求	才封装请求为map
	 *     
	 *     org.apache.catalina.connector.Request中有一个 parseParameters()方法  3111行
	 *  	parseBodyMethod="POST"  
	 *     if(!getConnector().isParseBodyMethod(getMethod()){
	 *     			sucess=true;
	 *     			return;	
	 *     }
	 *      除了POST请求都会导致上续方法直接return而不会去封装为map
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.succ();
	}
	
	//删除员工(批量单个都可以)
	//批量删除：1-2-3
	//单个删除:1
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
	
		if(ids.contains("-")) {
			//批量删除
			String[] str_ids=ids.split("-");
			//组装id的集合
			List<Integer> list =new ArrayList<>();
			for(String str_id:str_ids) {
				list.add(Integer.parseInt(str_id));
			}
			employeeService.deleteBatch(list);
		}else {
			//单个删除
			Integer id=Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.succ();
	}
	
	
	
}
