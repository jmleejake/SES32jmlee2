
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--  회원정보 수정 모달-->
<script>
//내용 초기화 
$('.modal').on('hidden.bs.modal', function() {
	$(this).removeData('bs.modal');
});
</script>

			<!-- header -->
		<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원정보 수정</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<form method="POST" action="user/user_Update" id="user_Update" >

						<div class="form-group">
							<label for="message-text" class="form-control-label">
								비밀번호</label> <input type="password" class="form-control"
								id="u_pwd_check" name="u_pwd">
						</div>

						<div class="form-group">
							<label for="message-text" class="form-control-label">
								비밀번호 확인</label> <input type="password" class="form-control"
								id="u_pwd_check2">
						</div>

						<div class="form-group">
							<label for="message-text" class="form-control-label"> 이름
							</label> <input type="text" class="form-control" id="u_name_check"
								value="${vo.u_name}" name="u_name">
						</div>

						<div class="form-group">
							<label for="message-text" class="form-control-label">이메일</label>
							<input type="text" class="form-control" id="u_email_check"
								value="${vo.u_email } "name="u_email">
						</div>

						<div class="form-group">
							<label for="message-text" class="form-control-label">전화번호</label>
							<input type="text" class="form-control" id="u_phone_check"
								value="${vo.u_phone }" name="u_phone">
						</div>

						<div class="form-group">
							<label for="message-text" class="form-control-label">생년월일</label>
							<input type="date" class="form-control" id="u_birth_check"
								value="${vo.u_birth }" name="u_birth">
						</div>

						<div class="form-group">
							<label for="message-text" class="form-control-label">주소</label> <input
								type="text" class="form-control" id="u_address_check"
								value="${vo.u_address}" name="u_address">
						</div>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btn check"
						onclick="return user_Update()">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>

