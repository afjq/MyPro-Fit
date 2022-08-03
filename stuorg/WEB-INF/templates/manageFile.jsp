<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	var msg = "您确定要删除此文件吗？\n\n请确认！";
	if (confirm(msg) == true) {
		return true;
	} else {
		return false;
	}
}

$(function(){
	/* 一级联动，选择组织显示部门 */
	$("#orgSelect")
			.change(
					function() {
						var orgId = $("#orgSelect").val();
						/*  alert("被选中的组织Id是：" + orgId); */
						/* 组织下拉列表响应change事件后，获取被选中的value值，即组织Id, */
						/* 清空部门下拉列表的值 */
						$("#depSelect").empty();
						$.ajax({
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
<body>
<!-- 置顶的标签导航条 -->
	<nav class="navbar navbar-light bg-light">
		<a class="navbar-brand" href="#"> <img
			src="/static/gks.jpg" width="30" height="30"
			class="d-inline-block align-top" alt=""> 学生组织管理系统
		</a> <a class="nav-link" href="/org/toManageOrg">学生组织管理中心</a> <a
			class="nav-link active" href="/file/toManageFile">文件管理中心</a> <a
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
			<li class="breadcrumb-item active" aria-current="page">文件管理</li>
		</ol>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<!-- 左侧文件查看模块 -->
			<div class="col-9">
				<table id="fileTable" class="table table-hover">
					<thead>
						<tr>
							<th>序号</th>
							<th>文件名</th>
							<th>组织</th>
							<th>部门</th>
							<th>上传者</th>
							<th>上传日期</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestScope.fileList}" var="file"
							varStatus="statu">
							<tr>
								<td>${statu.count}<input type="hidden" name="fileId"
									value="${file.fileId }"></td>

								<td>${file.fileName }</td>
								<td>${file.fileUploader.adminOrg.orgName}</td>
								<td>${file.fileDep.depName }</td>
								<td>${file.fileUploader.adminName}</td>
									<!-- 日期，格式 -->
								<td><fmt:formatDate value="${file.fileDate }"
										pattern="yyyy/MM/dd HH:mm:ss" /></td>
								<td>
									<!-- 删除按钮 -->
									<a href="/file/delFile?fileId=${file.fileId }"
									onclick="javascript:return del();">
									<svg class="bi bi-trash" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z" clip-rule="evenodd"/>
</svg>									
									</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<!-- 下载按钮 -->
									<a href="/file/downloadFile?fileId=${file.fileId }">
									<svg class="bi bi-box-arrow-in-down" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M4.646 8.146a.5.5 0 0 1 .708 0L8 10.793l2.646-2.647a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 0-.708z" clip-rule="evenodd"/>
  <path fill-rule="evenodd" d="M8 1a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0v-9A.5.5 0 0 1 8 1z" clip-rule="evenodd"/>
  <path fill-rule="evenodd" d="M1.5 13.5A1.5 1.5 0 0 0 3 15h10a1.5 1.5 0 0 0 1.5-1.5v-8A1.5 1.5 0 0 0 13 4h-1.5a.5.5 0 0 0 0 1H13a.5.5 0 0 1 .5.5v8a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5v-8A.5.5 0 0 1 3 5h1.5a.5.5 0 0 0 0-1H3a1.5 1.5 0 0 0-1.5 1.5v8z" clip-rule="evenodd"/>
</svg>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<!-- 右侧文件上传模块 -->
			<div class="col-3">
			<!-- 做文件上传的表单务必带上enctype="multipart/form-data" -->
				<form id="uploadFileForm" action="/file/uploadFile" enctype="multipart/form-data" method="post">
					<div class="form-group">
						<label for="uploadFile" class="h2">文件上传</label> 
						<input type="file" class="form-control-file" name="upFiles" required> 
						<!-- 下拉列表，选择组织部门 -->
						<select id="orgSelect" name="orgId" class="form-control">
							<option value="">请选择组织</option>
							<c:forEach items="${requestScope.orgList}" var="org">
								<option value="${org.orgId }">${org.orgName }</option>
							</c:forEach>
						</select>
						<select id="depSelect" name="depId" class="form-control">
							<option value="">请选择部门</option>
						</select>
						<button type="submit" class="btn btn-primary form-control">上传</button>
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
						<li class="page-item"><a class="page-link" href="/file/toManageFile?page=${pageInfo.navigateFirstPage}">首页</a></li>
						<li class="page-item">
							<c:if test="${pageInfo.hasPreviousPage }">
								<a class="page-link" href="/file/toManageFile?page=${pageInfo.prePage}">上一页</a>
							</c:if>
						</li>
						<li class="page-item">
							<c:if test="${pageInfo.hasNextPage }">
								<a class="page-link" href="/file/toManageFile?page=${pageInfo.nextPage}">下一页</a>
							</c:if>
						</li>
						<li class="page-item"><a class="page-link" href="/file/toManageFile?page=${pageInfo.navigateLastPage}">最后一页</a>
						</li>
					</ul>
				</nav>
		</div>
			<div class="col"></div>
	</div>
		<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>