
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
	
	
	
	$('.r_a_type').on('change', select);
	function select() {
		var a_type = $('input:radio[name=r_a_type]:checked').val();
			var sub_cates;
			
			
			var str ='서브 <select id="r_sub_cate" class="form-control">';
	
		if(a_type=='OUT'){
			sub_cates=[
				'식비'
				,'문화생활비'
				,'건강관리비'
				,'의류미용비'
				,'교통비'
				,'차량유지비'
				,'주거생활비'
				,'학비'
				,'사회생활비'
				,'유흥비'
				,'금융보험비'
				,'저축'
				,'기타'
				
			];
			for(var i=0;i<sub_cates.length;i++){
				str+='<option value="'+sub_cates[i]+'">'+sub_cates[i];
			}
			
			
		}
		if(a_type=='INC'){
			sub_cates=[
				'근로소득'
				,'금융소득'
				,'기타'
			
				
			];
			for(var i=0;i<sub_cates.length;i++){
				str+='<option value="'+sub_cates[i]+'">'+sub_cates[i];
			}
		}
		str+='</select><br>';
		str+='결제수단<select id="r_payment" class="form-control">'
		str+='<option value="현금">현금'
			str+='<option value="카드">카드<br>'
				str+='<option value="기타">기타</select><br>'
			str+='금액<input type="text" id="r_price" class="form-control"><br>'
			str+='항목<input type="text" id="r_a_memo" class="form-control">'
		
		$('#selectdiv').html(str);
	}
	
	function registAccbook() {



				
		var a_date = $('#r_a_date').val();
		var a_type = $('input:radio[name=r_a_type]:checked').val();




		var main_cate;
		var check ='';
		var ar = $('input[type=checkbox]:checked');

		$.each(ar, function(i, item) {

			if ($(this).prop('checked')) {
				check = $(item).val();
			}

		});
		if(a_type=='INC'){
			main_cate =check+"수입";
		}
		if(a_type=='OUT'){
			main_cate =check+"지출";
		}
		var sub_cate = $('#r_sub_cate option:selected').val();
		//alert(sub_cate);	
		var payment =$('#r_payment option:selected').val();
		//alert(payment);	
		var price = $('#r_price').val();
		var a_memo = $('#r_a_memo').val();
		
		if(a_date==""){
			
			alertify.alert("날짜를 확인해주세요");
			return;
		}
		if(price==""){
			alertify.alert("금액을 확인해주세요.");
			return;
		}
		if(isNaN(price)){
			alertify.alert("금액은 숫자만 입력해주세요.");
			return;
		}
		
		$.ajax({
			url : 'registAccbook',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				a_date : a_date
				,a_type : a_type
				,main_cate : main_cate
				,sub_cate : sub_cate
				,payment : payment
				,price : price
				,a_memo : a_memo
			},
			dataType : 'text',
			success : registResult,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});

	}
	
	function registResult() {
		alertify.success("등록 되었습니다.");
		search();
		
	}
	

	
	
	//내용 초기화 
	$('.modal').on('hidden.bs.modal', function () {
        $(this).removeData('bs.modal');
});

</script>

<!-- header -->
<div class="modal-header">
    <!-- 닫기(x) 버튼 -->
  <button type="button" class="close" data-dismiss="modal">×</button>
  <!-- header title -->
  
  <h4 class="modal-title">가계부 등록</h4>
</div>
<!-- body -->
	

<div class="modal-body">
    <form action="">
    날짜
    <input type="date" id="r_a_date" class="form-control" ><br>
    	 
    <label for="r_in" style="margin-right: 20px"><input type="radio" id="r_in" value="INC" class="r_a_type" name="r_a_type" >수입</label >
    <label for="r_out" style="margin-right: 20px"><input type="radio" id="r_out" value="OUT" class="r_a_type" name="r_a_type" >지출</label>
     <label for="r_main"><input type="checkbox" id="r_main" value="고정" >고정</label>
    <div id="selectdiv">
    </div>
    </form>
</div>
<!-- Footer -->
		
<div class="modal-footer">
   <input type="button"  class="btn btn-success" onclick="registAccbook()" value="확인" > 
  <button type="button" class="btn btn-default" data-dismiss="modal" name="model_close" id="model_close2">닫기</button>
</div>


