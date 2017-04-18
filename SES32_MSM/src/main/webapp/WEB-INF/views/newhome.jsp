<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Manage a Schedule and Money</title>

<!-- jQuery -->
<script src="../resources/template/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="./resources/template/js/bootstrap.min.js"></script>

<!-- W3School CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- Bootstrap Core CSS -->
<link href="./resources/template/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="./resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="./resources/template/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">
	
<!-- Modal CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.content_body {
  	   background-image: url("./resources/template/img/banner-bg.jpg");
	   background-repeat: no-repeat; 
	   background-size: cover;
	   background-position: 25%; 
}

.header {
  background-color: #327a81;
  color: white;
  font-size: 1.5em;
  padding: 1rem;
  text-align: center;
  text-transform: uppercase;
}

img {
  border-radius: 50%;
  height: 60px;
  width: 60px;
}

.table-users {
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow-y: auto;
  width: 800px;
  height: 150px;
  float: left;
}

.table-users2 {
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow-y: auto;
  width: 800px;
  height: 200px;
  float: left;
}

.table-users3 {
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow-y: auto;
  width: 800px;
  height: 350px;
  float: left;
}

table {
  width: 100%;
}
table td, table th {
  color: #2b686e;
  padding: 10px;
}
table td {
  text-align: center;
  vertical-align: middle;
}
table td:last-child {
  font-size: 0.95em;
  line-height: 1.4;
  text-align: center;
}
table th {
  background-color: #daeff1;
  font-weight: 300;
  text-align: center;
}
table tr:nth-child(2n) {
  background-color: white;
}
table tr:nth-child(2n+1) {
  background-color: #edf7f8;
}

