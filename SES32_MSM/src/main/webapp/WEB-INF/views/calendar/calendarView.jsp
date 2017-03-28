
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<!-- CSS mimi -->
<link href="../resources/css/style.css" rel="stylesheet" type="text/css" />
<!-- BootStrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- //BootStrap -->
<style type="text/css">
#content {
	background-color: navy;
	height: 468px;
}

.content_body {
	margin-left: 30px;
}

.content_left {
	float: left;
}

.content_right {
	margin-left: 10px;
	float: left;
}
</style>

</head>
<body>
	<ul>
		<div id="background">
			<div id="page">

				<div class="header">
					<div class="footer">
						<div class="body">

							<div id="sidebar">
								<a href="index.html"><img id="logo"
									src="../resources/images/logo_msm.png" width="154" height="75"
									alt="" title="" /></a>


								<ul class="navigation">
									<li class="active"><a href="calendar/calTest">캘린더테스트</a></li>
									<li><a href="accbook/accTest">가계부테스트</a></li>
									<li><a href="user/userPage">회원가입 페이지</a></li>
									<li><a href="user/mapAPI_Test">지도 API 테스트</a></li>
									<li class="last"><a href="contact.html">CONTACT</a></li>
								</ul>

								<div class="connect">
									<a href="http://facebook.com/freewebsitetemplates"
										class="facebook">&nbsp;</a> <a
										href="http://twitter.com/fwtemplates" class="twitter">&nbsp;</a>
									<a href="http://www.youtube.com/fwtemplates" class="vimeo">&nbsp;</a>
								</div>

								<div class="footenote">
									<span>&copy; Copyright &copy; 2011.</span> <span><a
										href="index.html">Company name</a> all rights reserved</span>
								</div>

							</div>
							<div id="content">
								<div class="high">
									<p>상세 검색 날짜검색 등록 간단 등록</p>
									<!-- search입력 -->
									<input type="text" class="form-control input-sm"
										placeholder="Search" style="width: 30%; float: left;">
									<button type="submit" class="btn btn-default" style="float: left;">
										<i class="glyphicon glyphicon-search"></i>
									</button>
									<!-- //search입력 -->
									<!-- date range 선택기 -->
									<div id="reportrange"  class="form-control" style="background: #fff; cursor: pointer; padding: 5px 10px;  width: 30%; float: left;">
    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    <span></span> <b class="caret"></b>
</div>

<script type="text/javascript">
$(function() {

    var start = moment().subtract(29, 'days');
    var end = moment();

    function cb(start, end) {
        $('#reportrange span').html(start.format('YYYY MM D') + ' - ' + end.format('YYYY MM D'));
    }

    $('#reportrange').daterangepicker({
        startDate: start,
        endDate: end,
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);

    cb(start, end);
    
});
</script>
									<!-- //날짜 범위 선택기 -->
									 <img
										alt="refresh" src="./resources/Refresh.png"
										style="width: 30px; height: 30px; float: left;">
								</div>
								<div class="content_body">
									<div class="content_left">
										<p>LeftLeftLeftLeftLeftLeftLeftLeftLeft</p>
										<img alt="" src="../resources/left_memo.PNG"
											style="width: 330px;">
									</div>
									<div class="content_right">
										<p>RightRightRightRightRightRightRightRight</p>
										<img alt="" src="../resources/right_calendar.PNG"
											style="width: 330px;">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="shadow">&nbsp;</div>
				</div>
			</div>
		</div>
	</ul>

</body>
</html>