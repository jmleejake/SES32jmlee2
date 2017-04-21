
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<script>

	$('.s_type').on('change', reset);
	//내용 초기화 
	$('.modal').on('hidden.bs.modal', function() {
		$(this).removeData('bs.modal');
	});

	function searchSubmit() {
		
		document.getElementById('type').value ="";
		document.getElementById('payment').value = "";
		document.getElementById('sub_cates').value = "";
		document.getElementById('keyWord').value = "";
		
		/*검색 시작 날짜  */
		document.getElementById('start_date').value = $('#s_start_date').val();

		/*검색 끝 날짜*/
		document.getElementById('end_date').value = $('#s_end_date').val();

		/* 타입 */
		if ($('input:radio[name=s_type]:checked').val() != null) {
			document.getElementById('type').value = $(
					'input:radio[name=s_type]:checked').val();

		}

		/* 결제 방법을 담은 배열 */
		var payment = new Array();
		var payments = $('input:checkbox[name=s_payment]');
		var p_check = false;

		/*카테고리를 담은 배열  */
		var sub_cates = new Array();
		var cate_check = $('input:checkbox[name=s_cate]');
		var s_check = false;

		$.each(payments, function(i, item) {
			if ($(item).prop('checked')) {
				payment.push($(item).val());
				p_check = true;
			}

		});

		$.each(cate_check, function(i, item) {
			if ($(item).prop('checked')) {
				sub_cates.push($(item).val());
				s_check = true;
			}

		});
		if (p_check) {
			document.getElementById('payment').value = payment;

		}
		if (s_check) {
			document.getElementById('sub_cates').value = sub_cates;

		}
		/* 키워드*/
		if ($('#s_keyword').val() != null) {
			document.getElementById('keyWord').value = $('#s_keyword').val();

		}
		
		search();
		
	}
	
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
			
				<label for=s_all><input type="radio" id="s_all" name="s_type" value="ALL" class="s_type" checked="checked">전체</label>
				<label for="s_in"><input type="radio" id="s_in" name="s_type" value="INC" class="s_type">수입</label>
				<label for="s_out"><input type="radio" id="s_out" name="s_type" value="OUT" class="s_type">지출</label>
			
				<br>
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
				<br>
			<legend>수입 카테고리</legend>
				<label for="s_cate14"><input type="checkbox" id="s_cate14" name="s_cate" value="근로소득" class="s_cate_in">근로소득</label>
				<label for="s_cate15"><input type="checkbox" id="s_cate15" name="s_cate" value="금융소득" class="s_cate_in">금융소득</label>
				<label for="s_cate16"><input type="checkbox" id="s_cate16" name="s_cate" value="기타" class="s_cate_in">기타</label>
				<br>
			<legend>결제수단 </legend>
				<label for="s_payment_money"><input type="checkbox" id="s_payment_money" name="s_payment" value="현금">현금</label>
				<label for="s_payment_card"><input type="checkbox" id="s_payment_card" name="s_payment" value="카드">카드</label>
				<br>
			<legend>항목 검색</legend>
			<input align="center" type="text" id="s_keyword" name="s_keyword" class="form-control"> 
			
		</fieldset>



		<div class="modal-body"></div>
		<!-- Footer -->


		<div class="modal-footer">
			<input type="button" value="검색" id="s_search_btn" onclick="searchSubmit()" class="btn btn-success">
			<button type="button" class="btn btn-default" data-dismiss="modal" name="model_close" id="model_close">닫기</button>
		</div>