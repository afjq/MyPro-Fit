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
<script type="text/javascript">
	$(function(){
	/* 接收Controller.toUpdateDep的值 */
		var depId = '${dep.depId}';
		var depName = '${dep.depName}';
		var orgId = '${org.orgId}';
		/* 放在页面控件 */
		$("#inputDepName").val(depName);
		$("#DepId").val(depId);
		$("#OrgId").val(orgId);
		
		
			/* 使用jquery-validation,更新部门表单验证 */
		$("#insertDepFrom").validate({
	
		rules:{
			depName:{
				required:true
			}
		},
		messages:{
			depName:{
				remote:"请输入新部门名！"
			}
		},
		
		submitHandler: function(form){

			form.submit();
		
		}
	});
	});
</script>
</head>
<body>
<!-- 置顶的标签导航条 -->
	<nav class="navbar navbar-light bg-light">
		<a class="navbar-brand" href="#">  <img src="/static/gks.jpg"
			width="30" height="30" class="d-inline-block align-top" alt="">
			学生组织管理系统</a> 
			<a class="nav-link active" href="/org/toManageOrg">学生组织管理中心</a> <a
			class="nav-link" href="/file/toManageFile">文件管理中心</a> <a
			class="nav-link" href="/place/toManagePlace">场地申请管理中心</a> <a
			class="nav-link" href="/notice/toManageNotice">公告通知管理中心</a>
			<a class="nav-link" href="/active/toManageActive">工作圈</a>
		<ul class="nav justify-content-end">
				<li class="nav-item">&nbsp;&nbsp;&nbsp;
			<svg class="bi bi-people-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M13.468 12.37C12.758 11.226 11.195 10 8 10s-4.757 1.225-5.468 2.37A6.987 6.987 0 0 0 8 15a6.987 6.987 0 0 0 5.468-2.63z"/>
  <path fill-rule="evenodd" d="M8 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" clip-rule="evenodd"/>
  <path fill-rule="evenodd" d="M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zM0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8z" clip-rule="evenodd"/>
</svg>
			<span huanclass="nav-link active" style="color: red">${sessionScope.admin.adminName}</span>，<a href="/allUser/logOut">退出登录</a>
			</li>
		</ul>
	</nav>

	<!-- 面包屑路径导航 -->
	<nav aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item"><a href="/admin/toAdminPage">我的主页</a></li>
	    <li class="breadcrumb-item"> <a href="/org/toManageOrg">组织管理</a></li>
	    <li class="breadcrumb-item active"><a href="/dep/toManageDep?orgId=${requestScope.org.orgId}">部门管理</a></li>
	    <li class="breadcrumb-item active">修改<span>${org.orgName }${dep.depName}</span></li>
	  </ol>
	</nav>	
	
	<div class="container-fluid">
		<div class="row">
		
			
			<!-- 第一列 占用2列 -->
			<div class="col"></div>
			<!-- 第二列，放表格内容，占用10列 -->
			<div class="col">
				<form  action="/dep/updateDep">
					<div class="form-group">
					<label class="control-label">修改部门名</label>
					<input class="form-control" type="text" id="inputDepName" name="depName" required>
				 <input type="hidden" id="OrgId" name="orgId" value="${org.orgId }">
					<input type="hidden" id="DepId" name="depId" value="${dep.depId }"> 
					<button type="submit" class="btn btn-warning form-control">保存</button>
						</div>
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