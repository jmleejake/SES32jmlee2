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

<style type="text/css">
.content_body {
	background-image: url("../resources/template/배경3_2.png");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
}

#targetmain_div {
	display: inline-block;
}

#target_div {
	width: 500px;
	height: 300px;
	overflow: auto;
}

#targetacc_div {
	width: 580px;
	height: 500px;
	overflow: auto;
	display: inline-block;
	height: auto;
}

.acc_in {
	border: 3px double rgba(244, 67, 54, 0.7);
	padding: 10px;
	width: 40%;
	height: 20%;
	display: inline-block;
	text-align: center;
	padding: 10px;
	overflow: scroll;
	color: white;
}

.acc_out {
	border: 3px double #ffea00;
	padding: 10px;
	width: 40%;
	height: 20%;
	display: inline-block;
	text-align: center;
}
</style>
</head>
<script>
	function w3_open() {
		document.getElementById("mySidebar").style.display = "block";
	}
	function w3_close() {
		document.getElementById("mySidebar").style.display = "none";
	}
</script>
<script>
	$(document).ready(function() {
		// 타겟리스트 초기화
		getTarget();

		$("#btn_search").on("click", function() {
			if ($("#tar_search").val() == "") {
				alert("검색어를 입력하세요");
				return;
			}

			getTarget();
		});
	});

	function getTarget() {
		$.ajax({
			url : "showTarget",
			type : "post",
			data : {
				search_val : $("#tar_search").val()
			},
			dataType : "json",
			success : showTarget,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	function showTarget(list) {
		$("#target_div").html("");
		var tableContent = "";
		tableContent += "<table>";
		tableContent += "<tr>";
		tableContent += "<th>그룹</th>";
		tableContent += "<th>이름</th>";
		tableContent += "<th>생년</th>";
		tableContent += "<th></th>";
		tableContent += "</tr>";
		$
				.each(
						list,
						function(i, target) {
							tableContent += "<tr>";
							tableContent += "<td>" + target.t_group + "</td>";
							tableContent += "<td><a class='showAcc' style='cursor:pointer;' t_id='" + target.t_id + "'>"
									+ target.t_name + "</a></td>";
							// 		tableContent += "<td><a href='getTargetAccList?t_id='" + target.t_id + ">" + target.t_name + "</a></td>";
							tableContent += "<td id='td_birth" + target.t_id + "'>"
									+ target.t_birth + "</td>";
							tableContent += "<td><input type='button' class='tar_birth' t_id='" + target.t_id + "' value='생년 입력'></td>";
							tableContent += "</tr>";
						});

		tableContent += "</table>";
		$("#target_div").html(tableContent);

		var t_id = "";
		$(".tar_birth")
				.on(
						"click",
						function() {
							t_id = $(this).attr("t_id");
							var birthContent = "";
							birthContent += "<input type='text' id='tx_birth" + t_id + "' style='width:50px;' placeholder='생년'>";
							birthContent += "<input type='button' value='저장' id='btn_tx_birth" + t_id + "' style='width:50px;'>";
							$("#td_birth" + t_id).html(birthContent);

							$("#btn_tx_birth" + t_id).on("click", function() {
								$.ajax({
									url : "updateBirth",
									type : "post",
									dataType : "json",
									data : {
										birth : $("#tx_birth" + t_id).val(),
										t_id : t_id
									},
									success : showTarget,
									error : function(e) {
										alert(JSON.stringify(e));
									}
								});
							}); // 생년 저장버튼 클릭시
						}); // 생년 입력버튼 클릭시

		$(".showAcc").on("click", showAccList);
	}

	function showAccList() {
		$.ajax({
			url : "getTargetAccList",
			type : "post",
			dataType : "json",
			data : {
				t_id : $(this).attr("t_id")
			},
			success : function(list) {
				var accContent = "";
				/*
				accContent += "<table>";
				accContent += "<tr>";
				accContent += "<th>일자</th>";
				accContent += "<th>경조사</th>";
				accContent += "<th>소속</th>";
				accContent += "<th>이름</th>";
				accContent += "<th>금액</th>";
				accContent += "</tr>";
				$.each(list, function(i, targetAcc) {
					accContent += "<tr>";
					accContent += "<th>" + targetAcc.ta_date + "</th>";
					accContent += "<th>" + targetAcc.ta_memo + "</th>";
					accContent += "<th>" + targetAcc.t_group +"</th>";
					accContent += "<th>" + targetAcc.t_name + "</th>";
					accContent += "<th>" + targetAcc.ta_price + "</th>";
					accContent += "</tr>";
				});
				accContent += "</table>";
				 */

				/*
				경조사의 특성상 오가는 수가 많지 않으니 
				수입과 지출로 나누어 테이블이 아닌  둥근네모로 표기
				 */
				$.each(list, function(i, targetAcc) {
					if (targetAcc.ta_type == 'INC') {
						accContent += "<p class='acc_in'>";
						accContent += targetAcc.ta_memo + "<br>";
						accContent += targetAcc.ta_price + "<br>";
						accContent += targetAcc.ta_date + "<br>";
						accContent += "</p>";
					} else if (targetAcc.ta_type == 'OUT') {
						accContent += "<p class='acc_out'> ";
						accContent += targetAcc.ta_memo + "<br>";
						accContent += targetAcc.ta_price + "<br>";
						accContent += targetAcc.ta_date + "<br>";
						accContent += "</p>";
					}

				});
				$("#targetacc_div").html(accContent);
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
</script>



<body>

	<!-- Navigation -->
	<div class="navbar navbar-default navbar-fixed-top topnav"
		role="navigation">
		<!-- Sidebar -->
		<div class="w3-sidebar w3-bar-block w3-border-right"
			style="display: none;" id="mySidebar">
			<button onclick="w3_close()" class="w3-bar-item w3-large">Close
				&times;</button>

			<c:if test="${loginID!=null && checkDelteNumber==null}">
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal">회원 정보 수정</button>
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal2">회원 정보 탈퇴</button>
			</c:if>

			<c:if test="${checkDelteNumber!=null}">
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#exampleModal">회원 정보 수정</button>
				<button type="button" class="btn btn-primary" data-toggle="modal"
					data-target="#exampleModal3">회원 정보 탈퇴</button>
			</c:if>
			<!-- 경조사관리 -->
			<a href="../target/excelTest" class="w3-bar-item w3-button">경조사
				관리</a>
		</div>
		<a class="navbar-brand topnav" href="javascript:w3_open()"><img
			src="../resources/user_settingIcon.png" style="height: 30px;">
		</a> <a class="navbar-brand topnav" href="./newhome">MSM</a>
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>

			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./newhome">HOME</a></li>
					<li><a href="./accbook/Accbook">Account</a></li>
					<li><a href="./calendar/calendarMainView">Calendar</a></li>
					<li><a href="userLogout">LogOut</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


	<!-- Body -->
	<div class="content_body">
		<div class="content_top">
			<form action="excelUpload" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="t_id" value="2"> <input
					type="hidden" name="t_name" value="jmlee"> <input
					type="file" name="upload" style="float: left;"><input
					type="submit" value="엑셀업로드" style="float: left;">
				<div style="color: red; font-size: 20px;">${up_ret }</div>
			</form>
			<input type="button" value="샘플다운로드"
				onclick="location.href='sampleDown'" style="float: left;"> <input
				type="button" value="엑셀 다운로드 기능 테스트"
				onclick="location.href='excelDown'" style="float: left;">
		</div>
		<br>
		<div class="content_left">
			<div id="targetmain_div">
				<input type="text" id="tar_search"><input type="button"
					id="btn_search" value="검색">
				<div id="target_div"></div>
			</div>
		</div>
		<div class="content_right">
			<div id="targetacc_div"></div>
		</div>




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