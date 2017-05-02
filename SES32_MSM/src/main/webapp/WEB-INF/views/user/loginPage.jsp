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

<!-- jqueryui -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<!-- alert창 CSS -->
<script
	src="../resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />

<link rel="stylesheet"
	href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />

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


<!--가운데 이미지 움직임  -->
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
    
  //가입시 아이디 중복 체크
    $('#u_id_check').on('keyup',idCheck);
  
  
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
//ID 가입 체크
function insertCheck(){
	
	
	var id = document.getElementById('u_id_check').value;
	var pwd = document.getElementById('u_pwd_check').value;
	var pwd2 = document.getElementById('u_pwd_check2').value;
	var name = document.getElementById('u_name_check').value;
	var email = document.getElementById('u_email_check').value;
	var phone = document.getElementById('u_phone_check').value;
	var birth = document.getElementById('u_birth_check').value;
	var address = document.getElementById('u_address_check').value;
	
	if($('#checkIDSpan').attr('check')!='ok'){
		alertify.alert("ID를 체크해주세요.");
		return false;
	}
	
	if(pwd==''){
		alertify.alert('비밀번호를 입력 해주세요.');
		return false;
	}
	if(pwd2==''){
		alertify.alert('비밀번호 확인을 입력 해주세요');
		return false;
	}
	if(name==''){
		alertify.alert('이름을 입력 해주세요.');
		return false;
	}
	if(name.length>20){
		alertify.alert('이름은 20자이내입니다.');
		return false;
	}
	if(email==''){
		alertify.alert('이메일을 입력해주세요');
		return false;
	}
	
	if(pwd != pwd2){
		alertify.alert('입력하신 비밀번호와 비밀번호 확인값이 일치하지 않습니다.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alertify.alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	if(!pwd.match(/[a-zA-Z0-9]*[^a-zA-Z0-9\n]+[a-zA-Z0-9]*$/)){
		alertify.alert('비밀번호는 문자, 숫자, 특수문자 조합으로 입력하여 주십시오.');
		return false;
	}
	

	
	var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	
	
	var regExp2 = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/;

	if(phone.match(regExp2)==null){
		alertify.alert('잘못된 휴대폰 번호입니다. 숫자, -(구분자)를 포함하여 입력합시오');
		return false;
	}
	
 
	
    if($('#accreditation').val()!='인증'){
    	alertify.alert('인증후에 가입이 가능합니다.');
    }else{
    	var f =document.getElementById("userInsertForm");
    	f.submit();

    	
    }	

}

var SetTime = 0;      // 최초 설정 시간(기본 : 초)  300으로 바꾸면 5분으로 됨
var intervalID;   //인증된 후 정지 
//가입 인증 메일 발송
function emailSend() {
	var email = $('#u_email_check').val();
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alertify.alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}

	$.ajax({
		url : 'emailCheckSend',
		type : 'POST',
		data:{
			u_email :email
		},
		dataType : 'text',
		success : function(data){
			if(data =='불가'){
				alertify.alert('사용중인 이메일입니다.');
			}else{
				//메일 발송후 인증 번호 셋팅
				console.log(data);
				$('#accreditation').val(data);	
				$('#acc_check').attr('disabled' ,false);
				
				intervalID = setInterval('msg_time()',1000);
				   
				SetTime=180;

			}
		}
	});

}


	
function msg_time() {   // 1초씩 카운트
    var id = $('#id').val();
     var msg = "현재 남은 시간은 <font color='red'>" + SetTime + "</font> 초 입니다.";
    SetTime--;               // 1초씩 감소
    if (SetTime < 0) {         // 시간이 종료 되었으면..
    	msg="인증 시간이 끝났습니다. 재발송 해주세요."
    	$('#acc_time').html(msg);
    }
    $('#acc_time').html(msg);   // div 영역에 보여줌 
 } 
 
 //가입 인증 체크 
var count=1;
function emailChack() {
	var accreditation =$('#accreditation').val();
	var accreditationText= $('#accreditationText').val();
	$('#acc_check').attr('disabled' ,false);
	//인증 3번 실패한 경우
	if(count==3){
		clearInterval(intervalID);
		msg=""
	        $('#acc_time').html(msg);
		$('#acc_check').attr('readonly' ,true);
		count=1;
		alertify.alert('3회 실패 인증번호를 재발급 받아주세요.');
		$('#acc_check').attr('disabled' ,true);
		return;
	}
	
	if(accreditation == accreditationText && SetTime>=0 && accreditation !='' ){
		clearInterval(intervalID);

		msg="인증되었습니다."
        $('#acc_time').html(msg);

		$('#accreditation').val('인증');		
		alertify.alert('인증되었습니다.');
		$('#u_email_check').attr('readonly' ,'readonly');
		$('#accreditationText').attr('readonly' ,'readonly');
		$('#acc_check_send').attr('disabled' ,true);
		$('#acc_check').attr('disabled' ,true);

	}else{
		alertify.alert('인증번호가 틀립니다.');
		count++;
	}
	
}

