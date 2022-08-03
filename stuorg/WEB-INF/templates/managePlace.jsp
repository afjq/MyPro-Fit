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
		var msg = "您确认要删除这个场地吗？\n\n请确认！";
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
		<a class="navbar-brand" href="#"> <img
			src="/static/gks.jpg" width="30" height="30"
			class="d-inline-block align-top" alt="">学生组织管理系统
		</a> <a class="nav-link" href="/org/toManageOrg">学生组织管理中心</a> <a
			class="nav-link" href="/file/toManageFile">文件管理中心</a> <a
			class="nav-link active" href="/place/toManagePlace">场地申请管理中心</a> <a
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
			<li class="breadcrumb-item active" aria-current="page">场地管理</li>
		</ol>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<!-- 左侧展示场地类型 -->
		  <div class="col-2">
		    <div class="list-group" id="list-tab" role="tablist">
		    	<!-- 每一种类型一个List -->
		    	<c:forEach items="${requestScope.ptypeList}" var="ptype">
		    	 	 <a class="list-group-item list-group-item-action" id="list-${ptype.ptypeId }-list" data-toggle="list" href="#list-${ptype.ptypeId }" role="tab" aria-controls="home">${ptype.ptypeName }</a>
		    	</c:forEach>
		    </div>
		  </div>
		  <!-- 中间展示 -->
		  <div class="col-7">
		    <div class="tab-content" id="nav-tabContent">
					<c:forEach items="${requestScope.ptypeList}" var="ptype">
						<!-- 每一种类型控制的div -->
						<div class="tab-pane fade show" id="list-${ptype.ptypeId }"
							role="tabpanel" aria-labelledby="list-${ptype.ptypeId }-list">
							<!-- 用表格 -->
							<table id="fileTable" class="table table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>场地</th>
										<th>容量</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ptype.ptypePlace}" var="place"
										varStatus="statu">
										<tr>
											<td>${statu.count}<input type="hidden" name="placeId"
												value="${place.placeId }"></td>

											<td>${place.placeName }&nbsp;&nbsp;&nbsp;<a href="/pused/toShowPused?placeId=${place.placeId }"><span class="badge badge-primary">${place.placeUsed }</span></a></td>
											<td>${place.placeCapacity }人</td>
											<td>
											<!-- 删除按钮 -->
												<a href="/place/delPlace?placeId=${place.placeId }"	onclick="javascript:return del();">
									<svg class="bi bi-trash" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z" clip-rule="evenodd"/>
</svg>									
												</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:forEach>
				</div>
		  </div>
		  <!-- 右侧 新增场地 -->
		   <div class="col-3">
		   	<form class="form-horizontal"
					action="/place/insertPlace"
					id="insertPlaceFrom">
					<div class="form-group">
							<label class="h2">添加场地</label> <br>
							<input class="form-control" type="text" name="placeName"  placeholder="新场地名" required />
							<input class="form-control" type="number" name="placeCapacity"  placeholder="容量" required />
							<!-- 下拉列表，选择场地类型 -->
							<select id="ptypeSelect" name="placeType" class="form-control">
								<option value="">请选择场地类型</option>
								<c:forEach items="${requestScope.ptypeList}" var="ptype">
									<option value="${ptype.ptypeId }">${ptype.ptypeName }</option>
								</c:forEach>
							</select>
						<button type="submit" class="btn btn-primary form-control">添加</button>
					</div>
				</form>
		   </div>
		</div>
	</div>
		<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>