<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login Page Form</title>

<!--modal 셋팅  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style>
body, html {
    height: 100%;
    background-repeat: no-repeat;
    background-image: url("../resources/template/img/intro-bg.jpg");
}

.card-container.card {
    max-width: 350px;
    padding: 40px 40px;
}

.btn {
    font-weight: 700;
    height: 36px;
    -moz-user-select: none;
    -webkit-user-select: none;
    user-select: none;
    cursor: default;
}

.card {
    padding: 20px 25px 30px;
    margin: 0 auto 25px;
    margin-top: 50px;
    -moz-border-radius: 2px;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}

.profile-img-card {
    width: 96px;
    height: 96px;
    margin: 0 auto 10px;
    display: block;
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    border-radius: 50%;
}

.profile-name-card {
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    margin: 10px 0 0;
    min-height: 1em;
}

.lgoinForm {
    display: block;
    color: #404040;
    line-height: 2;
    margin-bottom: 10px;
    font-size: 14px;
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}

.form-signin #u_id,
.form-signin #u_pwd {
    direction: ltr;
    height: 44px;
    font-size: 16px;
}

.form-signin input[type=password],
.form-signin input[type=text],
.form-signin button {
    width: 100%;
    display: block;
    margin-bottom: 10px;
    z-index: 1;
    position: relative;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}

.form-signin .form-control:focus {
    border-color: rgb(104, 145, 162);
    outline: 0;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgb(104, 145, 162);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgb(104, 145, 162);
}

.btn.btn-signin {
    /*background-color: #4d90fe; */
    background-color: rgb(104, 145, 162);
    /* background-color: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));*/
    padding: 0px;
    font-weight: 700;
    font-size: 14px;
    height: 36px;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    border-radius: 3px;
    border: none;
    -o-transition: all 0.218s;
    -moz-transition: all 0.218s;
    -webkit-transition: all 0.218s;
    transition: all 0.218s;
}

.btn.btn-signin:hover,
.btn.btn-signin:active,
.btn.btn-signin:focus {
    background-color: rgb(12, 97, 33);
}
</style>

<script>
$('#exampleModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var recipient = button.data('whatever') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('New message to ' + recipient)
	  modal.find('.modal-body input').val(recipient)
})
</script>

<script type="text/javascript">
$( document ).ready(function() {
    loadProfile();
    
    $("#timer_check").click(function(){ 
    	dailyMissionTimer(90);
    });
});

function dailyMissionTimer(duration) {
    
    var timer = duration
    var minutes, seconds;
    
    var interval = setInterval(function(){
        minutes = parseInt(timer / 60 % 60, 10);
        seconds = parseInt(timer % 60, 10);
		
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
		
        $('#time-min').text(minutes);
        $('#time-sec').text(seconds);

        if (--timer < 0) {
            timer = 0;
            clearInterval(interval);
            alert("제한시간 초과되었습니다. 다시 작업 시행하십시오.");
            location.href="http://localhost:8888/msm/user/loginPage";
        }
    }, 1000);
}

function checkForm(){
	var email = document.getElementById('recipient-name').value;
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	$.ajax({
		url : 'userVarification',
		type : 'POST',
		data : {u_email: email },
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/user/loginPage";
		}
	});
}

function checkForm2(){
	var checkNum = document.getElementById('incheck').value;
	var varification = document.getElementById('varification').value;
	var email = document.getElementById('email').value;
	
	if(checkNum!=varification){
		alert('인증번호가 일치하지 않습니다.');
		return false;
	}
	
	if(checkNum==varification){
		$.ajax({
			url : 'IdSearching',
			type : 'POST',
			data : {u_email: email, check: varification },
			dataType : 'text',
			success : function(data){
				alert(data+'아이디 확인 되었습니다.');
				location.href="http://localhost:8888/msm/user/loginPage";
			}
		});
	}
}

