<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>HouseholdAccountCheck</title>

<link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,900" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css" />

<!-- Accbook Page CSS -->
<!-- <link href="../resources/PageCSS/accountjsp.css" rel="stylesheet"> -->

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

<!-- modal -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!-- alert창 CSS -->
<script
	src="../resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />
</head>

<style type="text/css">
.content_body {
	background-image: url("../resources/template/배경6_2.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	/* 	background-position: top; */
}
h1{
  font-size: 30px;
  color: #fff;
  text-transform: uppercase;
  font-weight: 300;
  text-align: center;
  margin-bottom: 15px;
}

table{
  width:100%;
  table-layout: fixed;
}

.tbl-header, .tbl-header2{
  background-color: rgba(255,255,255,0.3);
 }
 
.tbl-content, .tbl-content2{
  height:200px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}

th{
  padding: 20px 15px;
  text-align: center;
  font-weight: 500;
  font-size: 12px;
  color: #fff;
  text-transform: uppercase;
}

td{
  padding: 15px;
  text-align: center;
  vertical-align:middle;
  font-weight: 300;
  font-size: 12px;
  color: #fff;
  border-bottom: solid 1px rgba(255,255,255,0.1);
}

/* demo styles */
/* @import url(http://fonts.googleapis.com/css?family=Roboto:400,500,300,700); */


/* for custom scrollbar for webkit browser*/
/* section{
  margin: 25px;
}

::-webkit-scrollbar {
    width: 6px;
} 
::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
} 
::-webkit-scrollbar-thumb {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
} */
</style>

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
$(document).ready(function()
{
	getOutIncome();
	$('input:radio[name=r_a_type]').click(function()
	{
		select();
	});
});


function getOutIncome() {
	$.ajax({
		url:"householdAccount"
		, type : "post"
		, dataType : "json"
		, success:showOutIncome
		, error:function(e) {
			alertify.error("리스트 가져오기 실패!!");
		}
	})
}

function showOutIncome(data) {
	console.log(data);
	var tbl_inc = "";
	var tbl_out = "";
	
// 	tbl_inc += "<div class='tbl-header'>";
// 	tbl_inc += "<table cellpadding='0' cellspacing='0' border='0'>";
// 	tbl_inc += "<thead>";
// 	tbl_inc += "<tr>";
// 	tbl_inc += "<th>일자</th>";
// 	tbl_inc += "<th>금액</th>";
// 	tbl_inc += "<th>메모</th>";
// 	tbl_inc += "<th>삭제</th>";
// 	tbl_inc += "</tr>";
// 	tbl_inc += "</thead>";
// 	tbl_inc += "</div>";
	
// 	tbl_inc += "<div class='tbl-content'>";
	tbl_inc += "<table>";
	tbl_inc += "<tr>";
	tbl_inc += "<th>일자</th>";
	tbl_inc += "<th>금액</th>";
	tbl_inc += "<th>메모</th>";
	tbl_inc += "<th>삭제</th>";
	tbl_inc += "</tr>"
	$.each(data.list_inc, function(i, inc) {
		tbl_inc += "<tr>";
		tbl_inc += "<td>" + inc.a_date + "</td>";
		tbl_inc += "<td>" + inc.price + "</td>";
		tbl_inc += "<td>" + inc.a_memo + "</td>";
		tbl_inc += "<td><input type='button' id='eDeleteCheck' class='btn btn-secondary' " 
		+ "onclick='checkForm2(" + inc.a_id + ", " + inc.price + ")' value='삭제'></td>";
		tbl_inc += "</tr>";
	});
	tbl_inc += "</table>";
// 	tbl_inc += "</div>";
	
	$("#tbl_income").html(tbl_inc);
	
// 	tbl_out += "<div class='tbl-header'>";
// 	tbl_out += "<table cellpadding='0' cellspacing='0' border='0'>";
// 	tbl_out += "<thead>";
	tbl_out += "<tr>";
	tbl_out += "<th>일자</th>";
	tbl_out += "<th>내역</th>";
	tbl_out += "<th>결제수단</th>";
	tbl_out += "<th>금액</th>";
	tbl_out += "<th>메모</th>";
	tbl_out += "<th>삭제</th>";
	tbl_out += "</tr>";
// 	tbl_out += "</thead>";
// 	tbl_out += "</div>";
	
// 	tbl_out += "<div class='tbl-content'>";
	tbl_out += "<table>";
	tbl_out += "<tr>";
	tbl_out += "<th>일자</th>";
	tbl_out += "<th>내역</th>";
	tbl_out += "<th>결제수단</th>";
	tbl_out += "<th>금액</th>";
	tbl_out += "<th>메모</th>";
	tbl_out += "<th>삭제</th>";
	tbl_out += "</tr>";
	$.each(data.list_out, function(i, out) {
		tbl_out += "<tr>";
		tbl_out += "<td>" + out.a_date + "</td>";
		tbl_out += "<td>" + out.sub_cate + "</td>";
		tbl_out += "<td>" + out.payment + "</td>";
		tbl_out += "<td>" + out.price + "</td>";
		tbl_out += "<td>" + out.a_memo + "</td>";
		tbl_out += "<td><input type='button' id='eDeleteCheck' class='btn btn-secondary' " 
		+ "onclick='checkForm2(" + out.a_id + ", " + out.price + ")' value='삭제'></td>";
		tbl_out += "</tr>";
	});
	tbl_out += "</table>";
// 	tbl_out += "</div>";
	
	$("#tbl_out").html(tbl_out);
}

function select() {
	
	var check1 = document.getElementsByName('r_a_type');
	var check_out = null;
	
	for(var i=0; i<check1.length;i++){
		if(check1[i].checked==true){
			check_out=check1[i].value;
		}
	}
	
	var sub_cates=null;	

	if(check_out=='MIN'){
		var str ='<select id="r_sub_cate" class="form-control">';
		sub_cates=[
			'식비'
			,'문화생활비'
			,'건강관리비'
			,'의류미용비'
			,'교통비'
			,'차량유지비'
			,'주거생활비'
			,'학비'
			,'사회생활비'
			,'유흥비'
			,'금융보험비'
			,'저축'
			,'기타'
		];
		
		for(var i=0;i<sub_cates.length;i++){
			str+='<option value="'+sub_cates[i]+'">'+sub_cates[i];
		}
		str+='</select><br>';
	}
	
	if(check_out=='PLS'){
		$('#selectdiv').html('');
	}
	
	$('#selectdiv').html(str);
}
</script>

<script type="text/javascript">
$(window).on("load resize ", function() {
	  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
	  $('.tbl-header').css({'padding-right':scrollWidth});

}).resize();

function checkForm(){
	var e_date = document.getElementById('expense_date').value;
	
	var main_cate = null;
	var main_cate_check = document.getElementsByName('r_a_type');
	for(var i=0; i<main_cate_check.length; i++){
		if(main_cate_check[i].checked==true){
			main_cate = main_cate_check[i].value;
		}
	}
	
	var sub_cate = null;
	
	if(main_cate == 'MIN'){
		sub_cate = document.getElementById('r_sub_cate').value;
	}
	
	if(main_cate == 'PLS'){
		sub_cate='기타';
	}
	
	var e_payment = null;
	var e_paymentCheck = document.getElementsByName('expense_payment');
	for(var i=0; i<e_paymentCheck.length; i++){
		if(e_paymentCheck[i].checked==true){
			e_payment = e_paymentCheck[i].value;
		}
	}
	
	var e_price = document.getElementById('expense_price').value;
	var e_memo = document.getElementById('expense_memo').value;
	
	if(e_memo.substring(0,4)=='<scr'){
		alert('장난치지 마세요');
		return false;
	}
	
	if(e_date==''){
		alert('날짜를 설정하십시오!!!');
		return false;
	}
	
	if(main_cate==null){
		alert('상위 카테고리 중 하나를 반드시 구분하여 선택하십시오!!!');
		return false;
	}
	
	if(sub_cate==null){
		alert('하위 카테고리 중 하나를 반드시 구분하여 선택하십시오!!!');
		return false;
	}
	
	if(main_cate_check == 'MIN'){
		if(sub_cate==null){
			alert('하위 카테고리 중 하나를 반드시 구분하여 선택하십시오!!!');
			return false;
		}
	}
	
	if(e_payment==null){
		alert('결제수단 중 하나를 선택하십시오!!!');
		return false;
	}
	
	if(isNaN(e_price)){
		alert('숫자만 입력하십시오!!!');
		return false;
	}
	
	if(e_price==0){
		alert('지출 액수를 입력하십시오!!!');
		return false;
	}
	
	$.ajax({
		url : 'emergencyChecking',
		type : 'POST',
		data : {a_date:e_date, main_cate:main_cate, sub_cate:sub_cate, payment:e_payment, price:e_price, a_memo: e_memo},
		dataType : 'json',
		success : function(ob){
			$('#btn_close').trigger('click');
			if(ob.msg != "") {
				alertify.success(ob.msg);
			} else if (ob.errmsg != "") {
				alertify.error(ob.errmsg);
			}
			getOutIncome();
		}
	});
}

function checkForm2(a_id, price){
	
	if(confirm('해당 내역을 삭제하시겠습니까?')){
		$.ajax({
			url : 'emergencyChecking2',
			type : 'POST',
			data : {a_id : a_id, price : price},
			dataType : 'text',
			success : function(ob){
				if(ob==1){
					alertify.success('삭제되었습니다.');
				}
				else{
					alertify.error('삭제실패!!');
				}
				getOutIncome();
			}
		});
	}
}
</script>

<body>

<!-- <div align="center"> -->
<!-- 	<a href="../newhome"><img  src="../resources/template/img/homeReturn.png" height="80px"></a>&nbsp&nbsp -->
<!-- 	<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModal"><img  src="../resources/template/img/writeCheck.png" height="30px"></button>&nbsp&nbsp&nbsp&nbsp -->
<!-- </div> -->

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
				<a href="../user/householdAccount" class="w3-bar-item w3-button"><i
					class="fa fa-krw"></i>비상금 관리 내역</a>
			</c:if>

			<!-- 경조사관리 -->
			<a href="../target/excelTest" class="w3-bar-item w3-button"><i
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
					<li><a href="Accbook">Account</a></li>
					<li><a href="../calendar/calendarMainView">Calendar</a></li>
					<li><a href="#contact">LogOut</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>
	<!-- //Navigation -->

	<div class="content_body">
		<!-- content_top -->
		<div class="content_top">
		
		</div>
		<!-- //content_top -->

		<!--content_left  -->
		<div class="content_left">

			<div id="table_button" style="margin-bottom: 0.5%">
				<button class="btn btn-default" data-toggle="modal" data-target="#registModal"
					style="float: right;">등록</button>
			</div>
			
			<section>
			  <h2>비상금 관리 내역</h2>
			  <div id="tbl_income">
			  </div>
			</section>
		</div>
		<!-- //content_left -->

		<!-- content_right -->
		<div class="content_right">
			<section>
			  <h2>비상금 지출 현황</h2>
			  
			  <div id="tbl_out">
			  </div>
			</section>
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
		  		  <input type="radio" id="r_in" value="PLS" class="r_a_type" name="r_a_type">수입
		  		  <input type="radio" id="r_out" value="MIN" class="r_a_type" name="r_a_type">지출
		  		  <div id="selectdiv"></div>
		          
		          <div class="form-group">
		             <label for="recipient-name" class="form-control-label">결제 수단</label>
		            	<input type="radio"  name="expense_payment" value="카드">카드
		            	<input type="radio"  name="expense_payment" value="현금">현금
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
		        <button type="button" class="btn btn-default" id="btn check" onclick="return checkForm()">등록</button>
		        <button type="button" class="btn btn-default" id="btn_close" data-dismiss="modal">닫기</button>
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