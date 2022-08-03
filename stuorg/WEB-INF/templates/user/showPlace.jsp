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
function insertPused() {
	$.ajax({
		url : "${pageContext.request.contextPath}/pused/applyPlace",
		type : "POST",
		dataType : "json",
		data : {
			"placeId" : placeId,
			"pusedFor" : pusedFor,
			"pusedStartTime" : pusedStartTime,
			"pusedEndTime" : pusedEndTime,
			cache : false
		},
		success : function(data) {
			alert("success:"+data);
		},
		error : function(data) {
			alert("error:" + data);
		}
	});
}
$(function(){
	/* 一级联动，选择组织显示部门 */
	$("#ptypeSelect")
			.change(
					function() {
						var ptypeId = $("#ptypeSelect").val();
						/*  alert("被选中的组织Id是：" + orgId); */
						/* 组织下拉列表响应change事件后，获取被选中的value值，即组织Id, */
						/* 清空部门下拉列表的值 */
						$("#placeSelect").empty();
						$.ajax({
									url : "${pageContext.request.contextPath}/place/findAllPlaceByPtypeId",
									type : "POST",
									dataType : "json",
									data : {
										"ptypeId" : ptypeId,
										cache : false
									},
									success : function(data) {
										/* alert("success，从controller取到的是:" + data); */
										for (var i = 0; i < data.length; i++) {
											/* 遍历部门集合 ，这里的data=depList*/
											/* alert("部门Id"+data[i].depId+"部门名："+data[i].depName);  */
											$("#placeSelect")
													.append(
															"<option value='" + data[i].placeId + "'>"
																	+ data[i].placeName
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
			<li class="breadcrumb-item active" aria-current="page">场地</li>
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
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:forEach>
				</div>
		  </div>
		  <!-- 右侧 申请场地 -->
		   <div class="col-3">
		   	<form class="form-horizontal"
					action="/pused/applyPlace"
					id="insertPusedFrom"  method="post">
					<div class="form-group">
							<label class="h2">申请使用</label> <br>
							<!-- 下拉列表，选择场地类型 -->
							<select id="ptypeSelect" name="placeTypeId" class="form-control">
								<option value="">请选择场地类型</option>
								<c:forEach items="${requestScope.ptypeList}" var="ptype">
									<option value="${ptype.ptypeId }">${ptype.ptypeName }</option>
								</c:forEach>
							</select>
							<!-- 下拉列表，选择场地 -->
							<select id="placeSelect" name="placeId" class="form-control">
							</select>
							<!-- 内容框 -->
						<textarea class="form-control"  name="pusedFor" rows="10" cols="30" placeholder="用途" required></textarea>
						<label>使用起止时间：</label> <br>
						<input name="pusedStartTime" type="text" value="2020-05-12 10:04:00"/>
						<input name="pusedEndTime"type="text" value="2020-05-12 10:04:00"/>
						<span style="color: red">${requestScope.msg}</span>
						<button id="insertPusedFrom" type="submit" class="btn btn-primary form-control" onclick="javascript:return insertPused();">提交申请</button>
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