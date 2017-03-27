<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>

<style>
#tablediv {
	float: left;
	width: 400px;
	height: 400px;
}

#tablediv th {
	background: green;
	font-size: 10px;
	text-align: center;
}

#piechart {
	float: right;
	width: 280px;
	height: 400px;
}
</style>

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



<!-- 차트 API 끌어오기 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		/* 데이터 만들기  */
		var data = google.visualization.arrayToDataTable([
				[ 'Task', 'Hours per Day' ], [ 'Work', 11 ], [ 'Eat', 2 ],
				[ 'Commute', 2 ], [ 'Watch TV', 2 ], [ 'Sleep', 7 ] ]);
		/* 옵션 설정*/

		var options = {
			title : 'My Daily Activities',
			backgroundColor : 'ffffff' //배경색
			,
			chartArea : {
				left : 40,
				top : 100,
				width : '70%',
				height : '90%'
			} //에어리어 
			,
			legend : {
				position : 'none',
				textStyle : {
					color : 'blue',
					fontSize : 16
				}
			} //범례 

			,
			titleTextStyle : {
				color : 'black',
				fontName : 'MS Mincho',
				fontSize : 20
			}
		// 

		};
		/* 차트 종류 선택  */
		var chart = new google.visualization.PieChart(document
				.getElementById('piechart'));
		/* 차트 그리기 (데이터,제목)  */
		chart.draw(data, options);
	}
</script>


<script type="text/javascript">
	//상세검색
	$(function() {
		$("#popbutton").click(function() {
			$('div.modal').modal({
				remote : 'layer'
			});
		})
	})
	//등록
	$(function() {
		$("#popbutton1").click(function() {
			$('div.modal').modal({
				remote : 'registAccbookView'
			});
		})
	})
	//음성등록
	$(function() {
		$("#popbutton2").click(function() {
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



								<div class="container">


									<div class="dropdown">
										<a id="dLabel" data-target="#" href="" data-toggle="dropdown"
											aria-haspopup="true" role="button" aria-expanded="false">
											Dropdown trigger <span class="caret"></span>
										</a>

										<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
											<li role="presentation"><a role="menuitem" tabindex="-1"
												href="#">전체</a></li>
											<li role="presentation"><a role="menuitem" tabindex="-1"
												href="#">체크카드</a></li>
											<li role="presentation"><a role="menuitem" tabindex="-1"
												href="#">현금</a></li>
											<li role="presentation"><a role="menuitem" tabindex="-1"
												href="#">통장</a></li>
										</ul>
									</div>
								</div>




								<input type="date" id="start_date"> <input type="date"
									id="end_date"> <input type="button"
									class="btn btn-xs btn-info" value="검색">

								<!-- Modal 상세검색 -->
								<button class="btn btn-xs btn-info" id="popbutton">상세검색</button>

								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn btn-xs btn-info" id="popbutton1">등록</button>

								<button class="btn btn-xs btn-info" id="popbutton2">음성등록</button>
								<input type="button" Class="btn btn-xs btn-info" value="엑셀등록">
								<br />
								<div class="modal fade">
									<div class="modal-dialog">
										<div class="modal-content">
											<!-- remote ajax call이 되는영역 -->

										</div>
									</div>
								</div>

								<br>
								<br>


								<!--테이블 영역  -->
								<div class="row" id="tablediv">
									<div class="col-md-4">
										<table class="table">
											<thead>
												<tr>
													<th></th>
													<th>날짜</th>
													<th>카테고리</th>
													<th>하위카테고리</th>
													<th>결제수단</th>
													<th>항목</th>
													<th>금액</th>
												</tr>

											</thead>

											<tbody>
												<tr>
													<td></td>
													<td>1</td>
													<td>Mark</td>
													<td>Otto</td>
													<td>@mdo</td>
													<td>@mdo</td>
													<td>@mdo</td>

												</tr>
												<tr>
													<td></td>
													<td>1</td>
													<td>Jacob</td>
													<td>Thornton</td>
													<td>@fat</td>
													<td>@mdo</td>
													<td>@mdo</td>
												</tr>
												<tr>
													<td></td>
													<td>1</td>
													<td>Larry</td>
													<td>the Bird</td>
													<td>@twitter</td>
													<td>@mdo</td>
													<td>@mdo</td>
												</tr>
											</tbody>
										</table>

									</div>
								</div>
								<!-- 웹페이지에 띄우기 -->
								<span id="piechart"></span>
							</div>
						</div>
						<div class="shadow">&nbsp;</div>
					</div>
				</div>
	</ul>

</body>
</html>