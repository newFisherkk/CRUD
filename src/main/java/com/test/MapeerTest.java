package com.test;

import java.util.UUID;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mapper.DepartmentMapper;
import com.mapper.EmployeeMapper;
import com.pojo.Department;
import com.pojo.Employee;

/**
 * 测试dao层的工作
 * 利用spring的单元测试
 * @author Administrator
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapeerTest {

	@Resource
	DepartmentMapper departmentMapper;
	
	@Resource
	EmployeeMapper empoleeMapper;
	
	@Resource
	SqlSessionTemplate sqlSessionTemplate;
	
	
	@Test
	public void testCRUD() {
//		//原始方法：1创建SpringIOC容器
//		ApplicationContext ctx =new ClassPathXmlApplicationContext("applicaitonContext.xml");
//		//2从容器中获取mapper
//		ctx.getBean(DepartmentMapper.class);
		
		System.out.println(departmentMapper);
		
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		
		
//		empoleeMapper.insertSelective(new Empolee(null,"苏三","女","susan@qq.com", 1));
		
		//重点：批量插入多个员工，使用可以批量操作的sqlSession
		EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);	
		String gender=null;
		for(int i=0;i<100;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5);
			if(i%2==0) {
				 gender ="男";
			}else {
				 gender ="女";
			}
			mapper.insertSelective(new Employee(null, uid, gender, uid+"@cqq.com", 1));
		}
		
	}
}