function checkForm3(){
	var id = document.getElementById('id2').value;
	var name = document.getElementById('u_name').value;
	var email = document.getElementById('recipient-name2').value;
	
	if(id=='' || name=='' || email==''){
		alert('해당란에 값을 입력하십시오.');
		return false;
	}
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	$.ajax({
		url : 'pwdVarification1',
		type : 'POST',
		data : {u_id: id, u_name: name, u_email: email },
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/user/loginPage";
		}
	});
}

function checkForm4(){
	var id = document.getElementById('check_id').value;
	var cpwd = document.getElmentById('check_pwd').value;
	var varification = document.getElementById('varification2').value;
	
	if(id != sessionID){
		alert('아이디가 일치하지 않습니다.');
		return false;
	}
	
	if(cpwd != varification){
		alert('임시 비밀번호가 일치하지 않습니다.')
		return false;
	}
	
	return true;
}

function checkForm5(){
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
	
	var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	
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
    var month = Number(birth.substr(6,2));
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
		url : 'userInsert',
		type : 'POST',
		data : {u_id: id, u_pwd: pwd, u_name: name, u_email: email, u_phone: phone, u_birth: birth, u_address: address },
		dataType : 'text',
		success : function(data){
			alert(data);
			
			if(confirm('비상금액을 별도로 입력하시겠습니까?')){
				insertEmergencies(id);
			}
			else{
				location.href="http://localhost:8888/msm/user/loginPage";
			}
		}
	});
}

function insertEmergencies(id){
	var num = prompt('희망 비상금액을 입력하십시오.', '');
	
	if(isNaN(num)){
		alert('숫자만 입력하십시오.');
		return false;
	}
	
	$.ajax({
		url : 'userUpdate2',
		type : 'POST',
		data : {u_id: id, u_emergences: num},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm/user/loginPage";
		}
	});
}

function checkForm6(){
	var id = prompt('사용하실 아이디를 입력하시오', '');
	
	if(id==null){
		alert('아이디를 입력하지 않았습니다.');
		return false;
	}
	
	var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
	
    if(!idReg.test(id)) {
        alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
        return false;
    }
	
	$.ajax({
		url : 'idCheck',
		type : 'POST',
		data : {u_id: id },
		dataType : 'text',
		success : function(data){
			
			if(id==data){
				alert(data+' 아이디가 존재합니다. 다른 아이디를 사용하십시오');
				return false;
			}
			else if(data==''){
				alert('사용 가능한 아이디입니다');
				document.getElementById('u_id_check').value=id;
			}
		}
	});
}

function getLocalProfile(callback){
    var profileImgSrc      = localStorage.getItem("PROFILE_IMG_SRC");
    var profileName        = localStorage.getItem("PROFILE_NAME");
    var profileReAuthEmail = localStorage.getItem("PROFILE_REAUTH_EMAIL");

    if(profileName !== null
            && profileReAuthEmail !== null
            && profileImgSrc !== null) {
        callback(profileImgSrc, profileName, profileReAuthEmail);
    }
}

function loadProfile() {
    if(!supportsHTML5Storage()) { return false; }
    // we have to provide to the callback the basic
    // information to set the profile
    getLocalProfile(function(profileImgSrc, profileName, profileReAuthEmail) {
        //changes in the UI
        $("#profile-img").attr("src",profileImgSrc);
        $("#profile-name").html(profileName);
        $("#lgoinForm").html(profileReAuthEmail);
        $("#u_id").hide();
        $("#remember").hide();
    });
}

/**
 * function that checks if the browser supports HTML5
 * local storage
 *
 * @returns {boolean}
 */
function supportsHTML5Storage() {
    try {
        return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
        return false;
    }
}
</script>

