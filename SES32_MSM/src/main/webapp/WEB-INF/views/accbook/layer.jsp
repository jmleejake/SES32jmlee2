
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<script>

	$('.s_type').on('change', reset);
	//내용 초기화 
	$('.modal').on('hidden.bs.modal', function() {
		$(this).removeData('bs.modal');
	});


	
	function reset() {
		var s_type = $('input:radio[name=s_type]:checked').val();
		
		//클릭 한 내용 초기화	
		$('input:checkbox[name=s_cate]:checked').prop('checked', false);
		
		$('input:checkbox[name=s_cate]').prop('disabled', false);
		if(s_type=='OUT'){
			$('.s_cate_in').prop('disabled', true);
		}
		if(s_type=='IN'){
			$('.s_cate_out').prop('disabled', true);
		}
		
	}

</script>


<!-- header -->
<div class="modal-header">
	<!-- 닫기(x) 버튼 -->
	<button type="button" class="close" data-dismiss="modal">×</button>
	<!-- header title -->

	<h4 class="modal-title">상세검색</h4>
</div>
<!-- body -->

<style>
	

</style>


<body>
	<div class="widget">


		<fieldset>
			
			<legend>타입 </legend>
			
				<label for=s_all><input type="radio" id="s_all" name="s_type" value="ALL" class="s_type">전체</label>
				<label for="s_in"><input type="radio" id="s_in" name="s_type" value="INC" class="s_type">수입</label>
				<label for="s_out"><input type="radio" id="s_out" name="s_type" value="OUT" class="s_type">지출</label>
			
			
			<legend>지출 카테고리</legend>
				<label for="s_cate1"><input type="checkbox" id="s_cate1" name="s_cate" value="식비" class="s_cate_out" >식비</label>
				<label for="s_cate2"><input type="checkbox" id="s_cate2" name="s_cate" value="문화생활비" class="s_cate_out" >문화생활비</label>
				<label for="s_cate3"><input type="checkbox" id="s_cate3" name="s_cate" value="건강관리비" class="s_cate_out">건강관리비</label>
				<label for="s_cate4"><input type="checkbox" id="s_cate4" name="s_cate" value="의류미용비" class="s_cate_out">의류미용비</label>
				<br>
				<label for="s_cate5"><input type="checkbox" id="s_cate5" name="s_cate" value="교통비" class="s_cate_out">교통비</label>
				<label for="s_cate6"><input type="checkbox" id="s_cate6" name="s_cate" value="차량유지비" class="s_cate_out">차량유지비</label>
				<label for="s_cate7"><input type="checkbox" id="s_cate7" name="s_cate" value="주거생활비" class="s_cate_out">주거생활비</label>
				<label for="s_cate8"><input type="checkbox" id="s_cate8" name="s_cate" value="학비" class="s_cate_out">학비</label>
				<br>
				<label for="s_cate9"><input type="checkbox" id="s_cate9" name="s_cate" value="사회생활비" class="s_cate_out">사회생활비</label>
				<label for="s_cate10"><input type="checkbox" id="s_cate10" name="s_cate" value="유흥비" class="s_cate_out">유흥비</label>
				<label for="s_cate11"><input type="checkbox" id="s_cate11" name="s_cate" value="금융보험비" class="s_cate_out">금융보험비</label>
				<label for="s_cate12"><input type="checkbox" id="s_cate12" name="s_cate" value="저축" class="s_cate_out">저축</label>
				<label for="s_cate13"><input type="checkbox" id="s_cate13" name="s_cate" value="기타" class="s_cate_out">기타</label>
			
			<legend>수입 카테고리</legend>
				<label for="s_cate14"><input type="checkbox" id="s_cate14" name="s_cate" value="근로소득" class="s_cate_in">근로소득</label>
				<label for="s_cate15"><input type="checkbox" id="s_cate15" name="s_cate" value="금융소득" class="s_cate_in">금융소득</label>
				<label for="s_cate16"><input type="checkbox" id="s_cate16" name="s_cate" value="기타" class="s_cate_in">기타</label>
			<legend>결제수단 </legend>
				<label for="s_payment_money"><input type="checkbox" id="s_payment_money" name="s_payment" value="현금">현금</label>
				<label for="s_payment_card"><input type="checkbox" id="s_payment_card" name="s_payment" value="카드">카드</label>
			<legend>메모 검색</legend>
			<input type="text" id="s_keyword" name="s_keyword"> 
			<input type="button" value="검색" id="s_search_btn" onclick="search()">	
		</fieldset>



		<div class="modal-body"></div>
		<!-- Footer -->


		<div class="modal-footer">

			<button type="button" class="btn btn-default" data-dismiss="modal" name="model_close" id="model_close">닫기</button>
		</div>