@media screen and (max-width: 700px) {
  table, tr, td {
    display: block;
  }

  td:first-child {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
    width: 100px;
  }
  td:not(:first-child) {
    clear: both;
    margin-left: 100px;
    padding: 4px 20px 4px 90px;
    position: relative;
    text-align: left;
  }
  td:not(:first-child):before {
    color: #91ced4;
    content: '';
    display: block;
    left: 0;
    position: absolute;
  }

  tr {
    padding: 10px 0;
    position: relative;
  }
  tr:first-child {
    display: none;
  }
}
@media screen and (max-width: 500px) {
  .header {
    background-color: transparent;
    color: white;
    font-size: 2em;
    font-weight: 700;
    padding: 0;
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
  }

  img {
    border: 3px solid;
    border-color: #daeff1;
    height: 100px;
    margin: 0.5rem 0;
    width: 100px;
  }

  td:first-child {
    background-color: #c8e7ea;
    border-bottom: 1px solid #91ced4;
    border-radius: 10px 10px 0 0;
    position: relative;
    top: 0;
    -webkit-transform: translateY(0);
            transform: translateY(0);
    width: 100%;
  }
  td:not(:first-child) {
    margin: 0;
    padding: 5px 1em;
    width: 100%;
  }
  td:not(:first-child):before {
    font-size: .8em;
    padding-top: 0.3em;
    position: relative;
  }
  td:last-child {
    padding-bottom: 1rem !important;
  }

  tr {
    background-color: white !important;
    border: 1px solid #6cbec6;
    border-radius: 10px;
    box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
    margin: 0.5rem 0;
    padding: 0;
  }

  .table-users {
    border: none;
    box-shadow: none;
    overflow: visible;
  }
  
  .table-users2 {
    border: none;
    box-shadow: none;
    overflow: visible;
  }
  
  .table-users3 {
    border: none;
    box-shadow: none;
    overflow: visible;
  }
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

(function($){
    $(window).on("load",function(){
        $(".content").mCustomScrollbar();
    });
})(jQuery);
</script>

<script type="text/javascript">
function calculatorOpen(){
	window.open("http://localhost:8888/msm/user/calculator", "", "width=350, height=274, status=1");
}

function checkForm(){
	var id = document.getElementById('u_id_check').value;
	var pwd = document.getElementById('u_pwd_check').value;
	var pwd2 = document.getElementById('u_pwd_check2').value;
	var name = document.getElementById('u_name_check').value;
	var email = document.getElementById('u_email_check').value;
	var phone = document.getElementById('u_phone_check').value;
	var birth = document.getElementById('u_birth_check').value;
	var address = document.getElementById('u_address_check').value;
	
	if(pwd==''||pwd2==''||name==''||email==''){
		alert('필수 항목에 해당 내용을 입력하십시오.');
		return false;
	}
	
	if(pwd != pwd2){
		alert('입력하신 비밀번호와 비밀번호 확인값이 일치하지 않습니다.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	if(!pwd.match(/[a-zA-Z0-9]*[^a-zA-Z0-9\n]+[a-zA-Z0-9]*$/)){
		alert('비밀번호는 문자, 숫자, 특수문자 조합으로 입력하여 주십시오.');
		return false;
	}
	
	if(id.indexOf(pwd)>-1){
		alert('비밀번호에 아이디를 사용하실 수 없습니다.');
		return false;
	}
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	var regExp2 = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/

	if(phone.match(regExp2)==null){
		alert('잘못된 휴대폰 번호입니다. 숫자, -(구분자)를 포함하여 입력합시오');
		return false;
	}
	
    var year = Number(birth.substr(0,4)); 
    var month = Number(birth.substr(5,2));
    var day = Number(birth.substr(8,2));

    if (month < 1 || month > 12) { // check month range
    	alert("Month must be between 1 and 12.");
     	return false;
    }

    if (day < 1 || day > 31) {
     	alert("Day must be between 1 and 31.");
     	return false;
    }

    if ((month==4 || month==6 || month==9 || month==11) && day==31) {
     	alert("Month "+month+" doesn't have 31 days!");
     	return false
    }

    if (month == 2) { // check for february 29th
     	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    
     	if (day>29 || (day==29 && !isleap)) {
      		alert("February " + year + " doesn't have " + day + " days! ");
      		return false;
     	}
    }
	
	$.ajax({
		url : 'user/userUpdate',
		type : 'POST',
		data : {u_id: id, u_pwd: pwd, u_name: name, u_email: email, u_phone: phone, u_birth: birth, u_address: address },
		dataType : 'text',
		success : function(data){
			alert(data);
			alert('다시 재로그인 부탁드립니다...');
			location.href="http://localhost:8888/msm";
		}
	});
}

function checkForm2(){
	var pwd = document.getElementById('pwd_check2').value;
	var email = document.getElementById('email_check2').value;
	
	if(pwd==''){
		alert('비밀번호를 입력하여주십시오.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	$.ajax({
		url : 'user/userDeleteCheck',
		type : 'POST',
		data : {pwd: pwd, email: email },
		dataType : 'text',
		success : function(data){
			alert(data);
			checkForm3();
		}
	});
}

function checkForm3(){

	var checkNumber = prompt('이메일로 전송된 인증번호를 입력하십시오.', '');
	
	$.ajax({
		url : 'user/userDelete',
		type : 'POST',
		data : {checkDelteNumber : checkNumber},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm";
		}
	});
}

function checkForm4(){
	var today = new Date(); 
	
	var year = today.getFullYear(); 
	var month = today.getMonth() + 1; 
	var day = today.getDate(); 
	
	var a_date = document.getElementById('acc_date').value;
	var a_memo = document.getElementById('acc_memo').value;
	var payment = document.getElementById('acc_payment').value;
	var price = document.getElementById('acc_price').value;
	
	if(isNaN(price)){
		alert('숫자를 입력하셔야 결과를 확인할 수 있습니다.');
		return false;
	}
	
	if(Number(a_date.substr(0,4))!=year){
		alert('올해 년도 내 입력하십시오.');
		return false;
	} 
	
	if(Number(a_date.substr(5,2))!=month){
		alert('이번 달 내에 대해서만 입력하십시오.');
		return false;
	} 
	
	$.ajax({
		url : 'user/additionalIncome',
		type : 'POST',
		data : {a_date : a_date, payment : payment, price : price, a_memo : a_memo},
		dataType : 'json',
		success : function(data){
			if(data.disposableSavings==0){
				alert('잔여금액이 없습니다!!! 저축 액수 및 비상지출 대비 액수 정산이 불가능합니다!!!');
				return false;
			}
			
			if(day==18){
				checkForm5(data);
			}
		
		location.href="http://localhost:8888/msm/newhome";
		}
	});
}

/* 정산 회수를 해당 날짜의 1회만 적용 - 현재 상태 : 날짜 한정 가능, 해당 날짜 내 1회성 제한이 불가능 - 계속 통장이 입금될 경우 잔여금액에 마이너스가 발생 */
function checkForm5(data){
	alert('저축 통장 및 연간 지출 대비 통장 입금은 매월 18일에 의무적으로 정산되어야 합니다.');
	
	$.ajax({
		url : 'user/emergencyExpense',
		type : 'POST',
		data : {savings: data.disposableSavings, originalIncome: data.originalIncome, disposableIncome: data.disposableIncome, recentEmergencies: data.recentEmergencies},
		dataType : 'json',
		success : function(ob){
			
			if(ob.pureRemaings==0){
				alert('순수 잔여금액이 존재하지 않습니다.');
			}
			
			if(ob.pureRemaings<0){
				alert('적자 발생!!! 지출 액수를 감소시키십시오!!!')
			}
			
			var u_emergences2 = ob.recentEmergencies;
			
			if(ob.pureRemaings>u_emergences2){
					if(confirm('비상금을 재설정하시겠습니다까? 현재 잔여액수는 '+ob.pureRemaings+', 지정 비상금 액수는 '+u_emergences2+' 입니다.')){
						updateEmergenceis2(ob.pureRemaings, u_emergences2);
					}
				}
			else updateEmergenceis1(u_emergences2);
		}
	});
}

function updateEmergenceis1(num){ // 비상금 재설정 취소 시, 이전 지정 비상금 액수로 누적시킨다.
	$.ajax({
		url : 'user/userUpdate2',
		type : 'POST',
		data : {u_emergences : num},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/newhome";
		}
	});
}

