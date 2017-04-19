<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HouseholdAccountCheck</title>

<link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,900" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</head>

<style type="text/css">
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
@import url(http://fonts.googleapis.com/css?family=Roboto:400,500,300,700);

body{
  background-image: url("../resources/template/img/banner-bg.jpg");
  font-family: 'Roboto', sans-serif;
}

/* for custom scrollbar for webkit browser*/
section{
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
}

.header {
  background-color: #327a81;
  color: white;
  font-size: 1.5em;
  padding: 1rem;
  text-align: center;
  text-transform: uppercase;
}

.table-users {
  border: 1px solid #327a81;
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow: hidden;
  width: 800px;
}

#table_check {
  width: 100%;
}
#table_check td, #table_check th {
  color: #2b686e;
  padding: 10px;
}
#table_check td {
  text-align: center;
  vertical-align: middle;
}
#table_check td:last-child {
  font-size: 0.95em;
  line-height: 1.4;
  text-align: center;
}
#table_check th {
  background-color: #daeff1;
  font-weight: 300;
}
#table_check tr:nth-child(2n) {
  background-color: white;
}
#table_check tr:nth-child(2n+1) {
  background-color: #edf7f8;
}

@media screen and (max-width: 700px) {
  #table_check, #table_check tr, #table_check td {
    display: block;
  }

  #table_check td:first-child {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
    width: 100px;
  }
  #table_check td:not(:first-child) {
    clear: both;
    margin-left: 100px;
    padding: 4px 20px 4px 90px;
    position: relative;
    text-align: center;
  }
  #table_check td:nth-child(2):before {
    content: '날짜:';
  }
  #table_check td:nth-child(3):before {
    content: '예상 지출 비용:';
  }
  #table_check td:nth-child(4):before {
    content: '기타 메모 사항:';
  }
  #table_check tr {
    padding: 10px 0;
    position: relative;
  }
  #table_check tr:first-child {
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

  #table_check td:first-child {
    background-color: #c8e7ea;
    border-bottom: 1px solid #91ced4;
    border-radius: 10px 10px 0 0;
    position: relative;
    top: 0;
    -webkit-transform: translateY(0);
            transform: translateY(0);
    width: 100%;
  }
  #table_check td:not(:first-child) {
    margin: 0;
    padding: 5px 1em;
    width: 100%;
  }
  #table_check td:not(:first-child):before {
    font-size: .8em;
    padding-top: 0.3em;
    position: relative;
  }
  #table_check td:last-child {
    padding-bottom: 1rem !important;
  }

  #table_check tr {
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
    overflow: auto;
  }
}
</style>

<script type="text/javascript">
$(window).on("load resize ", function() {
	  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
	  $('.tbl-header').css({'padding-right':scrollWidth});

}).resize();

function checkForm(){
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
		url : 'additionalIncome',
		type : 'POST',
		data : {a_date : a_date, payment : payment, price : price, a_memo : a_memo},
		dataType : 'json',
		success : function(data){
			if(data.disposableSavings==0){
				alert('잔여금액이 없습니다!!! 저축 액수 및 비상지출 대비 액수 정산이 불가능합니다!!!');
				return false;
			}
			
			if(day==19){
				checkForm2(data);
			}
		
		location.href="http://localhost:8888/msm/user/householdAccount";
		}
	});
}

/* 정산 회수를 해당 날짜의 1회만 적용 - 현재 상태 : 날짜 한정 가능, 해당 날짜 내 1회성 제한이 불가능 - 계속 통장이 입금될 경우 잔여금액에 마이너스가 발생 */
function checkForm2(data){
	alert('저축 통장 및 연간 지출 대비 통장 입금은 매월 19일에 의무적으로 정산되어야 합니다.');
	
	$.ajax({
		url : 'emergencyExpense',
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
		url : 'userUpdate2',
		type : 'POST',
		data : {u_emergences : num},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/user/householdAccount";
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
		url : 'userUpdate2',
		type : 'POST',
		data : {u_emergences : num},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/user/householdAccount";
		}
	});
}

function checkForm3(){
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
		url : 'expenseUpdate',
		type : 'POST',
		data : {expenseDate:e_date, expenseSubCategory:cate_check, expensePayment:e_payment, expensePrice:e_price, expenseMemo:e_memo},
		dataType : 'json',
		success : function(ob){
			checkForm4(ob);
		}
	});
}

function checkForm4(ob){
	
	var checkMessage = ob.alertMessage;
	alert(checkMessage);

	if(checkMessage.substr(0,3)=='(A)'){
		alert(checkMessage);
		location.href="http://localhost:8888/msm/user/householdAccount";
	}
	
	$.ajax({
		url : 'expenseUpdate2',
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
			
			location.href="http://localhost:8888/msm/user/householdAccount";
		}
	});
	
}

