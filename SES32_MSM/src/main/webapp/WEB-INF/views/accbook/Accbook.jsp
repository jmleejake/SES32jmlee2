<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true"%>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Landing Page - Start Bootstrap Theme</title>
<!-- Bootstrap Core CSS -->
<link href="../resources/template/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../resources/template/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">




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




<script>
	//모달 
	//상세검색

	$(function() {
		$("#popbutton").click(function() {
			$('.modal-content').empty();
			$('div.modal').modal({
				remote : 'layer'
			});
		})
	})
	//등록
	$(function() {
		$("#popbutton1").click(function() {
			$('.modal-content').empty();
			$('div.modal').modal({
				remote : 'registAccbookView'
			});
		})
	})
	//음성등록
	$(function() {
		$("#popbutton2").click(function() {
			$('.modal-content').empty();

			$('div.modal').modal({
				remote : 'layer'
			});
		})
	})
</script>



<!-- 차트 API 끌어오기 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<link href="../resources/css/accbookStyle.css" rel="stylesheet"
	type="text/css" />







<script>
	/*jquery */
	$(document).ready(function() {
		//버튼 누를시 이벤트
		$('#search').on('click', seartch);
		//날짜설정 함수
		init();
		$('#left').on('click', seartch);
		$('#rigth2').on('click', seartch);

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

	function seartch() {
		var start_date = $('#start_date').val();
		var end_date = $('#end_date').val();

		if (start_date > end_date) {
			alert('날짜를 제대로 입력 해주세요.');
			return;
		}

		var u_id = 'aaa';

		var page = $('#page').val();

		//차트 내용 조회
		$.ajax({
			url : 'getAccbook2',
			type : 'POST',
			dataType : 'json',
			//서버로 보내는 parameter
			data : {
				u_id : u_id,
				start_date : start_date,
				end_date : end_date,
			},
			success : output2,
			error : function(e) {
				alert('chart');
				alert(JSON.stringify(e));
			}
		});

		//테이블 내용 조회
		$.ajax({
			url : 'getAccbook',
			type : 'POST',
			dataType : 'json',
			//서버로 보내는 parameter
			data : {
				u_id : u_id,
				start_date : start_date,
				end_date : end_date,
				page : page
			},
			success : output,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});

	}

	function formSubmit(p) {

		var page = document.getElementById('page');
		page.value = p;
		seartch();
	}

	//테이블,페이징 
	function output(hm) {
		var start = hm.startPageGroup;
		var end = hm.endPageGroup;
		var currentPage = hm.currentPage;
		var ob = hm.list;
		//테이블
		var str = '<table id=table1> <tr> <th>날짜 <th>카테고리<th>하위카테고리<th>결제수단<th>항목<th>금액</tr>';
		for (var i = 0; i < ob.length; i++) {
			str += '<tr>' + '<td>' + ob[i].a_date +

			'<td>' + ob[i].main_cate + '<td>' + ob[i].sub_cate + '<td>'
					+ ob[i].payment + '<td>' + ob[i].a_memo + '<td>'
					+ ob[i].price + '</tr>';
		}
		str += '</table>';

		//$.each(ob,function(i,comment){
		//str += '<tr><td class="tdNum">' + comment.num+'<td class="tdName">' + comment.name + '<td class="tdText">' + comment.text 
		//+ '<td><input type="button" class="btnDel"  value="삭제" num="'+comment.num+'"> </tr>';

		//});

		$('#tablediv').html(str);
		//페이징	
		var str2 = ' ';

		var m2 = currentPage - 1;
		var m1 = currentPage + 1;
		str2 += '<a href="javascript:formSubmit(' + m2 + ')">◀</a>';
		for (var i = start; i <= end; i++) {
			str2 += '<a href="javascript:formSubmit(' + i + ')">' + i + '</a>';
		}
		str2 += '<a href="javascript:formSubmit(' + m1 + ')">▶</a>';
		$('#pagingdiv').html(str2);
		//차트 생성

	}

	//차트 출력
	function output2(hm) {

		console.log(hm);
		if (hm.size != 0) {
			pieChart(hm);
			colunmChart(hm);
			colunmChart2(hm);
		}
		if (hm.size == 0) {
			$('.silder').html('test');
		}
	}

	/* 차트 로드 */
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(pieChart);

	google.charts.setOnLoadCallback(colunmChart);
	google.charts.setOnLoadCallback(colunmChart2);
	
	function pieChart(ob2) {

		/* 데이터 만들기  */
		var data;
		var check;
		var arr_obj = new Array();
		var obj1 = [ 'item', 'price' ];
		var obj2 = [ 'fixed_out', ob2.fixed_out ];
		var obj3 = [ 'out', ob2.out ];
		var obj4 = [ 'fixed_in', ob2.fixed_in ];
		var obj5 = [ 'in', ob2.in1 ];
		arr_obj.push(obj1);
		arr_obj.push(obj2);
		arr_obj.push(obj3);
		arr_obj.push(obj4);
		arr_obj.push(obj5);

		data = google.visualization.arrayToDataTable(arr_obj);

		/* 옵션 설정*/

		var options = {
			title : '조회 내역',
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

	function colunmChart(ob2) {
		/* 데이터 만들기  */
		var data;
		var color = [ "gold", "#b87333", "color: green", "color: #e5e4e2",
				"silver" ];
		var arr_obj = new Array();
		var obj1 = [ "ㅁㅁㅁ", "price", {
			role : "style"
		} ];
		var obj2 = [ '수입', ob2.fixed_in + ob2.in1, "blue" ];
		var obj3 = [ '지출', ob2.fixed_out + ob2.out, "red" ];
		arr_obj.push(obj1);
		arr_obj.push(obj2);
		arr_obj.push(obj3);

		console.log(JSON.stringify(arr_obj));

		data = google.visualization.arrayToDataTable(arr_obj);

		//옵션 설정
		var options = {
			title : "막대 차트 test",
			width : 300,
			height : 400,
			bar : {
				groupWidth : "95%"
			},

			legend : {
				position : "none"
			},
		};

		//그래프 view 설정 
		var view = new google.visualization.DataView(data);
		view.setColumns([ 0, 1, {
			calc : "stringify",

			type : "string",
			role : "annotation"
		}, 2 ]);

		var chart = new google.visualization.ColumnChart(document
				.getElementById("columnchart_values"));
		chart.draw(view, options);
	}

	function colunmChart2(ob2) {
		/* 데이터 만들기  */

		var list = ob2.list;
		var data;
		var color = [ "gold", "#b87333", "color: green", "color: #e5e4e2",
				"silver" ];
		var arr_obj = new Array();

		var obj1 = [ "상위 지출 내역", "price", {
			role : "style"
		} ];
		arr_obj.push(obj1);
		$.each(list, function(i, acc) {

			if (i < 4) {

				var obj2 = [ acc.sub_cate, acc.price, "gold" ];
				arr_obj.push(obj2);
				i++;

			}
		});

		console.log(JSON.stringify(arr_obj));

		data = google.visualization.arrayToDataTable(arr_obj);

		//옵션 설정
		var options = {
			title : "막대 차트 test",
			width : 300,
			height : 400,
			bar : {
				groupWidth : "95%"
			},

			legend : {
				position : "none"
			},
		};

		//그래프 view 설정 
		var view = new google.visualization.DataView(data);
		view.setColumns([ 0, 1, {
			calc : "stringify",

			type : "string",
			role : "annotation"
		}, 2 ]);

		var chart = new google.visualization.ColumnChart(document
				.getElementById("columnchart_values2"));
		chart.draw(view, options);
	}
</script>

<script>
	function upload() {
		if ($('#file').val() == '') {
			alert('파일을 등록해주세요');
			return;
		}
		document.getElementById('upload').submit();
	}
</script>




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
				<input type="date" id="start_date"> <input type="date"
					id="end_date"> <input type="button"
					class="btn btn-xs btn-info" value="검색" id="search">


				<!-- Modal 상세검색 -->
				<button class="btn btn-xs btn-info" id="popbutton">상세검색</button>

				<button class="btn btn-xs btn-info" id="popbutton1">등록</button>

				<button class="btn btn-xs btn-info" id="popbutton2">음성등록</button>


				<input type="button" value="엑셀등록" Class="btn btn-xs btn-info"
					onclick="upload()">

				<form action="uploadAccbook" method="post" id="upload"
					enctype="multipart/form-data">

					<input type="file" name="file" id="file" size="30"
						multiple="multiple">
				</form>
			</div>
			<br>
			<br>
			<div class="content_left_body">
				<!--테이블 영역  -->
				<input type="hidden" name="page" id="page" value="1">
				<div id="tablediv"></div>



			</div>
		</div>

		<div class="content_right">

			<div class="content_right_high">


				<br />
				<div class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<!-- remote ajax call이 되는영역 -->

						</div>
					</div>
				</div>

			</div>
			<br> <br>
			<div class="content_right_body">
				<!-- 차트 슬라이더 -->
				<div>
					<div id="carousel-example-generic" class="carousel slide"
						data-ride="carousel" data-interval="false">
						<ol class="carousel-indicators">
							<li data-target="#carousel-example-generic" data-slide-to="0"
								class="active"></li>
							<li data-target="#carousel-example-generic" data-slide-to="1"></li>
							<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner" role="listbox">
							<div class="item active">
								<p id="piechart" class="silder">
							</div>
							<div class="item">
								<p id="columnchart_values" class="silder">
							</div>
							<div class="item">
								<p id="columnchart_values2" class="silder">
							</div>
						</div>
						<a class="left carousel-control" href="#carousel-example-generic"
							role="button" data-slide="prev" id="left"> <span
							class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> <a class="right carousel-control"
							href="#carousel-example-generic" role="button" data-slide="next"
							id="rigth2"> <span class="glyphicon glyphicon-chevron-right"
							aria-hidden="true"></span> <span class="sr-only">Next</span>
						</a>
					</div>
				</div>




			</div>
		</div>
			<!-- 페이징 영역 -->

	</div>


	<div align="center" id="pagingdiv"></div>


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
