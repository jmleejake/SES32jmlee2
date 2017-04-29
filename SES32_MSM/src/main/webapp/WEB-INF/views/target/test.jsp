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

<!-- W3School CSS -->
<link rel="stylesheet" href="../resources/PageCSS/targetjsp.css">

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

<!-- jQuery -->
<script src="../resources/template/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../resources/template/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>

<!-- alertify -->
<script
	src="../resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>
<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />
<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />


<!-- modal -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.w3-button {
	background-color: rgba(255, 255, 255, 0.7);
	border-radius: 10px;
	margin-right: 10px;
}

.edit, .del {
	font-size: 24px;
}
</style>

</head>
<script>
//회원 수정 모달창열기
$(function() {
	$("#userUpdatemodal").click(function() {
		$('#user_update_content').empty();
		
		$('#user_update_modal').modal({
			remote : '../user/userUpdatemodal'
		});
	});
});
	function w3_open() {
		document.getElementById("mySidebar").style.display = "block";
	}
	function w3_close() {
		document.getElementById("mySidebar").style.display = "none";
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						// 타겟리스트 초기화
						getTarget();

						// 검색
						$("#btn_search").on("click", function() {
							getTarget();
						});

						// 경조사 가계부 등록버튼 클릭시
						$("#btn_acc_create").on("click", addAccbook);

						// 등록창의 타겟설정 버튼 클릭시
						$("#set_acc_target").on("click", function() {
							// 타겟리스트 초기화
							getAccTarget();

							// 검색
							$("#btn_acc_search").on("click", function() {
								getAccTarget();
							});
						});

						// 등록창의 장소설정 버튼 클릭시
						$("#set_acc_location")
								.on(
										"click",
										function() {
											window
													.open(
															"http://localhost:8888/msm/user/showMap",
															"",
															"width=1000, height=500, status=1, location=no");
										});

						// 타겟등록시 닫기버튼 클릭시
						$("#btn_reg_close").on("click", targetRegistInit);

						// 경조사 가계부 등록시 닫기버튼 클릭시
						$("#btn_acc_close").on("click", accRegistInit);

					});

	// 메인화면 타겟리스트 얻기
	function getTarget(p) {
		$("#page").val(p);
		$.ajax({
			url : "showTarget",
			type : "post",
			data : $("#frm").serialize(),
			dataType : "json",
			success : showTarget,
			error : function(e) {
				alertify.error("타겟리스트 얻기 실패!!");
			}
		});
	}

	// 메인화면 타겟리스트 출력
	function showTarget(data) {
		var start = data.startPageGroup;
		var end = data.endPageGroup;
		var currentPage = data.currentPage;

		$("#target_div").html("");
		var tableContent = "";
		tableContent += '<table id="target_table" class="table table-hover">';
		tableContent += "<thead>";
		tableContent += "<tr>";
		tableContent += "<th>그룹</th>";
		tableContent += "<th>이름</th>";
		tableContent += "<th>생년월일</th>";
		tableContent += "<th>수정/삭제</th>";
		tableContent += "</tr>";
		tableContent += "</thead>";
		$
				.each(
						data.list,
						function(i, target) {
							tableContent += "<tr>";
							tableContent += "<td>" + target.t_group + "</td>";
							tableContent += "<td><a class='showAcc' t_id='" + target.t_id 
			+ "' t_name='" + target.t_name + "' t_group='" + target.t_group + "' t_birth='" + target.t_birth + "'>"
									+ target.t_name + "</a></td>";
							tableContent += "<td>" + target.t_birth + "</td>";
							tableContent += "<td><i class='edit fa fa-edit' data-toggle='modal' data-target='#targetEditModal' t_id='" + target.t_id 
							+ "' t_name='" + target.t_name + "' t_group='" + target.t_group + "' t_birth='" + target.t_birth + "'>"
									+ "</i><i class='del fa fa-trash-o' t_id='" + target.t_id + "'></i></td>";
							tableContent += "</tr>";
						});
		tableContent += "</table>";
		$("#target_div").html(tableContent);

		//페이징	
		var str2 = ' ';
		var m2 = currentPage - 5;
		var m1 = currentPage + 5;
		str2 += '<a href="javascript:getTarget(' + m2
				+ ')" class="w3-button w3-hover-purple">&laquo;</a>';
		for (var i = start; i <= end; i++) {
			str2 += '<a href="javascript:getTarget(' + i
					+ ')" class="w3-button w3-hover-blue"> ' + i + ' </a>';
		}
		str2 += '<a href="javascript:getTarget(' + m1
				+ ')" class="w3-button w3-hover-orange">&raquo;</a>';
		$('#target_pag_div').html(str2);

		// 타겟리스트 항목(이름) 클릭시
		$(".showAcc").on("click", function() {
			showAccList($(this).attr("t_id"), "");
		});
		$(".edit").on("click", function() {
			$("#e_group").val($(this).attr("t_group"));
			$("#e_name").val($(this).attr("t_name"));
			$("#e_birth").val($(this).attr("t_birth"));
			$("#e_id").val($(this).attr("t_id"));
		});
		$(".del").on("click", function() {
			deleteTarget($(this).attr("t_id"));
		});
	}

	// 타겟관련 가계부 출력
	var show_tid = "";
	function showAccList(id, type) {
		show_tid = id;
		
		$.ajax({
					url : "getTargetAccList",
					type : "post",
					dataType : "json",
					data : {
						t_id : id
						, ta_type : type
					},
					success : TargetAccList,
					error : function(e) {
						alertify.error("가계부 출력 실패!!");
					}
				});
	}
	
	function TargetAccList(list) {
		var content = list;
		var accContent = "";
		var viewt_content = '';
		/*
		경조사의 특성상 오가는 수가 많지 않으니 
		수입과 지출로 나누어 테이블이 아닌  둥근네모로 표기
		 */
		 viewt_content +=
				'<button id="btn_total" class="btn btn-default w3-hover-black"><i class="fa fa-square"></i>전체</button>'
				+'<button id="btn_inSC" class="btn btn-default w3-hover-blue"><i class="fa fa-square" style="color: #2196f3;"></i>수입</button>'
				+'<button id="btn_outSC" class="btn btn-default w3-hover-deep-orange"><i class="fa fa-square" style="color: #ff5722;"></i>지출</button>';
			
				$("#btn_div").html(viewt_content);
				
				$.each(list,function(i, targetAcc) {
					if (targetAcc.ta_type == 'INC') {
						accContent += '<div class="acc_in w3-card-4" style="width: 40%">';
						accContent += '<header class="w3-container w3-center w3-blue">';
						accContent += '<h5><a class="goCal" style="cursor:pointer;" id='+ targetAcc.t_id + ' start_date=' + targetAcc.ta_date + '>'
								+ targetAcc.ta_memo
								+ '</a></h5></header>';
						accContent += '<div class="w3-container w3-center w3-white">';
						accContent += '<h5>'
								+ targetAcc.ta_price
								+ '</h5>';
						accContent += '<h5>'
								+ targetAcc.ta_date
								+ '</h5>';
						accContent += '</div></div>';

					} else if (targetAcc.ta_type == 'OUT') {	
						accContent += '<div class="acc_in w3-card-4" style="width: 40%">';
						accContent += '<header class="w3-container w3-center w3-deep-orange">';
						accContent += '<h5><a class="goCal" style="cursor:pointer;" id='+ targetAcc.t_id + ' start_date=' + targetAcc.ta_date + '>'
								+ targetAcc.ta_memo
								+ '</a></h5></header>';
						accContent += '<div class="w3-container w3-center w3-white">';
						accContent += '<h5>'
								+ targetAcc.ta_price
								+ '</h5>';
						accContent += '<h5>'
								+ targetAcc.ta_date
								+ '</h5>';
						accContent += '</div></div>';
						
					}
				});
				
				$("#btn_total").on("click", function() {
					showAccList(show_tid, "");
				}); 
				$("#btn_inSC").on("click", function() {
					showAccList(show_tid, "INC");
				});
				$("#btn_outSC").on("click", function() {
					showAccList(show_tid, "OUT");
				});
		 
		accContent += "<form id='frm_tar' method='post' action='../calendar/calendarMainView'>";
		accContent += "<input type='hidden' id='c_id' name='id' >";
		accContent += "<input type='hidden' id='start_date' name='start_date' >";
		accContent += "<form>";

		$("#targetacc_div").html(accContent);

		// 제목 클릭시
		$(".goCal").on("click", function() {
			$("#c_id").val($(this).attr("id"));
			$("#start_date").val($(this).attr("start_date"));
			$("#frm_tar").submit();
		});
		
		
	}

	// 경조사 타겟정보 수정
	function updateTarget() {
		if (isNaN($("#e_birth").val())) {
			alertify.alert("생년은 숫자로 입력되어야 합니다.");
			return;
		}

		var id = $("#e_id").val();
		var name = $("#e_name").val();
		var group = $("#e_group").val();
		var birth = $("#e_birth").val();
		$.ajax({
			url : "updateTarget",
			type : "post",
			dataType : "json",
			data : {
				t_id : id,
				t_name : name,
				t_group : group,
				t_birth : birth
			},
			success : function(data) {
				if (data > 0) {
					alertify.success("수정되었습니다.");
					getTarget();
					$('#btn_edit_close').trigger('click');
				}
			},
			error : function(e) {
				alertify.error("수정 실패!!");
			}
		});
	}

	// 경조사 타겟정보 삭제
	function deleteTarget(id) {
		alertify.set({
			labels : {
				ok : "확인",
				cancel : "취소"
			}
		});
		alertify.set({
			buttonReverse : true
		});

		alertify.confirm("정말로 삭제 합니까?", function(ok) {
			if (ok) {
				$.ajax({
					url : "deleteTarget",
					type : "post",
					dataType : "json",
					data : {
						t_id : id
					},
					success : function(data) {
						if (data == 1) {
							getTarget();
						}
						// 우측화면 초기화
						$("#targetacc_div").html("");
						$("#t_manipulate_div").html("");
					},
					error : function(e) {
						alertify.error("삭제 실패!!");
					}
				});
			}
		});
	}

	// 경조사 가계부 등록
	function addAccbook() {
		console.log("addAccbook");
		if ($("#ta_date").val() == "") {
			alertify.alert("날짜와 시간이 함께 입력되어야 합니다.");
			return;
		}

		if ($("#ta_memo").val() == "") {
			alertify.alert("장소를 선택하지 않았습니다.");
			return;
		}

		if ($("#t_name").val() == "") {
			alertify.alert("타겟(대상자)를 선택하지 않았습니다.");
			return;
		}

		if ($("#ta_price").val() == "") {
			alertify.alert("금액을 입력하지 않았습니다.");
			return;
		}

		if (isNaN($("#ta_price").val())) {
			alertify.alert("금액은 숫자로 입력되어야 합니다.");
			return;
		}

		$.ajax({
			url : "addAccbook",
			type : "post",
			data : {
				ta_type : $("#ta_type").val(),
				ta_memo : $("#ta_memo").val(),
				ta_date : $("#ta_date").val(),
				t_id : $("#t_id").val(),
				ta_price : $("#ta_price").val(),
				t_name : $("#t_name").val(),
				t_url : $("#t_url").val(),
				address : $("#address").val()
			},
			success : function(data) {
				if (data > 0) {
					alertify.success("등록되었습니다.");
					accRegistInit();
					$('#btn_acc_close').trigger('click');
				}

			},
			error : function(e) {
				alertify.success("등록실패!!");
			}
		});
	}

	// 경조사 가계부 등록폼 초기화
	function accRegistInit() {
		// 초기화
		$("#ta_type").val("INC");
		$("#ta_memo").val("");
		$("#ta_date").val("");
		$("#t_id").val("");
		$("#ta_price").val("");
		$("#t_name").val("");
		$("#t_url").val("");
		$("#address").val("");
	}

	// 타겟등록폼 초기화
	function targetRegistInit() {
		$("#r_date").val("");
		$("#r_event").val("");
		$("#r_group").val("");
		$("#r_name").val("");
		$("#r_price").val("");
		$("#r_birth").val("");
	}

	// 등록시 타겟리스트 얻기
	function getAccTarget(p) {
		$("#reg_page").val(p);
		$.ajax({
			url : "showTarget",
			type : "post",
			data : {
				srch_val : $("#tar_acc_search").val(),
				srch_type : $("#srch_type").val(),
				page : $("#reg_page").val()
			},
			dataType : "json",
			success : showAccTargetList,
			error : function(e) {
				alertify.error("리스트 얻기 실패!!");
			}
		});
	}

	// 등록시 타겟리스트 출력
	function showAccTargetList(data) {
		var start = data.startPageGroup;
		var end = data.endPageGroup;
		var currentPage = data.currentPage;

		$("#targetlist_div").html("");
		var tableContent = "";
		tableContent += "<table class='table'>";
		tableContent += "<tr>";
		tableContent += "<th>그룹</th>";
		tableContent += "<th>이름</th>";
		tableContent += "<th>생년</th>";
		tableContent += "</tr>";
		$
				.each(
						data.list,
						function(i, target) {
							tableContent += "<tr>";
							tableContent += "<td>" + target.t_group + "</td>";
							tableContent += "<td><a class='target' style='cursor:pointer; color:black;' t_id='" + target.t_id + "' t_name='" + target.t_name + "'>"
									+ target.t_name + "</a></td>";
							tableContent += "<td>" + target.t_birth + "</td>";
							tableContent += "</tr>";
						});

		tableContent += "</table>";
		$("#targetlist_div").html(tableContent);

		//페이징	
		var str2 = ' ';
		var m2 = currentPage - 5;
		var m1 = currentPage + 5;
		str2 += '<a href="javascript:getAccTarget(' + m2
				+ ')" class="w3-button">&laquo;</a>';
		for (var i = start; i <= end; i++) {
			str2 += '<a href="javascript:getAccTarget(' + i
					+ ')" class="w3-button"> ' + i + ' </a>';
		}
		str2 += '<a href="javascript:getAccTarget(' + m1
				+ ')" class="w3-button">&raquo;</a>';
		$('#targetlist_pag_div').html(str2);

		$(".target").on("click", function() {
			$("#t_id").val($(this).attr("t_id"));
			$("#t_name").val($(this).attr("t_name"));
			$('#tar_srch_close').trigger('click');
		});

		$("#tar_acc_search").val("");
	}

	// 엑셀 파일 등록
	function upload() {
		if ($('#upload').val() == '') {
			alertify.alert("엑셀 파일을 등록해주세요");
			return;
		}
		$("#excel_upload").submit();
	}

	// 검색시 엔터키 입력시
	function pressEnter() {
		if (event.keyCode == 13) {
			getAccTarget(1);
		}
	}

	// 타겟 등록
	function addTarget() {
		if ($("#r_date").val() == "") {
			alertify.alert("경조사 일자를 선택하지 않았습니다.");
			return;
		}

		if ($("#r_event").val() == "") {
			alertify.alert("경조사명을 입력하지 않았습니다.");
			return;
		}

		if ($("#r_group").val() == "") {
			alertify.alert("그룹명을 입력하지 않았습니다.");
			return;
		}

		if ($("#r_name").val() == "") {
			alertify.alert("타겟(관리대상자)의 이름을 입력하지 않았습니다.");
			return;
		}

		if ($("#r_price").val() == "") {
			alertify.alert("금액을 입력하지 않았습니다.");
			return;
		}

		if (isNaN($("#r_price").val())) {
			alertify.alert("금액은 숫자로 입력되어야 합니다.");
			return;
		}

		// 등록진행
		$.ajax({
			url : "addTarget",
			type : "post",
			data : {
				t_name : $("#r_name").val(),
				t_group : $("#r_group").val(),
				t_birth : $("#r_birth").val(),
				ta_date : $("#r_date").val(),
				ta_memo : $("#r_event").val(),
				ta_price : $("#r_price").val()
			},
			dataType : "json",
			success : function(data) {
				if (data > 0) {
					alertify.success("등록되었습니다.");
					getTarget();
					$('#btn_reg_close').trigger('click');
				}
			},
			error : function(e) {
				alertify.error("등록 실패!!");
			}
		});

	}
