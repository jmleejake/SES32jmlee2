
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
	$('.a_type').on('change', select);
	function select() {
		var a_type = $('input:radio[name=a_type]:checked').val();
			var sub_cates;
			
			
			var str ='서브<select id="sub_cate>';
	
		if(a_type=='IN'){
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
			for(var i=-1;i<sub_cates.length;i++){
				str+='<option value="'+sub_cates[i]+'">'+sub_cates[i];
			}
			
			
		}
		if(a_type=='OUT'){
			sub_cates=[
				'근로소득'
				,'금융소득'
				,'기타'
			
				
			];
			for(var i=-1;i<sub_cates.length;i++){
				str+='<option value="'+sub_cates[i]+'">'+sub_cates[i];
			}
		}
		str+='</select><br>';
		str+='결제수단<select id="payment">'
		str+='<option value="현금">현금'
			str+='<option value="카드">카드</select><br>'
			
			str+='금액<input type="text name="price"><br>'
			str+='메모<input type="text name="a_memo">'
		
		$('#selectdiv').html(str);
	}

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
    <input type="date" id="a_date" ><br>
    	 
    <input type="radio" value="IN" class="a_type" name="a_type">수입
    <input type="radio" value="OUT" class="a_type" name="a_type">지출
    <div id="selectdiv">
    </div>
    
    </form>
</div>
<!-- Footer -->


<div class="modal-footer">
    <input type="button"  class="btn btn-lg btn-success" onclick="" value="확인" > 
  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
</div>


