<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Manage a Schedule and Money</title>
<!-- icon CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- jQuery -->
<script src="./resources/template/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="./resources/template/js/bootstrap.min.js"></script>

<!-- W3School CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- Bootstrap Core CSS -->
<link href="./resources/template/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="./resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="./resources/template/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- Modal CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

	
<!-- stylesheet -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css" />

<!-- javascript -->
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>


<style type="text/css">
.content_body {
	background-image: url("./resources/template/img/banner-bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 25%;
}

.header {
	background-color: #327a81;
	color: white;
	font-size: 1.5em;
	padding: 1rem;
	text-align: center;
	text-transform: uppercase;
}

.table-users {
	border-radius: 10px;
	box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
	max-width: calc(100% - 2em);
	margin: 1em auto;
	overflow-y: auto;
	width: 800px;
	height: 150px;
	float: left;
}

.table-users2 {
	border-radius: 10px;
	box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
	max-width: calc(100% - 2em);
	margin: 1em auto;
	overflow-y: auto;
	width: 800px;
	height: 200px;
	float: left;
}

.table-users3 {
	border-radius: 10px;
	box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
	max-width: calc(100% - 2em);
	margin: 1em auto;
	overflow-y: auto;
	width: 800px;
	height: 350px;
	float: left;
}

table {
	width: 100%;
}

table td, table th {
	color: #2b686e;
	padding: 10px;
}

table td {
	text-align: center;
	vertical-align: middle;
}

table td:last-child {
	font-size: 0.95em;
	line-height: 1.4;
	text-align: center;
}

table th {
	background-color: #daeff1;
	font-weight: 300;
	text-align: center;
}

table tr:nth-child(2n) {
	background-color: white;
}

table tr:nth-child(2n+1) {
	background-color: #edf7f8;
}

@media screen and (max-width: 700px) {
	table, tr, td {
		display: block;
	}
	td:first-child {
		position: absolute;
		top: 50%;
		-webkit-transform: translateY(-50%);
		transform: translateY(-50%);
		width: 100px;
	}
	td
	
	
	
	
	:not
	
	
	 
	
	
	(
	:first-child
	
	
	 
	
	
	)
	{
	clear
	
	
	
	
	:
	
	
	 
	
	
	both
	
	
	
	
	;
	margin-left
	
	
	
	
	:
	
	
	 
	
	
	100
	px
	
	
	
	
	;
	padding
	
	
	
	
	:
	
	
	 
	
	
	4
	px
	
	
	 
	
	
	20
	px
	
	
	 
	
	
	4
	px
	
	
	 
	
	
	90
	px
	
	
	
	
	;
	position
	
	
	
	
	:
	
	
	 
	
	
	relative
	
	
	
	
	;
	text-align
	
	
	
	
	:
	
	
	 
	
	
	left
	
	
	
	
	;
}

td:not (:first-child ):before {
	color: #91ced4;
	content: '';
	display: block;
	left: 0;
	position: absolute;
}

tr {
	padding: 10px 0;
	position: relative;
}

tr:first-child {
	display: none;
}

}
@media screen and (max-width: 500px) {
	.header {
		background-color: transparent;
		color: white;
		font-size: 2em;
		font-weight: 700;
		padding: 0;
		text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
	}
	img {
		border: 3px solid;
		border-color: #daeff1;
		height: 100px;
		margin: 0.5rem 0;
		width: 100px;
	}
	td:first-child {
		background-color: #c8e7ea;
		border-bottom: 1px solid #91ced4;
		border-radius: 10px 10px 0 0;
		position: relative;
		top: 0;
		-webkit-transform: translateY(0);
		transform: translateY(0);
		width: 100%;
	}
	td
	
	
	
	
	:not
	
	
	 
	
	
	(
	:first-child
	
	
	 
	
	
	)
	{
	margin
	
	
	
	
	:
	
	
	 
	
	
	0;
	padding
	
	
	
	
	:
	
	
	 
	
	
	5
	px
	
	
	 
	
	
	1
	em
	
	
	
	
	;
	width
	
	
	
	
	:
	
	
	 
	
	
	100%;
}

td:not (:first-child ):before {
	font-size: .8em;
	padding-top: 0.3em;
	position: relative;
}

td:last-child {
	padding-bottom: 1rem !important;
}

tr {
	background-color: white !important;
	border: 1px solid #6cbec6;
	border-radius: 10px;
	box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
	margin: 0.5rem 0;
	padding: 0;
}

.table-users {
	border: none;
	box-shadow: none;
	overflow: visible;
}

.table-users2 {
	border: none;
	box-shadow: none;
	overflow: visible;
}

.table-users3 {
	border: none;
	box-shadow: none;
	overflow: visible;
}
}
</style>
<style type="text/css">
}
#div_dday {
	width: 600px;
	height: 550px;
	overflow-y: auto;
}