function checkForm5(SavingsAcc, PureAcc){
	var automaticTransfer1 = document.getElementById('automaticTransfer1').value; // 저축 통장에서 연간 이벤트 통장으로 이체
	var automaticTransfer2 = document.getElementById('automaticTransfer2').value; // 잔여 액수에서 저축 통장으로 이체
	
	if(isNaN(automaticTransfer1)){
		return false;
	}
	
	if(isNaN(automaticTransfer2)){
		return false;
	}
	
	if(automaticTransfer1>0){
		if(SavingsAcc<=0){
			alert('저축 통장에서 출금할 잔여 금액이 없습니다!!!');
			return false;
		}
		
		$.ajax({
			url : 'transferAutomatic1',
			type : 'POST',
			data : {automaticTransfer:automaticTransfer1},
			dataType : 'text',
			success : function(data){
				alert(data);
				location.href="http://localhost:8888/msm/user/householdAccount";
			}
		});
	}
	
	if(automaticTransfer2>0){
		if(PureAcc<=0){
			alert('순수 잔여 액수에서 예금할 잔여 금액이 없습니다!!!');
			return false;
		}
		
		$.ajax({
			url : 'transferAutomatic2',
			type : 'POST',
			data : {automaticTransfer:automaticTransfer2},
			dataType : 'text',
			success : function(data){
				alert(data);
				location.href="http://localhost:8888/msm/user/householdAccount";
			}
		});
	}
}
</script>

<body>
<br/>
<div align="center">
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">변동 수입 추가 기록</button>
&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal2">추가 지출 내역 기입</button>
&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal3">비상 지출 통장 추가 입금</button>
&nbsp&nbsp
<a href="../newhome"><img src="../resources/template/img/homeReturn.png" width="50px" height="50px"></a>
</div>

<section>
  <h1>Additional Income</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
        </tr>
      </thead>
    </table>
  </div>
  
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
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
      </tbody>
    </table>
  </div>
</section>

<section>
  <h1>Expense Figures</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
        </tr>
      </thead>
    </table>
  </div> 
 
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
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
      
      <c:if test="${accResult ==null }">
	  <tr><td colspan="3">등록된 내역이 없습니다.</td></tr>
	  </c:if>
	  
      </tbody>
    </table>
  </div>
</section>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm()">확인</button>
		  </div>
	
	    </div>
	</div>
</div>

<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm3()">확인</button>
		  </div>
	
	    </div>
	</div>
</div>

<div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">예측 가능 변동 지출에 대한 처리사항</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	      <div class="modal-body">
	          <form>
	           <div class="form-group">
	           		<div class="table-users">
   						<div class="header">변동 지출 가용 범위</div>

   						<table id="table_check">
					      <tr>
					      	 <th>고정형 변동 지출액</th>
					         <th>유동형 변동 지출액</th>
					         <th>고정형 규정 범위</th>
					         <th>유동형 규정 범위</th>
					      </tr>

					      <tr>
					         <td>${fixedSumResult}</td>
					         <td>${floatingSumResult}</td>
					         <td>${fixedRangeResult}</td>
					         <td>${floatingRangeResult}</td>
					      </tr>
   						</table>
					</div>
	           </div>
	           
	           <div class="form-group">
	           		<div class="table-users">
   						<div class="header">비상 지출 대비 통장 내역</div>

   						<table id="table_check">
					      <tr>
					         <th>연간 지출 통장</th>
					         <th>의무 저축 통장</th>
					         <th>순수 잔여 금액</th>
					         <th>금월 총 지출액수</th>
					         <th>생활 적정 금액</th>
					      </tr>

					      <tr>
					         <td>${AnnualAcc}</td>
					         <td>${SavingsAcc}</td>
					         <td>${PureAcc}</td>
					         <td>${ExpenseCombined}</td>
					         <td>${reasonableSum}</td>
					      </tr>
   						</table>
					</div>
	           </div>
	           
	           <div class="form-group">
	             	<label for="recipient-name" class="form-control-label">저축->연간 이벤트</label>
	             	<input type="text" class="form-control" id="automaticTransfer1">
	           </div>
	           <div class="form-group">
	             	<label for="recipient-name" class="form-control-label">잔여 액수->저축</label>
	             	<input type="text" class="form-control" id="automaticTransfer2">
	           </div>
	    	 </form>
          </div>
      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm5(${SavingsAcc}, ${PureAcc})">확인</button>
		  </div>
	
	    </div>
	</div>
</div>
</body>
</html>