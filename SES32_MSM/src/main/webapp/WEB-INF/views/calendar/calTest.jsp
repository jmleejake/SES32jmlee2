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
});

function init() {
	scheduler.config.multi_day = true;
	scheduler.config.xml_date="%Y-%m-%d %H:%i";
	scheduler.config.details_on_create = true;
	scheduler.config.drag_create = false;

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

		scheduler.attachEvent("onClick", function(id, e){
			scheduler.showLightbox(id);
		});

		var marked = null;
		var marked_date = null;
		var event_step = 120;
		scheduler.attachEvent("onEmptyClick", function(date, native_event){
			scheduler.unmarkTimespan(marked);
			marked = null;

			var fixed_date = fix_date(date);
			scheduler.addEventNow(fixed_date, scheduler.date.add(fixed_date, event_step, "minute"));
		});

		/*
		scheduler.attachEvent("onMouseMove", function(event_id, native_event) {
			var date = scheduler.getActionData(native_event).date;
			var fixed_date = fix_date(date);

			if (+fixed_date != +marked_date) {
				scheduler.unmarkTimespan(marked);

				marked_date = fixed_date;
				marked = scheduler.markTimespan({
					start_date: fixed_date,
					end_date: scheduler.date.add(fixed_date, event_step, "minute"),
					css: "highlighted_timespan"
				});
			}
		});
		*/

	});

	scheduler.init('scheduler_here',new Date(2017,7,1),"month");
	scheduler.addEvent({
		start_date: new Date(2017,7,1,1),
		end_date: new Date(2017,7,1,3),
		text: "Use single click to create and open details form of existing events"
	});
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
		<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div>
		<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div>
		<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>
	</div>
	<div class="dhx_cal_header">
	</div>
	<div class="dhx_cal_data">
	</div>
</div>
</body>
</html>