.sch_event {
	border-radius: 25px;
	/* 	background-color: lime; */
	background-color: hsla(120, 100%, 50%, 0.3);
	padding: 20px;
	width: 150px;
	height: 120px;
	display: inline-block;
	text-align: center;
	margin-left: 10px;
}

/* 차트 타이틀 */
.c3-title {
	fill: white; /* titlecolor */
	font-size: 30px;
}
</style>






</head>
<script>
//수정 모달창열기
$(function() {
	$("#userUpdatemodal").click(function() {
		$('.modal-content').empty();
		$('div.modal').modal({
			remote : 'user/userUpdatemodal'
		});
	});
});

function w3_open() {
	document.getElementById("mySidebar").style.display = "block";
}

function w3_close() {
	document.getElementById("mySidebar").style.display = "none";
}

(function($){
    $(window).on("load",function(){
        //$(".content").mCustomScrollbar();
        
        var today = new Date(); 
		var year = today.getFullYear(); 
		var month = today.getMonth() + 1; 
		var day = today.getDate(); 
        
		if(day==21){
        	//alert('매월 21일에는 연간 이벤트, 의무 저축 입금이 이루어져야 합니다.');
		}
        
        scheduleInit(); // 스케쥴 얻기
        
        
        /* 차트 받아오기 */
        chartcreate();
    });
})(jQuery);

function scheduleInit() {
	$.ajax({
		url:"calendar/mainSchedule"
		, dataType:"json"
		, success : function(data) {
			var schContent = "";
			$.each(data, function(i, sch) {
				schContent += "<p class='sch_event' style= background-color:" + sch.color + ">";
				schContent += sch.dday + "<br>";
				schContent += sch.start_date + "<br>";
				schContent += "<a class='showAcc' style='cursor:pointer;' id='" + sch.id + "' start_date='" + sch.start_date + "'>" + sch.text + "</a><br>";
				schContent += sch.content != null ? sch.content : "no content" + "<br>";
				schContent += "</p>";
			});
			schContent += "<form id='frm_main' method='post' action='calendar/calendarMainView'>";
			schContent += "<input type='hidden' id='c_id' name='id' >";
			schContent += "<input type='hidden' id='start_date' name='start_date' >";
			schContent += "<form>";
			$("#div_dday").html(schContent);
			
			// 제목 클릭시
			$(".showAcc").on("click", function() {
				$("#c_id").val($(this).attr("id"));
				$("#start_date").val($(this).attr("start_date"));
				$("#frm_main").submit();
			});
		}
		, error : function(e) {
			alert(JSON.stringify(e));
		}
	});
}
</script>

<script type="text/javascript">
function calculatorOpen(){
	window.open("http://localhost:8888/msm/user/calculator", "", "width=350, height=274, status=1");
}

function user_Update(){
	var pwd = document.getElementById('u_pwd_check').value;
	var pwd2 = document.getElementById('u_pwd_check2').value;
	var name = document.getElementById('u_name_check').value;
	var email = document.getElementById('u_email_check').value;
	var phone = document.getElementById('u_phone_check').value;
	var birth = document.getElementById('u_birth_check').value;
	var address = document.getElementById('u_address_check').value;
	
/* 	if(pwd !=''){
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
	if(pwd2==''){
		alert('비밀번호 확인을 입력 해주세요');
		return false;
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
    } */
	
	var f =document.getElementById("user_Update");
	f.submit();

}

