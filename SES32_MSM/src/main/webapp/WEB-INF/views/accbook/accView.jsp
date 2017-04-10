<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

	function search() {
		var start_date = $('#start_date').val();
		var end_date = $('#end_date').val();
		var u_id = 'aaa';
		var page = document.getElementById('page').value;

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

				alert(JSON.stringify(e));
			}
		});

		//그래프 내용 조회
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
			width : 260,
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
			width : 260,
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



								<div class="container"></div>




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
								<br />
								<div class="modal fade">
									<div class="modal-dialog">
										<div class="modal-content">
											<!-- remote ajax call이 되는영역 -->

										</div>
									</div>
								</div>

								<br> <br>

								<!--테이블 영역  -->
								<div id="tablediv">
									<input type="hidden" name="page" id="page">


								</div>



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
										<a class="left carousel-control"
											href="#carousel-example-generic" role="button"
											data-slide="prev" id="left"> <span
											class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="right carousel-control"
											href="#carousel-example-generic" role="button"
											data-slide="next" id="rigth2"> <span
											class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</div>



							</div>


							<!-- 페이징 영역 -->

							<div align="center" id="pagingdiv"></div>





						</div>




					</div>
					<div class="shadow">&nbsp;</div>
				</div>
			</div>
	</ul>

</body>
</html>

