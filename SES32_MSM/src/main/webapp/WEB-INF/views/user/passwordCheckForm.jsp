<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script type="text/javascript">
function checkForm(){
	var id = document.getElementById('u_id').value;
	var name = document.getElementById('u_name').value;
	var email = document.getElementById('u_email').value;
	
	alert(id);
	alert(name);
	alert(email);
	
	$.ajax({
		url : 'pwdVarification1',
		type : 'POST',
		data : {u_id : id, u_name : name, u_email : email},
		dataType: 'text',
		success : function(data){
			alert(data);
			this.close();
		}
	});
}


</script>



</head>

<body>
<form onsubmit='return checkForm()'>
	<table border="1">
		<tr>
			<th> 아이디  </th><td><input type="text" id="u_id" name="u_id"></td>
		</tr>
		<tr>
			<th> 이름 </th><td><input type="text" id="u_name" name="u_name"></td>
		</tr>
		<tr>
			<th>이메일 </th><td><input type="text" id="u_email" name="u_email"></td>
		</tr>
	</table>

	<span>
    	<input type="submit" value="찾기"> 
    	<input type="reset" value="취소">
    </span>
</form>
</body>
</html>