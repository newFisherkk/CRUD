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
 * ����dao��Ĺ���
 * ����spring�ĵ�Ԫ����
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
//		//ԭʼ������1����SpringIOC����
//		ApplicationContext ctx =new ClassPathXmlApplicationContext("applicaitonContext.xml");
//		//2�������л�ȡmapper
//		ctx.getBean(DepartmentMapper.class);
		
		System.out.println(departmentMapper);
		
//		departmentMapper.insertSelective(new Department(null,"������"));
//		departmentMapper.insertSelective(new Department(null,"���Բ�"));
		
		
//		empoleeMapper.insertSelective(new Empolee(null,"����","Ů","susan@qq.com", 1));
		
		//�ص㣺����������Ա����ʹ�ÿ�������������sqlSession
		EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);	
		String gender=null;
		for(int i=0;i<100;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5);
			if(i%2==0) {
				 gender ="��";
			}else {
				 gender ="Ů";
			}
			mapper.insertSelective(new Employee(null, uid, gender, uid+"@cqq.com", 1));
		}
		
	}
}
