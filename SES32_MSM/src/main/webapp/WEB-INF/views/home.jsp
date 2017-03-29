<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>   

<html>
<head>
<title>Home</title>
<!-- CSS mimi -->
<link href="./resources/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 


<script type="text/javascript">
function checkForm(){
	var pwd=document.getElementById('u_pwd').value; // 패스워드 입력값
	var pwd2=document.getElementById('u_pwd2').value; // 패스워드 확인 입력값
	var name=document.getElementById('u_name').value; // 이름 입력값
	var email=document.getElementById('u_email').value; // 이메일 입력값
	var phone=document.getElementById('u_phone').value; // 핸드폰(01x-xxxx-xxxx) 입력값
	
	if(pwd =='' || pwd2==''|| name=='' || email==''){
		alert('모든 항목에 해당 내용을 입력하십시오.');
		return false;
	}
	
	if(pwd != pwd2){
		alert('입력하신 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	// 비밀번호 유효성 체크 (문자, 숫자, 특수문자의 조합으로 6~16자리)
	if(!pwd.match(/[a-zA-Z0-9]*[^a-zA-Z0-9\n]+[a-zA-Z0-9]*$/))
    {
        alert('비밀번호는 문자, 숫자, 특수문자의 조합으로 8~16자리로 입력해주세요.');
        return false;
    }
	
	if(id.indexOf(pwd)>-1){
		alert('비밀번호에 아이디를 사용할 수 없습니다.');
		return false;
	}
	
	var SamePass_0 = 0; //동일문자 카운트
	var SamePass_1 = 0; //연속성(+) 카운드
	var SamePass_2 = 0; //연속성(-) 카운드
	 
	for(var i=0; i < pwd.length; i++) {
	   var chr_pass_0 = pwd.charAt(i);
	   var chr_pass_1 = pwd.charAt(i+1);
	     
	   //동일문자 카운트
	   if(chr_pass_0 == chr_pass_1) {
	      SamePass_0 = SamePass_0 + 1;
	   }
	     
	   var chr_pass_2 = pwd.charAt(i+2);

	   //연속성(+) 카운드
	   if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
	      SamePass_1 = SamePass_1 + 1;
	   }
	     
	   //연속성(-) 카운드
	   if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
	      SamePass_2 = SamePass_2 + 1;
	   }
	}
	
	if(SamePass_0 > 1) {
	   alert("동일문자를 3번 이상 사용할 수 없습니다.");
	   return false;
	}
	  
	if(SamePass_1 > 1 || SamePass_2 > 1 ) {
	   alert("연속된 문자열(123 또는 321, abc, cba 등)을 3자 이상 사용 할 수 없습니다.");
	   return false;
	}
	
	// 이메일 유효성 체크
	// 검증에 사용할 정규식 변수 regExp에 저장
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if (email.match(regExp) == null) {
		alert('이메일 형식을 정확하게 입력하시오(penguin@naver.com 등)');
	   return false;
	}
	
	var regExp2 = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

	if ( !regExp2.test( phone ) ) {
	      alert("잘못된 휴대폰 번호입니다. 숫자, - 를 포함한 숫자만 입력하세요.");
	      return false;
	}

	return true;
}

function deleteCheck(pwd, id){
	var pwdRecheck = prompt('패스워드를 다시 한번 입력하십시오');
	
	if(pwdRecheck = pwd){
		if(confirm('정말로 계정을 삭제하시겠습니끼?')){
			$.ajax({
				url : 'user/userDelete?u_id='+id,
				type : 'POST',
				dataType : "text",
				success : function(){
					alert('삭제 완료 되었습니다.');
				}
			});
		}
	}
}

function logoutClickEvent(){
		
	if(confirm("로그아웃 하시겠습니까?")==true){
		location.href="user/userLogout";
	} else{
		return;
	}
}
	
function IDSearchingEvent(){
	
	var email = prompt('이메일을 입력하시오.');
	
	$.ajax({
		url : 'user/userVarification?u_email='+email,
		type : 'GET',
		dataType : "text",
		error : function(){
			alert('실패');
			return false;
		},
		success : function(data){
			alert(data);
			window.open("user/IDSearchingForm?varification="+data+"&email="+email, "아이디 조회 입려창", "top=200, left=400, width=400, height=250, scrollbars=1");
			IDSearchingEvent2(data, email);
		}
	});
}
	
function IDSearchingEvent2(data, email){
	alert('a');
	window.open("user/IDSearchingForm?varification="+data+"&email="+email, "아이디 조회 입려창", "top=200, left=400, width=400, height=250, scrollbars=1");
}
	
