<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login Page Form</title>

<!--modal 셋팅  -->
<meta charset="utf-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style>
body, html {
    height: 100%;
    background-repeat: no-repeat;
    background-image: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));
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
    background-color: #F7F7F7;
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

function checkForm(){
	var email = document.getElementById('recipient-name').value;
	alert(email);
	
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
	
	alert(checkNum);
	alert(varification);
	alert(email);
	
	alert(checkNum==varification);
	
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
	
	alert(id);
	alert(name);
	alert(email);
	
	$.ajax({
		url : 'pwdVarification1',
		type : 'POST',
		data : {u_id: id, u_name: name, u_email: email },
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href("http://localhost:8888/msm/");
		}
	});
}

function checkForm4(){
	var cpwd = document.getElmentById('check_pwd').value;
	var varification = document.getElementById('varification2').value;
	
	alert(cpwd);
	alert(varification);
	
	if(cpwd != varification){
		return false;
	}
}

$( document ).ready(function() {
    loadProfile();
});

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
            
          	<c:if test="${varification2==null}">
	            <form action="userLogin" class="form-signin" method="post">
	                <span id="lgoinForm" class="lgoinForm"></span>
	                <input type="text" id="u_id" name="u_id" class="form-control" placeholder="아이디를 입력하시오.">
	                <input type="password" id="u_pwd" name="u_pwd" class="form-control" placeholder="패스워드를 입력하시오.">
	                
	                <div id="remember" class="checkbox">
	                    <label>
	                        <input type="checkbox" value="remember-me"> 패스워드 저장
	                    </label>
	                </div>
	                
	                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
	                <button class="btn btn-lg btn-primary btn-block btn-signin" type="reset">취소</button>
	                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">아이디 찾기</button>
	                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal2">비밀번호 찾기</button>
	            </form>
            </c:if>
            
            <c:if test="${varification2!=null && loginID!=null}">
	            <form action="pwdVarification2" class="form-signin" method="post" onsubmit="return checkForm4()">
		                <span id="lgoinForm" class="lgoinForm"></span>
		                <input type="text" id="check_id" name="check_id" class="form-control" placeholder="아이디를 입력하시오.">
		                <input type="password" id="check_pwd" name="check_pwd" class="form-control" placeholder="임시 패스워드를 입력하시오.">
		                <input type="password" id="renew_pwd" name="renew_pwd" class="form-control" placeholder="새로운 패스워드를 입력하시오.">
		                
		                <div id="remember" class="checkbox">
		                    <label>
		                        <input type="checkbox" value="remember-me"> 패스워드 저장
		                    </label>
		                </div>
		                
		                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
		                <button class="btn btn-lg btn-primary btn-block btn-signin" type="reset">취소</button>
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
	            <input type="text" class="form-control" id="recipient-name">
	          </div>
	          
	          <div class="form-group">
	            <label for="message-text" class="form-control-label">인증 번호 입력</label>
	            <input type="text" class="form-control" id="text" readonly="readonly">
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
	            <input type="text" class="form-control" id="incheck">
	          </div>
	        </form>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        	<button type="button" class="btn btn-primary" id="btn check2" onclick="return checkForm2()">임시 비밀번호 전송</button>
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
            <input type="text" class="form-control" id="recipient-name2">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">ID</label>
            <input type="text" class="form-control" id="id2">
          </div>
          
          <div class="form-group">
            <label for="message-text" class="form-control-label">이름</label>
            <input type="text" class="form-control" id="u_name">
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