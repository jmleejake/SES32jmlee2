<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
function checkForm(){
	var check = document.getElementById('checkVarification').value;
	
	var data = document.getElementById('varification').value;
	var email = document.getElementById('email').value;
	
	alert(check);
	alert(data);
	alert(email);
	
	if(check = data){
		$.ajax({
			url : 'IdSearching',
			type : 'POST',
			data : {u_email : email},
			dataType : 'text',
			success : function(data){
				alert(data);
				this.close();
			},
			error : function(e){
				alert(JSON.Stringify(e));
			}
		});
	}
}
</script>

</head>
<body>

<%
	String varification = (String) request.getAttribute("varification");
	String email = (String)request.getAttribute("email");
%>

<form onsubmit='return checkForm()'>
	<input type="hidden" id="varification" name="varification" value="<%=varification %>">
	<input type="hidden" id="email" name="email" value="<%=email %>">
	<table border="1">
		<tr>
			<th>인증 번호 입력 </th><td><input type="text" id="checkVarification" name="checkVarification"></td>
		</tr>
	</table>

	<span>
    	<input type="submit" value="찾기"> 
    	<input type="reset" value="취소">
    </span>
</form>

</body>
</html>