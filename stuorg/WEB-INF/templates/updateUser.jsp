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
	$(function() {
		 /* 一级联动，选择组织显示部门 */
		$("#orgSelect").change(function(){
			var orgId = $("#orgSelect").val();
			 alert("被选中的组织Id是：" + orgId);
			/* 组织下拉列表响应change事件后，获取被选中的value值，即组织Id, */
			/* 清空部门下拉列表的值 */
			$("#depSelect").empty(); 
			$.ajax({
				url : "/dep/findAllDepByOrgId",
				type : "POST",
				dataType : "json",
				data : {
					"orgId" : orgId,cache:false
				},
				success : function(data){
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
			<li class="breadcrumb-item"><a href="/org/toManageOrg">组织管理</a></li>
			<li class="breadcrumb-item"><a href="/dep/toManageDep?orgId=${org.orgId }">${org.orgName}部门管理</a></li>
			<li class="breadcrumb-item"><a href="/user/toManageUser?orgId=${org.orgId }&depId=${dep.depId}">${org.orgName}${dep.depName}成员管理</a></li>
			<li class="breadcrumb-item active">修改<span>${org.orgName }${dep.depName}${user.userName}信息</span>
			</li>
		</ol>
	</nav>
	<div class="container">

		<div class="row">
			<!-- 第一列 占用2列 -->
			<div class="col"></div>
			<!-- 第二列，放表格内容，占用10列 -->
			<div class="col-9">
				<form class="form-horizontal" action="/user/updateUser">
					<input type="hidden" name="userId" value="${user.userId }">
					<div class="form-group">
						<label class="col-sm-3 control-label"> 姓名：</label>
						<div class="col-sm-9">
							<input class="form-control" type="text" name="userName"
								value="${user.userName }" required>
						</div>
						
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label"> 学号：</label>
						<div class="col-sm-9">
							<input class="form-control" type="text" name="userNum"
								value="${user.userNum }" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">密码：</label>
						<div class="col-sm-9">
							<input class="form-control" type="text" name="userPsw"
								value="${user.userPsw }" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">电话：</label>
						<div class="col-sm-9">
							<input class="form-control" type="text" name="userPhone"
								value="${user.userPhone }" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">QQ：</label>
						<div class="col-sm-9">
							<input class="form-control" type="text" name="userQQ"
								value="${user.userQq }" required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">班级：</label>
						<div class="col-sm-9">
							<select class="form-control" id="classSelect" name="userClass">
								<option value="${user.userClass.classId }">${user.userClass.className }</option>
								<c:forEach items="${clasList }" var="clas">
									<option value="${clas.classId }">${clas.className }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<!-- 更改组织部门的时候使用下拉列表 -->
					<!-- 1.foreach语句显示所有组织，2.jquery设置被选中的值 -->
					<div class="form-group">
						<label class="col-sm-3 control-label">组织：</label>
						<div class="col-sm-9">
							<select class="form-control" id="orgSelect" name="userOrg">
								<option value="${user.userOrg.orgId }">${user.userOrg.orgName }</option>
								<c:forEach items="${orgList }" var="org">
									<option value="${org.orgId }">${org.orgName }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">部门：</label>
						<div class="col-sm-9">
							<select class="form-control" id="depSelect" name="userDep">
								<option value="${user.userDep.depId }">${user.userDep.depName }</option>
								<c:forEach items="${depList }" var="dep">
									<option value="${dep.depId }">${dep.depName }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<!-- 存放更改后的组织Id，部门Id -->
					<!-- <input type="hidden" name="orgId" id="userOrg"> <input
						type="hidden" name="depId" id="userDep"> -->
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-warning form-control">保存</button>
					</div>
				</form>
            
            </div>
            <!-- 第三列 占用2列 -->
            <div class="col"></div>
		</div>
	</div>
</body>