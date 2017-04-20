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

th {
	text-align: center;
}

table {
	background-color: rgba(255, 255, 255, 0.5);
	text-align: center;
}

#targetmain_div {
	width: 100%;
	height: 100%;
	display: inline-block;
}

#target_div {
	width: 100%;
	height: 500px;
	overflow-y: auto; 
}

#targetacc_div {
	width: 100%;
	height: 100%;
	padding-top: 10%;
	overflow-y: auto;
	display: inline-block;
}

.acc_in {
	border: 5px double #ffbb33;
	min-height: 20px;
	padding: 10px;
	width: 40%;
	height: 20%;
	display: inline-block;
	text-align: center;
	padding: 10px;
	color: white;
	overflow-y: scroll;
}

.acc_out {
	border: 5px double #ff4444;
	min-height: 20px;
	padding: 10px;
	width: 40%;
	height: 20%;
	display: inline-block;
	text-align: center;
	padding: 10px;
	color: white;
}

#targetlist_div {
	width: 283px;
	height: 300px;
	overflow: auto;
}

th{
	width: 40px;
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
		
		// 경조사 가계부 등록버튼 클릭시
		$("#btn_acc_create").on("click", addAccbook);
		
		// 등록창의 타겟설정 버튼 클릭시
		$("#set_acc_target").on("click", function() {
			// 타겟리스트 초기화
			getAccTarget();

			$("#btn_acc_search").on("click", function() {
				if ($("#tar_acc_search").val() == "") {
					alert("검색어를 입력하세요");
					return;
				}

				getAccTarget();
			});
		});
		
		// 등록창의 장소설정 버튼 클릭시
		$("#set_acc_location").on("click", function() {
			window.open("http://localhost:8888/msm/user/mapAPI_Test3", "", "width=1000, height=500, status=1");
		});
	});

	// 메인화면 타겟리스트 얻기
	function getTarget() {
		$.ajax({
			url : "showTarget",
			type : "post",
			data : $("#frm").serialize(),
			dataType : "json",
			success : showTarget,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	// 메인화면 타겟리스트 출력
	function showTarget(list) {
		$("#target_div").html("");
		var tableContent = "";
		tableContent += '<table class="table table-hover">';
		tableContent += "<thead>";
		tableContent += "<tr>";
		tableContent += "<th>그룹</th>";
		tableContent += "<th>이름</th>";
		tableContent += "<th>생년</th>";
		tableContent += "<th></th>";
		tableContent += "</tr>";
		tableContent += "</thead>";
		$.each(list, function(i, target) {
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
		$(".tar_birth").on("click", function() {
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

		// 타겟리스트 항목(이름) 클릭시
		$(".showAcc").on("click", showAccList);
	}

	// 타겟관련 가계부 출력
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
	
	// 경조사 가계부 등록
	function addAccbook() {
	 	console.log("addAccbook");
		$.ajax({
			url : "addAccbook",
			type : "post",
			data : {
				ta_type:$("#ta_type").val()
				, ta_memo:$("#ta_memo").val()
				, ta_date:$("#ta_date").val()
				, t_id:$("#t_id").val()
				, ta_price:$("#ta_price").val()
				, t_name:$("#t_name").val()
				, t_url:$("#t_url").val()
			},
			success : function(data) {
				alert(data);
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
	
	// 등록시 타겟리스트 얻기
	function getAccTarget() {
		$.ajax({
			url:"showTarget"
				, type:"post"
				, data : {
					srch_val : $("#tar_acc_search").val()
					, srch_type : $("#srch_type").val()
				}
				, dataType : "json"
				, success:showAccTargetList
				, error:function(e) {
					alert(JSON.stringify(e));
				} 
		});
	}
	
	// 등록시 타겟리스트 출력
	function showAccTargetList(list) {
		$("#targetlist_div").html("");
		var tableContent = "";
		tableContent += "<table>";
		tableContent += "<tr>";
		tableContent += "<th>그룹</th>";
		tableContent += "<th>이름</th>";
		tableContent += "<th>생년</th>";
		tableContent += "</tr>";
		$.each(list, function(i, target) {
			console.log(target);
			tableContent += "<tr>";
			tableContent += "<td>" + target.t_group + "</td>";
			tableContent += "<td><a class='target' style='cursor:pointer;' t_id='" + target.t_id + "' t_name='" + target.t_name + "'>" + target.t_name + "</a></td>";
			tableContent += "<td>" + target.t_birth + "</td>";
			tableContent += "</tr>";
		});
		
		tableContent += "</table>";
		$("#targetlist_div").html(tableContent);
		
		$(".target").on("click", function() {
			$("#t_id").val($(this).attr("t_id"));
			$("#t_name").val($(this).attr("t_name"));
			$('#tar_srch_close').trigger('click');
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
														alert(log);
												}

											});
						});

	});
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
					<li><a href="../newhome">HOME</a></li>
					<li><a href="../accbook/Accbook">Account</a></li>
					<li><a href="../calendar/calendarMainView">Calendar</a></li>
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
				enctype="multipart/form-data" style="float: left;">

				<span
					class="btn btn-default"
					onclick="document.getElementById('upload').click();">파일찾기
					<input type="file" id="upload" name="upload"
					style="display: none; float: left;">
				</span> <input type="submit" class="btn btn-default" value="엑셀업로드"
					style="float: right;">
				<div style="color: red; font-size: 20px;">${up_ret }</div>
			</form>
			<input type="button" class="btn btn-default" value="경조사 가계부 등록" data-toggle="modal" data-target="#targetAccModal">

			<input type="text" id="readfile" class="form-control" readonly
				style="height: 5%; width: 20%; float: left;"> <input
				type="button" class="btn btn-default" value="샘플다운로드" onclick="location.href='sampleDown'"
				style="float: left;"> <input type="button"
				value="엑셀 다운로드 기능 테스트" onclick="location.href='excelDown'"
				style="float: left;">
		</div>

		<br>
		<div class="content_left">
			<form id="frm">
			<select name="srch_type">
				<option value="all">전체</option>
				<option value="grp">그룹</option>
				<option value="nm" selected="selected">이름</option>
				<option value="ev">이벤트</option>
			</select>
			<div id="targetmain_div">
				
				<input type="text" name="srch_val" class="form-control"
					style="width: 50%; float: left;"><input type="button"
					id="btn_search" value="검색" class="btn btn-default">
					<br> <br> 
				<div id="target_div"></div>
			</div>
			</form>
		</div>
		<div class="content_right">
			<div id="targetacc_div"></div>
		</div>
		
		<div class="modal fade" id="targetAccModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="width: 350px; ">
					<div class="modal-header">
						<h4 class="modal-title">경조사 가계부 등록</h4>
					</div>
					<div class="modal-body">
					<table>
						<tr>
						<td colspan="3">
						<select id="ta_type" class="form-control">
							<option value="INC">수입</option>
							<option value="OUT">지출</option>
						</select>
						</td>
						</tr>
						<tr>
							<th>날짜</th>
							<td colspan="2"><input type="datetime-local" id="ta_date" class="form-control"></td>
						</tr>
						<tr>
							<th>장소</th>
							<td>
							<input type="hidden" id="t_url">
							<input type="text" id="ta_memo" class="form-control" readonly="readonly" disabled="disabled">
							</td>
							<td>
							<input type="button" value="장소설정" id="set_acc_location" >
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
							<input type="hidden" id="t_id" >
							<input type="text" id="t_name" class="form-control" readonly="readonly" disabled="disabled" >
							</td>
							<td>
							<input type="button" value="타겟설정" id="set_acc_target" data-toggle="modal" data-target="#targetModal">
							</td>
						</tr>
						<tr>
							<th>금액</th>
							<td colspan="2"><input type="text" id="ta_price" class="form-control"></td>
						</tr>
					</table>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn_acc_create" class="btn btn-default" data-dismiss="modal">확인</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="targetModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">타겟설정</h4>
					</div>
					<div class="modal-body">
					<select id="srch_type">
						<option value="all">전체</option>
						<option value="grp">그룹</option>
						<option value="nm" selected="selected">이름</option>
						<option value="ev">이벤트</option>
					</select>
					<input type="text" id="tar_acc_search">
					<input type="button" id="btn_acc_search" value="검색" >
					<div id="targetlist_div"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
						<button type="button" id="tar_srch_close" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
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