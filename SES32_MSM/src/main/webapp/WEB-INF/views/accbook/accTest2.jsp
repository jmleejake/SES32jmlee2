<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<form name="form1">
    <select name="sel1" size="10">
    <option value="값">텍스트</option>
    </select>
</form>
 
<script language="JavaScript">

    function addOption(){
        var frm = document.form1;
        var op = new Option();
        op.value = '값' + frm.sel1.length; // 값 설정
        op.text = "텍스트" + frm.sel1.length; // 텍스트 설정
 
        op.selected = true; // 선택된 상태 설정 (기본값은 false이며 선택된 상태로 만들 경우에만 사용)
 
        frm.sel1.options.add(op); // 옵션 추가
    }

</script>
 
<input type="button" value=" 추가 " onclick="addOption()">
<input type="button" value=" 내용보기 " onclick="alert(document.form1.sel1.innerHTML.replace(/></gi, '>\n<'))">
</div>
</body>
</html>