function updateEmergenceis2(pureRemaings, u_emergences2){
	
	// 순수 잔여금액 + 이전 지정 비상금액
	var amountBefore = pureRemaings + u_emergences2;
	
	var num = prompt('희망 비상금액을 입력하십시오.', '');
	
	if(num==0){
		alert('비상 금액을 입력하십시오.');
		return false;
	}
	
	if(num>amountBefore){
		alert('비상금액 가능 출금 범위를 초과했습니다.');
		return false;
	}
	
	$.ajax({
		url : 'user/userUpdate2',
		type : 'POST',
		data : {u_emergences : num},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/newhome";
		}
	});
}

function checkForm6(){
	var today = new Date(); 
	var year = today.getFullYear(); 
	var month = today.getMonth() + 1; 
	var day = today.getDate(); 
	
	var e_date = document.getElementById('expense_date').value;
	var cate_check=null;
	var e_cate = document.getElementsByName('sub_cate');
	
	for(var i=0; i<e_cate.length; i++){
		if(e_cate[i].checked==true){
			cate_check = e_cate[i].value;
		}
	}
	
	var e_payment = document.getElementById('expense_payment').value;
	var e_price = document.getElementById('expense_price').value;
	var e_memo = document.getElementById('expense_memo').value;
	
	if(Number(e_date.substr(0,4))!=year){
		alert('올해 년도를 입력하십시오!!!');
		return false;
	}
	
	if(Number(e_date.substr(5,2))!=month){
		alert('이번 달 내에 대해서만 입력하십시오!!!');
		return false;
	}
	
	if(Number(day==17 && cate_check!='경조사비')){
		alert('매월 17일은 의무 입금 정산 날짜이므로 지출 사항이 제한됩니다.');
		return false;
	}
	
	if(cate_check==null){
		alert('하위 카테고리 중 하나를 반드시 구분하여 선택하십시오!!!');
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
		url : 'user/expenseUpdate',
		type : 'POST',
		data : {expenseDate:e_date, expenseSubCategory:cate_check, expensePayment:e_payment, expensePrice:e_price, expenseMemo:e_memo},
		dataType : 'json',
		success : function(ob){
			checkForm7(ob);
		}
	});
}