</head>
<body>
<input type="hidden" id="varification" value="${varification}">
<input type="hidden" id="varification2" value="${varification2}">
<input type="hidden" id="email" value="${email}">

    <div class="container">
        <div class="card card-container">
            <!-- <img class="profile-img-card" src="https://media.giphy.com/media/hdEhU942MSM6Y/giphy.gif" alt="" /> -->
            <img id="profile-img" class="profile-img-card" src="https://media.giphy.com/media/hdEhU942MSM6Y/giphy.gif" />
            <p id="profile-name" class="profile-name-card"></p>
            
          	<c:if test="${memberRegistrationCheck==null && loginFail==null}">
		        <form action="userLogin" class="form-signin" method="post">
		        <span id="lgoinForm" class="lgoinForm"></span>
		        	<input type="text" id="u_id" name="u_id" class="form-control" placeholder="아이디를 입력하시오." autofocus="autofocus">
		            <input type="password" id="u_pwd" name="u_pwd" class="form-control" placeholder="패스워드를 입력하시오.">
		                
			            <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
			            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal3">회원 가입</button>
			            
			            <div align="center">
				            <a  data-toggle="modal" data-target="#exampleModal">아이디 찾기</a>
				            <a  data-toggle="modal" data-target="#exampleModal2">비밀번호 찾기</a>
			            </div>
		        </form>
            </c:if> 
            
            <c:if test="${loginID==null && memberRegistrationCheck!=null}">
		        <form action="userLogin" class="form-signin" method="post">
		        <span id="lgoinForm" class="lgoinForm"></span>
		        	<input type="text" id="u_id" name="u_id" class="form-control" placeholder="아이디를 입력하시오." autofocus="autofocus">
		            <input type="password" id="u_pwd" name="u_pwd" class="form-control" placeholder="패스워드를 입력하시오.">
		                
			            <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
			            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal3">회원 가입</button>
			            
			            <div align="center">
				            <a  data-toggle="modal" data-target="#exampleModal">아이디 찾기</a>
				            <a  data-toggle="modal" data-target="#exampleModal2">비밀번호 찾기</a>
			            </div>
		        </form>
            </c:if>     
            
            <c:if test="${loginID==null && loginFail!=null}">
            <script>alert('회원 정보가 일치하지 않습니다!!!');</script>
		        <form action="userLogin" class="form-signin" method="post">
		        <span id="lgoinForm" class="lgoinForm"></span>
		        	<input type="text" id="u_id" name="u_id" class="form-control" placeholder="아이디를 입력하시오." autofocus="autofocus">
		            <input type="password" id="u_pwd" name="u_pwd" class="form-control" placeholder="패스워드를 입력하시오.">
		                
			            <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
			            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal3">회원 가입</button>
			            
			           	<div align="center">
				            <a  data-toggle="modal" data-target="#exampleModal">아이디 찾기</a>
				            <a  data-toggle="modal" data-target="#exampleModal2">비밀번호 찾기</a>
			            </div>
		        </form>
            </c:if>   
            
            <c:if test="${varification2!=null && loginID!=null}">
	            <form action="pwdVarification2" class="form-signin" method="post" onsubmit="return checkForm4()">
		        <span id="lgoinForm" class="lgoinForm"></span>
		        	<input type="text" id="check_id" name="check_id" class="form-control" placeholder="아이디를 입력하시오." autofocus="autofocus">
		            <input type="password" id="check_pwd" name="check_pwd" class="form-control" placeholder="임시 패스워드를 입력하시오.">
		            <input type="password" id="renew_pwd" name="renew_pwd" class="form-control" placeholder="새로운 패스워드를 입력하시오.">
		                
		                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
		        </form>
            </c:if>
		</div>
	</div>

<c:if test="${varification==null}">
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
	    	<div class="modal-content">
	      			<div class="modal-header">
	        			<h5 class="modal-title" id="exampleModalLabel">아이디 찾기</h5>
	          				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          					<span aria-hidden="true">&times;</span>
	        				</button>
	      			</div>
	      			
	        <div class="modal-body">
		        <form>
		          <div class="form-group">
		            <label for="recipient-name" class="form-control-label">이메일</label>
		            <input type="text" class="form-control" id="recipient-name" placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
		          </div>
		          
		          <div class="form-group">
		            <label for="message-text" class="form-control-label">인증 번호 입력</label>
		            <input type="text" class="form-control" id="text" readonly="readonly" placeholder="이메일 전송 후 활성화됩니다.">
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
</c:if>

