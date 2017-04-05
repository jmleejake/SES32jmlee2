<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<style>
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
  text-align: left;
  font-weight: 500;
  font-size: 12px;
  color: #fff;
  text-transform: uppercase;
}

td{
  padding: 15px;
  text-align: left;
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
  margin: 50px;
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
</script>

<body>
<section>
  <h1>Income Figures</h1>
  
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
        <tr>
          <td>2017-04-04</td>
          <td>식비 </td>
          <td>2,000,000</td>
        </tr>
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
        <tr>
          <td>2017-04-04</td>
          <td>식비 </td>
          <td>2,000,000</td>
        </tr>
      </tbody>
    </table>
  </div>
</section>
  
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<a href="javascript:calculatorOpen()">계산기</a><br/>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">등록</button>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">등록</h5>
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
	            <label for="recipient-name" class="form-control-label">액수</label>
	            <input type="text" class="form-control" id="acc_price">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">구분</label>
	            <div align="center">수입 <input type="radio" name="acc_type"> 지출 <input type="radio" name="acc_type"></div>
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