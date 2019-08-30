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

<script type="text/javascript" src="${app_path }/static/js/jquery.min.js"></script>
<link href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>

	<!-- Modal员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" >员工修改</h4>
	      </div>
	      
	      <div class="modal-body">
	        <!-- 添加一个表单 -->
			<form class="form-horizontal">
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			       <p class="form-control-static" id="updateEmpName"></p>
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">电子邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="update_empEmail" placeholder="email@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
		
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">性别</label>
			     <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" value="男" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" value="女"> 女
					</label>
				</div>
			  </div>
			  
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
					<select class="form-control" name="dId" id="updateDept">
						<!-- 通过ajax拿取 -->
					</select>
			    </div>
			  </div>
			  
			</form>
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="updateEmp">更新</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- Modal员工添加模态框 -->
	<div class="modal fade" id="empModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      
	      <div class="modal-body">
	        <!-- 添加一个表单 -->
			<form class="form-horizontal">
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="input_empName" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">电子邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="input_empEmail" placeholder="email@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
		
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">性别</label>
			     <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="gender" id="inlineRadio3" value="男" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="inlineRadio3" value="女"> 女
					</label>
				</div>
			  </div>
			  
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
					<select class="form-control" name="dId" id="inputDept">
						<!-- 通过ajax拿取 -->
					</select>
			    </div>
			  </div>
			  
			</form>
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveEmp">保存</button>
	      </div>
	    </div>
	  </div>
	</div>


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
				<button class="btn btn-success" id="open_empModal">新增</button>
				<button class="btn btn-danger" id="delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格，数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_on" /></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息-->
		<div class="row">
			 <!-- 分页文字 -->
			 <div class="col-md-6" id="page_info"> </div>
			 <!-- 分页条 -->
			 <div class="col-md-6" id="page_nav"> </div>
		</div>
	</div>
	
	<!-- 通过ajax向页面发送数据 -->
	<script type="text/javascript">
		//定义一个全局总记录数，比页数大的话总会显示最后一页
		var totalRecord,currentPage;
		//页面加载完成后直接去发送ajax请求得到分页数据
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${app_path}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//1.result里面就是controller里面封装返回的json数据,解析并显示员工数据
					build_emps_table(result); 
					//1.解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页条
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result){
			//清空tbody的数据
			$("#table tbody").empty();
			var emps=result.extend.pageInfo.list;
			//jquery中的遍历 item为emps中的每一个元素
			$.each(emps,function(index,item){
				var checkBoxTd=$("<td><input type='checkbox' class='check_item' /></td>");
				var empIdTd =$("<td></td>").append(item.empId);
				var empNameTd =$("<td></td>").append(item.empName);
				var genderTd =$("<td></td>").append(item.gender);
				var emailTd =$("<td></td>").append(item.email);
				var deptNameTd =$("<td></td>").append(item.department.deptName);
				
				/*
					按照css样式构建button按钮
					<button class="btn btn-success btn-sm">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					新增
					</button>
					
					新添一个edit_btn标识 好找
					addClass返回前面的button元素
				*/
				var editBtn=$("<button></button>").addClass("btn btn-success btn-sm edit_btn")
				             .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义属性表示员工id   为啥不用$
				editBtn.attr("edit-id",item.empId);
				var deleBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
				deleBtn.attr("dele-id",item.empId);
				//合成一个单元格
				var btn=$("<td></td>").append(editBtn).append(" ").append(deleBtn);
				
				
				//append方法执行完成以后还是返回原来的元素：<tr> 即还是在tr里，链式编程
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btn)
				.appendTo("#table tbody");
			});
		};
		
		//解析显示左下角分页信息
		function build_page_info(result){
			//清空信息
			$("#page_info").empty();
			
			$("#page_info").append("当前第"+result.extend.pageInfo.pageNum+"页，总"+result.extend.pageInfo.pages+"页，总"+result.extend.pageInfo.total+"条记录");
			totalRecord=result.extend.pageInfo.total;
			currentPage=result.extend.pageInfo.pageNum;
		}
		
		//解析显示右下角分页条
		function build_page_nav(result){
			//清空信息
			$("#page_nav").empty();
			
			//  attr 为设置属性值
			var ul=$("<ul></ul>").addClass("pagination");
			var firstPage=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePage=$("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPage.addClass("disabled");
				prePage.addClass("disabled");
			}else{
				//给首页，上一页添加单机事件
				firstPage.click(function(){
					to_page(1);
				});
				
				prePage.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
					
			var nextPage=$("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPage=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			
			if(result.extend.pageInfo.hasNextPage==false){
				nextPage.addClass("disabled");
				lastPage.addClass("disabled");
			}else{
				nextPage.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				
				lastPage.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(firstPage).append(prePage);
			//遍历数组1 2 3 4 5
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				//判断高亮
				var pnLi=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(result.extend.pageInfo.pageNum==item){
					pnLi.addClass("active");
				}
				ul.append(pnLi);
				pnLi.click(function(){
					//调用方法
					to_page(item);
				});
			});
			
			ul.append(nextPage).append(lastPage);
			var nav=$("<nav></nav>").append(ul);
			//必须是appendTo 不然外面根本没nav怎么放到外面去
			nav.appendTo("#page_nav");
		};
		
		//清除表单数据和样式
		function reset_form(ele){
			//部门怎么清空不了？！！！！！ 莫非清除的都是value值？  一试， 果真
			$(ele)[0].reset();
			$(ele).find(".form-control").text("");
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text(""); 
		}
		
		
		
		//点击新增按钮，弹出模态框
		$("#open_empModal").click(function(){
			//清除表单数据  [0]表dom对象:jQuery对象转DOM对象的实质就是取出jQuery对象中封装的DOM对象。jquery没有reset方法
			reset_form("#empModal form");	
			//发送ajax请求，查出部门信息，显示下拉列表
			getDept("#inputDept");
			//弹出模态框  modal
			$("#empModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有部门并显示在列表中
		function getDept(ele){
			//也可以在这里清空数据
			//$(ele).empty();
			$.ajax({
				url:"${app_path}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(index,item){
						//千万注意这里value穿的是ID，因为InsertSelective选的就是dId,跟序列化乱码(URLcoding)没关系，还是能认出来
						var optionEl =$("<option></option>").append(item.deptName).attr("value",item.deptId);
						$(optionEl).appendTo(ele);
					});
				}
			});
		};
		
		//封装校验
		function show_validate(ele,status,msg){
			//清空之前的样式
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if(status=="success"){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if(status=="error"){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		};
		
		//表单添加数据校验
		function validate_add_form(){
			//拿到要校验的数据，使用正则表达式
			var empName=$("#input_empName").val();
			var regName= /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("姓名为2-5位中文或者6-16位英文和数字的组合，可以有下划线");
				show_validate("#input_empName","error","前端校验：姓名为2-5位中文或者6-16位英文和数字的组合，可以有下划线" );
				return false;
			}else{
				show_validate("#input_empName","success","");				
			}
			//检验邮箱信息
			validate_email("#input_empEmail");
			return true;
		}
		
		//封装邮箱验证信息
		function validate_email(ele){
			var email=$(ele).val();
			var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate(ele,"error","前端校验：邮箱格式填写错误");
				return false;
			}else{
				show_validate(ele,"success","");
			}
		}
		
		//发送ajax请求校验empName，避免重复添加,注意，有个bug,连续点击此设置变得无效！
		$("#input_empName").change(function(){
			var empName=this.value;
			$.ajax({
				url:"${app_path}/checkUser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==200){
						show_validate("#input_empName","success","前端校验：此名字可用");
						$("#saveEmp").attr("ajax-val","success");
					}else{
						show_validate("#input_empName","error",result.extend.va_msg);
						$("#saveEmp").attr("ajax-val","error");
					}
				}
			});
		});
		
		//data为传到服务器的数据，result为服务器传过来的数据
		$("#saveEmp").click(function(){
			//表单进行数据校验--前端JS校验(不可靠)
			 if(!validate_add_form()){
				return false;
			}; 
			//判断之前的ajax用户名校验是否成功(通过添加一个属性值看属性值是否是sucess，如果成功才往下走
			if($(this).attr("ajax-val")=="error"){return false;}
			
			$.ajax({
				url:"${app_path}/emp",
				type:"POST",
				data:$("#empModal form").serialize(),
				success:function(result){
					//对后台传过来的Msg进行判断  里面有错误字段信息
					
					if(result.code==200){
						//员工保存成功，关闭模态框，并来到最后一页
						//alert($("#empModal form").serialize());  将表格改为 name=value字符串形式放置URL中？  FirstName=Mickey&LastName=Mouse
						$("#empModal").modal("hide");
						to_page(totalRecord);
					}else{
						console.log(result);
						if(undefined != result.extend.errorFields.email){
							show_validate("#input_empEmail","error",result.extend.errorFields.email);
						}else if(undefined != result.extend.errorFields.empName){
							show_validate("#input_empName","error",result.extend.errorFields.empName);
						}
					}
				}
			}); 
		});
		
		//$(document)   整个文档 第二个参数为它的元素后代 -当到达这个元素事，事件总是触发
		$(document).on("click",".edit_btn",function(){
			//查出部门信息并显示部门列表  
			reset_form("#empUpdateModal form");	
			getDept("#updateDept");
			//查出员工信息显示员工信息 
			getEmp($(this).attr("edit-id"));
			//把员工id传给模态框的更新按钮，秒啊
			$("#updateEmp").attr("empId",$(this).attr("edit-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
			
		//查出员工信息
		function getEmp(id){
			$.ajax({
				url:"${app_path}/emp/"+id,
				type:"GET",
				success:function(result){
					var empDate =result.extend.emp;
					console.log(empDate);
					$("#updateEmpName").text(empDate.empName);
					$("#update_empEmail").val(empDate.email);
					$("#empUpdateModal input[name=gender]").val([empDate.gender]);
					$("#empUpdateModal select").val([empDate.dId]);
				}
			});
		}
		
		//点击更新，更新员工信息
		$("#updateEmp").click(function(){
			//验证邮箱
			validate_email("#update_empEmail");
			
			//法1：发送post请求，封装更新的员工数据  有hiddenhttp过滤器， put可以当post请求，但是要在请求数据后加上  &_method=PUT
			//法2：发送PUT请求，添加过滤器HttpPutFormContentFilter
			$.ajax({
				url:"${app_path}/emp/"+$(this).attr("empId"),
				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				success:function(result){
					//alert(result.msg); 
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});
		});
		
		//删除单个员工
		$(document).on("click",".delete_btn",function(){
			//弹出是否删除对话框
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("dele-id");
			if(confirm("确认删除["+empName+"]吗？")){
				//确认则为true,则发送ajax请求删除即可
				$.ajax({
					url:"${app_path}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//刷新到本页
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选全不选按钮
		$("#check_on").click(function(){
			//attr获取checked是undefined, 原生dom属性用prop获取或修改  attr用于获取自定义的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		$(document).on("click",".check_item",function(){
			//判断当前是否全选满
			var flag= $(".check_item:checked").length==$(".check_item").length;
			$("#check_on").prop("checked",flag);
		});
		
		//批量删除
		$("#delete_all_btn").click(function(){
			//遍历已经选中的值
			var empNames="";
			var empIds="";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				empIds += $(this).parents("tr").find("td:eq(1)").text()+"-" ;
			});
			//去除empNames中多余逗号  empIds中多余的-
			empNames = empNames.substring(0,empNames.length-1);
			empIds = empIds.substring(0,empIds.length-1);
			if(confirm("确认删除【"+empNames+"】吗?")){
				//发送ajax请求
				$.ajax({
					url:"${app_path}/emp/"+empIds, 
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//刷新到本页
						to_page(currentPage);
					}
				});
			}
			
		});
		
	</script>
</body>
</html>