<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
$(document).ready(function() {
	// 타겟리스트 초기화
	getTarget();
	
	$("#btn_search").on("click", function() {
		if($("#tar_search").val() == "") {
			alert("검색어를 입력하세요");
			return;
		}
		
		getTarget();
	});
});

function getTarget() {
	$.ajax({
		url:"showTarget"
			, type:"post"
			, data : {search_val : $("#tar_search").val()}
			, dataType : "json"
			, success:showTarget
			, error:function(e) {
				alert(JSON.stringify(e));
			} 
	});
}

function showTarget(list) {
	$("#target_div").html("");
	var tableContent = "";
	tableContent += "<table>";
	tableContent += "<tr>";
	tableContent += "<th>그룹</th>";
	tableContent += "<th>이름</th>";
	tableContent += "<th>생년</th>";
	tableContent += "<th></th>";
	tableContent += "</tr>";
	$.each(list, function(i, target) {
		tableContent += "<tr>";
		tableContent += "<td>" + target.t_group + "</td>";
		tableContent += "<td><a class='showAcc' style='cursor:pointer;' t_id='" + target.t_id + "'>" + target.t_name + "</a></td>";
// 		tableContent += "<td><a href='getTargetAccList?t_id='" + target.t_id + ">" + target.t_name + "</a></td>";
		tableContent += "<td id='td_birth" + target.t_id + "'>" + target.t_birth + "</td>";
		tableContent += "<td><input type='button' class='tar_birth' t_id='" + target.t_id + "' value='생년 입력'></td>";
		tableContent += "</tr>";
	});
	
	tableContent += "</table>";
	$("#target_div").html(tableContent);
	
	var t_id = "";
	$(".tar_birth").on("click", function() {
		t_id = $(this).attr("t_id");
		var birthContent = "";
		birthContent += "<input type='text' id='tx_birth" + t_id + "' style='width:50px;' placeholder='생년'>";
		birthContent += "<input type='button' value='저장' id='btn_tx_birth" + t_id + "' style='width:50px;'>";
		$("#td_birth" + t_id).html(birthContent);
		
		$("#btn_tx_birth" + t_id).on("click", function() {
			$.ajax({
				url:"updateBirth"
					, type:"post"
					, dataType : "json"
					, data : {birth : $("#tx_birth" + t_id).val(), t_id : t_id}
					, success:showTarget
					, error:function(e) {
						alert(JSON.stringify(e));
					} 
			});
		}); // 생년 저장버튼 클릭시
	}); // 생년 입력버튼 클릭시
	
	$(".showAcc").on("click", showAccList);
}

function showAccList() {
	$.ajax({
		url:"getTargetAccList"
			, type:"post"
			, dataType : "json"
			, data : {t_id : $(this).attr("t_id")}
			, success:function(list) {
				var accContent = "";
				/*
				accContent += "<table>";
				accContent += "<tr>";
				accContent += "<th>일자</th>";
				accContent += "<th>경조사</th>";
				accContent += "<th>소속</th>";
				accContent += "<th>이름</th>";
				accContent += "<th>금액</th>";
				accContent += "</tr>";
				$.each(list, function(i, targetAcc) {
					accContent += "<tr>";
					accContent += "<th>" + targetAcc.ta_date + "</th>";
					accContent += "<th>" + targetAcc.ta_memo + "</th>";
					accContent += "<th>" + targetAcc.t_group +"</th>";
					accContent += "<th>" + targetAcc.t_name + "</th>";
					accContent += "<th>" + targetAcc.ta_price + "</th>";
					accContent += "</tr>";
				});
				accContent += "</table>";
				*/
				
				/*
				경조사의 특성상 오가는 수가 많지 않으니 
				수입과 지출로 나누어 테이블이 아닌  둥근네모로 표기
				*/
				$.each(list, function(i, targetAcc) {
					if(targetAcc.ta_type == 'INC') {
						accContent += "<p class='acc_in'>";
						accContent += targetAcc.ta_memo + "<br>";
						accContent += targetAcc.ta_price + "<br>";
						accContent += targetAcc.ta_date + "<br>";
						accContent += "</p>";
					} else if (targetAcc.ta_type == 'OUT') {
						accContent += "<p class='acc_out'> ";
						accContent += targetAcc.ta_memo + "<br>";
						accContent += targetAcc.ta_price + "<br>";
						accContent += targetAcc.ta_date + "<br>";
						accContent += "</p>";
					}
					
				});
				$("#targetacc_div").html(accContent);
			}
			, error:function(e) {
				alert(JSON.stringify(e));
			} 
	});
}
</script>
<style>
#targetmain_div {
	display: inline-block;
}

#target_div {
	width: 500px;
	height: 300px;
	overflow: auto;
}

#targetacc_div {
	width: 500px;
	height: 300px;
	overflow: auto;
	display: inline-block;
}

.acc_in {
	border-radius: 25px;
    background: #b3daff;
    padding: 20px; 
    width: 150px;
    height: 70px;
    display: inline-block;
    text-align: center;
}

.acc_out {
	border-radius: 25px;
    background: #ffcccc;
    padding: 20px; 
    width: 150px;
    height: 70px;
    display: inline-block;
    text-align: center;
}
</style>
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
<br><br>
<div id="targetmain_div">
<input type="text" id="tar_search"><input type="button" id="btn_search" value="검색" >
<div id="target_div"></div>
</div>
<div id="targetacc_div"></div>
</body>
</html>