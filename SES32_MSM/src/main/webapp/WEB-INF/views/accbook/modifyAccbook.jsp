
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
	var a_id = $('#m_a_id').val();
	
	$.ajax({
		url : 'getAccbook3',
		type : 'POST',
		//서버로 보내는 parameter
		data : {
			a_id :a_id 
		},
		dataType : 'json',
		success : modifyset,
		error : function(e) {
			alert(JSON.stringify(e));
		}
	});

function modifyset(ob) {
	var main_cate = ob.main_cate;
	
	if(ob.a_type=='INC'){
		$('input:radio[id="m_in"]').attr("checked", true); 
		
	}
	if(ob.a_type=='OUT'){
		$('input:radio[id="m_out"]').attr("checked", true); 
	}

	select();
	
	console.log(sub_cates);
	$('#m_sub_cate option[value="'+ob.sub_cate+'"]').attr('selected', 'selected');
	$('#m_payment option[value="'+ob.payment+'"]').attr('selected', 'selected');
	$('#m_price').val(ob.price);
	$('#m_a_memo').val(ob.a_memo);
	
	$('#m_a_date').val(ob.a_date);
	var sub_cates;

	if(main_cate=="고정지출"){
		$('input:checkbox[id="m_main"]').attr("checked", true); 
	
	}

	if(main_cate="고정수입"){
		$('input:checkbox[id="m_main"]').attr("checked", true); 
	}
		
	
	
	
	
}

	
	$('.m_a_type').on('change', select);
	
	
	function select() {
		var a_type = $('input:radio[name=m_a_type]:checked').val();
			var sub_cates;
			
			
			var str ='서브 <select id="m_sub_cate" class="form-control">';
	
		if(a_type=='OUT' ){
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
		str+='결제수단<select id="m_payment" class="form-control">'
		str+='<option value="현금">현금'
			str+='<option value="카드">카드<br>'
				str+='<option value="기타">기타</select><br>'
			str+='금액<input type="text" id="m_price" class="form-control"><br>'
			str+='항목<input type="text" id="m_a_memo" class="form-control">'
		
		$('#selectdiv').html(str);
	}
	
	function modifyAccbook() {
		
		var a_id= $('#m_a_id').val();	
		var a_date = $('#m_a_date').val();
		var a_type = $('input:radio[name=m_a_type]:checked').val();




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
		var sub_cate = $('#m_sub_cate option:selected').val();
		//alert(sub_cate);	
		var payment =$('#m_payment option:selected').val();
		//alert(payment);	
		var price = $('#m_price').val();
		var a_memo = $('#m_a_memo').val();
		
		if(a_date ==""){
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
			url : 'modifyAccbook',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				
				a_id : a_id,
				a_date : a_date
				,a_type : a_type
				,main_cate : main_cate
				,sub_cate : sub_cate
				,payment : payment
				,price : price
				,a_memo : a_memo
			},
			dataType : 'text',
			success : modifyResult(),
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});

	}
	
	function modifyResult() {
		alertify.success("수정 되었습니다.");
		
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
  
  <h4 class="modal-title">가계부 수정</h4>
</div>
<!-- body -->
	

<div class="modal-body">
	
	
    <form action="">
    날짜
    <input type="date" id="m_a_date" class="form-control" ><br>
    	 
    <label for="m_in" style="margin-right: 20px"><input type="radio" id="m_in" value="INC" class="m_a_type" name="m_a_type" >수입</label>
    <label for="m_out" style="margin-right: 20px"><input type="radio" id="m_out" value="OUT" class="m_a_type" name="m_a_type">지출</label>
     <label for="m_main"><input type="checkbox" id="m_main" value="고정">고정</label>
    <div id="selectdiv">
    </div>
    </form>
</div>
<!-- Footer -->
		
<div class="modal-footer">
   <input type="button"  class="btn btn-success" onclick="modifyAccbook()" value="확인" > 
  <button type="button" class="btn btn-default" data-dismiss="modal" name="model_close" id="model_close3">닫기</button>
</div>


