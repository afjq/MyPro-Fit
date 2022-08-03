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
<script>
	/* 删除前弹窗 */
	function del() {
		var msg = "确认删除以后，此部门下的所有成员等数据将同时被删除！\n\n请确认！";
		if (confirm(msg) == true) {
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body>
<!-- 置顶的标签导航条 -->
	<nav class="navbar navbar-light bg-light">
		<a class="navbar-brand" href="#"> <img src="/static/gks.jpg"
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
			<li class="breadcrumb-item active"><span>${requestScope.org.orgName }</span>部门管理</li>
		</ol>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<!-- 左侧 展示部门-->
			<div class="col-9">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>序号</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestScope.depList}" var="dep"
							varStatus="statu">
							<tr>
								<td>${statu.count}<input type="hidden" name="depId"
									value="${dep.depId}"></td>
								<td>${dep.depName }</td>
								<td>
								<!-- 删除按钮 -->
									<a href="/dep/delDep?depId=${dep.depId}&orgId=${org.orgId}"
									onclick="javascript:return del();">
									<svg class="bi bi-trash" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z" clip-rule="evenodd"/>
</svg>
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<!-- 更改按钮 -->
									 <a href="/dep/toUpdateDep?depId=${dep.depId}&orgId=${org.orgId}">
									<svg class="bi bi-pencil" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 0 1 1.414 0l2 2a1 1 0 0 1 0 1.414l-9 9a1 1 0 0 1-.39.242l-3 1a1 1 0 0 1-1.266-1.265l1-3a1 1 0 0 1 .242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd"/>
  <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 0 0 .5.5H4v.5a.5.5 0 0 0 .5.5H5v.5a.5.5 0 0 0 .5.5H6v-1.5a.5.5 0 0 0-.5-.5H5v-.5a.5.5 0 0 0-.5-.5H3z" clip-rule="evenodd"/>
</svg>
									</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									
									<!-- 管理用户按钮 -->
									<a href="/user/toManageUser?depId=${dep.depId}&orgId=${org.orgId}">
									<svg class="bi bi-collection" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M14.5 13.5h-13A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5zm-13 1A1.5 1.5 0 0 1 0 13V6a1.5 1.5 0 0 1 1.5-1.5h13A1.5 1.5 0 0 1 16 6v7a1.5 1.5 0 0 1-1.5 1.5h-13zM2 3a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 0-1h-11A.5.5 0 0 0 2 3zm2-2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 0-1h-7A.5.5 0 0 0 4 1z" clip-rule="evenodd"/>
</svg>
									</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!--右侧 新增部门 -->
			<div class="col-3">
				<form class="form-horizontal"
					action="/dep/insertDep" id="insertDepFrom">
					<div class="form-group">
					<label for="uploadFile" class="h2">新增部门</label> <br>
						 <input
							class="form-control" type="text" name="depName" placeholder="新部门名"  required>
						<input type="hidden" id="OrgId" name="orgId" value="${requestScope.org.orgId }">
						<button type="submit" class="btn btn-primary form-control">新增</button>
					</div>
					</form>
			</div>
		</div>
		<!-- 分页功能行 -->
		<div class="row">
			<div class="col"></div>
			<div class="col">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<li class="page-item"><a class="page-link" href="/dep/toManageDep?orgId=${requestScope.org.orgId }&page=${pageInfo.navigateFirstPage}">首页</a></li>
						<li class="page-item">
							<c:if test="${pageInfo.hasPreviousPage }">
								<a class="page-link" href="/dep/toManageDep?orgId=${requestScope.org.orgId }&page=${pageInfo.prePage}">上一页</a>
							</c:if>
						</li>
						<li class="page-item">
							<c:if test="${pageInfo.hasNextPage }">
								<a class="page-link" href="/dep/toManageDep?orgId=${requestScope.org.orgId }&page=${pageInfo.nextPage}">下一页</a>
							</c:if>
						</li>
						<li class="page-item"><a class="page-link" href="/dep/toManageDep?orgId=${requestScope.org.orgId }&page=${pageInfo.navigateLastPage}">最后一页</a>
						</li>
					</ul>
				</nav>
		</div>
		<div class="col"></div>
	</div>
	</div>
		<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>