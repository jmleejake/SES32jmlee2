<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UserPage</title>

<script type="text/javascript">
function checkForm(){
	var id=document.getElementById('u-id').value; // 아이디 입력값
	var pwd=document.getElementById('u_pwd').value; // 패스워드 입력값
	var pwd2=document.getElementById('u_pwd2').value; // 패스워드 확인 입력값
	var name=document.getElementById('u_name').value; // 이름 입력값
	var email=document.getElementById('u_email').value; // 이메일 입력값
	
	if(id =='' || pwd =='' || pwd2==''|| name=='' || email==''){
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
	
	return true;
}

</script>

</head>

<body>
<form action="userInsert" method="post" onsubmit='return checkForm()'>
    <table border="1">
        <tr>
            <th> 아이디 </th> <td> <input type="text" id="u_id" name="u_id"> </td>
        </tr>
        <tr>
            <th> 비밀번호 </th> <td> <input type="password" id="u_pwd" name="u_pwd"> </td>
        </tr>
        <tr>
            <th> 비밀번호 확인 </th> <td> <input type="password" id="u_pwd2" name="u_pwd2"> </td>
        </tr>
        <tr>
            <th> 이름 </th> <td> <input type="text" id="u_name" name="u_name"> </td>
        </tr>
        <tr>
            <th> 이메일 </th> <td> <input type="text" id="u_email" name="u_email"> </td>
        </tr>
    </table>
    
    <span>
    	<input type="submit" value="가입"> 
    	<input type="reset" value="취소">
    </span>
</form>
 
</body>
</html>