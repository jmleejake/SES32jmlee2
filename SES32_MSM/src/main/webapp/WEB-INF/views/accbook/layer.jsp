
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

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
  
  <h4 class="modal-title">Header</h4>
</div>
<!-- body -->


<div class="modal-body" >
    
</div>
<!-- Footer -->


<div class="modal-footer">
    Foo
  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
</div>



