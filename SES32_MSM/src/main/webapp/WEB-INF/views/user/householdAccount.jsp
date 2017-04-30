<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>HouseholdAccountCheck</title>

<!-- icon CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- jQuery -->
<script src="../resources/template/js/jquery.js"></script>

<!-- W3School CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- Bootstrap Core CSS -->
<link href="../resources/template/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="../resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../resources/template/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- Modal CSS -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!-- alert창 CSS -->
<script
	src="../resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />


<style type="text/css">
.content_body {
	background-image: url("../resources/template/배경6_2.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	/* 	background-position: top; */
}

 table{
/*   width:100%;
  table-layout: fixed; */ 
  background-color: rgba(255, 255, 255, 0.5);
}

/* .tbl-header, .tbl-header2{
  background-color: rgba(255,255,255,0.3);
 }
 
.tbl-content, .tbl-content2{
  height:200px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
} */
.th_title {
	background-color: #b3ccff;
	font-size: 18px;
}

th {
	background-color: #80aaff;
/* 	padding: 20px 15px; */
	text-align: center;
/* 	font-weight: 500; */
/* 	font-size: 12px; */
	color: white;
/* 	text-transform: uppercase; */
}

td {
/* 	padding: 15px; */
	text-align: center;
	vertical-align: middle;
/* 	font-weight: 300; */
/* 	font-size: 12px; */
	border-bottom: solid 1px rgba(255, 255, 255, 0.1);
}
</style>

</head>
<script>
	/* SideBar JavaScript */
	function w3_open() {
		document.getElementById("mySidebar").style.display = "block";
	}

	function w3_close() {
		document.getElementById("mySidebar").style.display = "none";
	}
</script>

<script>
//회원 수정 모달창 열기
$(function() {
	$("#userUpdatemodal").click(function() {
		$('#user_update_content').empty();
		
		$('#user_update_modal').modal({
			remote : '../user/userUpdatemodal'
		});
	});
});


	$(document).ready(function() {
		getOutIncome();
	
		
		$("#btn_bis_srch").on("click", getOutIncome);
				
		$("#btn_close").on("click", function() {
		});
		$("#bisInsert").on("click",function(){
			initRegistModal();
		});	
	});
	
	// 등록창 초기화
	function initRegistModal() {
		$("#expense_date").val("");
		$("#expense_price").val("");
		$("#expense_memo").val("");
		$("#r_cash").attr("checked", true);
		$("#r_in").attr("checked", true);
	}

	// 비상금관리 조회
	function getOutIncome() {
		var start = $("#d_start").val();
		var end = $("#d_end").val();
		var keyword = $("#keyword").val();
		
		if($("#d_start").val() > $("#d_end").val()) {
			alertify.alert("종료일자는 시작일자보다 클 수 없습니다!!");
			return;
		}
		
		$.ajax({
			url : "householdAccount"
			, type : "post"
			, data : {
				start_date : start
				, end_date : end
				, keyword : keyword
			}
			, dataType : "json"
			, success : showOutIncome
			, error : function(e) {
				alertify.error("리스트 가져오기 실패!!");
			}
		})
	}

	// 비상금관리 내역 데이터 뿌리기
	function showOutIncome(data) {
		console.log(data);
		var tbl_inc = "";
		var tbl_out = "";
		tbl_inc += '<table class="table">';
		tbl_inc += "<tr><th class='th_title' colspan='4'>비상금 관리 내역</th></tr>";
		tbl_inc += '<tr>';
		tbl_inc += '<th>일자</th>';
		tbl_inc += '<th>금액</th>';
		tbl_inc += '<th>항목</th>';
		tbl_inc += '<th>삭제</th>';
		tbl_inc += '</tr>'
		$
				.each(
						data.list_inc,
						function(i, inc) {
							tbl_inc += "<tr>";
							tbl_inc += "<td>" + inc.a_date + "</td>";
							tbl_inc += "<td>" + inc.price + "</td>";
							tbl_inc += "<td>" + inc.a_memo + "</td>";
							tbl_inc += "<td><input type='button' id='eDeleteCheck' class='btn btn-secondary' "
									+ "onclick='checkForm2("
									+ inc.a_id
									+ ", "
									+ inc.price + ")' value='삭제'></td>";
							tbl_inc += "</tr>";
						});
		tbl_inc += "</table>";

		$("#tbl_income").html(tbl_inc);

		tbl_out += '<table class="table">';
		tbl_out += "<tr><th class='th_title' colspan='6'>비상금 지출 내역</th></tr>";
		tbl_out += '<tr>';
		tbl_out += '<th>일자</th>';
		tbl_out += '<th>내역</th>';
		tbl_out += '<th>결제수단</th>';
		tbl_out += '<th>금액</th>';
		tbl_out += '<th>항목</th>';
		tbl_out += '<th>삭제</th>';
		tbl_out += '</tr>';
		$
				.each(
						data.list_out,
						function(i, out) {
							tbl_out += "<tr>";
							tbl_out += "<td>" + out.a_date + "</td>";
							tbl_out += "<td>" + out.sub_cate + "</td>";
							tbl_out += "<td>" + out.payment + "</td>";
							tbl_out += "<td>" + out.price + "</td>";
							tbl_out += "<td>" + out.a_memo + "</td>";
							tbl_out += "<td><input type='button' id='eDeleteCheck' class='btn btn-secondary' "
									+ "onclick='checkForm2("
									+ out.a_id
									+ ", "
									+ out.price + ")' value='삭제'></td>";
							tbl_out += "</tr>";
						});
		tbl_out += "</table>";

		$("#tbl_out").html(tbl_out);
	}

	
</script>

<script>
	$(window).on(
			"load resize ",
			function() {
				var scrollWidth = $('.tbl-content').width()
						- $('.tbl-content table').width();
				$('.tbl-header').css({
					'padding-right' : scrollWidth
				});

			}).resize();

	function checkForm() {
		var e_date = document.getElementById('expense_date').value;

		var main_cate = null;
		var main_cate_check = document.getElementsByName('r_a_type');
		for (var i = 0; i < main_cate_check.length; i++) {
			if (main_cate_check[i].checked == true) {
				main_cate = main_cate_check[i].value;
			}
		}

		var sub_cate = null;

		if (main_cate == 'MIN') {
			sub_cate = '기타';
		}

		if (main_cate == 'PLS') {
			sub_cate = '기타';
		}

		var e_payment = null;
		var e_paymentCheck = document.getElementsByName('expense_payment');
		for (var i = 0; i < e_paymentCheck.length; i++) {
			if (e_paymentCheck[i].checked == true) {
				e_payment = e_paymentCheck[i].value;
			}
		}

		var e_price = document.getElementById('expense_price').value;
		var e_memo = document.getElementById('expense_memo').value;


	

		if (e_date == '') {
			alertify.alert('날짜를 설정해주세요.');
			return false;
		}



		if (e_payment == null) {
			alertify.alert('결제수단 중 하나를 선택해주세요.');
			return false;
		}

		if (isNaN(e_price)) {
			alertify.alert('숫자만 입력해주세요.');
			return false;
		}

		if (e_price == 0) {
			alertify.alert('금액을 를 입력해주세요.');
			return false;
		}

		$.ajax({
			url : 'emergencyChecking',
			type : 'POST',
			data : {
				a_date : e_date,
				main_cate : main_cate,
				sub_cate : sub_cate,
				payment : e_payment,
				price : e_price,
				a_memo : e_memo
			},
			dataType : 'json',
			success : function(ob) {
				$('#btn_close').trigger('click');
				if (ob.msg != "") {
					alertify.success(ob.msg);
				} else if (ob.errmsg != "") {
					alertify.error(ob.errmsg);
				}
				getOutIncome();
			}
		});
	}

	function checkForm2(a_id, price) {

		if (confirm('해당 내역을 삭제하시겠습니까?')) {
			$.ajax({
				url : 'emergencyChecking2',
				type : 'POST',
				data : {
					a_id : a_id,
					price : price
				},
				dataType : 'text',
				success : function(ob) {
					if (ob == 1) {
						alertify.success('삭제되었습니다.');
					} else {
						alertify.error('삭제실패!!');
					}
					getOutIncome();
				}
			});
		}
	}
</script>

<body>
		<div class="modal fade" id="user_update_modal">
				<div class="modal-dialog">
					<div class="modal-content" id="user_update_content" style="width: 500px">
						<!-- remote ajax call이 되는영역 -->

					</div>
				</div>
			</div>


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

				<a href="householdAccount" class="w3-bar-item w3-button"><i
					class="fa fa-krw"></i>비상금 관리 내역</a>
			</c:if>

			<!-- 경조사관리 -->
			<a href="../target/targetManage" class="w3-bar-item w3-button"><i
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
				<a class="navbar-brand topnav" href="../newhome">MSM</a>
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
		<!-- [0001] content_top -->
		<div class="content_top">
			<div>
				<input type="date" class="form-control" id="d_start" style="float: left; width: 160px;">
				<input type="date" class="form-control" id="d_end" style="float: left; width: 160px;">
				<input type="text" class="form-control" id="keyword" placeholder="※항목의 내용으로 검색" style="float: left; width: 300px;">
				<input type="button" class="btn btn-default" id="btn_bis_srch" value="검색" style="float: left;">
				<button class="btn btn-default" data-toggle="modal" data-target="#registModal"
					style="float: left; margin-left: 50px;" id="bisInsert">등록</button>
			</div>
		</div>
		<!-- //content_top -->

		<!-- content_left -->
		<div class="content_left">
			<div id="tbl_income"></div><!-- 비상금 관리 내역 -->
		</div>
		<!-- //content_left -->

		<!-- content_right -->
		<div class="content_right">
			<div id="tbl_out"></div><!-- 비상금 지출 내역 -->
		</div>
		<!-- //content_right -->

		<!-- 등록modal -->
		<div class="modal fade" id="registModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">비상금 사용 내역</h5>
						<!-- 	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
						<!-- 	          		<span aria-hidden="true">&times;</span> -->
						<!-- 	        	</button> -->
					</div>

					<div class="modal-body">
						<form>
							<div class="form-group">
								<label for="recipient-name" class="form-control-label">일자</label>
								<input type="date" class="form-control" id="expense_date">
							</div>

							<label for="recipient-name" class="form-control-label">종류</label>
							<input type="radio" id="r_in" value="PLS" class="r_a_type"
								name="r_a_type" checked="checked">수입 <input type="radio" id="r_out"
								value="MIN" class="r_a_type" name="r_a_type">지출

							<div class="form-group">
								<label for="recipient-name" class="form-control-label">결제
									수단</label> <input type="radio" name="expense_payment" value="카드" checked="checked">카드
								<input type="radio" name="expense_payment" id="r_cash" value="현금">현금
							</div>

							<div class="form-group">
								<label for="recipient-name" class="form-control-label">가격</label>
								<input type="text" class="form-control" id="expense_price">
							</div>

							<div class="form-group">
								<label for="recipient-name" class="form-control-label">메모</label>
								<input type="text" class="form-control" id="expense_memo">
							</div>
						</form>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" id="btn check"
							onclick="return checkForm()">등록</button>
						<button type="button" class="btn btn-default" id="btn_close"
							data-dismiss="modal">닫기</button>
					</div>

				</div>
			</div>
		</div>
		<!-- //등록modal -->

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