function checkForm2(){
	var pwd = document.getElementById('pwd_check2').value;
	var email = document.getElementById('email_check2').value;
	
	if(pwd==''){
		alert('비밀번호를 입력하여주십시오.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	$.ajax({
		url : 'user/userDeleteCheck',
		type : 'POST',
		data : {pwd: pwd, email: email },
		dataType : 'text',
		success : function(data){
			alert(data);
			checkForm3();
		}
	});
}

function checkForm3(){

	var checkNumber = prompt('이메일로 전송된 인증번호를 입력하십시오.', '');
	
	$.ajax({
		url : 'user/userDelete',
		type : 'POST',
		data : {checkDelteNumber : checkNumber},
		dataType : 'text',
		success : function(data){
			alert(data);
			location.href="http://localhost:8888/msm";
		}
	});
}


function chartcreate() {

	//첫날
	var f_start = new Date();
	f_start.setDate('01');

	//마지막 날 계산
	var end_day = (new Date(f_start.getFullYear(),
			f_start.getMonth() + 1, 0)).getDate();
	var f_end = new Date();
	f_end.setDate(end_day);
	
	//날짜 포맷
	var start_date = dateToYYYYMMDD(f_start);
	var end_date = dateToYYYYMMDD(f_end);

	
	$.ajax({
		url : 'accbook/getAccbook2',
		type : 'POST',
		//서버로 보내는 parameter
		data : {
			start_date : start_date,
			end_date : end_date,
		},
		dataType : 'json',
		success : output,
		error : function(e) {
			alert(JSON.stringify(e));
		}
	}); 
}

function output(hm) {
	if (hm.size != 0) {
		pieChart(hm);
	}
	if (hm.size == 0) {
		
	}
}
//데이트 포멧 
function dateToYYYYMMDD(date) {
	function pad(num) {
		num = num + '';
		return num.length < 2 ? '0' + num : num;
	}
	return date.getFullYear() + '-' + pad(date.getMonth() + 1) + '-'
			+ pad(date.getDate());
}

function pieChart(ob2) {
	

		var pieData = {
				고정지출 : ob2.fixed_out,
				지출 : ob2.out,
				고정수입 : ob2.fixed_in,
				수입 : ob2.in1
		};
	
		console.log(pieData);
		var type;
		var list;
		
		var chartpie = c3.generate({
			bindto : "#piechart",

			data : {
				json : [ pieData ],
				keys : {
					value : Object.keys(pieData),
				},
				type : "pie",
				onclick : function(d){
					console.log(d);
						var barData =  {};		
						var keyname = '';
		
					if(d.id=="고정수입"){
						type="고정수입";
						list = ob2.fixed_in_list;
						$.each(list,function(i,item){
							i++;
						barData[keyname + i +" "  +item.a_memo] =item.price;				
						});		
					}	
					if(d.id=="고정지출"){
						type="고정지출";
						list = ob2.fixed_out_list;
						$.each(list,function(i,item){
							i++;
							barData[keyname + i +" "  +item.a_memo] =item.price;						
						});	
					}
					if(d.id=="지출"){
						type="지출";
						list = ob2.out_list;
						$.each(list,function(i,item){
							i++;
							barData[keyname + i +" "  +item.a_memo] =item.price;
							
						});
					}
					if(d.id=="수입"){
						type="수입";
						list = ob2.in_list;
						$.each(list,function(i,item){
							i++;
							barData[keyname + i +" "  +item.a_memo] =item.price;
							
						});
					}

					var chartbar = c3.generate({
						bindto : "#piechart",

						data : {
							json : [ barData ],
							keys : {
								value : Object.keys(barData),
							},
							type : "bar",
							onclick : function(d){
								  chartcreate();
							}
						},
						title : {
							text :type
						},

						bar: {
					        width: {
					            ratio: 0.5 // this makes bar width 50% of length between ticks
					        }

					    },
					    tooltip: {
					    	  format: {
					    	    title: function (x) { return type }
					    	  }
					    	}
					});

				}
			},
			title : {
				text : "이번달 수입 지출 현황"
			},
			bar: {
		        width: {
		            ratio: 0.5 // this makes bar width 50% of length between ticks
		        }

		    },
			tooltip : {
				format : {

					value : function(value, ratio, id) {
						return d3.format(',')(value) + "원";
					}

				}
			}
			

		});
	}
