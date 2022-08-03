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
</head>
<script>
/* 删除前弹窗 */
function del() {
	var msg = "您确定要删除此通知吗？\n\n请确认！";
	if (confirm(msg) == true) {
		return true;
	} else {
		return false;
	}
}
</script>
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
			<li class="breadcrumb-item active" aria-current="page">公告通知</li>
		</ol>
	</nav>
	
	<div class="container-fluid">
		<div class="row">
		<div class="col"></div>
			<!-- 左侧查看模块 -->
			<div class="col-10">
				<!-- 折叠卡片 -->	
				<div class="accordion" id="showNotice">
					<!-- 卡片1,2，。。。。 -->
					<c:forEach items="${requestScope.noticeList}" var="notice" varStatus="statu" >
						<div class="card">
							<!-- 卡片标题 -->
							<div class="card-header" id="headingOne">
								<h2 class="mb-0">
									<button class="btn btn-link btn-block text-left" type="button"
										data-toggle="collapse" data-target="#collapse${statu.count}"
										aria-expanded="true" aria-controls="collapse${statu.count}">
										${notice.noticeTitle }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${notice.noticePerson.adminOrg.orgName }
									${notice.noticeDep.depName}
									${notice.noticePerson.adminName }
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<fmt:formatDate value="${notice.noticeTime }"
										pattern="yyyy/MM/dd HH:mm:ss" /></button>
								</h2>
							</div>
							<!-- 通过data-target="#collapse${statu.count}" 和  aria-controls="collapse${statu.count}" 来控制：-->
							<!-- 卡片内容  id="collapse${statu.count}" -->
							<div id="collapse${statu.count}" class="collapse"
								aria-labelledby="headingOne" data-parent="#showNotice">
								<div class="card-body">
									${notice.noticeContent }
									<br>
									<!-- 显示此通知所附带的所有文件 -->
									<c:forEach items="${notice.noticeFile }" var="files">
										<a href="/file/downloadFile?fileId=${files.fileId }">${files.fileName }</a><br>
									</c:forEach>	
								</div>
									
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>
		<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>