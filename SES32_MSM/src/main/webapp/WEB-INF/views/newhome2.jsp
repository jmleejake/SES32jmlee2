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

<!-- Custom CSS -->
<link href="./resources/PageCSS/homejsp.css" rel="stylesheet">

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

<!-- alert창 CSS -->
<script
	src="./resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>

<link rel="stylesheet"
	href="./resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />

<link rel="stylesheet"
	href="./resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />


<style type="text/css">
/*slide 좌우화살표배경  */
.carousel-control.right {
	background-image: none;
}

.carousel-control.left {
	background-image: none;
}

.carousel-control {
	height: 85%;
}

.carousel-indicators {
	bottom: 5%;
}

.glyphicon {
	color: black;
}
/* 차트 타이틀 */
.c3-title {
	font-size: 25px;
}
/* 차트 배경 */
.c3 svg {
	/* bar chart y axis size */
	font: 14px sans-serif;
	background-color: rgba(255, 255, 255, 0.7);
}

.c3-legend-item {
	/* item size */
	font-size: 15px;
}


body {
	background-color: #f2f2f2;
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


function startClock() { // internal clock//
	var today=new Date();
	var y=today.getFullYear();
	var M=today.getMonth();
	var d=today.getDate();
	var h=today.getHours();
	var m=today.getMinutes();
	var s=today.getSeconds();
	m = checkTime(m);
	s = checkTime(s);
	M = checkDate(M);
	M = checkTime(M);
	var time=y+"-"+M+"-"+d+" ("+h+":"+m+":"+s+")  ";
	document.getElementById('Display_clock').innerHTML = time;
	var t = setTimeout(function(){startClock()},500);
}

function checkTime(i) {
if (i<10) {i = "0" + i};  // add zero in front of numbers < 10 
	return i;
}

function checkDate(i) {
 	i = i+1 ;  // to adjust real month
   	return i;
}

(function($){
    $(window).on("load",function(){
        //$(".content").mCustomScrollbar();
        scheduleInit(); // 스케쥴 얻기
        
        callMainChart();/* 차트 받아오기 */
     
        
        var alertMessage = document.getElementById("alertMessage").value;
        var alertMessageDiv = document.getElementById("alertMessageDiv");
		if(alertMessage!=''){
			alertMessageDiv.innerHTML = "<p><font color='red'>"+alertMessage+"</font></p>";
		}
    });
})(jQuery);
</script>


<script type="text/javascript">
	
	
	
	
	var obj3;
//차트생성
function callMainChart(){
	//첫날
	
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
		url : 'accbook/getAccbook4',
		type : 'POST',
		data :{
			start_date : start_date,
			end_date : end_date,
		},
		dataType : 'json',
		success : function(obj2){
		
			if(obj2.haban.size==0 && obj2.sang.size==0 && obj2.year.size==0 && obj2.pie.size==0){
				$('.silder').html('<img src="./resources/Img/img_notData.gif" style="width=: 80% ;  ">');
			}else{
				obj3=obj2.pie;
				lineChart(obj2.year,obj2.year.type);
				lineChart(obj2.sang,obj2.sang.type);
				lineChart(obj2.haban,obj2.haban.type);
				pieChart(obj2.pie);
			}
		},
		error : function(e) {
			alert(JSON.stringify(e));
		}
	}); 
	

}		
	

