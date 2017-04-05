<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="excelUpload" method="post" enctype="multipart/form-data">
	<input type="hidden" name="t_id" value="2">
	<input type="hidden" name="t_name" value="jmlee">
	<input type="file" name="upload"><input type="submit" value="엑셀업로드"><br/>
	<div style="color: red; font-size: 20px;">${up_ret }</div>
</form>
<br>
<input type="button" value="샘플다운로드" 
onclick="location.href='sampleDown'">
<br><br>
<input type="button" value="엑셀 다운로드 기능 테스트" 
onclick="location.href='excelDown'">
</body>
</html>