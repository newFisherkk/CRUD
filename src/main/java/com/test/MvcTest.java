package com.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.pojo.Employee;

/**
 * ʹ��Spring����ģ���ṩ�Ĳ��������ܣ�����crud����ȷ��
 * @author Administrator
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
	//����springmvc��IOC����,WebAppConfiguration��ȡweb IOC����
	@Autowired
	WebApplicationContext context;
	//����mvc����
	MockMvc mockMvc;
	
	//���before�ǲ��Ե�before org.junit.Before;
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//ģ�������õ�����ֵ
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
		
		//����ɹ����������л���pageInfo
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("��ǰҳ�룺"+pi.getPageNum());
		System.out.println("��ҳ�룺"+pi.getPages());
		System.out.println("�ܼ�¼��:"+pi.getTotal());
		
		int[] nums=pi.getNavigatepageNums();
		for(int i:nums) {
			System.out.println("������ʾ��ҳ��:"+i);
		}
		//��ȡԱ������
		List<Employee> list = pi.getList();
		for(Employee emp:list) {
			System.out.println("ID:"+emp.getEmpId()+"   Name:"+emp.getEmpName());
		}
	}
	
	
}
