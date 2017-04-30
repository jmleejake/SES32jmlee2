<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- modal -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- jquery -->
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
$(document).ready(function() {
	getTarget(1);
	
	// 타겟 검색
	$("#btn_search").on("click", function() {
		getTarget();
	});
});
//타겟리스트 얻기 
function getTarget(p) {
	$("#page").val(p);
	$.ajax({
		url : "../target/showTarget",
		type : "post",
		data : {
			srch_val : $("#tar_search").val()
			, srch_type : $("#srch_type").val()
			, page : $("#page").val()
		},
		dataType : "json",
		success : showTarget,
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});
}

// 타겟리스트 뿌려주기
function showTarget(data) {
	var start = data.startPageGroup;
	var end = data.endPageGroup;
	var currentPage = data.currentPage;
	
	$("#target_div").html("");
	var tableContent = "";
	tableContent += '<table class="table">';
	tableContent += "<tr>";
	tableContent += "<th>그룹</th>";
	tableContent += "<th>이름</th>";
	tableContent += "<th>생년</th>";
	tableContent += "</tr>";
	$.each(data.list,function(i, target) {
		tableContent += "<tr>";
		tableContent += "<td>" + target.t_group + "</td>";
		tableContent += "<td><a class='showAcc' style='cursor:pointer;' t_id='" + target.t_id + "' t_name='" + target.t_name + "'>"
				+ target.t_name + "</a></td>";
		tableContent += "<td id='td_birth" + target.t_id + "'>"
				+ target.t_birth + "</td>";
		tableContent += "</tr>";
	});

	tableContent += "</table>";
	$("#target_div").html(tableContent);
	
	//페이징	
	var str2 = ' ';
	var m2 = currentPage - 5;
	var m1 = currentPage + 5;
	str2 += '<a href="javascript:getTarget(' + m2
			+ ')" class="w3-button">&laquo;</a>';
	for (var i = start; i <= end; i++) {
		str2 += '<a href="javascript:getTarget(' + i
				+ ')" class="w3-button"> ' + i + ' </a>';
	}
	str2 += '<a href="javascript:getTarget(' + m1
			+ ')" class="w3-button">&raquo;</a>';
	$('#target_pag_div').html(str2);

	$(".showAcc").on("click", function() {
		$("#t_id").val($(this).attr("t_id"));
		$("#t_setting").val($(this).attr("t_name"));
		$('#tar_srch_close').trigger('click');
	});
}
</script>

			<div class="modal-header">
				<h4 class="modal-title">타겟설정</h4>
			</div>
			<div class="modal-body">
				<table>
					<tr>
						<td><select id="srch_type" class="form-control">
								<option value="all">전체</option>
								<option value="grp">그룹</option>
								<option value="nm" selected="selected">이름</option>
								<option value="ev">이벤트</option>
						</select></td>
						<td><input type="text" class="form-control"
							id="tar_search" onkeydown="pressEnter();"></td>
						<td><input type="button" class="btn btn-default"
							id="btn_search" value="검색"></td>
					</tr>
				</table>
				<div id="target_div"></div>
				<input type="hidden" name="page" id="page" value="1">
				<div align="center" id="target_pag_div" class="w3-bar"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default"
					data-dismiss="modal">확인</button>
				<button type="button" id="tar_srch_close" class="btn btn-default"
					data-dismiss="modal">닫기</button>
			</div>
