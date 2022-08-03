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
</head>
<body>
	<!-- 置顶的标签导航条 -->
	<nav class="navbar navbar-light bg-light">
		<a class="navbar-brand" href="#"> <img src="/static/gks.jpg"
			width="30" height="30" class="d-inline-block align-top" alt="">
			学生组织系统
		</a> <a class="nav-link" href="/org/toManageOrg">学生组织中心</a> <a
			class="nav-link" href="/file/toManageFile">文件中心</a> <a
			class="nav-link" href="/place/toManagePlace">场地申请中心</a> <a
			class="nav-link" href="/notice/toManageNotice">公告通知中心</a>
		<ul class="nav justify-content-end">
			<li class="nav-item">&nbsp;&nbsp;&nbsp;
			<svg class="bi bi-people-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M13.468 12.37C12.758 11.226 11.195 10 8 10s-4.757 1.225-5.468 2.37A6.987 6.987 0 0 0 8 15a6.987 6.987 0 0 0 5.468-2.63z"/>
  <path fill-rule="evenodd" d="M8 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" clip-rule="evenodd"/>
  <path fill-rule="evenodd" d="M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zM0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8z" clip-rule="evenodd"/>
</svg>
			<span huanclass="nav-link active" style="color: red">${sessionScope.user.userName}</span>，<a
				href="/allUser/logOut">退出登录</a>
			</li>
		</ul>
	</nav>

	<!-- 面包屑路径导航 -->
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item active" aria-current="page">组织</li>
		</ol>
	</nav>
	
	<!-- 展示部分 -->
	<div class="container-fluid">
		<div class="row">
		<div class="col"></div>
			<!-- 左侧 查看 -->
			<div class="col-6">
				<table id="orgTable" class="table table-hover ">
					<thea>
					<tr>
						<th>序号</th>
						<th>组织</th>
						<th>下一级</th>
					</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestScope.orgList}" var="org"
							varStatus="statu">
							<tr>
								<td>${statu.count}<input type="hidden" name="orgId"
									value="${org.orgId }"></td>
								<td>${org.orgName }</td>
								<td>
									<!-- 部门按钮 --> <a href="/dep/toManageDep?orgId=${org.orgId}">
										<svg class="bi bi-collection" width="1em" height="1em"
											viewBox="0 0 16 16" fill="currentColor"
											xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd"
												d="M14.5 13.5h-13A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5zm-13 1A1.5 1.5 0 0 1 0 13V6a1.5 1.5 0 0 1 1.5-1.5h13A1.5 1.5 0 0 1 16 6v7a1.5 1.5 0 0 1-1.5 1.5h-13zM2 3a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 0-1h-11A.5.5 0 0 0 2 3zm2-2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 0-1h-7A.5.5 0 0 0 4 1z"
												clip-rule="evenodd" />
</svg>
								</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col"></div>
		</div>


		<!-- 分页功能行 -->
		<div class="row">
			<div class="col-5"></div>
			<div class="col">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<li class="page-item"><a class="page-link"
							href="/org/toManageOrg?page=${pageInfo.navigateFirstPage}">首页</a></li>
						<li class="page-item"><c:if
								test="${pageInfo.hasPreviousPage }">
								<a class="page-link"
									href="/org/toManageOrg?page=${pageInfo.prePage}">上一页</a>
							</c:if></li>
						<li class="page-item"><c:if test="${pageInfo.hasNextPage }">
								<a class="page-link"
									href="/org/toManageOrg?page=${pageInfo.nextPage}">下一页</a>
							</c:if></li>
						<li class="page-item"><a class="page-link"
							href="/org/toManageOrg?page=${pageInfo.navigateLastPage}">最后一页</a>
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