function insertEmergencies(id){
	var num = prompt('희망 비상금액을 입력하십시오.', '');
	
	if(isNaN(num)){
		alertify.alert('숫자만 입력하십시오.');
		return false;
	}
	
	$.ajax({
		url : 'userUpdate2',
		type : 'POST',
		data : {u_id: id, u_emergences: num},
		dataType : 'text',
		success : function(data){
			location.href="http://localhost:8888/msm/user/loginPage";
		}
	});
}

function idCheck(){
	var id =$('#u_id_check').val(); 
	$('#checkIDSpan').attr('check','no');
	
	var str = '';
	
	
	if(id.length<6 ){
		str='영문,숫자 조합 6자 이상'
		$('#checkIDSpan').html(str);
		return;	
	}
	
	
	var idReg = /^[a-z]+[a-z0-9]{5,9}$/g;
	
    if(!idReg.test(id)) {
    	str ="조건에 맞지 않습니다.";
    	$('#checkIDSpan').html(str);
        return;
    }
	
    
	$.ajax({
		url : 'idCheck',
		type : 'POST',
		data : {u_id: id },
		dataType : 'text',
		success : function(data){
			
			if(id==data){
				
				str=data+' 아이디가 존재합니다.';
				$('#checkIDSpan').html(str);
				
				return false;
			}
			else if(data==''){
				str ='사용 가능한 아이디입니다';
				$('#checkIDSpan').html(str);
				$('#checkIDSpan').attr('check','ok');
				
			}
		}
	});
	
}

function userIDSearch() {

	var name = document.getElementById('u_s_name_check').value;
	var email = document.getElementById('u_s_email_check').value;
	
	if(name==''){
		alertify.alert('이름을 입력해주세요.');
		return false;
	}
	if(name.length>20){
		alertify.alert('이름은 20자이내입니다.');
		return false;
	}
	if(email==''){
		alertify.alert('이메일을 입력해주세요');
		return false;
	}
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alertify.alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}

  	var f =document.getElementById("userIDSearch");
	f.submit();

	

}

function userPWSearch() {
	var id =$('#u_sp_id_check').val();
	var name = $('#u_sp_name_check').val();
	var email = $('#u_sp_email_check').val();
	
	if(id==''){
		alertify.alert('아이디를 입력해주세요.');
		return false;
	}
	
	if(name==''){
		alertify.alert('이름을 입력 해주세요.');
		return false;
	}
	if(name.length>20){
		alertify.alert('이름은 20자이내입니다.');
		return false;
	}
	if(email==''){
		alertify.alert('이메일을 입력해주세요');
		return false;
	}
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alertify.alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}

  	var f =document.getElementById("userPWSearch");
	f.submit();

	

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
	<!--결과 메세지  -->
	<c:if test="${errorMsg != null }">
		<c:choose>
			<c:when test="${errorMsg == '검색성공' }">
				<script>
					alertify.success("메일을 발송하였습니다.");
				</script>
			</c:when>
			<c:when test="${errorMsg == '등록성공' }">
				<script>
					alertify.success("회원가입이 완료되었습니다.");
				</script>
			</c:when>
			<c:when test="${errorMsg == '검색실패' }">
				<script>
					alertify.alert("존재 하지않는 정보입니다. 다시 한번 확인해주세요.");
				</script>
			</c:when>
			<c:when test="${errorMsg == '등록 실패' }">
				<script>
					alertify.alert("회원가입이 실패하였습니다.");
				</script>
			</c:when>
			<c:when test="${errorMsg == '로그인실패' }">
				<script>
					alertify.alert("아이디 또는 비밀번호를 다시 확인하세요.");
				</script>
			</c:when>
			
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	</c:if>


		

<input type="hidden" id="accreditation" >
    
    
    <div class="container">
        <div class="card card-container">
            <!-- <img class="profile-img-card" src="https://media.giphy.com/media/hdEhU942MSM6Y/giphy.gif" alt="" /> -->
            <img id="profile-img" class="profile-img-card" src="https://media.giphy.com/media/hdEhU942MSM6Y/giphy.gif" />
            <p id="profile-name" class="profile-name-card"></p>
            
          
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

		</div>
	</div>
