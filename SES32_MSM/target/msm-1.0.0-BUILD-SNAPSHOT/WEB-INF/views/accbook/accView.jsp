<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<!-- CSS mimi -->
<link href="../resources/css/style.css" rel="stylesheet" type="text/css" />
<!-- jquery  -->
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<!-- modal -->
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#popbutton").click(function() {
			$('div.modal').modal({
				remote : 'layer'
			});
		})
	})
</script>


<script>
	/*jquery */

	$(document).ready(function() {
		//첫번째 버튼에 이벤트 연결 (이벤트 종류p.442)
		//	$('#bt1').on('click',btClick1);//내용이 복잡할 경우 함수 정의 - 호출 x ()쓰지말 것
		//날짜설정 함수
		init();

	});

	/* 홈페이지 처음 시작할때 날짜설정 함수 */
	function init() {
		//첫날
		var start_date = new Date();
		start_date.setDate('01');

		//마지막 날 계산
		var end_day = (new Date(start_date.getFullYear(),
				start_date.getMonth() + 1, 0)).getDate();
		var end_date = new Date();
		end_date.setDate(end_day);

		//날짜 포맷
		var f_start = dateToYYYYMMDD(start_date);
		var f_end = dateToYYYYMMDD(end_date);

		document.getElementById('start_date').value = f_start;
		document.getElementById('end_date').value = f_end;
	}

	//데이트 포멧 
	function dateToYYYYMMDD(date) {
		function pad(num) {
			num = num + '';
			return num.length < 2 ? '0' + num : num;
		}
		return date.getFullYear() + '-' + pad(date.getMonth() + 1) + '-'
				+ pad(date.getDate());
	}
</script>
<!--modal 셋팅  -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
									<li><a href="accbook/accTest">메인</a></li>
									<li><a href="user/userPage">일정 관리</a></li>
									<li class="active"><a href="blog.html">가계부</a></li>
									<li><a href="user/mapAPI_Test">경조사 </a></li>
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

							<!-- 검색 -->
							<div id="content">
								<br> <br> <br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select
									class="payment">
									<option value="전체">전체</option>
									<option value="체크카드">체크카드</option>
									<option value="현금">현금</option>
									<option value="통장">통장</option>
								</select> <input type="date" id="start_date"> <input type="date"
									id="end_date"> <input type="button" value="검색">





								<!-- Modal -->
								<button class="btn btn-default" id="popbutton">모달출력버튼</button>
								<br />
								<div class="modal fade">
									<div class="modal-dialog">
										<div class="modal-content">
											<!-- remote ajax call이 되는영역 -->
											
										</div>
									</div>
								</div>



								<div></div>
							</div>
						</div>
					</div>
					<div class="shadow">&nbsp;</div>
				</div>
			</div>
	</ul>

</body>
</html>