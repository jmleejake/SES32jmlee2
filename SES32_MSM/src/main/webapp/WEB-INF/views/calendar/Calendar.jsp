<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta
	content="Google Chrome is a browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier."
	name="description">
<title>SCHDULE</title>
<!-- Bootstrap Core CSS -->
<link href="./resources/template/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="./resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="./resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="./resources/template/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="./resources/template/js/bootstrap.min.js"></script>

<!-- dateRange js -->
<script src="./resources/daterange.js" type="text/javascript"></script>

<!-- Include Required Prerequisites -->
<script type="text/javascript"
	src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>

<!-- 날자 범위 선택기 -->
<script type="text/javascript"
	src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

<!-- voice -->
<script type="text/javascript" src="./resources/voice.js"></script>
<link href="https://plus.google.com/100585555255542998765"
	rel="publisher">
<link href="//www.google.com/images/icons/product/chrome-32.png"
	rel="icon" type="image/ico">
<link
	href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&amp;subset=latin"
	rel="stylesheet">
<script src="//www.google.com/js/gweb/analytics/autotrack.js"></script>
<script>
	new gweb.analytics.AutoTrack({
		profile : 'UA-26908291-1'
	});
</script>
<style type="text/css">
#start_button {
	margin-left: 20%;
	background-color: white;
	border: 0;
	outline: 0;
}

#mic_img {
	width: 150px;
	height: 150px;
}

#select_language {
	position: relative;
	left: -73px;
}

#results {
	font-size: 14px;
	font-weight: bold;
	border: 1px solid #ddd;
	padding: 15px;
	text-align: left;
	min-height: 150px;
}
</style>
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
					<li><a href="Accbook">Account</a></li>
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
			<!-- search입력 -->
			<div id="search_div">
				<input type="text" class="form-control"
					placeholder="&nbsp;&nbsp;&nbsp;&nbsp;Search"
					style="width: 90%; border: 0px; border-radius: 20px; vertical-align: bottom; outline: none; box-sizing: border-box; float: left;">
				<button type="submit" class="btn btn-default"
					style="width: 20%; height: 34px; border: 0px; border-radius: 20px; vertical-align: bottom; box-sizing: border-box; margin-left: -20%; float: left;">
					<i class="glyphicon glyphicon-search"></i>
				</button>
			</div>
			<div id="reportrange" class="form-control"
				style="background: #fff; cursor: pointer; width: auto; float: left;">
				<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp; <span></span>
				<b class="caret"></b>
			</div>

			<br> 
			<div class="content_left_body">

				<p>LeftLeftLeftLeftLeftLeftLeftLeftLeft여기에 내용 넣는 자리여기에 내용 넣는
					자리여기에 내용 넣는 자리여기에 내용 넣는 자리여기에 내용 넣는 자리여기에 내용 넣는 자리여기에 내용 넣는 자리</p>
			</div>
		</div>
		<div class="content_right">

			<img alt="refresh" src="./resources/calendarimg/Refresh.png"
				style="width: 30px; height: 30px; float: left; margin-right: 5px;">

			<button type="button" class="btn btn-default"
				style="margin-right: 5px; float: left;">등록</button>

			<button type="button" class="btn btn-default" data-toggle="modal"
				data-target="#myModal" style="float: left;">간단등록</button>

			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog modal-sm">

					<!--voice Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">마이크 테스트</h4>
							<button id="start_button" onclick="startButton(event)">
								<img alt="mic" src="./resources/Micimg/Mic.png" id="mic_img">
							</button>
						</div>
						<div class="modal-body">
							<div id="results">
								<span class="final" id="final_span"></span> <span
									class="interim" id="interim_span"></span>
							</div>

						</div>
						<div class="modal-footer">
							<select id="select_language" onchange="updateCountry()">
							</select>
							<button type="button" id="voicesubmit" class="btn btn-default">등록</button>
							<button type="button" id="closebt" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>

					<script>
						/* 언어 종류 */
						var langs = [ [ '한국어', [ 'ko-KR' ] ],
								[ 'English', [ 'en-US', 'United States' ] ],
								[ '日本語', [ 'ja-JP' ] ] ];

						for (var i = 0; i < langs.length; i++) {
							select_language.options[i] = new Option(
									langs[i][0], i);
						}
						updateCountry();
						console.log('Speak Ready');
					</script>

				</div>
			</div>

			<img alt="excel" src="./resources/calendarimg/Excel.png"
				style="width: 30px; height: 30px; float: left; margin-right: 10px;">

			<br> 
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
	<script type="text/javascript">
		$('.modal').on('hidden.bs.modal', function() {
			$(this).removeData('bs.modal');
		});
	</script>
</body>
</html>
