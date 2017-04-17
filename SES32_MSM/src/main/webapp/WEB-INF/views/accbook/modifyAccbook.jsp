
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
	console.log(ob);
	$('#m_a_date').val(ob.a_date);
	var main_cate = ob.main_cate;
	if(main_cate=="지출"){
		alert('a');
		('#m_out).attr("checked", "checked");
		
	}
	}
	if(main_cate=="고정지출"){
	
	}
	if(main_cate=="수입"){
		
	}
	if(main_cate="고정수입"){
		
	}
		
	$('#m_a_date').val(ob.a_date);
}

	
	$('.m_a_type').on('change', select);
	
	
	function select() {
		var a_type = $('input:radio[name=m_a_type]:checked').val();
			var sub_cates;
			
			
			var str ='서브 <select id="m_sub_cate">';
	
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
		str+='결제수단<select id="m_payment">'
		str+='<option value="현금">현금'
			str+='<option value="카드">카드<br>'
				str+='<option value="기타">기타</select><br>'
			str+='금액<input type="text" id="m_price"><br>'
			str+='메모<input type="text" id="m_a_memo">'
		
		$('#selectdiv').html(str);
	}
	
	function modifyAccbook() {



				
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
		$.ajax({
			url : 'modifyAccbook',
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
			success : modifyResult(),
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});

	}
	
	function modifyResult() {
		search();
	}
	

	
	
/* 	//내용 초기화 
	$('.modal').on('hidden.bs.modal', function () {
        $(this).removeData('bs.modal');
}); */

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
    <input type="date" id="m_a_date" ><br>
    	 
    <label for="m_in"><input type="radio" id="m_in" value="INC" class="m_a_type" name="m_a_type" >수입</label>
    <label for="m_out"><input type="radio" id="m_out" value="OUT" class="m_a_type" name="m_a_type">지출</label>
     <label for="m_main"><input type="checkbox" id="m_main" value="고정">고정</label>
    <div id="selectdiv">
    </div>
    </form>
</div>
<!-- Footer -->
		
<div class="modal-footer">
   <input type="button"  class="btn btn-lg btn-success" onclick="modifyAccbook()" value="확인" > 
  <button type="button" class="btn btn-default" data-dismiss="modal" name="model_close" id="model_close3">닫기</button>
</div>


