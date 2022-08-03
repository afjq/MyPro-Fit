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
	
	/* 使用jquery-validation插件验证表单 */
	$(function() {

		$("#loginForm").validate({
			rules : {
				/* num 指的是控件的name属性 */
				num : {
					required : true,
					minlength : 9
				},
				pwd : {
					required : true,
					minlength : 6
				}
			},
			messages : {
				num : {
					required : "请输入学号",
					minlength : "学号长度不能小于 9个数字"
				},
				pwd : {
					required : "请输入密码！",
					minlength : "密码长度不能小于 6个字符"
				}
			},

			submitHandler : function(form) {
				form.submit();

			}
		});
	});
</script>
<style type="text/css">
body {
	margin-top: 100px;
	margin-bottom: 100px;
}
</style>
</head>
<!-- 背景图 -->
<body  background="/static/bg7.jpg"
style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;"
>


	<!-- 容器 -->
	<div class="container">
		<!-- 行 欢迎登录 -->
		<div class="row">
			<!-- 第一列 占用2列 -->
			<div class="col-5"></div>
			<!-- 第二列，放表格内容，占用10列 -->
			<div class="col-3">
				<label class="h2" style="color: white">欢迎登陆</label>
			</div>
			<!-- 第三列 占用2列 -->
			<div class="col"></div>
		</div>
		<br>
		<!-- 登录行 -->
		<div class="row">
			<div class="col">
					<form action="/allUser/login"method="post">
					<div class="form-group">
						<!-- 账号输入框 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-lg">
									<svg
							class="bi bi-people-circle" width="1em" height="1em"
							viewBox="0 0 16 16" fill="currentColor"
							xmlns="http://www.w3.org/2000/svg">
  <path
								d="M13.468 12.37C12.758 11.226 11.195 10 8 10s-4.757 1.225-5.468 2.37A6.987 6.987 0 0 0 8 15a6.987 6.987 0 0 0 5.468-2.63z" />
  <path fill-rule="evenodd" d="M8 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"
								clip-rule="evenodd" />
  <path fill-rule="evenodd"
								d="M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zM0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8z"
								clip-rule="evenodd" />
					</svg>
								</span>
							</div>
							<input id="num" name="num"  type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div><br>
						<!-- 密码输入框 -->
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<!-- 图标 -->
								<span class="input-group-text" id="inputGroup-sizing-lg">
									<svg
							class="bi bi-lock-fill" width="1em" height="1em"
							viewBox="0 0 16 16" fill="currentColor"
							xmlns="http://www.w3.org/2000/svg">
  <rect width="11" height="9" x="2.5" y="7" rx="2" />
  <path fill-rule="evenodd"
								d="M4.5 4a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"
								clip-rule="evenodd" />
</svg>
								</span>
							</div>
							<input name="psw"	type="password" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg" required>
						</div>

					</div>
					
						<!-- 单选按钮，选择以什么身份登录 -->
						<input type="radio" name="identity" value="user" checked="true" /><span style="color: white">用户</span> 
						<input type="radio" name="identity" value="admin" /><span style="color: white">管理员</span>
						 <a href="/user/toRegist">注册</a>
						<div class="checkbox">
							<label style="color: white"> <input type="checkbox">记住我
							</label> <span style="color: red">${mes}</span>
						</div>
					<button type="submit" class="btn btn-primary form-control">登陆</button>
					</form>
			</div>
		</div>

	</div>

		<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>