<!--  아이디 찾기-->
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
		        <form method="post" id="userIDSearch" action="userIDSearch" >
				     <div class="form-group">
				            <label for="message-text" class="form-control-label" > 이름 </label>
				            <input type="text" class="form-control"   id="u_s_name_check" name="u_name">
				          </div>
		   			<div class="form-group">
         				 <label for="message-text" class="form-control-label"> 이메일 </label>
          				 <input type="text" class="form-control" id="u_s_email_check"   name="u_email" placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
         			</div>
						
		        </form>
	        </div>
	      
	        <div class="modal-footer">
	        	<button type="button" class="btn btn-secondary" id="btn check" onclick="return userIDSearch()">확인</button>
	          	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        </div>
	      
	    	</div>
		</div>
	</div>

<!--비밀번호 찾기  -->
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
	        <form method="post" id="userPWSearch" action="userPWSearch" >
	          <div class="form-group">
	            <label for="message-text" class="form-control-label">ID</label>
	            <input type="text" class="form-control" id="id2"  id="u_sp_id_check" name="u_id" placeholder="아이디를 입력하여 주십시오.">
	          </div>
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">이메일</label>
	            <input type="text" class="form-control" id="u_sp_email_check" name="u_email" placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
	      
	          </div>

	          <div class="form-group">
	            <label for="message-text" class="form-control-label">이름</label>
	            <input type="text" class="form-control" id="u_sp_name_check" name="u_name">
	          </div>
	        </form>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="btn check" onclick="return userPWSearch()">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
      
    </div>
	</div>
</div>

<!-- 회원가입 모달창 -->
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
    	<form class="form-inline" id="userInsertForm" method="post" action="userInsert">
          <div class="form-group">
          <br>
            <label for="recipient-name" class="form-control-label" style="margin-right: 45px" >아이디 </label>
           <input type="text"  class="form-control" style="width:200px ;margin-right: 10px"  id="u_id_check"  name="u_id"  >
           <span id="checkIDSpan" check=""></span>

          </div>
          <br><br>
          <div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 31px" > 비밀번호</label>
            <input type="password" class="form-control" style="width:470px" id="u_pwd_check" name="u_pwd" placeholder="8자 이상 16자 이하, 문자, 숫자, 특수문자 조합으로 입력하여 주십시오.">
          </div>
          <br><br>
          <div class="form-group">
            <label for="message-text" class="form-control-label" > 비밀번호 확인</label>
            <input type="password" class="form-control" style="width:470px" id="u_pwd_check2" placeholder="비밀번호를 다시 한번 입력하여 주십시오.">
          </div>
          <br><br>
          <div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 60px" > 이름 </label>
            <input type="text" class="form-control"   style="width:200px" id="u_name_check" name="u_name">
          </div>
          <br><br>
			<div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 45px"> 이메일 </label>
           <input type="text" class="form-control" id="u_email_check" style="width:270px; margin-right: 20px"   name="u_email" >
           <input type="button"  onclick="javascript:emailSend()" value="인증번호 발송" class="btn btn-secondary" id="acc_check_send" >
           <p id="acc_time" align="right"></p>
          </div>
           <br>
			<div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 31px"> 인증번호 </label>
           <input type="text" class="form-control" id="accreditationText" style="width:270px; margin-right: 20px"  >
            <input type="button"  id="acc_check" onclick="javascript:emailChack()" value="인증번호 확인" class="btn btn-secondary" disabled="disabled">
          </div>
           <br><br>
          <div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 31px">전화번호</label>
            <input type="text" class="form-control" id="u_phone_check" style="width:270px" name="u_phone" placeholder="ex)000-0000-0000">
          </div>
            <br><br>
          <div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 31px">생년월일</label>
            <input type="date" class="form-control" style="width:270px" id="u_birth_check" name="u_birth" placeholder="ex)19900222">
          </div>
            <br><br>
          <div class="form-group">
            <label for="message-text" class="form-control-label" style="margin-right: 60px">주소</label>
            <input type="text" class="form-control" style="width:370px; margin-right: 10px"  id="u_address_check" name="u_address" >
         
          </div>
    	</form>
      </div>
      
      <div class="modal-footer" style="text-align: center;">
        <button type="button" class="btn btn-default" id="btn check" onclick="return insertCheck()" >확인</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
      
    </div>
	</div>
</div>
</body>
</html>