//스케쥴 얻기
function scheduleInit() {
	var outSum = 0;
	var today = new Date();
    var day = today.getDate(); 
    today.setDate(day-1);
    var start_date = dateToYYYYMMDD(today);
    var end_date = dateToYYYYMMDD(today);
    
	$.ajax({
		url:"calendar/mainSchedule"
		, data : {
      		start_date : start_date,
      		end_date : end_date
   		}
		, dataType:"json"
		, success : function(obj) {
			var schContent = "";
			
			outSum = obj.fixed_out + obj.out; // 전날 지출 총액
			
			schContent += '<div class="sch_event w3-card-4" style="width: 30%; display: inline-block;">';
			schContent += '<header class="w3-container w3-center" style= "background-color:#ffff80">';
			schContent += '<h5><a id="goAccount" style="cursor:pointer;">[Summary]</a></h5></header>';
			schContent += '<div class="w3-container w3-center w3-white">';
			schContent += '<h5>어제의 총 지출 금액</h5>';
			schContent += '<h5>'+ outSum + '원</h5>';
			schContent += '</div></div>';
			
			$.each(obj.schList, function(i, sch) {
				var text = sch.text.length > 10 ? sch.text.substring(0,10) + "..." : sch.text;
				var content = "no content";
				if(sch.content != null) {
					content = sch.content.length > 10 ? sch.content.substring(0,10) + "..." : sch.content;
				}
				
				schContent += '<div class="sch_event w3-card-4" style="width: 30%; display: inline-block;">';
				schContent += '<header class="w3-container w3-center" style= background-color:' + sch.color + '>';
				schContent += '<h5>'+ sch.dday+ '</h5></header>';
				schContent += '<div class="w3-container w3-center w3-white">';
				schContent += '<h5>'+ sch.start_date+ '</h5>';
				schContent += '<h5><a class="showAcc" style="cursor:pointer;" id=' + sch.id + ' start_date=' + sch.start_date + '>' + text + '</a></h5>';
				schContent += '<h5>'+ content + '</h5>';
				schContent += '</div></div>';
		
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
			
			// summary클릭시
			$("#goAccount").on("click", function() {
				
				location.href = "accbook/Accbook";
			});
		}
		, error : function(e) {
			alert(JSON.stringify(e));
		}
	});
}

function checkForm(){
	var id = document.getElementById('u_id_check').value;
	var pwd = document.getElementById('u_pwd_check').value;
	var pwd2 = document.getElementById('u_pwd_check2').value;
	var name = document.getElementById('u_name_check').value;
	var email = document.getElementById('u_email_check').value;
	var phone = document.getElementById('u_phone_check').value;
	var birth = document.getElementById('u_birth_check').value;
	var address = document.getElementById('u_address_check').value;
	
	if(pwd==''||pwd2==''||name==''||email==''){
		alertify.alert('필수 항목에 해당 내용을 입력하십시오.');
		return false;
	}
	
	if(pwd != pwd2){
		alertify.alert('입력하신 비밀번호와 비밀번호 확인값이 일치하지 않습니다.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alertify.alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	if(!pwd.match(/[a-zA-Z0-9]*[^a-zA-Z0-9\n]+[a-zA-Z0-9]*$/)){
		alertify.alert('비밀번호는 문자, 숫자, 특수문자 조합으로 입력하여 주십시오.');
		return false;
	}
	
	if(id.indexOf(pwd)>-1){
		alertify.alert('비밀번호에 아이디를 사용하실 수 없습니다.');
		return false;
	}
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alertify.alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	var regExp2 = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/

	if(phone.match(regExp2)==null){
		alertify.alert('잘못된 휴대폰 번호입니다. 숫자, -(구분자)를 포함하여 입력합시오');
		return false;
	}
	
    var year = Number(birth.substr(0,4)); 
    var month = Number(birth.substr(5,2));
    var day = Number(birth.substr(8,2));

    if (month < 1 || month > 12) { // check month range
    	alertify.alert("Month must be between 1 and 12.");
     	return false;
    }

    if (day < 1 || day > 31) {
    	alertify.alert("Day must be between 1 and 31.");
     	return false;
    }

    if ((month==4 || month==6 || month==9 || month==11) && day==31) {
    	alertify.alert("Month "+month+" doesn't have 31 days!");
     	return false
    }

    if (month == 2) { // check for february 29th
     	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    
     	if (day>29 || (day==29 && !isleap)) {
     		alertify.alert("February " + year + " doesn't have " + day + " days! ");
      		return false;
     	}
    }
	
	$.ajax({
		url : 'user/userUpdate',
		type : 'POST',
		data : {u_id: id, u_pwd: pwd, u_name: name, u_email: email, u_phone: phone, u_birth: birth, u_address: address },
		dataType : 'text',
		success : function(data){
			alertify.alert(data);
			alertify.alert('다시 재로그인 부탁드립니다...');
			location.href="http://localhost:8888/msm";
		}
	});
}

function checkForm2(){
	var pwd = document.getElementById('pwd_check2').value;
	var email = document.getElementById('email_check2').value;
	
	if(pwd==''){
		alertify.alert('비밀번호를 입력하여주십시오.');
		return false;
	}
	
	if(pwd.length > 16 && pwd.length < 8){
		alertify.alert('비밀번호는 8자 이상 16자 이하 입력해야 합니다.');
		return false;
	}
	
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.match(regExp) == null){
		alertify.alert('이메일 형식을 정확하게 입력하시오.(penguin@daum.net 등)');
		return false;
	}
	
	$.ajax({
		url : 'user/userDeleteCheck',
		type : 'POST',
		data : {pwd: pwd, u_email: email },
		dataType : 'text',
		success : function(data){
			alertify.alert(data);
			
			if(data=='reject!!!'){
				alertify.alert('비밀번호가 일치하지 않습니다!!!!');
				return false;
			}
			else if(data=='success!!!'){
				checkForm3();
			}
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
			alertify.alert(data);
			
			if(data=='삭제 완료'){
				location.href="http://localhost:8888/msm";
			}
			else if(data='번호 불일치'){
				return false;
			}
		}
	});
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
			bindto : "#pieChart",

			data : {
				json : [ pieData ],
				keys : {
					value : Object.keys(pieData),
				},
				type : "pie",
				onclick : function(d){
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
						bindto : "#pieChart",

						data : {
							json : [ barData ],
							keys : {
								value : Object.keys(barData),
							},
							type : "bar",
							onclick : function(d){
								 pieChart(obj3);
							}
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

	function lineChart(ob2,type){
		
	
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
		var id ;
		var chartTitle;
		if(type=='1년'){
			data2.push(['x',1,2,3,4,5,6,7,8,9,10,11,12]);	
			id=1;
			chartTitle = new Date().getFullYear() -1 +"년" 
			
		}
		if(type=='상반기'){
			data2.push(['x',1,2,3,4,5,6]);
			id=2;
			chartTitle=new Date().getFullYear() -1 +'년 상반기'
		}
		if(type=='하반기'){
			data2.push(['x',7,8,9,10,11,12]);
			id=3;
			chartTitle=new Date().getFullYear() -1 +'년 하반기'
		}
		var count=0;
	$.each(sub_cates, function(i, cate) {
		var data=new Array();
		data.push(sub_cates[count]);
		$.each(ob2, function(j, acc) {
			if(acc==type){

			}else{
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
			}
		
		});

		count++;
		data2.push(data);	
		
	}); 
	var barData =  {
			bindto : "#lineChart"+id,
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
					},
	
	
				}
			},
	 
		};			
	var chart = c3.generate(barData);
		
	}

</script>
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
<div class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 500px">
			<!-- remote ajax call이 되는영역 -->

		</div>
	</div>
</div>



<body onload="startClock()">
	<input type="hidden" id="alertMessage" value="${alertMessage}">

	<!-- Navigation -->
	<nav class="navbar navbar-inverse bg-inverse navbar-fixed-top topnav"
		role="navigation">
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand topnav" href="./newhome">MSM</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./accbook/Accbook"><i class="fa fa-krw"></i>가계부</a></li>
					<li><a href="./calendar/calendarMainView"><i
							class="fa fa-calendar"></i>일정</a></li>
					<li><a href="./target/targetManage"><i
							class="fa fa-address-book-o"></i>경조사</a></li> 
					<li><a href="#"><i class="fa fa-sign-out" style="font-size: 150%;"></i></a></li>
					<li><button type="button" class="w3-button w3-animate-opacity"
							data-toggle="modal" data-target="#exampleModal"
							id="userUpdatemodal">
							<img src="./resources/user_settingIcon.png"
								style="margin-top:2px;  height: 20px; width: 30px;">
						</button></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<!-- Body -->

		<%-- 	<div style="width: 95%;">
				<table id="money_info">
					<tr>
						<th id="th_1">지난달 실소득</th>
						<th>지난달 변동지출</th>
						<th>이번달 변동지출</th>
						<th id="th_4">생활 적정 액수</th>
					</tr>

					<c:if test="${loginID !=null }">
						<tr>
							<td id="td_1">${UsableIncome}</td>
							<td>${floatingExpense}</td>
							<td>${floatingExpense2}</td>
							<td id="td_4">${reasonableExpense}</td>
						</tr>
					</c:if>

					<c:if test="${loginID ==null }">
						<tr>
							<td colspan="6">로그인 먼저 부탁드립니다.</td>
						</tr>
					</c:if>
				</table>

				<div id="alertMessageDiv" align="center"></div>
				<div id="Display_clock" align="center" style="color: white"></div>
			</div> --%>
			
			<div class="section_meddle">
			<div class="section_m" style="width: 49%; margin-right: 2%;">
				<div class="img" style="padding: 1em 1em 1em; height: 100%; overflow-y: auto;">
					<div id="div_dday"></div>
				</div>
			</div>

			<div class="section_m" style="width: 49%;">
				<div class="img" style="padding: 4em 3em 3em;">
					<p id="pieChart" class="silder"	style="width: 100%; height: 100%;">
				</div>
			</div>

		</div>


		<div class="section">
			<h3 class="chart_title" style="text-transform: uppercase; height: 5%;">전년도 상반기 수입 지출</h3>
			<div class="chartdiv" style="overflow: visible; text-align: left; height: 90%;">
				<p id="lineChart2" style="width: 100%; height: 100%;">
			</div>
		</div>

		<div class="section">
			<h3 class="chart_title" style="text-transform: uppercase;">전년도 하반기 수입 지출</h3>
			<div class="chartdiv" style="overflow: visible; height: 90%; ">
				<p id="lineChart3" style="width: 100%; height: 100%;">
			</div>
		</div>


</body>
</html>