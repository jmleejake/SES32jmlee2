
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
<script src="resources/js/jquery-3.1.1.min.js"></script>

<style>
		.modal-content{
			padding: 30px;
        	font-size: 50px;
        	font-weight: bold;
        	text-align: center;
        	background-color: #ffffff;
        	opacity: 0.5;
		}
</style>
	
<script>
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
			alert("인증번호 : "+data);
			IDSearchingEvent2(data, email);
		}
	});
}
	
function IDSearchingEvent2(data, email){
	var varification = prompt('인증 번호를 입력하시오', '');
		
	if(data == varification){
		$.ajax({
			url : 'user/IdSearching?u_email='+email,
			type : 'POST',
			dataType : "text",
			error : function(){
				alert('실패');
				return false;
			},
			success : function(data){
				alert("아이디 : "+data);
				return true;
			}
		});
	}
}
	
function PasswordSearchingEvent(){
	window.open("user/passwordCheckForm", "패스워드 조회 입력창", "top=200, left=400, width=400, height=250, scrollbars=1");	
}
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
								  <button class="btn btn-default" data-target="#layerpop" data-toggle="modal">로그인 버튼(임시)</button>
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
            		<th>--Name--</th>
            		<td><input type="text" id="u_id" name="u_id"></td>
            	</tr>
            	<tr>
            		<th>--Password--</th>
            		<td><input type="password" id="u_pwd" name="u_pwd"></td>
            	</tr>
            	
            	<tr>
            		<td colspan="2" align="center">
            			<c:if test="${loginID==null}">
            				<input type="submit" value="로그인">
            				<input type="reset" value="취소"><br/>
            				<input type="button" value="아이디 찾기" onclick="IDSearchingEvent();">
            				<input type="button" value="비밀번호 찾기" onclick="PasswordSearchingEvent();">
            			</c:if>
            	
            			<c:if test="${loginID!=null}">
            				<input type="button" value="로그아웃" onclick="logoutClickEvent()">
            			</c:if>
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