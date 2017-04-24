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
	var e_date = document.getElementById('expense_date').value;
	
	var main_cate = null;
	var main_cate_check = document.getElementsByName('main_cate');
	for(var i=0; i<main_cate_check.length; i++){
		if(main_cate_check[i].checked==true){
			main_cate = main_cate_check[i].value;
		}
	}
	
	var cate_check=null;
	var e_cate = document.getElementsByName('sub_cate');
	for(var i=0; i<e_cate.length; i++){
		if(e_cate[i].checked==true){
			cate_check = e_cate[i].value;
		}
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
	
	if(main_cate==null){
		alert('상위 카테고리 중 하나를 반드시 구분하여 선택하십시오!!!');
		return false;
	}
	
	if(cate_check==null){
		alert('하위 카테고리 중 하나를 반드시 구분하여 선택하십시오!!!');
		return false;
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
		data : {a_date:e_date, main_cate:main_cate, sub_cate:cate_check, payment:e_payment, price:e_price, a_memo: e_memo},
		dataType : 'text',
		success : function(ob){
			alert(ob);
			location.href="http://localhost:8888/msm/user/householdAccount";
		}
	});
	
}
</script>

<body>
<br/>
<div align="center">
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">비상금 누적 및 이용</button>
	&nbsp&nbsp
	<a href="../newhome"><img src="../resources/template/img/homeReturn.png" width="50px" height="50px"></a>
</div>

<section>
  <h1>비상금 누적 내역</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
          <th>메모</th>
          <th>지불수단</th>
        </tr>
      </thead>
    </table>
  </div>
  
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
 	  <c:if test="list!=null">
      <c:forEach var="check1" items="${list}">
      <tr>
          <td>${check1.a_date}</td>
          <td>${check1.sub_cate}</td>
          <td>${check1.price}</td>
          <td>${check1.a_memo}</td>
          <td>${check1.payment}</td>
      </tr>
      </c:forEach>
      </c:if>
      </tbody>
    </table>
  </div>
</section>

<section>
  <h1>비상금 소비 내역</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
          <th>메모</th>
          <th>지불수단</th>
        </tr>
      </thead>
    </table>
  </div> 
 
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
      <c:if test="list2!=null">
      <c:forEach var="check2" items="${list2}">
      <tr>
          <td>${check2.a_date}</td>
          <td>${check2.sub_cate}</td>
          <td>${check2.price}</td>
          <td>${check2.a_memo}</td>
          <td>${check2.payment}</td>
      </tr>
      </c:forEach>
      </c:if>
      </tbody>
    </table>
  </div>
</section>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">비상금 누적 및 이용</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	     <div class="modal-body">
	          <form>
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">일자</label>
	             <input type="date" class="form-control" id="expense_date">
	           </div>
	           
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">종류</label>
	           	         <input type="radio"  name="main_cate" value="PLS">누적
	            		 <input type="radio"  name="main_cate" value="MIN">소비
	           </div>
	           
	           <div class="form-group">
	           	   <label for="recipient-name" class="form-control-label">내용</label><br/>
	           
		            	<input type="radio"  name="sub_cate" value="주거생활비">주거생활비
		            	<input type="radio"  name="sub_cate" value="금융소득">금융소득
		            	<input type="radio"  name="sub_cate" value="건강관리비">건강관리비
		            	<input type="radio"  name="sub_cate" value="의류미용비">의류미용비
		            	<input type="radio"  name="sub_cate" value="교통비">교통비
		            	<input type="radio"  name="sub_cate" value="식비">식비
		            	<input type="radio"  name="sub_cate" value="문화생활비">문화생활비<br/>
		            	<input type="radio"  name="sub_cate" value="차량유지비">차량유지비
		            	<input type="radio"  name="sub_cate" value="사회생활비">사회생활비
		            	<input type="radio"  name="sub_cate" value="유흥비">유흥비
		            	<input type="radio"  name="sub_cate" value="금융보험비">금융보험비
		            	<input type="radio"  name="sub_cate" value="저축">저축
		            	<input type="radio"  name="sub_cate" value="근로소득">근로소득
		            	<input type="radio"  name="sub_cate" value="학비">학비
	          </div>
	          
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
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm()">확인</button>
		  </div>
	
	    </div>
	</div>
</div>

</body>
</html>