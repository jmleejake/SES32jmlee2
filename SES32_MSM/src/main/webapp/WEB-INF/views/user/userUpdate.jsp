
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--  회원정보 수정 모달-->
<script>
//내용 초기화 
	$('.modal').on('hidden.bs.modal', function() {
		$(this).removeData('bs.modal');
	});
	
	
	var path = window.location.pathname;
	alert(path)
		if(path=='/msm/newhome'){		
			$.ajax({
					url : './user/userUpdateSet',
					type : 'POST',
					dataType : 'json',
					success : updateSet
				});
		}else{
			$.ajax({
				url : '../user/userUpdateSet',
				type : 'POST',
				dataType : 'json',
				success : updateSet,
			});
		}
		
		function updateSet(obj) {
			document.getElementById('u_name_check').value = obj.u_name;
			document.getElementById('u_email_check').value = obj.u_email;
			document.getElementById('u_phone_check').value = obj.u_phone;
			document.getElementById('u_birth_check').value =obj.u_birth;
			document.getElementById('u_address_check').value = obj.u_address;
		}
		
		function user_Update(){
			var pwd = document.getElementById('u_pwd_check').value;
			var pwd2 = document.getElementById('u_pwd_check2').value;
			var name = document.getElementById('u_name_check').value;
			var email = document.getElementById('u_email_check').value;
			var phone = document.getElementById('u_phone_check').value;
			var birth = document.getElementById('u_birth_check').value;
			var address = document.getElementById('u_address_check').value;
			
		 	if(pwd !=''){
				if(pwd != pwd2){
					alert('입력하신 비밀번호와 비밀번호 확인값이 일치하지 않습니다.');
					return false;
				}
				
				if(pwd.length > 16 && pwd.length < 8){
					alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
					return false;
				}
				
				if(!pwd.match(/[a-zA-Z0-9]*[^a-zA-Z0-9\n]+[a-zA-Z0-9]*$/)){
					alert('비밀번호는 문자, 숫자, 특수문자 조합으로 입력하여 주십시오.');
					return false;
				}
				
				if(id.indexOf(pwd)>-1){
					alert('비밀번호에 아이디를 사용하실 수 없습니다.');
					return false;
				}
			}

			if(name==''){
				alert('이름을 입력 해주세요.');
				return false;
			}
			if(email==''){
				alert('이메일을 입력해주세요');
				return false;
			}
			

			
			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			if(email.match(regExp) == null){
				alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
				return false;
			}
			
			var regExp2 = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/

			if(phone.match(regExp2)==null){
				alert('잘못된 휴대폰 번호입니다. 숫자, -(구분자)를 포함하여 입력합시오');
				return false;
			}
			
		    var year = Number(birth.substr(0,4)); 
		    var month = Number(birth.substr(5,2));
		    var day = Number(birth.substr(8,2));

		    if (month < 1 || month > 12) { // check month range
		    	alert("Month must be between 1 and 12.");
		     	return false;
		    }

		    if (day < 1 || day > 31) {
		     	alert("Day must be between 1 and 31.");
		     	return false;
		    }

		    if ((month==4 || month==6 || month==9 || month==11) && day==31) {
		     	alert("Month "+month+" doesn't have 31 days!");
		     	return false
		    }

		    if (month == 2) { // check for february 29th
		     	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		    
		     	if (day>29 || (day==29 && !isleap)) {
		      		alert("February " + year + " doesn't have " + day + " days! ");
		      		return false;
		     	}
		    } 
			if($('#email_check_label').attr('check')=='no'){
				alert('이메일 확인을 해주세요.')
				return false;
			}
		    
			var f =document.getElementById("user_Update");
			f.submit();

		}	
		
		function msmDelete() {
			alertify.set({
				labels : {
					ok : "확인",
					cancel : "취소"
				}
			});
			alertify.set({
				buttonReverse : true
			});
		
			
	    	alertify.confirm("탈퇴를 하시면 모든 정보는 삭제됩니다.", function(e) {
				if (e) {
					alertify.confirm("정말로 탈퇴 하시겠습니까?", function(e) {
						if (e) {
							if(path=='/msm/newhome'){		
								location.href="./user/userDelete";
							}else{
								location.href="../user/userDelete";
							}
						} else {
							// user clicked "cancel"
						}
					});
					

				} else {
					// user clicked "cancel"
				}
			});
			
			
	
	    
			
			
			
			
			
		}	
		//이메일 체크
		function emailCheck(){
			var email =$('#u_email_check').val(); 
			var str = '';
			

		    if(email.length==0) {
		        return;
		    }
			
		    
			if(path=='/msm/newhome'){
				$.ajax({
					url : './user/emailCheck',
					type : 'POST',
					data : {
						u_email: email
					}
				,dataType : 'text',
					success : function(data){
						console.log(data);
						alert(data);
						if(data=="ok"){
							str='변경 가능합니다.';
							$('#email_check_label').html(str);
							$('#email_check_label').attr('check', 'ok');
						}
						else if(data==""){						
							str ='이메일 변경은 체크 후 가능합니다.';	
							$('#email_check_label').html(str);		
							$('#email_check_label').attr('check', 'ok');
								
						}	
						else if(data=="no"){
							str ='사용중인 이메일입니다.';
							$('#email_check_label').html(str);
							$('#email_check_label').attr('check', 'no');
						}
					
					}
				});
			}else{	
				$.ajax({
					url : '../user/emailCheck',
					type : 'POST',
					data : {
						u_email: email
					}
				,dataType : 'text',
					success : function(data){
						console.log(data);
						alert(data);
						if(data=="ok"){
							str='변경 가능합니다.';
							$('#email_check_label').html(str);
							$('#email_check_label').attr('check', 'ok');
						}
						else if(data==""){						
							str ='이메일 변경은 체크 후 가능합니다.';	
							$('#email_check_label').html(str);		
							$('#email_check_label').attr('check', 'ok');
								
						}	
						else if(data=="no"){
							str ='사용중인 이메일입니다.';
							$('#email_check_label').html(str);
							$('#email_check_label').attr('check', 'no');
						}
					
					}
				});
			}		 
		    
		}
	
		
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
					<form method="POST" action="user/user_Update" id="user_Update"  >

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
								value="${vo.u_email } "name="u_email" >
							<label id="email_check_label" check="ok">이메일 변경은 체크 후 가능합니다.</label>
							<input type="button" onclick="emailCheck()" value="이메일 체크" style="float: right;">	
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

				<div class="modal-footer"  style="text-align: center;">
					<button type="button" class="btn btn-default" id="btn check"
						onclick="return user_Update()" >확인</button>
					<button type="button" class="btn btn-default"
						data-dismiss="modal"  >닫기</button>
					<button  class="btn btn-default" id="btn check"  onclick="msmDelete()" style="float: right;" >회원 탈퇴</button>
				</div>

