<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Account Book</title>

<!-- W3School CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>



<style>
.mySlides {
	display: none
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0
}
</style>

<!-- alert창 CSS 넣기 -->
<style>
#modalContainer {
	background-color: rgba(0, 0, 0, 0.3);
	position: absolute;
	top: 0;
	width: 100%;
	height: 100%;
	left: 0px;
	z-index: 10000;
	background-image: url(tp.png);
	/* required by MSIE to prevent actions on lower z-index elements */
}

#alertBox {
	position: relative;
	width: 33%;
	min-height: 100px;
	max-height: 400px;
	margin-top: 50px;
	border: 1px solid #fff;
	background-color: #fff;
	background-repeat: no-repeat;
	top: 30%;
}

#modalContainer>#alertBox {
	position: fixed;
}

#alertBox h1 {
	margin: 0;
	font: bold 1em Raleway, arial;
	background-color: #f97352;
	color: #FFF;
	border-bottom: 1px solid #f97352;
	padding: 10px 0 10px 5px;
}

#alertBox p {
	height: 50px;
	padding-left: 5px;
	padding-top: 30px;
	text-align: center;
	vertical-align: middle;
}

#alertBox #closeBtn {
	display: block;
	position: relative;
	margin: 10px auto 10px auto;
	padding: 7px;
	border: 0 none;
	width: 70px;
	text-transform: uppercase;
	text-align: center;
	color: #FFF;
	background-color: #f97352;
	border-radius: 0px;
	text-decoration: none;
	outline: 0 !important;
}

/* unrelated styles */
#mContainer {
	position: relative;
	width: 600px;
	margin: auto;
	padding: 5px;
	border-top: 2px solid #fff;
	border-bottom: 2px solid #fff;
}

h1, h2 {
	margin: 0;
	padding: 4px;
}

code {
	font-size: 1.2em;
	color: #069;
}

#credits {
	position: relative;
	margin: 25px auto 0px auto;
	width: 350px;
	font: 0.7em verdana;
	border-top: 1px solid #000;
	border-bottom: 1px solid #000;
	height: 90px;
	padding-top: 4px;
}

#credits img {
	float: left;
	margin: 5px 10px 5px 0px;
	border: 1px solid #000000;
	width: 80px;
	height: 79px;
}

.important {
	background-color: #F5FCC8;
	padding: 2px;
}

@media ( max-width : 600px) {
	#alertBox {
		position: relative;
		width: 90%;
		top: 30%;
	}
}
</style>
<script>
	var ALERT_TITLE = "알림";
	var ALERT_BUTTON_TEXT = "확인";

	if (document.getElementById) {
		window.alert = function(txt) {
			createCustomAlert(txt);
		}
	}

	function createCustomAlert(txt) {
		d = document;

		if (d.getElementById("modalContainer"))
			return;

		mObj = d.getElementsByTagName("body")[0].appendChild(d
				.createElement("div"));
		mObj.id = "modalContainer";
		mObj.style.height = d.documentElement.scrollHeight + "px";

		alertObj = mObj.appendChild(d.createElement("div"));
		alertObj.id = "alertBox";
		if (d.all && !window.opera)
			alertObj.style.top = document.documentElement.scrollTop + "px";
		alertObj.style.left = (d.documentElement.scrollWidth - alertObj.offsetWidth)
				/ 2 + "px";
		alertObj.style.visiblity = "visible";

		h1 = alertObj.appendChild(d.createElement("h1"));
		h1.appendChild(d.createTextNode(ALERT_TITLE));

		msg = alertObj.appendChild(d.createElement("p"));
		//msg.appendChild(d.createTextNode(txt));
		msg.innerHTML = txt;

		btn = alertObj.appendChild(d.createElement("a"));
		btn.id = "closeBtn";
		btn.appendChild(d.createTextNode(ALERT_BUTTON_TEXT));
		btn.href = "#";
		btn.focus();
		btn.onclick = function() {
			removeCustomAlert();
			return false;
		}

		alertObj.style.display = "block";

	}

	function removeCustomAlert() {
		document.getElementsByTagName("body")[0].removeChild(document
				.getElementById("modalContainer"));
	}
	function ful() {
		alert('Alert this pages');
	}
