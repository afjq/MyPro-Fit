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
			学生组织管理系统</a> 
			<a class="nav-link" href="/org/toManageOrg">学生组织管理中心</a> <a
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

	<!-- 轮播 -->
	<div id="carousel" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carousel" data-slide-to="0" class="active"></li>
			<li data-target="#carousel" data-slide-to="1"></li>
			<li data-target="#carousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="/static/img/carousel/01.jpg" class="d-block w-100"
					alt="...">
			</div>
			<div class="carousel-item">
				<img src="/static/img/carousel/02.jpg" class="d-block w-100"
					alt="...">
			</div>
			<div class="carousel-item">
				<img src="/static/img/carousel/03.jpg" class="d-block w-100"
					alt="...">
			</div>
		</div>
		<a class="carousel-control-prev" href="#ccarousel" role="button"
			data-slide="prev"> <span class="carousel-control-prev-icon"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carousel" role="button"
			data-slide="next"> <span class="carousel-control-next-icon"
			aria-hidden="true"></span> <span class="sr-only">Next</span>
		</a>
		<!-- 轮播-end -->
<br>
		<div class="container-fluid">
			<div class="row">
				<div class="col">
					<div class="card text-right" style="width: 20rem;">
						<img src="/static/img/allUserPage/c1.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">数计学院欢迎你——亲爱的新同学们!</h5>
							<p class="card-text">今天，你是数计学院莘莘学子中卷起千堆雪中的一朵浪花;明天，你是数计学院熠熠生辉的丰碑上最耀眼的一个名字!同学们，扬起你理想的风帆，让我们一起努力打造数计学院明天的辉煌! 
数计学院欢迎你——亲爱的新同学们!
数计学院院长 吴建生
2019年8月29日
</p>
	<a href="http://sjy.gxstnu.edu.cn/info/1013/2801.htm" class="btn btn-primary">
								详情 &nbsp; <svg class="bi bi-info-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" clip-rule="evenodd"/>
  <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
  <circle cx="8" cy="4.5" r="1"/>
</svg>
								</a>
						</div>
					</div>
				</div>
					<div class="col">
						<div class="card text-right" style="width: 20rem;">
							<img src="/static/img/allUserPage/c2.png" class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">抗战疫情，你我共勉—计科大数据191班主题班会</h5>
								<p class="card-text">辅导员韦洪锦老师对同学们给予了鼓励，希望同学们能够在这场疫情中做好自我的同时发挥模范作用。

最后班主任王文明老师对此次班会进行了小结，一一回答了同学们提出的问题，同时强调，要求每一位同学要务必遵守学校规定，不违反疫情防控纪律要求；遵守网络学习制度，做好居家学习；要认真配合辅导员和班干部完成每日学生健康数据上报工作，做到准时如实；要做好规律起居，合理安排作息时间，加强自我防护意识。

科学防疫，坚定信心，就是抗击疫情最好的疫苗。春风送暖，万物更新，希望疫情散去，祖国无恙，你我无恙，人间充满爱和希望！</p>
								<a href="http://sjy.gxstnu.edu.cn/info/1013/3032.htm" class="btn btn-primary">
								详情 &nbsp; <svg class="bi bi-info-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" clip-rule="evenodd"/>
  <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
  <circle cx="8" cy="4.5" r="1"/>
</svg>
								</a>
							</div>
						</div>
					</div>
						<div class="col">
							<div class="card text-right" style="width: 20rem;">
								<img src="/static/img/allUserPage/c3.png" class="card-img-top" alt="...">
								<div class="card-body">
									<h5 class="card-title">我院学生第一党支部举行线上支部大会暨主题党课</h5>
									<p class="card-text">3月31日，我院学生第一党支部通过钉钉的视频会议召开支部大会暨主题党课，支部全体党员参加，会议由支部书记韦洪锦主持。

会上，全体党员认真学习了赵富恒同志先进事迹，并积极发表自己的学习感言。接着，支部书记韦洪锦同志对2020年春季学期支部工作计划进行了说明 ，党员们就支部计划展开讨论。</p>
								<a href="http://sjy.gxstnu.edu.cn/info/1013/3034.htm" class="btn btn-primary">
								详情 &nbsp; <svg class="bi bi-info-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" clip-rule="evenodd"/>
  <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
  <circle cx="8" cy="4.5" r="1"/>
</svg>
								</a>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="card text-right" style="width: 20rem;">
								<img src="/static/img/allUserPage/c4.jpg" class="card-img-top" alt="...">
								<div class="card-body">
									<h5 class="card-title">新学期学院领导深入宿舍看望慰问我院返校教师和留学生</h5>
									<p class="card-text">3月10日，学院党委书记权武生、院长吴建生在学院办公室负责人及对外交流合作处有关人员的陪同下，到来宾校区宿舍看望慰问了我院返校教师和留学生，并送去了口罩、生活用品等物资。</p>
									<a href="http://sjy.gxstnu.edu.cn/info/1013/3023.htm" class="btn btn-primary">
								详情 &nbsp; <svg class="bi bi-info-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" clip-rule="evenodd"/>
  <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
  <circle cx="8" cy="4.5" r="1"/>
</svg>
								</a>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="card text-right" style="width: 20rem;">
								<img src="/static/img/allUserPage/c5.png" class="card-img-top" alt="...">
								<div class="card-body">
									<h5 class="card-title">台湾德明财经科技大学到我院开展交流访问</h5>
									<p class="card-text">1月8日上午，台湾德明财经科技大学财政税务系主任倪仁禧（博士）、国际交流事务主任文郁、乔中珏博士、蔡智孝博士一行四人到我院交流访问，双方在理科楼L502会议室举行座谈会。学校人事处莫付欢副处长，学院院长吴建生、党委副书记王文明、副院长李洁坤、阮慎参加座谈会。</p>
									<a href="http://sjy.gxstnu.edu.cn/info/1013/3003.htm" class="btn btn-primary">
								详情 &nbsp; <svg class="bi bi-info-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" clip-rule="evenodd"/>
  <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
  <circle cx="8" cy="4.5" r="1"/>
</svg>
								</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br>
			<br>
				<!-- 底部导航栏 -->
	<nav class="navbar fixed-bottom navbar-light bg-light">
		<a class="navbar-brand" href="#">广西科技师范学院2020届本科毕业设计 &nbsp;/ &nbsp;基于Web的学生组织管理系统 &nbsp;/ &nbsp;李峥滢 &nbsp;/ &nbsp;计算机科学与技术（软件开发方向）162班 &nbsp;/ &nbsp;163012222</a>
	</nav>
</body>