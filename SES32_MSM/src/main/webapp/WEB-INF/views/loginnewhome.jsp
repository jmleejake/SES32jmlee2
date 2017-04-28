<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Manage a Schedule and Money</title>
<!-- icon CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<!-- W3School CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- Bootstrap Core CSS -->
<link href="./resources/template/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="./resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="./resources/template/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-fixed-top topnav"
		role="navigation">
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

				<a class="navbar-brand topnav" href="#home">MSM</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#home">Home</a></li>
					<li><a href="#about">About</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>


	<!-- Header -->
	<a name="home"></a>
	<div class="intro-header">
		<div class="container">

			<div class="row">
				<div class="col-lg-12">
					<div class="intro-message">
						<h1>Manage a Schedule and Money</h1>
						<br>
						<ul class="list-inline intro-social-buttons">
							<c:if test="${loginID==null}">
								<li><a href="user/loginPage" class="btn btn-default btn-lg">
										<span>Start Management</span>
								</a></li>
							</c:if>

							<c:if test="${loginID!=null}">
								<li><a href="user/userLoginAgain"
									class="btn btn-default btn-lg"> <span>Start
											Management Again</span></a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>

		</div>
		<!-- /.container -->

	</div>
	<!-- /.intro-header -->

	<!-- Page Content -->

	<a name="about"></a>
	<div class="content-section-a">

		<div class="container">
			<div class="row">
				<div class="col-lg-5 col-sm-6">
					<hr class="section-heading-spacer">
					<div class="clearfix"></div>
					<h2 class="section-heading">간단하고 안전하게 시작하십시오.</h2>

					<div class="lead" style="float: left;">
						<div style="float: left;">
							<i class="material-icons">schedule</i>
						</div>
						몇 초안에 무료 계정을 쉽게 설정하고 필요할 때 도움을받을 수 있습니다.
					</div>
					<div class="lead" style="float: left;">
						<div style="float: left;">
							<i class="material-icons">security</i>
						</div>
						우리는 귀하의 정보를 안전하게 보호하기 위해 노력하고 있습니다.
					</div>

				</div>
				<div class="col-lg-5 col-lg-offset-2 col-sm-6">
					<img class="img-responsive" src="./resources/Img/loginMainImg.PNG" alt="">
				</div>
			</div>

		</div>
		<!-- /.container -->

	</div>
	<!-- /.content-section-a -->

	<div class="content-section-b">

		<div class="container">

			<div class="row">
				<div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
					<hr class="section-heading-spacer">
					<div class="clearfix"></div>
					<h2 class="section-heading">손쉽게 당신의 가계부를 정리하십시오.</h2>
					<ul class="lead">
						<li>차트를 통해 당신이 사용한 내역을 볼 수 있습니다.</li>
						<li>엑셀을 이용한 간편한 등록을 해보십시오.</li>
						<li>사용한 내역을 쉽게 찾고 필요한 내역만 다운로드 하세요.</li>
					</ul>
				</div>
				<div class="col-lg-5 col-sm-pull-6  col-sm-6">
					<img class="img-responsive" src="./resources/Img/accbookMainImg.PNG" alt="">
				</div>
			</div>

		</div>
		<!-- /.container -->

	</div>
	<!-- /.content-section-b -->

	<div class="content-section-a">

		<div class="container">

			<div class="row">
				<div class="col-lg-5 col-sm-6">
					<hr class="section-heading-spacer">
					<div class="clearfix"></div>
					<h2 class="section-heading">스케쥴을 편하게 관리하십시오.</h2>

					<div class="lead">
						<div style="float: left;">       
							<i class="fa fa-calendar"></i>  
						</div>
						<div style="padding-left: 20px;">
						쉽게 등록하고 필요할 때 도움을 받을 수 있습니다.
						</div>
					</div>
					<div class="lead" style="float: left;">
						<div style="float: left;">
							<i class="fa fa-microphone"></i>
						</div> 
						<div style="padding-left: 20px;">
						음성녹음을 통한 더욱 간단한 스케줄 등록기능이 있습니다.
						</div>
					</div>
				</div>
				<div class="col-lg-5 col-lg-offset-2 col-sm-6">
					<img class="img-responsive" src="./resources/Img/calendarMainImg.PNG" alt="">
				</div>
			</div>

		</div>
		<!-- /.container -->

	</div>
	<!-- /.content-section-a -->

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<p class="copyright text-muted small">Copyright &copy; SCMaster
						C Class 2Group.</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- jQuery -->
	<script src="./resources/template/js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="./resources/template/js/bootstrap.min.js"></script>

</body>
</html>