function PasswordSearchingEvent(){
	window.open("user/passwordCheckForm", "패스워드 조회 입력창", "top=200, left=400, width=400, height=250, scrollbars=1");	
}

function wrapWindowByMask(){
	//화면의 높이와 너비를 구한다.

	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$('#mask').css({'width': '35%','height': '50%'});  

	//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
	$('#mask').fadeIn(1000);      
	$('#mask').fadeTo("slow", 0.7);    

	//윈도우 같은 거 띄운다.
	$('.window').show();
}
$(document).ready(function(){
//검은 막 띄우기
$('.openMask').click(function(e){
	e.preventDefault();
	wrapWindowByMask();
});

//닫기 버튼을 눌렀을 때
$('.window .close').click(function (e) {  
    //링크 기본동작은 작동하지 않도록 한다.
    e.preventDefault();  
    $('#mask, .window').hide();  
});       


});
</script>

</head>

<body>
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
									<li><a href="user/userPage">회원가입 페이지</a></li>
									<li><a href="user/mapAPI_Test">지도 API 테스트</a></li>
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
								
								<c:if test="${vo.getU_id()!=null }">
								  	<input type="button" value="로그아웃" onclick="logoutClickEvent()">
								  	
								  	<div id="mask">
								  	
									<div class="window">
										<form action="user/userUpdate" method="post" onsubmit='return checkForm()'>
										
    									<table  border="1">
									        <tr>
									            <th> 아이디 </th> <td> <input type="text" id="u_id" name="u_id" value="${vo.getU_id() }"readonly="readonly"> </td>
									        </tr>
									        <tr>
									            <th> 비밀번호 </th> <td> <input type="password" id="u_pwd" name="u_pwd"> </td>
									        </tr>
									        <tr>
									            <th> 비밀번호 확인 </th> <td> <input type="password" id="u_pwd2" name="u_pwd2"> </td>
									        </tr>
									        <tr>
									            <th> 이름 </th> <td> <input type="text" id="u_name" name="u_name" value="${vo.getU_name() }"> </td>
									        </tr>
									        <tr>
									            <th> 이메일 </th> <td> <input type="text" id="u_email" name="u_email" value="${vo.getU_email() }"> </td>
									        </tr>
									        <tr>
									            <th> 연락처 </th> <td> <input type="text" id="u_phone" name="u_phone" value="${vo.getU_phone() }"> </td>
									        </tr>
									        <tr>
									            <th> 생년월일 </th> <td> <input type="date" id="u_birth" name="u_birth" value="${vo.getU_birth() }"> </td>
									        </tr>
									        <tr>
									            <th> 주소 </th> <td> <input type="text" id="u_address" name="u_address" value="${vo.getU_address() }"> </td>
									        </tr>
									        
									        <tr>
									        	<td colspan="2">
									        			<input type="submit" value="수정" > 
									   					<input type="button" value="회원 탈퇴" onclick="deleteCheck('${vo.getU_pwd()}', '${vo.getU_id() }')">
										    			<input type="button" class="close" value="취소">
										    	</td>
									        </tr>
									    </table>
										</form>
									</div>
									</div>
									<a href="#" class="openMask"> 수정 화면 </a>
								  	
            					  </c:if>

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
								  <c:if test="${vo.getU_id()==null }">
								  	<button class="btn btn-default" data-target="#layerpop" data-toggle="modal">로그인 버튼(임시)</button>
								  </c:if>
								  
								  
								</div>
							</div>
						</div>
					</div>
					<div class="shadow">&nbsp;</div>
				</div>
			</div>
		</div>
	</ul>
	
<div class="modal fade" id="layerpop" >
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
        <h4 class="modal-title">로그인 확인사항</h4>
      </div>

      <!-- body -->
      <div class="modal-body">
      <form action="user/userLogin" method="post">
            <table border="1">
            	<tr>
            		<th>--ID--</th>
            		<td><input type="text" id="u_id" name="u_id"></td>
            	</tr>
            	<tr>
            		<th>--Password--</th>
            		<td><input type="password" id="u_pwd" name="u_pwd"></td>
            	</tr>
            	
            	<tr>
            		<td colspan="2" align="center">
            				<input type="submit" value="로그인">
            				<input type="reset" value="취소"><br/>
            				<input type="button" value="아이디 찾기" onclick="IDSearchingEvent();">
            				<input type="button" value="비밀번호 찾기" onclick="PasswordSearchingEvent();">
            		</td>
            	</tr>
            	
            </table>
            
      </form>
      </div>

      <!-- Footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>

</body>
</html>