function checkForm7(ob){
	
	var checkMessage = ob.alertMessage;
	alert(checkMessage);

	if(checkMessage.substr(0,3)=='(A)'){
		alert(checkMessage);
		location.href="http://localhost:8888/msm/newhome";
	}
	
	$.ajax({
		url : 'user/expenseUpdate2',
		type : 'POST',
		data : {expenseDate : ob.expenseDate
				, subCategory : ob.subCategory
				, expensePayment : ob.expensePayment
				, memo : ob.memo
				, relevantPrice : ob.relevantPrice
				, allowedExpenseRange : ob.allowedExpenseRange
				, fixedExpenseRange : ob.fixedExpenseRange
				, floatingExpenseRange : ob.floatingExpenseRange
				, fixedExpenseSum: ob.fixedExpenseSum
				, floatingExpenseSum:ob.floatingExpenseSum
				, alertMessage:ob.alertMessage},
		dataType : 'text',
		success : function(ob){
			alert(ob);
			
			if(ob==1){
				alert('정상적인 지출 처리가 완료되었습니다!!!');
			}
			else if(ob==0){
				alert('비상금 및 연간 이벤트 지출 통장에 잔여금액이 없습니다!!!');
			}
			
			location.href="http://localhost:8888/msm/newhome";
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
				
			<!-- 로그인 시의 시행 가능 버튼 출력 -->	
			<c:if test="${loginID !=null }">
				<button type="button" class="w3-bar-item w3-button" data-toggle="modal" data-target="#exampleModal">회원 정보 수정</button>
				<button type="button" class="w3-bar-item w3-button" data-toggle="modal" data-target="#exampleModal2">회원 정보 탈퇴</button>
				<button type="button" class="w3-bar-item w3-button" data-toggle="modal" data-target="#exampleModal3">변동 수입 추가 기록</button>
				<button type="button" class="w3-bar-item w3-button" data-toggle="modal" data-target="#exampleModal4">추가 지출 내역 기입</button>
			</c:if>
			
			<!-- 계산기 -->
			<a href="javascript:calculatorOpen()" class="w3-bar-item w3-button">계산기</a>
			
			<!-- 맵 위치 -->
			<a href="mapAPI_Test" class="w3-bar-item w3-button">지도 위치 확인</a>
			
			<!-- 경조사관리 -->
			<a href="./target/excelTest" class="w3-bar-item w3-button">경조사 관리</a>
			
		</div>
		
		<a class="navbar-brand topnav" href="javascript:w3_open()"><img
			src="./resources/user_settingIcon.png" style="height: 30px;"> </a>
		<a class="navbar-brand topnav" href="../newhome">MSM</a>
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
					<li><a href="newhome">HOME</a></li>
					<li><a href="./accbook/Accbook">Account</a></li>
					<li><a href="./calendar/calendarMainView">Calendar</a></li>
					<li><a href="user/userLogout">LogOut</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


<!-- Body -->
<div class="content_body">

<div class="table-users" >
   <div class="header">Combined Arrangement</div>

   <table>
      <tr>
         <th>월 고정 수입</th>
         <th>월 가처분 소득</th>
         <th>월 변동 지출 총 액수</th>
         <th>비상 지출 대비 의무 입금</th>
         <th>비상금 적재 잔여 액수</th>
         <th>순수 잔여 액수</th>
      </tr>
		
      <c:if test="${loginID !=null }">
      <tr>
         <td>${originalIncome}</td>
	     <td>${disposableIncome}</td>
	     <td>${expenditureChange}</td>
	     <td>${emergencyPreparednessDeposit}</td>
	     <td>${remainEmergencesAccount}</td>
	     <td>${updateRemainingAmount}</td>
      </tr>
      </c:if>
      
      <c:if test="${loginID ==null }">
	  		<tr><td colspan="3">로그인 먼저 부탁드립니다.</td></tr>
	  </c:if>
   </table>
</div><br/>

<div class="table-users2" >
   <div class="header">Combined Arrangement</div>

   <table>
      <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
      </tr>

      <c:if test="${additionalList !=null }">
      <c:forEach var="vo1" items="${additionalList}">
      <c:if test="${vo1.a_type eq 'in'}">
	     <tr>
	       <td>${vo1.a_date }</td>
	       <td>${vo1.a_memo }</td>
	       <td>${vo1.price }</td>
	     </tr>
	  </c:if>
	  </c:forEach>
	  </c:if>
	  
	  <c:if test="${accResult ==null }">
	  		<tr><td colspan="3">등록된 내역이 없습니다.</td></tr>
	  </c:if>
	  
   </table>
</div>

<div class="table-users3" >
   <div class="header">Combined Arrangement</div>

   <table>
      <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
      </tr>

      <c:if test="${accResult !=null }">
 	  <c:forEach var="vo2" items="${accResult}">
 	  <c:if test="${vo2.a_type eq 'out'}">
        <tr>
          <td>${vo2.a_date }</td>
          <td>${vo2.sub_cate } </td>
          <td>${vo2.price }</td>
        </tr>
      </c:if>
      </c:forEach>
      </c:if>
      
      <c:if test="${accResult==null }">
	  		<tr><td colspan="3">등록된 내역이 없습니다.</td></tr>
	  </c:if>
   </table>
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
	
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      	<div class="modal-header">
	        	<h5 class="modal-title" id="exampleModalLabel">회원정보 수정사항</h5>
	          		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          			<span aria-hidden="true">&times;</span>
	        		</button>
	      	</div>
	      			
	      <div class="modal-body">
    	  <form>
          <div class="form-group">
            <label for="recipient-name" class="form-control-label">아이디 </label>
            <input type="text" class="form-control" id="u_id_check" value="${vo.getU_id() }" readonly="readonly">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label"> 비밀번호</label>
            <input type="password" class="form-control" id="u_pwd_check">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label"> 비밀번호 확인</label>
            <input type="password" class="form-control" id="u_pwd_check2">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label"> 이름 </label>
            <input type="text" class="form-control" id="u_name_check" value="${vo.getU_name() }">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">이메일</label>
            <input type="text" class="form-control" id="u_email_check" value="${vo.getU_email() }">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">전화번호</label>
            <input type="text" class="form-control" id="u_phone_check" value="${vo.getU_phone() }">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">생년월일</label>
            <input type="date" class="form-control" id="u_birth_check" value="${vo.getU_birth() }">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">주소</label>
            <input type="text" class="form-control" id="u_address_check" value="${vo.getU_address() }">
          </div>
    	  </form>
          </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm()">확인</button>
	 </div>
	      
	    </div>
	</div>
</div>
	
<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      	<div class="modal-header">
	        	<h5 class="modal-title" id="exampleModalLabel">회원정보 삭제 사항</h5>
	          		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          			<span aria-hidden="true">&times;</span>
	        		</button>
	      	</div>
	      			
	      <div class="modal-body">
    	  <form>
          <div class="form-group">
            <label for="recipient-name" class="form-control-label">비밀번호를 입력하십시오.</label>
            <input type="password" class="form-control" id="pwd_check2" placeholder="비밀번호를 정확히 입력하여 주십시오.">
          </div>
          
           <div class="form-group">
            <label for="recipient-name" class="form-control-label">이메일을 입력하십시오.</label>
            <input type="text" class="form-control" id="email_check2" placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
          </div>
          
    	  </form>
          </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm2()">확인</button>
	 </div>
	      
	    </div>
	</div>
</div>

<div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">변동 수입 추가 기록</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	      <div class="modal-body">
	          <form>
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">등록 일자</label>
	             <input type="date" class="form-control" id="acc_date">
	           </div>
	          
	           <div class="form-group">
	            <label for="recipient-name" class="form-control-label">내역</label>
	            <input type="text" class="form-control" id="acc_memo">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">수입 수단</label>
	            <input type="text" class="form-control" id="acc_payment">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">액수</label>
	            <input type="text" class="form-control" id="acc_price">
	          </div>
	    	  </form>
          </div>
      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm4()">확인</button>
		  </div>
	
	    </div>
	</div>
</div>

<div class="modal fade" id="exampleModal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">추가 지출 내역 기입</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	      <div class="modal-body">
	          <form>
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">기입 일자</label>
	             <input type="date" class="form-control" id="expense_date">
	           </div>
	          
	           <div class="form-group">
	            <label for="recipient-name" class="form-control-label">내용</label>
	            	식비<input type="radio"  name="sub_cate" value="식비">
	            	외식비<input type="radio"  name="sub_cate" value="외식비">
	            	유흥비<input type="radio"  name="sub_cate" value="유흥비">
	            	교통비<input type="radio"  name="sub_cate" value="교통비">
	            	생활용품<input type="radio"  name="sub_cate" value="생활용품">
	            	미용<input type="radio"  name="sub_cate" value="미용">
	            	영화<input type="radio"  name="sub_cate" value="영화">
	            	의료비<input type="radio"  name="sub_cate" value="의료비">
	            	경조사비<input type="radio"  name="sub_cate" value="경조사비">
	          </div>
	          
	          <div class="form-group">
	             <label for="recipient-name" class="form-control-label">결제 수단</label>
	             <input type="text" class="form-control" id="expense_payment">
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
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm6()">확인</button>
		  </div>
	
	    </div>
	</div>
</div>
</body>
</html>