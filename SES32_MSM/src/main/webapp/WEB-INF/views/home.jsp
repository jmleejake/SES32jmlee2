<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   

<html>
<head>
<title>Home</title>
<!-- CSS mimi -->
<link href="./resources/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 

<!--modal 셋팅  -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
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
			location.href="http://localhost:8888/msm";
		}
	});
}

function checkForm3(){
	var checkNumber = document.getElementById('checkVarificationNumber').value;
	var checkNumber2 = document.getElementById('delteVarification').value;
	
	if(checkNumber!=checkNumber2){
		alert('인증 번호가 일치하지 않습니다.');
		return false;
	}
	
	if(checkNumber==checkNumber2){
		$.ajax({
			url : 'user/userDelete',
			type : 'POST',
			dataType : 'text',
			success : function(data){
				alert(data);
				location.href="http://localhost:8888/msm";
			}
		});
	}
}
</script>
</head>
<body>
<input type="hidden" id="delteVarification" value="${checkDelteNumber}">
	<ul>
		<div id="background">
			<div id="page">

				<div class="header">
					<div class="footer">
						<div class="body">

							<div id="sidebar">
								<a href="index.html"><img id="logo"
									src="./resources/images/logo_msm.png" width="154" height="75"
									alt="" title="" /></a>


								<ul class="navigation">
									<li class="active"><a href="calendar/calTest">캘린더테스트</a></li>
									<li><a href="accbook/accTest">가계부테스트</a></li>
									<li><a href="user/mapAPI_Test">지도 API 테스트</a></li>
									<li><a href="user/householdAccount">수입 및 지출 내역 확인</a></li>
									<li><a href="target/excelTest">엑셀서비스 테스트</a></li>
									<li class="last"><a href="contact.html">CONTACT</a></li>
								</ul>

								<div class="connect">
									<a href="http://facebook.com/freewebsitetemplates"
										class="facebook">&nbsp;</a> <a
										href="http://twitter.com/fwtemplates" class="twitter">&nbsp;</a>
									<a href="http://www.youtube.com/fwtemplates" class="vimeo">&nbsp;</a>
								</div>

								<div class="footenote">
									<span>&copy; Copyright &copy; 2011.</span> <span><a
										href="index.html">Company name</a> all rights reserved</span>
								</div>
								
								<div class="loginButton_Temporary" align="center">
										<c:if test="${loginID==null }">
											<p><a href="user/loginPage">로그인(임시)</a></p>
										</c:if>
										
										<c:if test="${loginID!=null && checkDelteNumber==null}">
											<p><a href="user/userLogout">로그아웃(임시)</a></p>
											<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">회원 정보 수정</button>
											<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal2">회원 정보 탈퇴</button>
										</c:if>
										
										<c:if test="${checkDelteNumber!=null}">
											<p><a href="user/userLogout">로그아웃(임시)</a></p>
											<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">회원 정보 수정</button>
											<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal3">회원 정보 탈퇴</button>
										</c:if>
								</div>
								
							</div>
							<div id="content">

								<img src="./resources/images/cotton-flower.jpg" width="726"
									height="546" alt="" title="">
								<div class="featured">
									<div class="header">
										<ul>
											<li class="first">
												<!--<p>hi.</p> --> <img src="./resources/images/hi.jpg"
												width="50" height="62" alt="" title="">
											</li>
											<li class="last">
												<p>Lorem ipsum dolor sit amet, consectetur adipiscing
													elit. Duis diam urna, malesuada in porttitor eget, suscipit
													sit amet</p>
											</li>
										</ul>
									</div>
									<div class="body">
										<p>
											This website template has been designed by <a
												href="http://www.freewebsitetemplates.com/">Free Website
												Templates</a> for you, for free. You can replace all this text
											with your own text.
										</p>

										<p>
											You can remove any link to our website from this <a
												href="http://www.freewebsitetemplates.com/">website
												template</a>, you're free to use this website
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="shadow">&nbsp;</div>
				</div>
			</div>
		</div>
	</ul>
	
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
	        	<h5 class="modal-title" id="exampleModalLabel">회원정보 삭제 사항</h5>
	          		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          			<span aria-hidden="true">&times;</span>
	        		</button>
	      	</div>
	      			
	      <div class="modal-body">
          <form>
           <div class="form-group">
            <label for="recipient-name" class="form-control-label">인증번호를 입력하십시오.</label>
            <input type="text" class="form-control" id="checkVarificationNumber" placeholder="이메일에 전송된 인증번호를 입력해야 회원 탈퇴가 이뤄집니다.">
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
</body>
</html>