<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta
	content="Google Chrome is a browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier."
	name="description">
<title>Schdule</title>
<!-- Bootstrap Core CSS -->
<link href="../resources/template/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../resources/template/css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../resources/template/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="../resources/template/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../resources/template/js/bootstrap.min.js"></script>

<!-- dateRange js -->
<!-- <script src="../resources/daterange.js" type="text/javascript"></script> -->

<!-- Include Required Prerequisites -->
<script type="text/javascript"
	src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>

<!-- 날자 범위 선택기 -->
<script type="text/javascript"
	src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

<!-- voice -->
<script type="text/javascript" src="../resources/voice.js"></script>
<link href="https://plus.google.com/100585555255542998765"
	rel="publisher">
<link href="//www.google.com/images/icons/product/chrome-32.png"
	rel="icon" type="image/ico">
<link
	href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&amp;subset=latin"
	rel="stylesheet">
<script src="//www.google.com/js/gweb/analytics/autotrack.js"></script>

<!-- CALENDAR JAVASCRIPT -->
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<script src="../resources/jquery-ui-1.12.1/jquery-ui.js"></script>
<script src="../resources/calendar/codebase/dhtmlxscheduler.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_recurring.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_minical.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/locale/locale_ko.js" type="text/javascript" charset="utf-8"></script>

<!-- CALENDAR CSS -->
<link rel="stylesheet" href="../resources/calendar/codebase/dhtmlxscheduler.css">

<script>
	new gweb.analytics.AutoTrack({
		profile : 'UA-26908291-1'
	});
	
	$( function() {
		init(); // 캘린더 초기화
	    $( "#my_form" ).draggable(); // 등록창이 이동 가능하도록 처리
	} );

	//현재 연월 값!
	var todayDate = new Date();
	var todayDate2 = new Date();
	var nowHr = todayDate2.getHours();
	var nowMin = todayDate2.getMinutes();
	//이벤트창 현재시간으로 설정 
	function selectTime(){
		if(nowHr<12){
		$("#Sam")[0].selected=true;
		$("#Eam")[0].selected=true;
		$("#SHour_"+nowHr)[0].selected=true;
		$("#EHour_"+nowHr)[0].selected=true;
		}else{
		$("#Spm")[0].selected=true;
		$("#Epm")[0].selected=true;
		$("#SHour_"+(nowHr-12))[0].selected=true;
		$("#EHour_"+(nowHr-12))[0].selected=true;
		}
		$("#SMin_"+nowMin)[0].selected=true;
		$("#EMin_"+nowMin)[0].selected=true;
	}

	// DB에서 넘어온 값으로 시간설정 세팅
	function selectTimeFromDB(sH, sM, eH, eM){
		if(sH<12){
		$("#Sam")[0].selected=true;
		$("#SHour_"+sH)[0].selected=true;
		}else{
		$("#Spm")[0].selected=true;
		$("#SHour_"+(sH-12))[0].selected=true;
		}
		
		
		if(eH<12){
		$("#Eam")[0].selected=true;
		$("#EHour_"+eH)[0].selected=true;
		}else{
		$("#Epm")[0].selected=true;
		$("#EHour_"+(eH-12))[0].selected=true;
		}
		$("#SMin_"+sM)[0].selected=true;
		$("#EMin_"+eM)[0].selected=true;
	}

	// 초기화
	function init() {
		scheduler.config.xml_date = "%Y-%m-%d %H:%i";
		scheduler.config.details_on_dblclick = true;
		scheduler.config.details_on_create = true;
		scheduler.config.drag_move = false;

		scheduler.init('scheduler_here', new Date(), "month");
		
		getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);