<c:if test="${varification!=null}">
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
	    	<div class="modal-content">
	      			<div class="modal-header">
	        			<h5 class="modal-title" id="exampleModalLabel">아이디 찾기</h5>
	          				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          					<span aria-hidden="true">&times;</span>
	        				</button>
	      			</div>
	      			
	        <div class="modal-body">
		        <form>
		          <div class="form-group">
		            <label for="recipient-name" class="form-control-label">이메일</label>
		            <input type="text" class="form-control" id="recipient-name" value="${email}" readonly="readonly">
		          </div>
		          
		          <div class="form-group">
		            <label for="message-text" class="form-control-label">인증 번호 입력</label>
		            <input type="text" class="form-control" id="incheck" placeholder="이메일에 전송된 인증번호를 입력하여 주십시오.">
		          </div>
		        </form> 
	        </div>
	      
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	          <button type="button" class="btn btn-primary" id="btn check2" onclick="return checkForm2()">임시 비밀번호 전송</button>
	        
	      	  <div>
		  			<span id="time-min"></span><span id="time-sec"></span>
	      	  </div>
	        </div>
	      
		  </div>
		</div>
	</div>
</c:if>

<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
    <div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="exampleModalLabel">비밀번호 찾기</h5>
          				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      			</div>
      			
      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">이메일</label>
	            <input type="text" class="form-control" id="recipient-name2" placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
	          </div>
	          
	          <div class="form-group">
	            <label for="message-text" class="form-control-label">ID</label>
	            <input type="text" class="form-control" id="id2" placeholder="아이디를 입력하여 주십시오.">
	          </div>
	          
	          <div class="form-group">
	            <label for="message-text" class="form-control-label">이름</label>
	            <input type="text" class="form-control" id="u_name" placeholder="본명을 입력하여 주십시오.">
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
        			<h5 class="modal-title" id="exampleModalLabel">회원가입 창</h5>
          				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      			</div>
      			
      <div class="modal-body">
    	<form>
          <div class="form-group">
            <label for="recipient-name" class="form-control-label">아이디 </label>
            <input type="text" class="form-control" id="u_id_check" name="u_id" readonly="readonly" placeholder="아이디 입력 전 중복 체크 확인하십시오.">
            <input type="button" value="아이디 중복 체크 확인" onclick="checkForm6()">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label"> 비밀번호</label>
            <input type="password" class="form-control" id="u_pwd_check" name="u_pwd" placeholder="비밀번호는 8자 이상 16자 이하, 문자, 숫자, 특수문자 조합으로 입력하여 주십시오.">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label"> 비밀번호 확인</label>
            <input type="password" class="form-control" id="u_pwd_check2" placeholder="비밀번호를 다시 한번 입력하여 주십시오.">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label"> 이름 </label>
            <input type="text" class="form-control" id="u_name_check" placeholder="본명을 입력하여 주십시오.">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">이메일</label>
            <input type="text" class="form-control" id="u_email_check" name="u_email" placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">전화번호</label>
            <input type="text" class="form-control" id="u_phone_check" name="u_phone" placeholder="숫자, -(구분자)를 포함하여 입력합시오">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">생년월일</label>
            <input type="date" class="form-control" id="u_birth_check" name="u_birth" placeholder="구분자없이 년월일을 입력하십시오(19900222 등)">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">주소</label>
            <input type="text" class="form-control" id="u_address_check" name="u_address" placeholder="주소를 입력하여줍시오.">
          </div>
    	</form>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm5()">확인</button>
      </div>
      
    </div>
	</div>
</div>
</body>
</html>