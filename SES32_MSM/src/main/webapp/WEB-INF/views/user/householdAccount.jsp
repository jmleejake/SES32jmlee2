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
  height:100px;
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
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
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
</style>

<script type="text/javascript">
$(window).on("load resize ", function() {
	  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
	  $('.tbl-header').css({'padding-right':scrollWidth});

}).resize();
	
function calculatorOpen(){
	window.open("http://localhost:8888/msm/user/calculator", "", "width=350, height=274, status=1");
}

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
			
			if(day==17){
				checkForm2(data);
			}
		
		location.href="http://localhost:8888/msm/user/householdAccount";
		}
	});
}

/* 정산 회수를 해당 날짜의 1회만 적용 - 현재 상태 : 날짜 한정 가능, 해당 날짜 내 1회성 제한이 불가능 - 계속 통장이 입금될 경우 잔여금액에 마이너스가 발생 */
function checkForm2(data){
	alert('저축 통장 및 연간 지출 대비 통장 입금은 매월 17일에 의무적으로 정산되어야 합니다.');
	
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
</script>

<body>

&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<a href="javascript:calculatorOpen()">계산기</a><br/>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">변동 수입 추가 기록</button>
&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal2">추가 지출 내역 기입</button>
&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal3">비상 지출 통장 추가 입금</button>
&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal4">생활 적정 금액 확인</button>

<section>
  <h1>Combined Arrangement</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>월 고정 수입</th>
          <th>월 변동 총 수입</th>
          <th>월 가처분 소득</th>
          <th>월 변동 지출 총 액수</th>
          <th>비상 지출 대비 의무 입금</th>
          <th>비상금 적재 잔여 액수</th>
          <th>순수 잔여 액수</th>
        </tr>
      </thead>
    </table>
  </div>
  
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
	     <tr>
	       <td>${originalIncome}</td>
	       <td>${fluctuationIncome}</td>
	       <td>${disposableIncome}</td>
	       <td>${expenditureChange}</td>
	       <td>${emergencyPreparednessDeposit}</td>
	       <td>${remainEmergencesAccount}</td>
	       <td>${updateRemainingAmount}</td>	    	       
	     </tr>
      </tbody>
    </table>
  </div>
</section>

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
	        <h5 class="modal-title" id="exampleModalLabel">비상 지출 통장 추가 입금</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	      <div class="modal-body">
	          <form>
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">저축 통장 입금 액수</label>
	             <input type="text" class="form-control" id="">
	           </div>
	          
	           <div class="form-group">
	            <label for="recipient-name" class="form-control-label">연간 일정 대비 통장 입금 액수</label>
	            <input type="text" class="form-control" id="">
	          </div>
	    	 </form>
          </div>
      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="">확인</button>
		  </div>
	
	    </div>
	</div>
</div>

<div class="modal fade" id="exampleModal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">생활 적정 금액 확인</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	      <div class="modal-body">
	          <form>
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">전달 대비 저축률</label>
	             <input type="text" class="form-control" id="">
	           </div>
	          
	           <div class="form-group">
	            <label for="recipient-name" class="form-control-label">축의금 지출 예정 금액</label>
	            <input type="text" class="form-control" id="">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">연간 지출 대비 통장 잔여금액</label>
	            <input type="text" class="form-control" id="">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">월 저축 통장 잔여금액</label>
	            <input type="text" class="form-control" id="">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">전달 대비 생활 적정 금액 기준</label>
	            <input type="text" class="form-control" id="">
	          </div>
	    	 </form>
          </div>
      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="">확인</button>
		  </div>
	
	    </div>
	</div>
</div>
</body>
</html>