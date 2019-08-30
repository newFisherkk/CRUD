<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<% 
pageContext.setAttribute("app_path", request.getContextPath());
%>

<!-- web路径问题：
	不以/开头的为相对路径，以当前资源的路径为基准
	以/开头的相对路径找资源以服务器的根路径(http://localhost:8080)为标准，需要加上项目名才能正确找到
		http://localhost:8080/ssm-crud 
 -->

<script type="text/javascript" src="${app_path }/static/js/jquery.min.js"></script>
<link href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
	<!-- bootstrap搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-success">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格，数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				
				<c:forEach items="${pageInfo.list}" var="emp">
					<tr>
						<td>${emp.empId}</td>
						<td>${emp.empName}</td>
						<td>${emp.gender}</td>
						<td>${emp.email}</td>
						<td>${emp.department.deptName}</td>
						<td>
							<button class="btn btn-success btn-sm">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
							新增
							</button>
							<button class="btn btn-danger btn-sm">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
							删除
							</button>
						</td>
					</tr>
				</c:forEach>
				
				
				</table>
			</div>
		</div>
		<!-- 分页信息-->
		<div class="row">
			 <!-- 分页文字 -->
			 <div class="col-md-6">
			 	当前第${pageInfo.pageNum }页，总${pageInfo.pages }页,总 ${pageInfo.total}条记录
			 </div>
			 
			 
			 <!-- 分页条 -->
			 <div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li>
				  		<a href="${app_path}/emps?pn=1">首页</a>
				  	</li>
				  	
				  	 <c:if test="${pageInfo.hasPreviousPage}">
					  	<li>
					      <a href="${app_path}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				  	 </c:if>
				   
				    
				    <c:forEach items="${pageInfo.navigatepageNums}" var="pn">
				    	<c:if test="${pn eq pageInfo.pageNum }">
				    		<li class="active"><a href="#">${pn}</a></li>
				    	</c:if>
				    	<c:if test="${pn != pageInfo.pageNum }">
				    		<li ><a href="${app_path}/emps?pn=${pn}">${pn}</a></li>
				    	</c:if>
				    </c:forEach>
				    
				    
				   <c:if test="${pageInfo.hasNextPage}">
					    <li>
					      <a href="${app_path}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				   </c:if>
				   
				    <li>
				  		<a href="${app_path}/emps?pn=${pageInfo.pages}">末页</a>
				  	</li>
				  </ul>
				</nav>
			 </div>
		</div>
	</div>
</body>
</html>