<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<title>Mini calendar with the recurring events</title>

	<!-- JAVASCRIPT -->
	<script src="../resources/js/jquery-3.1.1.min.js"></script>
	<script src="../resources/calendar/codebase/dhtmlxscheduler.js" type="text/javascript" charset="utf-8"></script>
	<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_recurring.js" type="text/javascript" charset="utf-8"></script>
	<script src="../resources/calendar/codebase/ext/dhtmlxscheduler_minical.js" type="text/javascript" charset="utf-8"></script>
	<script src="../resources/calendar/codebase/locale/locale_ko.js" type="text/javascript" charset="utf-8"></script>
	
	<!-- CSS -->
	<link rel="stylesheet" href="../resources/calendar/codebase/dhtmlxscheduler.css">

	<style type="text/css" >
		html, body {
			margin: 0px;
			padding: 0px;
			height: 100%;
			overflow: hidden;
		}
	</style>

	<script type="text/javascript" charset="utf-8">
		// 년월 값 얻기
		var thisMonth = new Date().getMonth()+1;
		var thisYear = new Date().getFullYear();	
		
		$(document).ready(function() {
			init();
			getScheduleData(thisYear, thisMonth);
			
			$(".dhx_cal_prev_button").on("click", function() {
				getScheduleData(thisYear, thisMonth);
			});
			
			$(".dhx_cal_next_button").on("click", function() {
				getScheduleData(thisYear, thisMonth);
			});
		});
		
		function init() {
			scheduler.config.multi_day = true;
			scheduler.config.xml_date = "%Y-%m-%d %H:%i";
			scheduler.config.include_end_by = true;
			scheduler.config.repeat_precise = true;
			scheduler.config.start_on_monday = false; // 월요일부터 시작X

			// 달력 설정하는 textbox클릭시 미니캘린더 팝업
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
			
			// 알람시간 설정
			scheduler.locale.labels.section_alarm = "알람시간";
			
			var alarm_opts = [
				{key:"none", label:"없음"},
				{key:"0", label:"시작시간"},
				{key:"5", label:"5분전"},
				{key:"10", label:"10분전"},
				{key:"60", label:"1시간 전"},
				{key:"180", label:"3시간 전"}
			];
			
			// 제목 설정
			scheduler.locale.labels.section_title = "타이토루";

			// 등록/수정창 설정
			scheduler.config.lightbox.sections = [
				{ name:"title", height:60, map_to:"text", type:"textarea", focus:true},
				{ name:"description", height:200, map_to:"content", type:"textarea"},
// 				{ name:"recurring", type:"recurring", map_to:"rec_type", button:"recurring" },
				{ name:"recurring", type:"recurring", map_to:"rec_type", button:"recurring", form:"my_recurring_form" },
				{ name:"alarm", height:23, type:"select", options: alarm_opts, map_to:"alarm_val" },
				{ name:"time", height:72, type:"calendar_time", map_to:"auto" }
			];

			// 캘린더 화면 초기화
			scheduler.init('scheduler_here', new Date(), "month");

			// 데이터 추가
			scheduler.addEvent({
				id:1234
				, start_date: new Date(2017,2,22,14)
				, end_date: new Date(2017,2,24,18)
				, text: "니홍고 3차 역량 -0- -0- -0- -0- -0- -0- -0-"
			});

		}// init function
		
		function getScheduleData(thisYear,thisMonth) {
			$.ajax({
				url:"getSchedule"
				, type:"post"
				, data:{
					thisYear:thisYear
					, thisMonth:thisMonth
				}
				, dataType : "json"
				, success:showEvents
				, error:function(e) {
					alert(JSON.stringify(e));
				} 
			});
		}

		function showEvents(ret) {
			var calArray = new Array();
			
			$.each(ret, function(i, event) {
				var calObj = 
				{
						id:event.id
						, text:event.text
						, start_date:event.start_date
						, end_date:event.end_date
						, content:event.content
						, rec_type:event.rec_type
						, event_pid:event.event_pid
				}
				calArray.push(calObj);
			});
			scheduler.parse(calArray, "json");
		}

	</script>
</head>
<body>
<div id="scheduler_here" class="dhx_cal_container" style='width:100%; height:100%;'>
	<div class="dhx_cal_navline">
		<div class="dhx_cal_prev_button">&nbsp;</div>
		<div class="dhx_cal_next_button">&nbsp;</div>
		<div class="dhx_cal_today_button"></div>
		<div class="dhx_cal_date"></div>
		<!-- 일간/주간/월간 탭 주석처리 -->
<!-- 		<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div> -->
<!-- 		<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div> -->
<!-- 		<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div> -->

		<!--이벤트 설정시 반복view  -->
		<div class="dhx_form_repeat" id="my_recurring_form">
			<form>
				<div>
					<select name="repeat">
						<option value="day">매일</option>
						<option value="week">매주</option>
						<option value="month">매월</option>
						<option value="year">매년</option>
					</select>
					<br />
					<label>
					    <input type="radio" name="end" value="no" checked/>No end date
					</label>
					<br />
					<label>
					    <input type="radio" name="end" value="date_of_end" />
					    <input class="dhx_repeat_date" type="text" name="date_of_end" />까지</label>
				</div>
				<div>
					<div style="display: none;" id="dhx_repeat_day">
						<input type="hidden" name="day_type" value="d" /> <input
							type="hidden" name="day_count" value="1" />
					</div>
					<div style="display: none;" id="dhx_repeat_week">
						원하는 요일을 선택하여 주세요!:<br /> <label><input type="checkbox"
							name="week_day" value="1" />월</label> <label><input
							type="checkbox" name="week_day" value="2" />화</label> <label><input
							type="checkbox" name="week_day" value="3" />수</label> <label><input
							type="checkbox" name="week_day" value="4" />목</label> <label><input
							type="checkbox" name="week_day" value="5" />금</label> <label><input
							type="checkbox" name="week_day" value="6" />토</label> <label><input
							type="checkbox" name="week_day" value="0" />일</label> <input
							type="hidden" name="week_count" value="1" />
					</div>
					<div style="display: none;" id="dhx_repeat_month">
						<label><input class="dhx_repeat_radio" type="hidden"
							name="month_type" value="d" /></label> <input class="dhx_repeat_text"
							type="text" name="month_day" value="1" />일<input
							class="dhx_repeat_text" type="hidden" name="month_count" value="1" /><br />
					</div>
					<div style="display: none;" id="dhx_repeat_year">
						<label><select name="year_month"><option value="0" selected >1월<option value="1">2월<option value="2">3월<option value="3">4월<option value="4">5월<option value="5">6월<option value="6">7월<option value="7">8월<option value="8">9월<option value="9">10월<option value="10">11월<option value="11">12월</select><input class="dhx_repeat_radio" type="hidden" name="year_type" value="d"/></label><input class="dhx_repeat_text" type="text" name="year_day" value="1" />일<br />
					</div>
				</div>
				<input type="hidden" value="no" name="end">
			</form>
		</div>
		<!--이벤트 설정시 반복view  -->
		
	</div>
	<div class="dhx_cal_header">
	</div>
	<div class="dhx_cal_data">
	</div>
</div>
</body>