//	 	scheduler.init('scheduler_here', todayDate, "month");
		 // 월 변경
	    $('.dhx_cal_prev_button').on('click', function(){
	   	 todayDate.setMonth(todayDate.getMonth() - 1);
	   	 getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
	   	 });
	    $('.dhx_cal_next_button').on('click', function(){
	   	 todayDate.setMonth(todayDate.getMonth() + 1);
	   	 getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
	   	 });
	    
	    // 반복일정 체크박스 초기화
	    fnc_e_date_init(true);
	}

	//반복일정 체크박스 및 종료일자 세팅 초기화
	function fnc_e_date_init(status) {
		$("#check_end_date")[0].checked = !status;
		if(status) $("#end_date").val("");
		$("#end_date")[0].disabled = status;
	}

	var html = function(id) { return document.getElementById(id); }; //just a helper

	scheduler.showLightbox = function(id) {
		fnc_e_date_init(true);
		e_dateInit();
		var ev = scheduler.getEvent(id);
		scheduler.startLightbox(id, html("my_form"));
		
		html("description").focus();
		html("description").value = ev.text;
//	 	html("custom1").value = ev.custom1 || "";
		html("content").value = ev.content || "";
//	 	html("category").value = ev.subject || "";
//	 	html("alarm").value = ev.alarm_val  || "none";
		html("repeat").value = ev.repeat_type || "none";
		html("check_end_date").checked = ev.check_end_date;
		html("end_date").value = ev.repeat_end_date || "";
//	 	html("timeSetting").value = ev.timeSetting || "";

		switch(ev.repeat_type) {
		case "monthly": // 매월
			$("#mon_day").val(ev.repeat_detail);
			break;
		case "yearly": // 매년
			var sp = ev.repeat_detail.split("_");
			$("#yr_month").val(sp[0]);
			$("#yr_day").val(sp[1]);	
			break;
		}
		
		$("#alarm").val(ev.alarm_val != null ? ev.alarm_val : "none");
		
		/* //날짜입력창============================= */
		var sDate=ev.start_date;
		var eDate=ev.end_date;
		
		var sH=sDate.getHours();
		var sM=sDate.getMinutes();
		var eH=eDate.getHours();
		var eM=eDate.getMinutes();
		
		//db에서 가져 올때
		if(ev.is_dbdata == "T"){
			selectTimeFromDB(sH, sM, eH, eM);
		}
		//이벤트창에 날짜설정
		else{
		if(sDate.getDate() != eDate.getDate()){
		//alert("날짜 다름");
		eDate=ev.end_date.setHours(ev.end_date.getHours()-1);
		eDate=new Date(eDate);
		}		
		}
	    var SYear = sDate.getFullYear();
	    var SMonth = sDate.getMonth()+1;
	    if(SMonth < 10) SMonth = "0" + SMonth;
	    var SDay = sDate.getDate();
	    if(SDay < 10) SDay = "0" + SDay;
	    $("#timeSetStart").val(SYear+"-"+SMonth+"-"+SDay);
	    var EYear = eDate.getFullYear();
	    var EMonth = eDate.getMonth()+1;
	    if(EMonth < 10) EMonth = "0" + EMonth;
	    var EDay = eDate.getDate();
	    if(EDay < 10) EDay = "0" + EDay;
	    $("#timeSetEnd").val(EYear+"-"+EMonth+"-"+EDay);
	    //새로 이벤트 입력할때 
		if(ev.is_dbdata == null)selectTime();
		
		/* //날짜입력창============================= */
		if(ev.is_dbdata == "T"){
			// 수정시 반복여부 체크
			ev.id = getRealId(ev, "update");
			
			// 반복등록시 종료일자 입력한 내용 체크박스와 함께 세팅.
			if(ev.repeat_end_date != null) {
				console.log("update & repeat status");
				fnc_e_date_init(false);
			}
		}
	};

	// 저장
	function save_form() {
		var ev = scheduler.getEvent(scheduler.getState().lightbox_id);
		ev.text = html("description").value;
//	 	ev.custom1 = html("custom1").value;
		ev.content = $("#content")[0].value;
		ev.alarm_val = $("#alarm").val();
		ev.check_end_date = $("#check_end_date")[0].checked;
		ev.repeat_type = $("#repeat").val()
		ev.repeat_end_date = $("#end_date").val();
		ev.category = $("#category").val();
		/*
		ev.start_date = $("#timeSetStart").val() 
		+ " " + $("#Sampm").val() + " " 
		+ $("#SHour").val() + ":" + $("#SMin").val();
		ev.end_date = $("#timeSetEnd").val()
		+ " " + $("#Eampm").val() + " " 
		+ $("#EHour").val() + ":" + $("#EMin").val();
		*/
		//
		
		switch ($("#Sampm").val()) {
		case "AM":
			ev.start_date = new Date($("#timeSetStart").val() 
			+ " " + $("#SHour").val() 
			+ ":" + $("#SMin").val());
			break;
			
		case "PM":
			ev.start_date = new Date($("#timeSetStart").val() 
			+ " " + (parseInt($("#SHour").val())+12) 
			+ ":" + $("#SMin").val());
			break;
		}
		
		switch ($("#Eampm").val()) {
		case "AM":
			ev.end_date = new Date($("#timeSetEnd").val() 
			+ " " + $("#EHour").val() 
			+ ":" + $("#EMin").val());
			break;
			
		case "PM":
			ev.end_date = new Date($("#timeSetEnd").val() 
			+ " " + (parseInt($("#EHour").val())+12) 
			+ ":" + $("#EMin").val());
			break;
		}
		
		switch($("#repeat").val()) {
		case "monthly": // 매월
			 ev.repeat_detail = $("#mon_day").val();
			break;
		case "yearly": // 매년
			ev.repeat_detail = $("#yr_month").val() + "_" + $("#yr_day").val();	
			break;
		}
		
		console.log(ev);
		
		$.ajax({
			url:"regist"
			, type:"post"
			, data:ev
			,success:function() {
				console.log("success");
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
			}
			, error:function() {
				alert("등록실패");
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
			}
		});

		scheduler.endLightbox(true, html("my_form"));
		
		if(ev.is_dbdata == null){
			scheduler.deleteEvent(ev.id);
		}
	}

	// 창닫기
	function close_form() {
		scheduler.endLightbox(false, html("my_form"));
	}

	// 삭제
	function delete_event() {
		var event_id = scheduler.getState().lightbox_id;
		var ev = scheduler.getEvent(event_id);
		
		scheduler.endLightbox(false, html("my_form"));
		
		// 반복일정 삭제시
		event_id = getRealId(ev, "delete");
		console.log("after getRealId :: " + event_id);
		
		$.ajax({
			url : "del"
			, method : "post"
			, data : {"id" : event_id}
			, success : function(){
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
				alert("deleted!!!");
			}
			,error : function(){
				alert("Not deleted!!!")
			}
		});
		
		scheduler.deleteEvent(event_id);
	}

	// 반복일정 삭제/수정시 
	function getRealId(ev, type) {
		var ret = ev.id;
		console.log(ret);
		console.log(ev);
		
		if(ev.repeat_type != 'none') {
			console.log(ev.repeat_type);
			try {
				// 반복일정의 sub가 되는 id를 삭제할때
				// ex> repeat_0_8
				var sp_id = ret.split("_");
				if(sp_id.length == 1) {
					throw new error();
				}
				var org_id = sp_id[2];
				ret = org_id;
				if(type == "delete") {
					console.log(ret);
					var del_id_list = rept_id_map.get(ret);
					for(var i=0; i<del_id_list.length; i++) {
						console.log(del_id_list[i]);
						scheduler.deleteEvent(del_id_list[i]);
					}
				}
			} catch(err) {
				// 반복일정의 main이 되는 id를 삭제할때
				console.log("exception!!");
				ret = ev.id;
				if(type == "delete") {
					console.log(ret);
					var del_id_list = rept_id_map.get(ret);
					for(var i=0; i<del_id_list.length; i++) {
						console.log(del_id_list[i]);
						scheduler.deleteEvent(del_id_list[i]);
					}
				}
			}
		}
		console.log("getRealId :: " + ret);
		return ret;
	}

	// 반복 일정 셀렉트박스
	function repeatChanged() {
		e_dateInit();
		switch ($("#repeat").val()) {
			case "daily":
				$("#timeSetEnd")[0].disabled = true;
				// 매일 반복일때 날짜는 변경 못하되 시간은 수정가능하도록 함
//	 			$("#Eampm")[0].disabled = true;
//	 			$("#EHour")[0].disabled = true;
//	 			$("#EMin")[0].disabled = true;
				break;
		
		}
	}

	// 시간설정 종료일자 초기화
	function e_dateInit() {
		$("#timeSetEnd")[0].disabled = false;
		$("#Eampm")[0].disabled = false;
		$("#EHour")[0].disabled = false;
		$("#EMin")[0].disabled = false;
	}

	//반복일정 체크박스 클릭시
	function fnc_end_date() {
		if($("#check_end_date")[0].checked) {
			$("#end_date")[0].disabled = false;
		} else {
			$("#end_date").val("");
			$("#end_date")[0].disabled = true;
		}
	}

	// 미니캘린더 보이기
	function show_minical(){
	    if (scheduler.isCalendarVisible()){
	        scheduler.destroyCalendar();
	    } else {
	        scheduler.renderCalendar({
	            position:"dhx_minical_icon",
	            date:scheduler._date,
	            navigation:true,
	            handler:function(date,calendar){
	                scheduler.setCurrentView(date);
	                scheduler.destroyCalendar()
	                getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
	            }
	        });
	    }
	}

	// 종료일자 textbox클릭시 미니캘린더 보이기
	function input_minical(id){
	    if (scheduler.isCalendarVisible()){
	        scheduler.destroyCalendar();
	    } else {
	        scheduler.renderCalendar({
	            position:id,
	            date:scheduler._date,
	            navigation:true,
	            handler:function(date,calendar){
	                var originDate=date;
	                var tYear = originDate.getFullYear();
	                var tMonth = originDate.getMonth()+1;
	                if(tMonth < 10) tMonth = "0" + tMonth;
	                var tDay = originDate.getDate();
	                if(tDay < 10) tDay = "0" + tDay;
	                $("#"+id).val(tYear+"-"+tMonth+"-"+tDay);
	                scheduler.destroyCalendar()
	            }
	        });
	    }
	}

	// 스케쥴 목록을 얻어 화면에 보이기
	function getCalData(thisYear, thisMonth) {
		$.ajax({
			url:"getSchedule"
				, type:"post"
				, data : {"thisYear":thisYear,"thisMonth" : thisMonth}
				, dataType : "json"
				, success:showEvents
				, error:function(e) {
					alert(JSON.stringify(e));
				} 
		});
	}

	// 스케쥴 화면세팅
	function showEvents(ret) {
		var calArray = new Array();
		$.each(ret, function(i, event) {
			var calObj = {
					id:event.id
					, text:event.text
					, start_date:event.start_date
					, end_date:event.end_date
					, content:event.content
					, repeat_type:event.repeat_type
					, repeat_end_date:event.repeat_end_date
					, is_dbdata:event.is_dbdata
					, alarm_yn:event.alarm_yn
					, alarm_val:event.alarm_val
//	 				, subject : event.category
			}
			calArray.push(calObj);
		});
		scheduler.parse(calArray, "json");
		
		//반복일정 뿌려주는 구간!!! repeat
		if(event.repeat_type !="none") {
			console.log("반복일정");
			$.each(calArray, function(i, event) {
				
				makeRepeat(event);
			});
		} 
	}

	//반복 등록된 id들의 array를 original id를 key로 map형태로 저장
	var rept_id_map = new Map();

	function makeRepeat(ev){
		var rept_list_id = new Array();
		
	    //시작날짜를 Date로 !
	    var rStart = new Date(ev.start_date);
	    console.log("반복 기한 시작날짜 : "+rStart);
	    //종료날짜를 Date로!
	    var rEnd = new Date(ev.repeat_end_date);
		console.log("반복 기한 종료날짜 : "+rEnd);
		//이벤트의 종료날짜
	    var rEventEnd = new Date(ev.end_date);
		console.log("r이벤트 종료날짜 : "+rEventEnd);
	    if(rStart.getTime() == rEventEnd.getTime()){
	    	console.log("들어옴");
	    	rEventEnd.setMinutes(rEventEnd.getMinutes()+5);
	    }
		//시작날짜와 종료날짜의 시간텀!
	    var diff = rEnd - rStart;
	    var currDay = 24*60*60*1000;//시*분*초*밀리세컨
	    var currMonth = currDay*30;//월만듬
	    var currYear=currMonth*12;//년 만듬

	    //반복일정 만들기 view 딴에 뿌려주기 !!!! 
	    var Repeat = ev.repeat_type;
	    switch (Repeat) {
	    case "daily":
	    	var dayDiff = parseInt(diff/currDay);
	    	for(var i=0;i<dayDiff;i++){
	    	    var rSday=rStart.setDate(rStart.getDate()+1);
	    	    var rEday=rEventEnd.setDate(rEventEnd.getDate()+1);
	    	  scheduler.addEvent({
	 		       id:"repeat_"+i+"_"+ev.id
	 		      , text:ev.text
					, start_date: new Date(rSday)
					, end_date: new Date(rEday)
					, content:ev.content
					, repeat_type:ev.repeat_type
					, repeat_end_date:ev.repeat_end_date
					, is_dbdata:ev.is_dbdata
//	 				, subject : ev.subject
	 		    });
	    	  rept_list_id.push("repeat_"+i+"_"+ev.id);
	    	}
	    	break;
	    case "monthly":
	    	var monthDiff = parseInt(diff/currMonth);
	    	for(var i=0;i<monthDiff;i++){
	    		var rSday2=rStart.setMonth(rStart.getMonth()+1);
	    		var rEday2=rEventEnd.setMonth(rEventEnd.getMonth()+1);
	    	  	scheduler.addEvent({
	 		       id:"repeat_"+i+"_"+ev.id
	 		      , text:ev.text
					, start_date: new Date(rSday2)
					, end_date: new Date(rEday2)
					, content:ev.content
					, repeat_type:ev.repeat_type
					, repeat_end_date:ev.repeat_end_date
					, is_dbdata:ev.is_dbdata
//	 				, subject : ev.subject
	 		    });
	    	  	rept_list_id.push("repeat_"+i+"_"+ev.id);
	    	}
	    	break;
	    case "yearly":
	    	var yearlyDiff = parseInt(diff/currYear);
	    	for(var i=0;i<yearlyDiff;i++){
	    		var rSday3 = rStart.setFullYear(rStart.getFullYear()+1);
	    		var rEday3 = rEventEnd.setFullYear(rEventEnd.getFullYear()+1);
	    	  	scheduler.addEvent({
	 		       id:"repeat_"+i+"_"+ev.id
	 		      , text:ev.text
					, start_date: new Date(rSday3)
					, end_date: new Date(rEday3)
					, content:ev.content
					, repeat_type:ev.repeat_type
					, repeat_end_date:ev.repeat_end_date
					, is_dbdata:ev.is_dbdata
//	 				, subject : ev.subject
	 		    });
	    	  	rept_list_id.push("repeat_"+i+"_"+ev.id);
	    	}
	    	break;
	    }
	    rept_id_map.set(ev.id, rept_list_id);
	    console.log(rept_id_map);
	}
