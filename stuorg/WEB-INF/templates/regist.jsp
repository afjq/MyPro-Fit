<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<title>学生组织管理系统</title>
<!-- JQuery -->
<script type="text/javascript"
	src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<!-- BootStrap的CSS -->
<link rel="stylesheet" type="text/css"
	href="/webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
<!-- Bootstrap的JS -->
<script src="/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- JQuery-Validate -->
<script
	src="/webjars/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<!-- JQuery-Validate 中文信息提示包  -->
<script
	src="/webjars/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
<script type="text/javascript">
	/* 验证 */
	$(function() {

		/* 验证两次密码输入是否一致 */
		$("#psw2").blur(function() {
			if ($("#psw").val() != $("#psw2").val()) {
				$("#mes").html("<font color='red'>两次密码输入不一致</font>");/* 提示 */
				$("#psw2").val("");/* 清空  */
			} else {
				$("#mes").html("");/* 提示 */
			}

		});

		/* 一级联动，选择组织显示部门 */
		$("#orgSelect")
				.change(
						function() {
							var orgId = $("#orgSelect").val();
							/*  alert("被选中的组织Id是：" + orgId); */
							/* 组织下拉列表响应change事件后，获取被选中的value值，即组织Id, */
							/* 清空部门下拉列表的值 */
							$("#depSelect").empty();
							$
									.ajax({
										url : "${pageContext.request.contextPath}/dep/findAllDepByOrgId",
										type : "POST",
										dataType : "json",
										data : {
											"orgId" : orgId,
											cache : false
										},
										success : function(data) {
											/* alert("success，从controller取到的是:" + data); */
											for (var i = 0; i < data.length; i++) {
												/* 遍历部门集合 ，这里的data=depList*/
												/* alert("部门Id"+data[i].depId+"部门名："+data[i].depName);  */
												$("#depSelect")
														.append(
																"<option value='" + data[i].depId + "'>"
																		+ data[i].depName
																		+ "</option>");
											}
										},
										error : function(data) {
											alert("error:" + data)
										}
									});
						});
	});
</script>
</head>
<!-- 背景图 -->
<!-- <body 
style="background-color:#6EB3DA; background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;"
> -->
<!-- 背景图 -->
<body  background="/static/bg7.jpg"
style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;"
>
<br>
<br>
	<h2 align="center" style="color: white">欢迎注册</h2>
	<div class="container-fluid">
		<div class="row">
			<!-- 第一列 占用2列 -->
			<div class="col"></div>
			<!-- 第二列，放表格内容，占用10列 -->
			<div class="col">
				<form action="/user/regist">
					<div class="form-group">
						<!-- 学号 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">学号</span>
							</div>
							<input id="num" name="num"  type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><br>
						<!-- 姓名 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">姓名</span>
							</div>
							<input id="name" name="name" type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><br>
						<!-- 密码 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">密码</span>
							</div>
							<input id="psw" name="psw" type="password" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><br>
						<!-- 密码 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">确认密码</span>
							</div>
							<input id="psw2" name="psw2" type="password" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><span
						id="mes"></span><br>
						<!-- 电话 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">电话</span>
							</div>
							<input  id="phone" name="phone" type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><br> 
						<!-- QQ -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">QQ</span>
							</div>
							<input id="QQ" name="QQ"  type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><br> 
						
						<select id="classSelect" name="clas"
							class="form-control">
							<option value="">请选择班级</option>
							<c:forEach items="${requestScope.clasList}" var="clas">
								<option value="${clas.classId }">${clas.className }</option>
							</c:forEach>
						</select> <br>
						
						<select id="orgSelect" name="org" class="form-control">
							<option value="">请选择组织</option>
							<c:forEach items="${requestScope.orgList}" var="org">
								<option value="${org.orgId }">${org.orgName }</option>
							</c:forEach>
						</select> <br>
						
						<select id="depSelect" name="dep" class="form-control">
							<option value="">请选择部门</option>
						</select><br>
					<button type="submit" class="btn btn-primary form-control">注册</button>
					</div>
					
					<!-- 学号：<input id="num" name="num" type="text" class="form-control"
						required /> 
					姓名：<input id="name" name="name" type="text"
						class="form-control" required />
					密码：<input id="psw" name="psw"
						type="password" class="form-control" required /> 
					请再次输入密码确认：<span
						id="mes"></span><input id="psw2" name="psw2" type="password"
						class="form-control" required />
					 电话：<input id="phone"
						name="phone" type="text" class="form-control" required />
					QQ:<input
						id="QQ" name="QQ" type="text" class="form-control" />  -->
				</form>
			</div>
			<!-- 第三列 占用2列 -->
			<div class="col"></div>
		</div>
	</div>
		<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>