<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Landing Page - Start Bootstrap Theme</title>
<!-- Bootstrap Core CSS -->
<link href="./resources/template/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="./resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="./resources/template/font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="./resources/template/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="./resources/template/js/bootstrap.min.js"></script>

</head>

<body>

	<!-- Navigation -->
	<div class="navbar navbar-default navbar-fixed-top topnav"
		role="navigation">
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand topnav" href="">우리조 타이틀</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="home">HOME</a></li>
					<li><a href="Accbook">Accbook</a></li>
					<li><a href="Calendar">Calendar</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


	<!-- Header -->
	<a name="about"></a>
	<div class="content_body">
		<div class="content_left">
			<div class="content_left_high">
				<!-- search입력 -->
				<div id="search_div">
					<input type="text" class="form-control"
						placeholder="&nbsp;&nbsp;&nbsp;&nbsp;Search"
						style="width: 90%; border: 0px; border-radius: 20px; vertical-align: bottom; outline: none; box-sizing: border-box; float: left;">
					<button type="submit" class="btn btn-default"
						style="width: 30%; height: 34px; border: 0px; border-radius: 20px; vertical-align: bottom; box-sizing: border-box; margin-left: -20%; float: left;">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>

			<div class="content_left_body">
			
				<p>LeftLeftLeftLeftLeftLeftLeftLeftLeft여기에 내용 넣는 자리여기에 내용 넣는
					자리여기에 내용 넣는 자리여기에 내용 넣는 자리여기에 내용 넣는 자리여기에 내용 넣는 자리여기에 내용 넣는 자리</p>

			</div>
		</div>

		<div class="content_right">

			<div class="content_right_high">

				<img alt="refresh" src="./resources/calendarimg/Refresh.png"
					style="width: 30px; height: 30px; float: left; margin-right: 5px;">

				<button type="button" class="btn btn-default"
					style="margin-right: 5px; float: left;">등록</button>

				<button type="button" class="btn btn-default" data-toggle="modal"
					data-target="#myModal" style="float: left;">간단등록</button>

				<img alt="refresh" src="./resources/calendarimg/Excel.png"
					style="width: 30px; height: 30px; float: left; margin-right: 10px;">

			</div>
			<br> <br>
			<div class="content_right_body">

				<p>RightRightRightRightRightRightRightRight 여기에 내용 넣는 자리 여기에 내용
					넣는 자리 여기에 내용 넣는 자리 여기에 내용 넣는 자리</p>


			</div>
		</div>
	</div>



	<a name="contact"></a>
	<div class="banner">

		<div class="container">

			<div class="row">
				<div class="col-lg-6">
					<h2>Connect to Start Bootstrap:</h2>
				</div>
				<div class="col-lg-6">
					<ul class="list-inline banner-social-buttons">
						<li><a href="https://twitter.com/SBootstrap"
							class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i>
								<span class="network-name">Twitter</span></a></li>
						<li><a
							href="https://github.com/IronSummitMedia/startbootstrap"
							class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i>
								<span class="network-name">Github</span></a></li>
						<li><a href="#" class="btn btn-default btn-lg"><i
								class="fa fa-linkedin fa-fw"></i> <span class="network-name">Linkedin</span></a>
						</li>
					</ul>
				</div>
			</div>

		</div>
		<!-- /.container -->

	</div>
	<!-- /.banner -->

	<!-- Footer -->
	<footer>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="list-inline">
					<li><a href="#">Home</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#about">About</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#services">Services</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#contact">Contact</a></li>
				</ul>
				<p class="copyright text-muted small">Copyright &copy; Your
					Company 2014. All Rights Reserved</p>
			</div>
		</div>
	</div>
	</footer>
</body>

</html>