</script>
<style type="text/css">
.content_body {
	background-image: url("../resources/template/Calendar배경.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

#start_button {
	margin-left: 20%;
	background-color: white;
	border: 0;
	outline: 0;
}

#mic_img {
	width: 150px;
	height: 150px;
}

#select_language {
	position: relative;
	left: -73px;
}

#results {
	font-size: 14px;
	font-weight: bold;
	border: 1px solid #ddd;
	padding: 15px;
	text-align: left;
	min-height: 150px;
}

.content_top {
	margin-top: 4%;
	height: 30%;
}

#my_form {
	position: absolute;
	top: 100px;
	left: 200px;
	z-index: 15;
	display: none;
	background-color: white;
	border: 2px outset gray;
	padding: 20px;
	font-family: Tahoma;
	font-size: 10pt;
}

.detail_sel {
	width: 65px;
	height: 20px;
	display: inline-block;
}

.sel {
	width: 80px;
	height: 20px;
}

.time_section {
	width: 100px;
	height: 15px;
}

#description {
	width: 200px;
}
</style>
</head>

<body>

	<!-- Navigation -->
	<div class="navbar navbar-default navbar-fixed-top topnav"
		role="navigation">
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand topnav" href="">우리조 타이틀</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="home">HOME</a></li>
					<li><a href="Accbook">Account</a></li>
					<li><a href="Calendar">Calendar</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


	<!-- Header -->
	<a name="about"></a>
	<div class="content_body">
		<div class="content_top">
			<!-- search입력 -->
			<div id="search_div">
				<input type="text" class="form-control"
					placeholder="&nbsp;&nbsp;&nbsp;&nbsp;Search"
					style="width: 100%; border: 0px; border-radius: 20px; vertical-align: bottom; outline: none; box-sizing: border-box; float: left;">
				<button type="submit" class="btn btn-default"
					style="width: 20%; height: 34px; border: 0px; border-radius: 20px; vertical-align: bottom; box-sizing: border-box; margin-left: -20%; float: left;">
					<i class="glyphicon glyphicon-search"></i>
				</button>
			</div>
