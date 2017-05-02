<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error</title>
<!-- icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">

h1, h2, h3 {
	text-align: center;

}

h2, h3 {
	color: gray;
}


#prev {
	margin-left: 45%;
	margin-right: 5%;
}
</style>
<script>

</script>
</head>  
<body>
	
	<i class="fa fa-warning" style="font-size:150px;color:yellow; margin-left: 43%;"></i>

	<h2>이용에 불편을 드려 죄송합니다.</h2>
	<h1>요청하신 페이지를 찾을 수가 없습니다.</h1>
	<h3>요청하신 페이지를 찾을 수가 없습니다. 찾으시려는 페이지의 주소가 변경 혹은 <br> 삭제되어 요청하신 페이지를 찾을 수
		없습니다. 입력하신 주소가 정확한지 다시 한번 부탁드립니다.<br> 서비스 이용에 불편을 드려서 대단히 죄송합니다.</h3>

	<hr>
	<label id="prev" onclick="history.go(-1)" style="cursor: pointer;"><i class="fa fa-angle-double-left" style="color: blue; font-size: 23px; "></i>돌아가기</label>	

</body>
</html>