</script>

<!--파일 업로드 이름 나오게 하는 js -->
<script type="text/javascript">
	$(function() {

		// We can attach the `fileselect` event to all file inputs on the page
		$(document).on(
				'change',
				':file',
				function() {
					var input = $(this), numFiles = input.get(0).files ? input
							.get(0).files.length : 1, label = input.val()
							.replace(/\\/g, '/').replace(/.*\//, '');
					input.trigger('fileselect', [ numFiles, label ]);
				});

		// We can watch for our custom `fileselect` event like this
		$(document)
				.ready(
						function() {
							$(':file')
									.on(
											'fileselect',
											function(event, numFiles, label) {

												var input = $('#readfile'), log = numFiles > 1 ? numFiles
														+ ' files selected'
														: label;

												if (input.length) {
													input.val(log);
												} else {
													if (log)
														alertify.alert(log);
												}

											});
						});

	});
</script>

<body>
	
		<div class="modal fade" id="user_update_modal">
				<div class="modal-dialog">
					<div class="modal-content" id="user_update_content" style="width: 500px">
						<!-- remote ajax call이 되는영역 -->

					</div>
				</div>
			</div>

	<c:if test="${up_ret != null }">
		<c:choose>
			<c:when test="${up_ret == 'ok' }">
				<script>
					alertify.success("등록 완료");
				</script>
			</c:when>
			<c:otherwise>
				<script>
					alertify.error("엑셀파일만 업로드 가능합니다.");
				</script>
			</c:otherwise>
		</c:choose>
	</c:if>
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
					data-toggle="modal" data-target="#exampleModal" id="userUpdatemodal">
					<i class="fa fa-user-circle-o"></i>회원 정보 수정
				</button>

				<a href="../user/householdAccount" class="w3-bar-item w3-button"><i
					class="fa fa-krw"></i>비상금 관리 내역</a>
			</c:if>

			<!-- 경조사관리 -->
			<a href="targetManage" class="w3-bar-item w3-button"><i
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
				<a class="navbar-brand topnav" href="./newhome">MSM</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../newhome">HOME</a></li>
					<li><a href="../accbook/Accbook">Account</a></li>
					<li><a href="../calendar/calendarMainView">Calendar</a></li>
					<li><a href="../user/userLogout">LogOut</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


	<!-- Body -->
	<div class="content_body">
		<div class="content_top">

			<form action="excelUpload" method="post" id="excel_upload"
				enctype="multipart/form-data" style="float: left;">

				<span class="btn btn-default"
					onclick="document.getElementById('upload').click();">파일찾기 <input
					type="file" id="upload" name="upload"
					style="display: none; float: left;">
				</span>
			</form>
			<input type="text" id="readfile" class="form-control" readonly
				placeholder="Excel File Upload..."
				style="width: 23%; vertical-align: bottom; float: left;"> <input
				type="submit" class="btn btn-default" style="float: left;"
				value="업로드" onclick="upload();"> <input type="button"
				class="btn btn-default" value="경조사 가계부 등록" data-toggle="modal"
				data-target="#targetAccModal"> <input type="button"
				class="btn btn-default" value="샘플다운로드"
				onclick="location.href='sampleDown'" style="float: left;">
		</div>

		<br>

		<!-- content_left -->
		<div class="content_left">
			<div id="table_button">
				<form id="frm">
					<select name="srch_type" class="form-control"
						style="width: 23%; float: left;">
						<option value="all">전체</option>
						<option value="grp">그룹</option>
						<option value="nm" selected="selected">이름</option>
						<option value="ev">이벤트</option>
					</select> <input type="text" class="form-control"
						style="width: 58%; float: left;" id="tar_search" name="srch_val">
					<input type="button" class="btn btn-default" style="float: left;"
						id="btn_search" value="검색"> <input type="button"
						class="btn btn-default" data-toggle="modal"
						data-target="#targetRegistModal" value="등록"> <input
						type="hidden" name="page" id="page" value="1">
				</form>
			</div>
			<!-- <div id="targetmain_div"></div> -->
			<!--target table div -->
			<div id="target_div"></div>

			<!--table page div -->
			<div align="center" id="target_pag_div" class="w3-bar w3-large"></div>

		</div>
		<!-- //content_left -->
 

		<!-- content_right -->
		<div class="content_right">
		
		<!-- 수입/지출 button -->   
			<div id="btn_div"></div>
			<div id="targetacc_div">
			
			<!-- <div class="w3-card-4 w3-white" style="width: 40%"> -->
			</div> 
				<!-- <div class="w3-container w3-center">
					<h5>John Doe</h5>
					<h6>50000</h6>
					<h6>2007-12-12</h6>
				</div> -->
			</div>
		</div>
		<!-- //content_right -->


		<!-- 경조사 가계부 등록 modal -->
		<div class="modal fade" id="targetAccModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="width: 350px;">
					<div class="modal-header">
						<h4 class="modal-title">경조사 가계부 등록</h4>
					</div>
					<div class="modal-body">
						<table>
							<tr>
								<td colspan="3"><select id="ta_type" class="form-control">
										<option value="INC">수입</option>
										<option value="OUT">지출</option>
								</select></td>
							</tr>
							<tr>
								<th>날짜</th>
								<td colspan="2"><input type="datetime-local" id="ta_date"
									class="form-control"></td>
							</tr>
							<tr>
								<th>장소</th>
								<td><input type="hidden" id="t_url"> <input
									type="hidden" id="address"> <input type="text"
									id="ta_memo" class="form-control" readonly="readonly"
									disabled="disabled"></td>
								<td><input type="button" class="btn btn-default"
									value="장소설정" id="set_acc_location"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="hidden" id="t_id"> <input
									type="text" id="t_name" class="form-control"
									readonly="readonly" disabled="disabled"></td>
								<td><input type="button" class="btn btn-default"
									value="타겟설정" id="set_acc_target" data-toggle="modal"
									data-target="#targetModal"></td>
							</tr>
							<tr>
								<th>금액</th>
								<td colspan="2"><input type="text" id="ta_price"
									class="form-control"></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn_acc_create" class="btn btn-default">확인</button>
						<button type="button" id="btn_acc_close" class="btn btn-default"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- //경조사 가계부 등록 modal -->

		<!-- 수정 modal -->
		<div class="modal fade" id="targetEditModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="width: 320px;">
					<div class="modal-header">
						<h4 class="modal-title">정보 수정</h4>
					</div>
					<div class="modal-body">
						<table>
							<tr>
								<td>그룹</td>
								<td><input type="text" class="form-control" id="e_group"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" class="form-control" id="e_name">
									<input type="hidden" id="e_id"></td>
							</tr>
							<tr>
								<th>생년</th>
								<td><input type="text" class="form-control" id="e_birth"
									placeholder="예)20071210"></td>
							</tr>

						</table>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn_edit_create" class="btn btn-default"
							onclick='updateTarget();'>확인</button>
						<button type="button" id="btn_edit_close" class="btn btn-default"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- //수정 modal -->

		<!-- 등록 modal -->
		<div class="modal fade" id="targetRegistModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="width: 320px;">
					<div class="modal-header">
						<h4 class="modal-title">타겟 등록</h4>
					</div>
					<div class="modal-body">
						<table>
							<tr>
								<td style="width: 80px;">경조사 일자</td>
								<td><input type="date" class="form-control" id="r_date"></td>
							</tr>
							<tr>
								<td>경조사명</td>
								<td><input type="text" class="form-control" id="r_event"></td>
							</tr>
							<tr>
								<td>그룹</td>
								<td><input type="text" class="form-control" id="r_group"></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input type="text" class="form-control" id="r_name"></td>
							</tr>
							<tr>
								<td>금액</td>
								<td><input type="text" class="form-control" id="r_price"></td>
							</tr>
							<tr>
								<td>생년</td>
								<td><input type="text" class="form-control" id="r_birth"
									placeholder="예)20071210"></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							onclick='addTarget();'>확인</button>
						<button type="button" id="btn_reg_close" class="btn btn-default"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- //등록 modal -->

		<!-- 타겟설정 modal -->
		<div class="modal fade" id="targetModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="width: 350px;">
					<div class="modal-header">
						<h4 class="modal-title">타겟설정</h4>
					</div>
					<div class="modal-body">
						<table>
							<tr>
								<td><select id="srch_type" class="form-control">
										<option value="all">전체</option>
										<option value="grp">그룹</option>
										<option value="nm" selected="selected">이름</option>
										<option value="ev">이벤트</option>
								</select></td>
								<td><input type="text" class="form-control"
									id="tar_acc_search" onkeydown="pressEnter();"></td>
								<td><input type="button" class="btn btn-default"
									id="btn_acc_search" value="검색"></td>
							</tr>
						</table>
						<div id="targetlist_div"></div>
						<div id="targetlist_pag_div" align="center"></div>
						<input type="hidden" id="reg_page">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
						<button type="button" id="tar_srch_close" class="btn btn-default"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- //타겟설정 modal -->
	</div>

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
</body>
</html>