<!-- 			<div id="reportrange" class="form-control" -->
<!-- 				style="background: #fff; cursor: pointer; width: auto; float: left;"> -->
<!-- 				<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp; <span></span> -->
<!-- 				<b class="caret"></b> -->
<!-- 			</div> -->


			<img alt="refresh" src="../resources/refresh.png"
				style="width: 30px; height: 30px; float: left; margin-right: 5px;">

			<button type="button" class="btn btn-default"
				style="margin-right: 5px; float: left;">등록</button>

			<button type="button" class="btn btn-default" data-toggle="modal"
				data-target="#myModal" style="float: left;">간단등록</button>

			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog modal-sm">

					<!--voice Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">마이크 테스트</h4>
							<button id="start_button" onclick="startButton(event)">
								<img alt="mic" src="../resources/Micimg/Mic.png" id="mic_img">
							</button>
						</div>
						<div class="modal-body">
							<div id="results">
								<span class="final" id="final_span"></span> <span
									class="interim" id="interim_span"></span>
							</div>

						</div>
						<div class="modal-footer">
							<select id="select_language" onchange="updateCountry()">
							</select>
							<button type="button" id="voicesubmit" class="btn btn-default">등록</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>

					<script>
						/* 언어 종류 */
						var langs = [ [ '한국어', [ 'ko-KR' ] ],
								[ 'English', [ 'en-US', 'United States' ] ],
								[ '日本語', [ 'ja-JP' ] ] ];

						for (var i = 0; i < langs.length; i++) {
							select_language.options[i] = new Option(
									langs[i][0], i);
						}
						updateCountry();
						console.log('Speak Ready');
					</script>

				</div>
			</div>

			<img alt="excel" src="../resources/Excel.png"
				style="width: 30px; height: 30px; float: left; margin-right: 10px;">

		</div>
		<br> <br>
		<div class="content_bottom">

			<!-- CALENDAR -->
			<div id="my_form">
				<table>
			<!-- 		<tr> -->
			<!-- 			<th>카테고리</th> -->
			<!-- 			<td><input type="text" id="category"></td> -->
			<!-- 		</tr> -->
					<tr>
						<th>제목</th>
						<td><input type="text" id="description"></td>
					</tr>
			<!-- 		<tr> -->
			<!-- 			<th>작성자</th> -->
			<!-- 			<td><input type="text" id="custom1"></td> -->
			<!-- 		</tr> -->
					<tr>
						<th>내용</th>
						<td><textarea id="content" rows="5" cols="50"></textarea></td>
					</tr>
					<tr>
						<th>시간설정</th>
						<td> 
						<!-- 시간설정================================== -->
						<input class="time_section" type="text" id="timeSetStart" onclick="input_minical('timeSetStart')" readonly="readonly">
						<select id="Sampm">
							<option id="Sam">AM</option>
							<option id="Spm">PM</option>
						</select>
						<select id="SHour">
							<c:forEach var="i" begin="1" end="12" >
							<option id="SHour_${i }">
							<c:if test="${i<10 }">
							0${i }
							</c:if>
							<c:if test="${i>=10 }">
							${i }
							</c:if>
							</option>
							</c:forEach>
						</select> :
						<select id="SMin">
							<c:forEach var="i" begin="0" end="59">
							<option id="SMin_${i }">
							<c:if test="${i<10 }">
							0${i }
							</c:if>
							<c:if test="${i>=10 }">
							${i }
							</c:if>
							</option>
							</c:forEach>
						</select>
						~
						<input class="time_section" type="text" id="timeSetEnd" onclick="input_minical('timeSetEnd')" readonly="readonly">
						<select id="Eampm">
							<option id="Eam">AM</option>
							<option id="Epm">PM</option>
						</select>
						<select id="EHour">
							<c:forEach var="i" begin="1" end="12" >
							<option id="EHour_${i }">
							<c:if test="${i<10 }">
							0${i }
							</c:if>
							<c:if test="${i>=10 }">
							${i }
							</c:if>
							</option>
							</c:forEach>
						</select> :
						<select id="EMin">
							<c:forEach var="i" begin="0" end="59">
							<option id="EMin_${i }">
							<c:if test="${i<10 }">
							0${i }
							</c:if>
							<c:if test="${i>=10 }">
							${i }
							</c:if>
							</option>
							</c:forEach>
						</select>
						<br>
						<select class="sel" id="repeat" style="margin-top: 3px;" onchange="repeatChanged();">
							<option value="none">반복안함</option>
							<option value="daily">매일</option>
							<option value="monthly">매월</option>
							<option value="yearly">매년</option>
						</select>
					    <input type="checkbox" id="check_end_date" value="date_of_end" onclick="fnc_end_date();" />
					    <input class="time_section" type="text" id="end_date" disabled="disabled" readonly="readonly" onclick="input_minical('end_date')" />까지
					    <br>
						<!-- 시간설정================================== -->
						</td>
					</tr>
					<tr>
						<th>알람</th>
						<td>
						<select class="sel" id="alarm" onchange="alarmChanged();">
							<option value="none">알람없음</option>
							<option value="0">시작시간</option>
							<option value="5">5분전</option>
							<option value="10">10분전</option>
							<option value="60">1시간전</option>
							<option value="180">3시간전</option>
						</select>
						</td>
					</tr>
				</table>
			<div style="text-align: center;">
				<input type="button" name="save" value="Save" id="save" style='width:100px;' onclick="save_form()">
				<input type="button" name="close" value="Close" id="close" style='width:100px;' onclick="close_form()">
				<input type="button" name="delete" value="Delete" id="delete" style='width:100px;' onclick="delete_event()">
			</div>
			</div>
			
			<div id="scheduler_here" class="dhx_cal_container" style='width:100%; height:800px;'>
				<div class="dhx_cal_navline">
					<div class="dhx_cal_prev_button">&nbsp;</div>
					<div class="dhx_cal_next_button">&nbsp;</div>
					<div class="dhx_cal_today_button"></div>
					<div class="dhx_cal_date"></div>
					<!-- 미니캘린더 -->
					<div class="dhx_minical_icon" id="dhx_minical_icon" onclick="show_minical()">&nbsp;</div> 	
					<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div>
					<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div>
					<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>
				</div>
				<div class="dhx_cal_header">
				</div>
				<div class="dhx_cal_data">
				</div>
			</div>
			<!-- CALENDAR -->


		</div>
		<!-- content bottom -->
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
					<li><a href="#about">About</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#services">Services</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#contact">Contact</a></li>
				</ul>
				<p class="copyright text-muted small">Copyright &copy; Your
					Company 2014. All Rights Reserved</p>
			</div>
		</div>
	</div>
	</footer>
</body>
</html>