</script>


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
	//수정
	$(function() {
		$(".popbutton3").click(function() {

			var a_ids = $('input:checkbox[name=deleteCheck]');

			var a_id;
			var check = 0;
			$.each(a_ids, function(i, item) {
				if ($(item).prop('checked')) {
					check++;
				}

			});

			if (check >= 2 || check == 0) {
				alert('수정할 내역을 확인해주세요.')
				return;
			}

			$.each(a_ids, function(i, item) {
				if ($(item).prop('checked')) {
					a_id = $(item).val();
				}

			});

			$('#m_a_id').val(a_id);

			$('.modal-content').empty();

			$('div.modal').modal({
				remote : 'modifyAccbook'
			});
		})

	})
</script>



<!-- 차트 API 끌어오기 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>



<script>
	/*jquery */
	$(document).ready(function() {
		//버튼 누를시 이벤트
		$('#search').on('click', search);
		//날짜설정 함수
		init();
		$('#left').on('click', search);
		$('#rigth2').on('click', search);

		$('#search').trigger('click');
		$('#search').trigger('click');

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

		document.getElementById('s_start_date').value = f_start;
		document.getElementById('s_end_date').value = f_end;

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
		/*검색 시작 날짜  */
		var start_date = $('#s_start_date').val();
		/*검색 끝 날짜*/
		var end_date = $('#s_end_date').val();

		/* 타입 */
		var type = $('input:radio[name=s_type]:checked').val();
		/* 결제 방법을 담은 배열 */
		var payment = new Array();

		var payments = $('input:checkbox[name=s_payment]');
		/*카테고리를 담은 배열  */
		var sub_cates = new Array();

		var keyWord = '';
		keyWord = $('#s_keyword').val();

		var cate_check = $('input:checkbox[name=s_cate]');

		$.each(payments, function(i, item) {
			if ($(item).prop('checked')) {
				payment.push($(item).val());
			}

		});

		$.each(cate_check, function(i, item) {
			if ($(item).prop('checked')) {
				sub_cates.push($(item).val());
			}

		});

		if (start_date > end_date) {
			alert('날짜를 제대로 입력 해주세요.');
			return;
		}

		var u_id = 'aaa';

		var page = $('#page').val();

		$('#model_close').trigger('click');
		$('#model_close2').trigger('click');
		jQuery.ajaxSettings.traditional = true;
		/*alert('type:'+type);
		console.log(payment);
		console.log(sub_cates);
		alert('sub'+sub_cates);
		alert('key'+keyWord);
		alert('payment'+payment);*/

		//차트 내용 조회
		$.ajax({
			url : 'getAccbook2',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				u_id : u_id,
				start_date : start_date,
				end_date : end_date,
				type : type,
				sub_cates : sub_cates,
				keyWord : keyWord,
				payment : payment
			},
			dataType : 'json',
			success : output2,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});

		//테이블 내용 조회
		$.ajax({
			url : 'getAccbook',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				u_id : u_id,
				start_date : start_date,
				end_date : end_date,
				type : type,
				sub_cates : sub_cates,
				payment : payment,
				keyWord : keyWord,
				page : page
			},
			dataType : 'json',
			success : output,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});

	}

	function formSubmit(p) {

		var page = document.getElementById('page');
		page.value = p;
		search();
	}

	//테이블,페이징 
	function output(hm) {
		var start = hm.startPageGroup;
		var end = hm.endPageGroup;
		var currentPage = hm.currentPage;
		var ob = hm.list;
		//테이블
		console.log(ob);
		var str = '<table id="table1" class="table"><thead> <tr> <th><input type="checkbox" id="allCheck"><th>날짜 <th>카테고리<th>하위카테고리<th>결제수단<th>항목<th>금액</tr></thead><tbody>';
		for (var i = 0; i < ob.length; i++) {
			str += '<tr>'
					+ '<td><input type="checkbox" name="deleteCheck" value="'+ob[i].a_id+'"><td>'
					+ ob[i].a_date
					+ '<td>'
					+ ob[i].main_cate
					+ '<td>'
					+ ob[i].sub_cate
					+ '<td>'
					+ ob[i].payment
					+ '<td>'
					+ ob[i].a_memo
					+ '<td>'
					+ ob[i].price
					+ '<td><input type="hidden" name="a_id" value="'
					+ ob[i].a_id + '"></tr>';
		}
		str += '</tbody></table>';

		$('#tablediv').html(str);
		$('#allCheck').on('click', allCheck);
		//페이징	
		var str2 = ' ';

		var m2 = currentPage - 5;
		var m1 = currentPage + 5;
		str2 += '<a href="javascript:formSubmit(' + m2
				+ ')" class="w3-button">&laquo;</a>';
		for (var i = start; i <= end; i++) {
			str2 += '<a href="javascript:formSubmit(' + i
					+ ')" class="w3-button"> ' + i + ' </a>';
		}
		str2 += '<a href="javascript:formSubmit(' + m1
				+ ')" class="w3-button">&raquo;</a>';
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
		var obj2 = [ '고정 지출', ob2.fixed_out ];
		var obj3 = [ '지출', ob2.out ];
		var obj4 = [ '고정 수입', ob2.fixed_in ];
		var obj5 = [ '수입', ob2.in1 ];
		arr_obj.push(obj1);
		arr_obj.push(obj2);
		arr_obj.push(obj3);
		arr_obj.push(obj4);
		arr_obj.push(obj5);

		data = google.visualization.arrayToDataTable(arr_obj);

		/* 옵션 설정*/

		var options = {
			title : '수입 지출 현황',
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
		var obj1 = [ "item", "price", {
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
			title : "수입 지출 현황",
			width : 300,
			height : 400,
			bar : {
				groupWidth : "80%"
			},

			legend : {
				position : "none"
			},
			titleTextStyle : {
				color : 'black',
				fontName : 'MS Mincho',
				fontSize : 20
			}
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

			if (i < 3) {

				var obj2 = [ acc.sub_cate, acc.price, color[i] ];
				arr_obj.push(obj2);
				i++;

			}
		});

		console.log(JSON.stringify(arr_obj));

		data = google.visualization.arrayToDataTable(arr_obj);

		//옵션 설정
		var options = {
			title : "상위 Best3 항목",
			width : 300,
			height : 400,
			bar : {
				groupWidth : "80%"
			},

			legend : {
				position : "none"
			},
			titleTextStyle : {
				color : 'black',
				fontName : 'MS Mincho',
				fontSize : 20
			}
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

	function deleteAccbook() {

		var checkflag = false;
		var deleteCheck = $('input:checkbox[name=deleteCheck]');

		/*카테고리를 담은 배열  */
		console.log(deleteCheck);
		var a_id = new Array();

		$.each(deleteCheck, function(i, item) {
			if ($(item).prop('checked')) {
				a_id.push($(item).val());
				checkflag = true;

			}

		});
		if (!checkflag) {
			return;
		}
		var check = confirm('정말로 삭제 합니까?');

		if (check) {

			$.ajax({
				url : 'deleteAccbook',
				type : 'POST',
				//서버로 보내는 parameter
				data : {
					a_id : a_id
				},
				success : search(),
				error : function(e) {
					alert(JSON.stringify(e));
				}
			});
		}
	}

	function allCheck() {

		var check = $('#allCheck').is(":checked");

		var deleteCheck = $('input:checkbox[name=deleteCheck]');

		if (check) {
			$.each(deleteCheck, function(i, item) {
				this.checked = true;
			});
		}
		if (!check) {
			$.each(deleteCheck, function(i, item) {
				this.checked = false;

			});
		}
	}
	/* 엑셀 다운로드 */
	function excelDown() {
		var f = document.getElementById('excelDownAccbook');
		/*검색 시작 날짜  */
		document.getElementById('start_date').value = $('#s_start_date').val();

		/*검색 끝 날짜*/
		document.getElementById('end_date').value = $('#s_end_date').val();

		/* 타입 */
		if ($('input:radio[name=s_type]:checked').val() != null) {
			document.getElementById('type').value = $(
					'input:radio[name=s_type]:checked').val();

		}

		/* 결제 방법을 담은 배열 */
		var payment = new Array();
		var payments = $('input:checkbox[name=s_payment]');
		var p_check = false;

		/*카테고리를 담은 배열  */
		var sub_cates = new Array();
		var cate_check = $('input:checkbox[name=s_cate]');
		var s_check = false;

		$.each(payments, function(i, item) {
			if ($(item).prop('checked')) {
				payment.push($(item).val());
				p_check = true;
			}

		});

		$.each(cate_check, function(i, item) {
			if ($(item).prop('checked')) {
				sub_cates.push($(item).val());
				s_check = true;
			}

		});
		if (p_check) {
			document.getElementById('payment').value = payment;

		}
		if (s_check) {
			document.getElementById('sub_cates').value = sub_cates;

		}
		/* 키워드*/
		if ($('#s_keyword').val() != null) {
			document.getElementById('keyWord').value = $('#s_keyword').val();

		}

		f.submit();
	}
</script>
<style type="text/css">
.content_body {
	background-image: url("../resources/template/배경6_2.png");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: top;
}  
 
.content_top {
	padding-top: 2%;
}

table {
	background-color: rgba(255, 255, 255, 0.5);
	text-align: center;
}

table th{
  background-color: #ffb74d;
  color:#EEEEEE;
  text-align: center;
}
</style>


</head>

<body>

	<!--수정을 위한 히든 값  -->
	<input type="hidden" id="m_a_id" class="popbutton3">


	<!-- 엑셀 다운로드 검색 파라미터 히든 값 설정-->
	<form method="POST" action="excelDownAccbook" id="excelDownAccbook">
		<input type="hidden" name="start_date" id="start_date"> <input
			type="hidden" name="end_date" id="end_date"> <input
			type="hidden" name="type" id="type"> <input type="hidden"
			name="sub_cates" id="sub_cates"> <input type="hidden"
			name="keyWord" id="keyWord"> <input type="hidden"
			name="payment" id="payment">


	</form>
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
				<a class="navbar-brand topnav" href="">MSM</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../newhome">HOME</a></li>
					<li><a href="Accbook">Accbook</a></li>
					<li><a href="../calendar/calendarMainView">Calendar</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


	<!-- Header -->
	<div class="content_body">
		<div class="content_top">
			<!-- 	search입력 -->
			<input type="date" id="s_start_date" class="form-control"
				style="width: 12%; float: left;">
				 <input type="date"
				id="s_end_date" class="form-control"
				style="width: 12%; float: left;"> <input type="button"
				class="btn btn-default" value="검색" id="search" style="float: left;">
 
 
			<!-- Modal 상세검색 -->
			<button class="btn btn-default" id="popbutton" style="margin-right: 14.5%; float: left;">상세검색</button>
 
			<form action="uploadAccbook" method="post" id="upload"
				enctype="multipart/form-data" style="float: left;">
 
   
				<span class="btn btn-default"
					onclick="document.getElementById('file').click();">Excel File
					<input type="file" id="file" name="file"
					style="display: none; float: left;" mutiple>
				</span>
  
			</form> 
			 <input type="text"
				id="readfile" class="form-control" placeholder="Excel File Upload..." readonly
				style="height: 6%; width: 23%; vertical-align:bottom; float: left;">
				<input type="button" value="Upload" Class="btn btn-default"
				onclick="upload()" style="float: left;">
		</div> 


		<script type="text/javascript">
			$(function() {

				// We can attach the `fileselect` event to all file inputs on the page
				$(document)
						.on(
								'change',
								':file',
								function() {
									var input = $(this), numFiles = input
											.get(0).files ? input.get(0).files.length
											: 1, label = input.val().replace(
											/\\/g, '/').replace(/.*\//, '');
									input.trigger('fileselect', [ numFiles,
											label ]);
								});

				// We can watch for our custom `fileselect` event like this
				$(document)
						.ready(
								function() {
									$(':file')
											.on(
													'fileselect',
													function(event, numFiles,
															label) {

														var input = $('#readfile'), log = numFiles > 1 ? numFiles
																+ ' files selected'
																: label;

														if (input.length) {
															input.val(log);
														} else {
															if (log)
																alert(log);
														}

													});
								});

			});
		</script>

		<br><br>
		<div class="content_left">

			<!--테이블 영역  -->
			<input type="hidden" name="page" id="page" value="1"> <input
				type="button" class="btn btn-default" onclick="excelDown()"
				value="엑셀다운로드" style="margin-left: 3%; float: left;">
			<button id="deleteAccbook" class="btn btn-default"
				onclick="deleteAccbook()" style="float: right;">삭제</button>
			<button class="popbutton3 btn btn-default" style="float: right;">수정</button>
			<button class="btn btn-default" id="popbutton1" style="float: right;">등록</button>
			<div id="tablediv" style="padding-left: 3%;"></div>


			<div align="center" id="pagingdiv" class="w3-bar"></div>

		</div>

		<div class="content_right">

			<div class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- remote ajax call이 되는영역 -->

					</div>
				</div>
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
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev" id="left"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next" id="rigth2"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>

			</div>
		</div>
		<!-- 페이징 영역 -->

	</div>





	<!-- Footer -->
	<footer>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="list-inline">
					<li><a href="#">Home</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#">About</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#">Services</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#">Contact</a></li>
				</ul>
				<p class="copyright text-muted small">Copyright &copy; SCMaster
					C Class 2Group.</p>
			</div>
		</div>
	</div>
	</footer>
</body>

</html>
