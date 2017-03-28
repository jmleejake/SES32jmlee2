<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar 테스트 페이지</title>

<!-- JAVASCRIPT -->
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<script src="../resources/calendar/codebase/dhtmlxscheduler.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_limit.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_recurring.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_minical.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/locale/locale_ko.js" type="text/javascript" charset="utf-8"></script>

<!-- CSS -->
<link rel="stylesheet" href="../resources/calendar/codebase/dhtmlxscheduler.css" type="text/css" charset="utf-8">

<style >
	html, body{
		margin:0px;
		padding:0px;
		height:100%;
		overflow:hidden;
	}

	.dhx_cal_event {
		z-index: 1;
		cursor: pointer;
	}
	.highlighted_timespan {
		background-color: #87cefa;
		opacity:0.5;
		filter:alpha(opacity=50);
		cursor: pointer;
		z-index: 0;
	}
</style>

<script charset="utf-8">
$(document).ready(function() {
	init();
	getScheduleData();
	$("#btn_search").on("click", searchSchedule);
});

function init() {
	scheduler.config.multi_day = true;
	scheduler.config.xml_date="%Y-%m-%d %H:%i";
	scheduler.config.details_on_create = true;
	scheduler.config.drag_create = false;
	scheduler.config.start_on_monday = false;
	
	// 반복---------------
	scheduler.config.occurrence_timestamp_in_utc = true;
	scheduler.config.include_end_by = true;
	scheduler.config.repeat_precise = true;
	
	scheduler.locale.labels.section_recurring = "반복설정";

	scheduler.attachEvent("onLightbox", function(){
		var lightbox_form = scheduler.getLightbox(); // this will generate lightbox form
		var inputs = lightbox_form.getElementsByTagName('input');
		var date_of_end = null;
		for (var i=0; i<inputs.length; i++) {
			if (inputs[i].name == "date_of_end") {
				date_of_end = inputs[i];
				break;
			}
		}

		var repeat_end_date_format = scheduler.date.date_to_str(scheduler.config.repeat_date);
		var show_minical = function(){
			if (scheduler.isCalendarVisible())
				scheduler.destroyCalendar();
			else {
				scheduler.renderCalendar({
					position:date_of_end,
					date: scheduler.getState().date,
					navigation:true,
					handler:function(date,calendar) {
						date_of_end.value = repeat_end_date_format(date);
						scheduler.destroyCalendar()
					}
				});
			}
		};
		date_of_end.onclick = show_minical;
	});
	// -----------------------
	
	// 알람시간 설정
	scheduler.locale.labels.section_alarm = "알람시간";
	
	var alarm_opts = [
		{key:"none", label:"없음"},
		{key:"start", label:"시작시간"},
		{key:"5", label:"5분전"},
		{key:"10", label:"10분전"},
		{key:"60", label:"1시간 전"},
		{key:"180", label:"3시간 전"}
	];
	
	// 제목 설정
	scheduler.locale.labels.section_title = "타이로루";
	
	scheduler.config.lightbox.sections=[
		{name:"title", height:60, map_to:"text", type:"textarea", focus:true},
		{name:"description", height:130, map_to:"content", type:"textarea"},
		{name:"alarm", height:23, type:"select", options: alarm_opts, map_to:"alarm_val" },
		{name:"recurring", type:"recurring", map_to:"rec_type", button:"recurring" },
		{name:"time", height:72, type:"time", map_to:"auto"}
	];

	scheduler.attachEvent("onTemplatesReady", function() {
		var fix_date = function(date) {  
			date = new Date(date);
			if (date.getMinutes() > 30)
				date.setMinutes(30);
			else
				date.setMinutes(0);
			date.setSeconds(0);
			return date;
		};

	});

	scheduler.init('scheduler_here',new Date(2017,2,1),"month");
	
	// 데이터 추가
	scheduler.addEvent({
		id:1234
		, start_date: new Date(2017,2,22,14)
		, end_date: new Date(2017,2,24,18)
		, text: "니홍고 3차 역량 -0- -0- -0- -0- -0- -0- -0-"
	});
	
}

function getScheduleData() {
	$.ajax({
		url:"getSchedule"
		, type:"post"
		, success:showEvents
		, error:function(e) {
			alert(JSON.stringify(e));
		} 
	});
}

function showEvents(ret) {
	var calArray = new Array();
	
	$.each(ret, function(i, event) {
		var calObj = {id:event.c_id, text:event.c_memo, start_date:event.c_start_time, end_date:event.c_end_time}
		calArray.push(calObj);
	});
	scheduler.parse(calArray, "json");
}

function searchSchedule() {
	$.ajax({
		url:"getSchedule"
		, type:"post"
		, contentType : "application/json; charset=utf-8"
		, data:JSON.stringify({
			c_start_time:$("#sdate").val()
			, c_end_time:$("#edate").val()
			
		})
		, success:showEvents
		, error:function(e) {
			alert(JSON.stringify(e));
		}
	});
}
</script>
</head>
<body>
<form id="frm">
<input id="sdate" type="date" > ~ <input id="edate" type="date" >
<input type="button" id="btn_search" value="검색">
</form>
<div id="scheduler_here" class="dhx_cal_container" style='width:100%; height:100%;'>
	<div class="dhx_cal_navline">
		<div class="dhx_cal_prev_button">&nbsp;</div>
		<div class="dhx_cal_next_button">&nbsp;</div>
		<div class="dhx_cal_today_button"></div>
		<div class="dhx_cal_date"></div>
<!-- 		<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div> -->
<!-- 		<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div> -->
<!-- 		<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div> -->
	</div>
	<div class="dhx_cal_header">
	</div>
	<div class="dhx_cal_data">
	</div>
</div>
</body>
</html>