function lineChart(period){
	//첫날

	$.ajax({
		url : 'accbook/getAccbook4',
		type : 'POST',
		data :{
			period : period
		},
		dataType : 'json',
		success : function(ob2){
			console.log(ob2);
			var test = '{bindto : "#piechart",data: {columns: [';
			
			console.log(JSON.stringify(ob2));
			
	

			var mon=['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
			
			var sub_cates=[
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
				,'근로소득'
				,'금융소득'
				,'기타'
			];
		

		var data2 =new Array();
		 var count=0;

			var data2 = new Array();
			
			if(period=='1년'){
				data2.push(['x','1월',2,3,4,5,6,7,8,9,10,11,12]);		
			}
			if(period=='상반기'){
				data2.push(['x',1,2,3,4,5,6]);	
			}
			if(period=='하반기'){
				data2.push(['x',7,8,9,10,11,12]);	
			}
			var count=0;
		$.each(sub_cates, function(i, cate) {
			var data=new Array();
			data.push(sub_cates[count]);
			
			$.each(ob2, function(j, acc) {
				if(acc.length==0){
					data.push(0);
				}else{
					var check=false;
					var price;					
						$.each(acc, function(k, month) {
							if(cate==month.sub_cate){
								price = month.price;
								check =true;
							}
						});
						
					if(!check){
						data.push(0)
					}else{
						data.push(price);
						check=true;
					}
				}
			});
			count++;
			console.log(data);
				data2.push(data);	
		}); 
		
			console.log(data2);
			 
		var barData =  {
				bindto : "#piechart",
				data: {
					x: 'x',
					columns: data2,
					type: 'spline'
					,onclick : function(d){
						    	chartcreate();
						    }
			    },
			   
			    axis: {
			        y: {
			        	padding: {top:0, bottom:0}
			        }
			    },
			    tooltip : {
					format : {
						title :  function (value) { return value+"월" },
						value : function(value, ratio, id) {
							return d3.format(',')(value) + "원";
						}

					}
				}
			 
		 
			};			
		var chart = c3.generate(barData);	
	  
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	}); 
	

}		
	
	

	

 	function test() {
	//
 		var today = new Date();
		var end_date = dateToYYYYMMDD(today);
 	    var day = today.getDate(); 
 	    var day2 = day-1;
		
		today.setDate(day2);
 		var start_date = dateToYYYYMMDD(today);
		
 		//날짜 포맷
		
 		
 		alert(start_date);
 		alert(end_date);
 		$.ajax({
			url : 'accbook/getAccbook2',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				start_date : start_date,
				end_date : end_date
				
			},
			dataType : 'json',
			success : function(ob) {
				console.log(ob);
			},
			error : function(e) {
				alert(JSON.stringify(e));
			}
		}); 
	}

</script>

<body>

<!--결과 메세지  -->
	<c:if test="${errorMsg != null }">
		<c:choose>
			<c:when test="${errorMsg == '수정성공' }">
				<script>
					alertify.success("회원 정보 수정에 성공하였습니다.");
				</script>
			</c:when>
			<c:when test="${errorMsg == '수정실패' }">
				<script>
					alertify.alert("회원정보 수정에 실패하였습니다.");
				</script>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	</c:if>
	<!-- Navigation -->
	<div class="navbar navbar-default navbar-fixed-top topnav"
		role="navigation">
		<!-- Sidebar -->
		<div class="w3-sidebar w3-bar-block w3-border-right"
			style="display: none;" id="mySidebar">
			<button onclick="w3_close()" class="w3-bar-item w3-large">Close
				&times;</button>

			<!-- 로그인 시의 시행 가능 버튼 출력 -->
			<c:if test="${loginID !=null }">
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal" id="userUpdatemodal">회원 정보 수정</button>
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal2">회원 정보 탈퇴</button>
				<a href="user/householdAccount" class="w3-bar-item w3-button">추가
					수입 및 추가 지출 처리 내역</a>
			</c:if>

			<!-- 계산기 -->
			<a href="javascript:calculatorOpen()" class="w3-bar-item w3-button"><i
				class="fa fa-calculator"></i> 계산기</a>

			<!-- 맵 위치 -->
			<a href="user/mapAPI_Test" class="w3-bar-item w3-button"><i
				class="fa fa-map-o"></i> 지도 위치 확인</a>

			<!-- 경조사관리 -->
			<a href="./target/excelTest" class="w3-bar-item w3-button"><i
				class="fa fa-address-book-o"></i> 경조사 관리</a> <a
				href="./target/excelTest" class="w3-bar-item w3-button"><i
				class="fa fa-user-circle-o"></i> <i class="material-icons">settings</i>회원
				관리</a>
		</div>

		<a class="navbar-brand topnav" href="javascript:w3_open()"><img
			src="./resources/user_settingIcon.png" style="height: 30px;"> </a>
		<a class="navbar-brand topnav" href="../newhome">MSM</a>
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>

			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./newhome">HOME</a></li>
					<li><a href="./accbook/Accbook">Account</a></li>
					<li><a href="./calendar/calendarMainView">Calendar</a></li>
					<li><a href="user/userLogout">LogOut</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>

	
	<!-- Body -->
	
	<div class="content_body">
		<div class="content_left">
			<div id="div_dday"></div>

		</div>
	
		<div class="content_right">

			<input type="button" value="연간분석" onclick="lineChart('1년')">
			<input type="button" value="상반기분석" onclick="lineChart('상반기')">
			<input type="button" value="하반기분석" onclick="lineChart('하반기')">
			<input type="button" value="test" onclick="test()">
			<!-- 차트 -->
			<p id="piechart" class="silder" style="width: 400px; height: 500px;">
			<div class="table-users">
				<div class="header">Combined Arrangement</div>

				<table>
					<tr>
						<th>월 고정 수입</th>
						<th>월 가처분 소득</th>
						<th>월 변동 지출 총 액수</th>
						<th>비상 지출 대비 의무 입금</th>
						<th>비상금 적재 잔여 액수</th>
						<th>순수 잔여 액수</th>
					</tr>

					<c:if test="${loginID !=null }">
						<tr>
							<td>${originalIncome}</td>
							<td>${disposableIncome}</td>
							<td>${expenditureChange}</td>
							<td>${emergencyPreparednessDeposit}</td>
							<td>${remainEmergencesAccount}</td>
							<td>${updateRemainingAmount}</td>
						</tr>
					</c:if>

					<c:if test="${loginID ==null }">
						<tr>
							<td colspan="6">로그인 먼저 부탁드립니다.</td>
						</tr>
					</c:if>
				</table>
			</div>


		</div>
	</div>

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<ul class="list-inline">
						<li><a href="#">Home</a></li>
						<li class="footer-menu-divider">&sdot;</li>
						<li><a href="#">About</a></li>
						<li class="footer-menu-divider">&sdot;</li>
						<li><a href="#">Services</a></li>
						<li class="footer-menu-divider">&sdot;</li>
						<li><a href="#">Contact</a></li>
					</ul>
					<p class="copyright text-muted small">Copyright &copy; SCMaster
						C Class 2Group.</p>

				</div>
			</div>
		</div>
		
		<div class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content" style="width: 500px">
						<!-- remote ajax call이 되는영역 -->

					</div>
				</div>
			</div>
		
		
		
	</footer>
<!--회원 정보수정 모달  -->
<%-- 	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
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

			</div>
		</div>
	</div> --%>

	<!-- <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원정보 삭제 사항</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="recipient-name" class="form-control-label">비밀번호를
								입력하십시오.</label> <input type="password" class="form-control"
								id="pwd_check2" placeholder="비밀번호를 정확히 입력하여 주십시오.">
						</div>

						<div class="form-group">
							<label for="recipient-name" class="form-control-label">이메일을
								입력하십시오.</label> <input type="text" class="form-control"
								id="email_check2"
								placeholder="이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)">
						</div>

					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="btn check"
						onclick="return checkForm2()">확인</button>
				</div>


			</div>
		</div>
	</div> -->

</body>
</html>