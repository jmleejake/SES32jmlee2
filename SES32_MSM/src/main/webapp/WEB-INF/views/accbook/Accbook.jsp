<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<%@ page session="true"%>

<html>
<head>

<!-- stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css" />

<!-- javascript -->
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Account Book</title>

<!-- icon CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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

<!-- jqueryui -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<!-- jquery  -->
<!-- <script src="../resources/js/jquery-3.1.1.min.js"></script> -->


<!-- modal -->
<!-- <script src="//code.jquery.com/jquery-1.11.0.min.js"></script> -->
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
/* 차트 타이틀 */
.c3-title {
	fill: black; /* titlecolor */
	font-size: 20px;
} 

.c3-axis-x .tick {
	display: none;
}

.c3-legend-item {
	/* item size */
	font-size: 15px;
}

.c3 svg {
	/* bar chart y axis size */
	font: 13px sans-serif;
	background-color: rgba(255, 255, 255, 0.7);
}

/* .c3-axis-y .tick, .c3 .c3-axis-y path, .c3 .c3-axis-y line {
	stroke: #8cff66;
}

.c3 .c3-axis-x path, .c3 .c3-axis-x line {
	stroke: #8cff66;
} */
</style>
<!-- alert창 CSS -->
<script
	src="../resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>


<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />

<script>
	/*사이드바 script  */
	function w3_open() {
		document.getElementById("mySidebar").style.display = "block";
	}

	function w3_close() {
		document.getElementById("mySidebar").style.display = "none";
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
			alertify.set({
				labels : {
					ok : "확인",
					cancel : "취소"
				}
			});

			var a_ids = $('input:checkbox[name=deleteCheck]');
			var a_id;
			var check = 0;
			$.each(a_ids, function(i, item) {
				if ($(item).prop('checked')) {
					check++;
				}

			});

			if (check >= 2 || check == 0) {
				alertify.alert("수정할 내역을 확인해주세요.");

				return;
			}

			$.each(a_ids, function(i, item) {
				if ($(item).prop('checked')) {
					a_id = $(item).val();
				}

			});

			if (a_id.substr(0, 1) == 'G') {

				alertify.alert("경조사는 경조사 관리에서 수정 가능합니다.");
				return;

			}
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
		var type = $('#type').val();
		/* 결제 방법을 담은 배열 */
		var payment = $('#payment').val();

		/*카테고리를 담은 배열  */
		var sub_cates = $('#sub_cates').val();

		var keyWord = $('#keyWord').val();

		if (start_date > end_date) {
			alertify.alert("날짜를 확인해주세요.");
			return;
		}

		var page = $('#page').val();

		$('#model_close').trigger('click');
		$('#model_close2').trigger('click');
		$('#model_close3').trigger('click');
		jQuery.ajaxSettings.traditional = true;

		//차트 내용 조회
		$.ajax({
			url : 'getAccbook2',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
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
			}
		});

		//테이블 내용 조회
		$.ajax({
			url : 'getAccbook',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
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
		var str = '<table id="table1" class="table"><thead> <tr> <th><input type="checkbox" id="allCheck"><th>날짜 <th>유형<th>카테고리<th>결제수단<th>항목<th>금액</tr></thead><tbody>';
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
					+ '<input type="hidden" name="a_id" value="'
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
				+ ')" class="w3-button w3-hover-purple">&laquo;</a>';
		for (var i = start; i <= end; i++) {
			str2 += '<a href="javascript:formSubmit(' + i
					+ ')" class="w3-button w3-hover-blue"> ' + i + ' </a>';
		}
		str2 += '<a href="javascript:formSubmit(' + m1
				+ ')" class="w3-button w3-hover-orange">&raquo;</a>';
		$('#pagingdiv').html(str2);
	}
	//차트 출력
	function output2(hm) {

		if (hm.size != 0) {
			pieChart(hm);
			colunmChart(hm);
			colunmChart2(hm);
		}
		if (hm.size == 0) {
			$('.silder').html('test');
		}
	}
	function pieChart(ob2) {

		var pieData = {
			고정지출 : ob2.fixed_out,
			지출 : ob2.out,
			고정수입 : ob2.fixed_in,
			수입 : ob2.in1
		};
		var type;
		var list;
		var chartpie = c3
				.generate({
					bindto : "#piechart",
					data : {
						json : [ pieData ],
						keys : {
							value : Object.keys(pieData),
						},
						type : "pie",
						onclick : function(d) {
							var barData = {};
							var keyname = '';
							if (d.id == "고정수입") {
								type = "고정수입";
								list = ob2.fixed_in_list;
								$
										.each(
												list,
												function(i, item) {
													i++;
													barData[keyname + i + " "
															+ item.a_memo] = item.price;
												});
							}
							if (d.id == "고정지출") {
								type = "고정지출";
								list = ob2.fixed_out_list;
								$
										.each(
												list,
												function(i, item) {
													i++;
													barData[keyname + i + " "
															+ item.a_memo] = item.price;
												});
							}
							if (d.id == "지출") {
								type = "지출";
								list = ob2.out_list;
								$
										.each(
												list,
												function(i, item) {
													i++;
													barData[keyname + i + " "
															+ item.a_memo] = item.price;

												});
							}
							if (d.id == "수입") {
								type = "수입";
								list = ob2.in_list;
								$
										.each(
												list,
												function(i, item) {
													i++;
													barData[keyname + i + " "
															+ item.a_memo] = item.price;

												});
							}
							var chartbar = c3.generate({
								bindto : "#piechart",

								data : {
									json : [ barData ],
									keys : {
										value : Object.keys(barData),
									},
									type : "bar",
									onclick : function(d) {
										$('#search').trigger('click');
									}
								},
								title : {
									text : type
								},

								bar : {
									width : {
										ratio : 0.8
									// this makes bar width 50% of length between ticks
									}

								},
								tooltip : {
									format : {
										title : function(x) {
											return type
										}
									}
								}
							});
						}
					},
					title : {
						text : "수입 지출 현황"
					},

					tooltip : {
						format : {
							value : function(value, ratio, id) {
								return d3.format(',')(value) + "원";
							}

						}
					}
				});

	}

	function colunmChart(ob2) {
		/* 데이터 만들기  */

		var colunmData = {
			수입 : ob2.fixed_in + ob2.in1,
			지출 : ob2.fixed_out + ob2.out
		};
		var chartpie = c3.generate({
			bindto : "#columnchart_values",

			data : {
				json : [ colunmData ],
				keys : {
					value : Object.keys(colunmData),
				},
				type : "bar",
			},
			title : {
				text : "수입 지출 현황"
			},

			tooltip : {
				format : {

					title : function(x) {
						return '수입 지출'
					},

					value : function(value, ratio, id) {
						return d3.format(',')(value) + "원";
					}

				}
			},
			bar : {
				width : {
					ratio : 0.5
				}
			}

		});

	}

	function colunmChart2(ob2) {
		/* 데이터 만들기  */

		var list = ob2.list;

		var colunmData = {
			일위 : ob2.list[0].price,
			이위 : ob2.list[1].price,
			삼위 : ob2.list[2].price
		};

		var chartpie = c3.generate({
			bindto : "#columnchart_values2",

			data : {
				json : [ colunmData ],
				keys : {
					value : Object.keys(colunmData),
				},
				type : "bar",
			},
			title : {
				text : "상위 BEST 3 항목"
			},

			tooltip : {
				format : {

					title : function(x) {
						return '상위 BEST 3 항목'
					},
					name : function(name, ratio, id, index) {
						if (id == '일위') {

							return list[0].a_memo + "(" + list[0].sub_cate
									+ ")";
						}
						if (id == '이위') {
							return list[1].a_memo + "(" + list[1].sub_cate
									+ ")";
						}
						if (id == '삼위') {
							return list[2].a_memo + "(" + list[2].sub_cate
									+ ")";

						}
						return null;

					},
					value : function(value, ratio, id) {
						return d3.format(',')(value) + "원";
					}

				}
			}
		});

	}
</script>

<script>
	/* 엑셀 파일로 등록 */
	function upload() {
		if ($('#file').val() == '') {
			alertify.alert("엑셀 파일을 등록해주세요");
			return;
		}
		document.getElementById('upload').submit();
	}
	/* 가계부 삭제  */
	function deleteAccbook() {

		var checkflag = false;
		var checkflag2 = false;
		var deleteCheck = $('input:checkbox[name=deleteCheck]');

		/*카테고리를 담은 배열  */
		var a_id = new Array();

		/* 체크된 내역만   */
		$.each(deleteCheck, function(i, item) {
			if ($(item).prop('checked')) {
				a_id.push($(item).val());
				checkflag = true;

			}

		});

		$.each(a_id, function(i, item2) {

			if (item2.substr(0, 1) == 'G') {
				alertify.alert("경조사는 경조사 관리에서 삭제 가능합니다.");
				checkflag2 = true;
				return;
			}

		});

		if (!checkflag) {
			alertify.alert("삭제할 내역을 체크해주세요");
			return;
		}

		if (!checkflag2) {
			alertify.set({
				labels : {
					ok : "확인",
					cancel : "취소"
				}
			});
			alertify.set({
				buttonReverse : true
			})

			alertify.confirm("정말로 삭제 합니까?", function(e) {
				if (e) {
					$.ajax({
						url : 'deleteAccbook',
						type : 'POST',
						//서버로 보내는 parameter
						data : {
							a_id : a_id
						},
						success : deleteResult,
						error : function(e) {
						}
					});
				} else {
					// user clicked "cancel"
				}
			});
		}

	}

	function deleteResult() {
		alertify.success("삭제 되었습니다.");

		search();
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

table {
	background-color: rgba(255, 255, 255, 0.7);
	text-align: center;
}

table th {
	background-color: #ffb74d;
	color: #EEEEEE;
	text-align: center;
}

.carousel-inner>.item>p {
	width: 90%;
	height: 400px;
	margin: auto;
}

.carousel-control.right {
	background-image: none;
}

.carousel-control.left {
	background-image: none;
}

.content_left {
	overflow-y: auto;
}
</style>


</head>

<body>
	<c:if test="${errorMsg!=null}">
		<script>
			alertify.success('${errorMsg}');
		</script>
	</c:if>
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
		<!-- Sidebar -->
		<div class="w3-sidebar w3-bar-block w3-border-right"
			style="display: none;" id="mySidebar">
			<button onclick="w3_close()" class="w3-bar-item w3-large">Close
				&times;</button>

			<!-- 로그인 시의 시행 가능 버튼 출력 -->
			<c:if test="${loginID !=null }">
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal">
					<i class="fa fa-user-circle-o"></i>회원 정보 수정
				</button>
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal2">
					<i class="fa fa-exclamation-triangle"></i>회원 정보 탈퇴
				</button>
				<a href="user/householdAccount" class="w3-bar-item w3-button"><i
					class="fa fa-krw"></i>비상금 관리 내역</a>
			</c:if>

			<!-- 경조사관리 -->
			<a href="./target/excelTest" class="w3-bar-item w3-button"><i
				class="fa fa-address-book-o"></i> 경조사 관리</a>
		</div>

		<a class="navbar-brand topnav" href="javascript:w3_open()"><img
			src="../resources/user_settingIcon.png" style="height: 30px;">
		</a>

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
					<li><a href="#contact">LogOut</a></li>
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
				style="width: 13%; float: left;"> <input type="date"
				id="s_end_date" class="form-control"
				style="width: 13%; float: left;"> <input type="button"
				class="btn btn-default" value="검색" id="search" style="float: left;">


			<!-- Modal 상세검색 -->
			<button class="btn btn-default" id="popbutton"
				style="margin-right: 11%; float: left;">상세검색</button>

			<form action="uploadAccbook" method="post" id="upload"
				enctype="multipart/form-data" style="float: left;">

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="btn btn-default"
					onclick="document.getElementById('file').click();">파일 찾기 <input
					type="file" id="file" name="file"
					style="display: none; float: left;" mutiple>
				</span>

			</form>


			<input type="text" id="readfile" class="form-control"
				placeholder="Excel File Upload..." readonly
				style="width: 23%; vertical-align: bottom; float: left;"> <input
				type="button" value="업로드" Class="btn btn-default" onclick="upload()"
				style="float: left;"> <input type="button" value="샘플다운로드"
				Class="btn btn-default" onclick="location.href='sampleDown2'"
				style="float: left;">
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
															if (log) {

															}
														}

													});
								});

			});
		</script>


		<div class="content_left">

			<!--테이블 영역  -->
			<input type="hidden" name="page" id="page" value="1"> <input
				type="button" class="btn btn-default" onclick="excelDown()"
				value="엑셀다운로드" style="margin-left: 5%; float: left;">
			<button id="deleteAccbook" class="btn btn-default"
				onclick="deleteAccbook()" style="float: right;">삭제</button>
			<button class="popbutton3 btn btn-default" style="float: right;">수정</button>
			<button class="btn btn-default" id="popbutton1" style="float: right;">등록</button>

			<div id="tablediv" style="margin-left: 5%; height: 85%;"></div>


			<div align="center" id="pagingdiv" class="w3-bar w3-large"></div>

		</div>

		<div class="content_right">

			<div class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content" style="width: 500px">
						<!-- remote ajax call이 되는영역 -->

					</div>
				</div>
			</div>



			<!-- 차트 슬라이더 -->

			<div id="carousel-example-generic" class="carousel slide"
				data-ride="carousel" data-interval="false"
				style="width: 95%; height: 90%; margin-right: 5%; margin-top: 5%;"> 
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
