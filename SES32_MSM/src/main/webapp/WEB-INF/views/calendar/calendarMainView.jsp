<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Schedule - Calendar</title>
<!-- calendarJSP CSS -->
<link href="../resources/PageCSS/calendarjsp.css" rel="stylesheet"> 

<!-- Bootstrap Core CSS -->
<link href="../resources/template/css/bootstrap.min.css"
	rel="stylesheet">
<!-- icon CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<!-- W3School CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

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
<script src="../resources/calendar/codebase/dhtmlxscheduler.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="../resources/calendar/codebase/ext/dhtmlxscheduler_recurring.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="../resources/calendar/codebase/ext/dhtmlxscheduler_minical.js"
	type="text/javascript" charset="utf-8"></script>
<script src="../resources/calendar/codebase/locale/locale_ko.js"
	type="text/javascript" charset="utf-8"></script>

<!-- CALENDAR CSS -->
<link rel="stylesheet"
	href="../resources/calendar/codebase/dhtmlxscheduler.css">
<link rel="stylesheet"
	href="../resources/jquery-ui-1.12.1/jquery-ui.css">

<!-- alertify -->
<script src="../resources/alertify.js-0.3.11/alertify.js-0.3.11/lib/alertify.min.js"></script>
<link rel="stylesheet" href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.core.css" />
<link rel="stylesheet" href="../resources/alertify.js-0.3.11/alertify.js-0.3.11/themes/alertify.default.css" />

<script>
	/*사이드바 script  */
	function w3_open() {
		document.getElementById("mySidebar").style.display = "block";
	}

	function w3_close() {
		document.getElementById("mySidebar").style.display = "none";
	}
</script>

<script>
	//현재 연월 값!
	var todayDate = new Date();
	var todayDate2 = new Date();
	var nowHr = todayDate2.getHours();
	var nowMin = todayDate2.getMinutes();

	new gweb.analytics.AutoTrack({
		profile : 'UA-26908291-1'
	});

	// 초기화
	function init() {
		scheduler.config.xml_date = "%Y-%m-%d %H:%i";
		scheduler.config.details_on_dblclick = true;
		scheduler.config.details_on_create = true;
		scheduler.config.drag_move = false;

		scheduler.config.max_month_events = 3;

		scheduler.xy.menu_width = 0;
		scheduler.attachEvent("onClick", function() {
			return false;
		});

		var year = todayDate.getFullYear();
		var month = todayDate.getMonth();
		var day = todayDate.getDay();
		if (isNaN('${year}')) {
			scheduler.init('scheduler_here', new Date(), "month");
		} else {
			year = '${year}';
			month = ${month}-1;
			day = ${day}-0;
			scheduler.init('scheduler_here', new Date(year, month, day),"month");
		}

		getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);

		// 월 변경
		$('.dhx_cal_prev_button').on('click', function() {
			todayDate.setMonth(todayDate.getMonth() - 1);
			getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
		});
		$('.dhx_cal_next_button').on('click', function() {
			todayDate.setMonth(todayDate.getMonth() + 1);
			getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
		});

		// 반복일정 체크박스 초기화
		fnc_e_date_init(true);
	}

	//반복일정 체크박스 및 종료일자 세팅 초기화
	function fnc_e_date_init(status) {
		$("#check_end_date")[0].checked = !status;
		if (status)
			$("#end_date").val("");
		$("#end_date")[0].disabled = status;
	}

	// 검색시 자동완성
	$(function() {
		$("#tx_search").autocomplete({
			source : function(request, response) {
				$.ajax({
					url : "searchSchedule",
					type : "post",
					dataType : "json",
					data : {
						keyword : $("#tx_search").val()
					},
					success : function(data) {
						// DB에서 가져온 데이터를 검색 텍스트박스 아래에 세팅
						response($.map(data, function(item) {
							return {
								label : item.start_date + " : " + item.text,
								value : item.text,
								id : item.id
							}
						}));
					}
				});
			},
			minLength : 2
			// 검색된 데이터중 한개를 클릭시 해당 일정의 창을 띄워줌
			,
			select : function(event, ui) {
				scheduler.showLightbox(ui.item.id);
			}
		});
	});

	$(function() {
		init(); // 캘린더 초기화
		$("#my_form").draggable(); // 등록창이 이동 가능하도록 처리
		$("#targetModal").draggable(); // 타겟설정창이 이동 가능하도록 처리

		// 타겟설정 클릭시
		$("#btn_search_target").on("click", function() {

			// 타겟리스트 초기화
			getTarget();

			// 타겟 검색
			$("#btn_search").on("click", function() {
				getTarget();
			});
		});

		// 등록시 장소검색 버튼 클릭시
		$("#btn_search_location")
				.on(
						"click",
						function() {
							var mapObj = window
									.open(
											"http://localhost:8888/msm/user/showMap?opener_type=cal",
											"",
											"width=1000, height=500, status=1");

							var opener_type = mapObj.document
									.getElementById("opener_type");
							opener_type.value = "cal";
						});
	});

	// 타겟리스트 얻기 
	function getTarget(p) {
		$("#page").val(p);
		$.ajax({
			url : "../target/showTarget",
			type : "post",
			data : {
				srch_val : $("#tar_search").val()
				, srch_type : $("#srch_type").val()
				, page : $("#page").val()
			},
			dataType : "json",
			success : showTarget,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	// 타겟리스트 뿌려주기
	function showTarget(data) {
		var start = data.startPageGroup;
		var end = data.endPageGroup;
		var currentPage = data.currentPage;
		
		$("#target_div").html("");
		var tableContent = "";
		tableContent += '<table class="table">';
		tableContent += "<tr>";
		tableContent += "<th>그룹</th>";
		tableContent += "<th>이름</th>";
		tableContent += "<th>생년</th>";
		tableContent += "</tr>";
		$.each(data.list,function(i, target) {
			tableContent += "<tr>";
			tableContent += "<td>" + target.t_group + "</td>";
			tableContent += "<td><a class='showAcc' style='cursor:pointer;' t_id='" + target.t_id + "' t_name='" + target.t_name + "'>"
					+ target.t_name + "</a></td>";
			tableContent += "<td id='td_birth" + target.t_id + "'>"
					+ target.t_birth + "</td>";
			tableContent += "</tr>";
		});

		tableContent += "</table>";
		$("#target_div").html(tableContent);
		
		//페이징	
		var str2 = ' ';
		var m2 = currentPage - 5;
		var m1 = currentPage + 5;
		str2 += '<a href="javascript:getTarget(' + m2
				+ ')" class="w3-button">&laquo;</a>';
		for (var i = start; i <= end; i++) {
			str2 += '<a href="javascript:getTarget(' + i
					+ ')" class="w3-button"> ' + i + ' </a>';
		}
		str2 += '<a href="javascript:getTarget(' + m1
				+ ')" class="w3-button">&raquo;</a>';
		$('#target_pag_div').html(str2);

		$(".showAcc").on("click", function() {
			$("#t_id").val($(this).attr("t_id"));
			$("#t_setting").val($(this).attr("t_name"));
			$('#tar_srch_close').trigger('click');
		});
	}

	//이벤트창 현재시간으로 설정 
	function selectTime() {
		if (nowHr == 0) {
			$("#Sam")[0].selected = true;
			$("#Eam")[0].selected = true;
			$("#SHour_" + nowHr + 12)[0].selected = true;
			$("#EHour_" + nowHr + 12)[0].selected = true;
		} else if (nowHr < 12) {
			$("#Sam")[0].selected = true;
			$("#Eam")[0].selected = true;
			$("#SHour_" + nowHr)[0].selected = true;
			$("#EHour_" + nowHr)[0].selected = true;
		} else if (nowHr == 12) {
			$("#Spm")[0].selected = true;
			$("#Epm")[0].selected = true;
			$("#SHour_" + nowHr)[0].selected = true;
			$("#EHour_" + nowHr)[0].selected = true;
		} else if (nowHr > 12) {
			$("#Spm")[0].selected = true;
			$("#Epm")[0].selected = true;
			$("#SHour_" + (nowHr - 12))[0].selected = true;
			$("#EHour_" + (nowHr - 12))[0].selected = true;
		}
		$("#SMin_" + nowMin)[0].selected = true;
		$("#EMin_" + nowMin)[0].selected = true;
	}

	// DB에서 넘어온 값으로 시간설정 세팅
	function selectTimeFromDB(sH, sM, eH, eM) {
		if (sH == 0) {
			$("#Sam")[0].selected = true;
			$("#SHour_" + (sH + 12))[0].selected = true;
		} else if (sH < 12) {
			$("#Sam")[0].selected = true;
			$("#SHour_" + sH)[0].selected = true;
		} else if (sH == 12) {
			$("#Spm")[0].selected = true;
			$("#SHour_" + sH)[0].selected = true;
		} else if (sH > 12) {
			$("#Spm")[0].selected = true;
			$("#SHour_" + (sH - 12))[0].selected = true;
		}

		if (eH == 0) {
			$("#Eam")[0].selected = true;
			$("#EHour_" + (eH + 12))[0].selected = true;
		} else if (eH < 12) {
			$("#Eam")[0].selected = true;
			$("#EHour_" + eH)[0].selected = true;
		} else if (eH == 12) {
			$("#Epm")[0].selected = true;
			$("#EHour_" + eH)[0].selected = true;
		} else if (eH > 12) {
			$("#Epm")[0].selected = true;
			$("#EHour_" + (eH - 12))[0].selected = true;
		}
		$("#SMin_" + sM)[0].selected = true;
		$("#EMin_" + eM)[0].selected = true;
	}

	var html = function(id) {
		return document.getElementById(id);
	}; //just a helper

	scheduler.showLightbox = function(id) {
		fnc_e_date_init(true);
		e_dateInit();
		var ev = scheduler.getEvent(id);

		console.log(ev);

		scheduler.startLightbox(id, html("my_form"));

		// 현재시간 세팅
		selectTime();

		html("description").focus(); // 제목
		html("description").value = ev.text; // 제목
		html("content").value = ev.content || ""; // 내용
		html("repeat").value = ev.repeat_type || "none"; // 반복설정
		html("check_end_date").checked = ev.check_end_date; // 반복 종료일자 입력 여부
		html("end_date").value = ev.repeat_end_date || ""; // 종료일자
		html("t_setting").value = ev.c_target || ""; // 타겟설정 (이름)
		html("t_id").value = ev.t_id || ""; // 타겟설정 (아이디)

		/*
		switch (ev.repeat_type) {
		case "monthly": // 매월
			$("#mon_day").val(ev.repeat_detail);
			break;
		case "yearly": // 매년
			var sp = ev.repeat_detail.split("_");
			$("#yr_month").val(sp[0]);
			$("#yr_day").val(sp[1]);
			break;
		}
		*/

		$("#alarm").val(ev.alarm_val != null ? ev.alarm_val : "none"); // 알람설정
		$("#sel_color").val(ev.color != null ? ev.color : "lightgray"); // 색상설정

		/* //날짜입력창============================= */
		var sDate = ev.start_date;
		var eDate = ev.end_date;

		var sH = sDate.getHours();
		var sM = sDate.getMinutes();
		var eH = eDate.getHours();
		var eM = eDate.getMinutes();

		//db에서 가져 올때
		if (ev.is_dbdata == "T") {
			selectTimeFromDB(sH, sM, eH, eM);
		}
		//이벤트창에 날짜설정
		else {
			if (sDate.getDate() != eDate.getDate()) {
				//alert("날짜 다름");
				eDate = ev.end_date.setHours(ev.end_date.getHours() - 1);
				eDate = new Date(eDate);
			}
		}
		var SYear = sDate.getFullYear();
		var SMonth = sDate.getMonth() + 1;
		if (SMonth < 10)
			SMonth = "0" + SMonth;
		var SDay = sDate.getDate();
		if (SDay < 10)
			SDay = "0" + SDay;

		$("#timeSetStart").val(SYear + "-" + SMonth + "-" + SDay);

		var EYear = eDate.getFullYear();
		var EMonth = eDate.getMonth() + 1;
		if (EMonth < 10)
			EMonth = "0" + EMonth;
		var EDay = eDate.getDate();
		if (EDay < 10)
			EDay = "0" + EDay;

		$("#timeSetEnd").val(EYear + "-" + EMonth + "-" + EDay);

		//새로 이벤트 입력할때 
		if (ev.is_dbdata == null)
			selectTime();

		/* //날짜입력창============================= */
		if (ev.is_dbdata == "T") {
			// 수정시 반복여부 체크
			ev.id = getRealId(ev, "update");

			// 반복등록시 종료일자 입력한 내용 체크박스와 함께 세팅.
			if (ev.repeat_end_date != null) {
				fnc_e_date_init(false);
			}
		}
	};

	// 저장
	function save_form() {
		var ev = scheduler.getEvent(scheduler.getState().lightbox_id);
		ev.text = html("description").value;
		ev.content = $("#content")[0].value;
		ev.alarm_val = $("#alarm").val();
		ev.check_end_date = $("#check_end_date")[0].checked;
		ev.repeat_type = $("#repeat").val()
		ev.repeat_end_date = $("#end_date").val();
		ev.category = $("#category").val();
		ev.color = $("#sel_color").val();
		ev.t_id = $("#t_id").val();
		ev.c_target = $("#t_setting").val();

		// 시작시간 설정
		switch ($("#Sampm").val()) {
		case "AM":
			var hr12 = parseInt($("#SHour").val());
			if (hr12 == 12) {
				hr12 = 0;
			}
			ev.start_date = new Date($("#timeSetStart").val() + " " + hr12
					+ ":" + $("#SMin").val());
			break;

		case "PM":
			var hr24 = parseInt($("#SHour").val()) + 12;
			if (hr24 == 24) {
				hr24 = 12;
			}
			ev.start_date = new Date($("#timeSetStart").val() + " " + hr24
					+ ":" + $("#SMin").val());
			break;
		}

		// 종료시간 설정
		switch ($("#Eampm").val()) {
		case "AM":
			var hr12 = parseInt($("#EHour").val());
			if (hr12 == 12) {
				hr12 = 0;
			}
			ev.end_date = new Date($("#timeSetEnd").val() + " " + hr12 + ":"
					+ $("#EMin").val());
			break;

		case "PM":
			var hr24 = parseInt($("#EHour").val()) + 12;
			if (hr24 == 24) {
				hr24 = 12;
			}
			ev.end_date = new Date($("#timeSetEnd").val() + " " + hr24 + ":"
					+ $("#EMin").val());
			break;
		}

		/*
		// 반복설정
		switch ($("#repeat").val()) {
		case "monthly": // 매월
			ev.repeat_detail = $("#mon_day").val();
			break;
		case "yearly": // 매년
			ev.repeat_detail = $("#yr_month").val() + "_" + $("#yr_day").val();
			break;
		}
		*/

		$.ajax({
			url : "regist",
			type : "post",
			data : ev,
			success : function() {
				alertify.success("등록되었습니다.");
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
			},
			error : function() {
				alertify.error("등록실패!!");
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
			}
		});

		scheduler.endLightbox(true, html("my_form")); // 등록창 종료

		if (ev.is_dbdata == null) {
			scheduler.deleteEvent(ev.id); // dhtmlx calendar에서 생성하는 id의 일정을 삭제 (두개로 중복되어 보이는 현상 제거)
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

		$.ajax({
			url : "del",
			method : "post",
			data : {
				"id" : event_id
			},
			success : function() {
				getCalData(todayDate.getFullYear(), todayDate.getMonth() + 1);
				alertify.success("삭제되었습니다.");
			},
			error : function() {
				alertify.error("삭제실패!!!")
			}
		});

		scheduler.deleteEvent(event_id);
	}

	// 반복일정 삭제/수정시 
	function getRealId(ev, type) {
		var ret = ev.id;

		if (ev.repeat_type != 'none') {
			try {
				// 반복일정의 sub가 되는 id를 삭제할때
				// ex> repeat_0_8
				var sp_id = ret.split("_");
				if (sp_id.length == 1) {
					throw new error();
				}
				var org_id = sp_id[2];
				ret = org_id;
				if (type == "delete") {
					var del_id_list = rept_id_map.get(ret);
					for (var i = 0; i < del_id_list.length; i++) {
						scheduler.deleteEvent(del_id_list[i]);
					}
				}
			} catch (err) {
				// 반복일정의 main이 되는 id를 삭제할때
				console.log("exception!!");
				ret = ev.id;
				if (type == "delete") {
					var del_id_list = rept_id_map.get(ret);
					for (var i = 0; i < del_id_list.length; i++) {
						scheduler.deleteEvent(del_id_list[i]);
					}
				}
			}
		}
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
		if ($("#check_end_date")[0].checked) {
			$("#end_date")[0].disabled = false;
		} else {
			$("#end_date").val("");
			$("#end_date")[0].disabled = true;
		}
	}

	// 미니캘린더 보이기
	function show_minical() {
		if (scheduler.isCalendarVisible()) {
			scheduler.destroyCalendar();
		} else {
			scheduler.renderCalendar({
				position : "dhx_minical_icon",
				date : scheduler._date,
				navigation : true,
				handler : function(date, calendar) {
					scheduler.setCurrentView(date);
					scheduler.destroyCalendar()
					getCalData(todayDate.getFullYear(),
							todayDate.getMonth() + 1);
				}
			});
		}
	}

	// 종료일자 textbox클릭시 미니캘린더 보이기
	function input_minical(id) {
		if (scheduler.isCalendarVisible()) {
			scheduler.destroyCalendar();
		} else {
			scheduler.renderCalendar({
				position : id,
				date : scheduler._date,
				navigation : true,
				handler : function(date, calendar) {
					var originDate = date;
					var tYear = originDate.getFullYear();
					var tMonth = originDate.getMonth() + 1;
					if (tMonth < 10)
						tMonth = "0" + tMonth;
					var tDay = originDate.getDate();
					if (tDay < 10)
						tDay = "0" + tDay;
					$("#" + id).val(tYear + "-" + tMonth + "-" + tDay);
					scheduler.destroyCalendar()
				}
			});
		}
	}

	// 스케쥴 목록을 얻어 화면에 보이기
	function getCalData(thisYear, thisMonth) {
		$.ajax({
			url : "getSchedule",
			type : "post",
			data : {
				"thisYear" : thisYear,
				"thisMonth" : thisMonth
			},
			dataType : "json",
			success : showEvents,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	// 스케쥴 화면세팅
	function showEvents(ret) {
		var calArray = new Array();
		$.each(ret, function(i, event) {
			var calObj = {
				id : event.id,
				text : event.text,
				start_date : event.start_date,
				end_date : event.end_date,
				content : event.content,
				repeat_type : event.repeat_type,
				repeat_end_date : event.repeat_end_date,
				is_dbdata : event.is_dbdata,
				alarm_yn : event.alarm_yn,
				alarm_val : event.alarm_val,
				color : event.color,
				c_target : event.c_target,
				t_id : event.t_id
			}

			calArray.push(calObj);
		});
		scheduler.parse(calArray, "json");

		//반복일정 뿌려주는 구간!!! repeat
		if (event.repeat_type != "none") {
			$.each(calArray, function(i, event) {
				makeRepeat(event);
			});
		}
	}

	//반복 등록된 id들의 array를 original id를 key로 map형태로 저장
	var rept_id_map = new Map();

	function makeRepeat(ev) {
		var rept_list_id = new Array();

		//시작날짜를 Date로 !
		var rStart = new Date(ev.start_date);
		//종료날짜를 Date로!
		var rEnd = new Date(ev.repeat_end_date);
		//이벤트의 종료날짜
		var rEventEnd = new Date(ev.end_date);
		if (rStart.getTime() == rEventEnd.getTime()) {
			rEventEnd.setMinutes(rEventEnd.getMinutes() + 5);
		}
		//시작날짜와 종료날짜의 시간텀!
		var diff = rEnd - rStart;
		var currDay = 24 * 60 * 60 * 1000;//시*분*초*밀리세컨
		var currMonth = currDay * 30;//월만듬
		var currYear = currMonth * 12;//년 만듬

		//반복일정 만들기 view 딴에 뿌려주기 !!!! 
		var Repeat = ev.repeat_type;
		switch (Repeat) {
		case "daily":
			var dayDiff = parseInt(diff / currDay);
			for (var i = 0; i < dayDiff; i++) {
				var rSday = rStart.setDate(rStart.getDate() + 1);
				var rEday = rEventEnd.setDate(rEventEnd.getDate() + 1);
				scheduler.addEvent({
					id : "repeat_" + i + "_" + ev.id,
					text : ev.text,
					start_date : new Date(rSday),
					end_date : new Date(rEday),
					content : ev.content,
					repeat_type : ev.repeat_type,
					repeat_end_date : ev.repeat_end_date,
					is_dbdata : ev.is_dbdata,
					color : ev.color,
					c_target : ev.c_target,
					t_id : ev.t_id
				});
				rept_list_id.push("repeat_" + i + "_" + ev.id);
			}
			break;
		case "monthly":
			var monthDiff = parseInt(diff / currMonth);
			for (var i = 0; i < monthDiff; i++) {
				var rSday2 = rStart.setMonth(rStart.getMonth() + 1);
				var rEday2 = rEventEnd.setMonth(rEventEnd.getMonth() + 1);
				scheduler.addEvent({
					id : "repeat_" + i + "_" + ev.id,
					text : ev.text,
					start_date : new Date(rSday2),
					end_date : new Date(rEday2),
					content : ev.content,
					repeat_type : ev.repeat_type,
					repeat_end_date : ev.repeat_end_date,
					is_dbdata : ev.is_dbdata,
					color : ev.color,
					c_target : ev.c_target,
					t_id : ev.t_id
				});
				rept_list_id.push("repeat_" + i + "_" + ev.id);
			}
			break;
		case "yearly":
			var yearlyDiff = parseInt(diff / currYear);
			for (var i = 0; i < yearlyDiff; i++) {
				var rSday3 = rStart.setFullYear(rStart.getFullYear() + 1);
				var rEday3 = rEventEnd.setFullYear(rEventEnd.getFullYear() + 1);
				scheduler.addEvent({
					id : "repeat_" + i + "_" + ev.id,
					text : ev.text,
					start_date : new Date(rSday3),
					end_date : new Date(rEday3),
					content : ev.content,
					repeat_type : ev.repeat_type,
					repeat_end_date : ev.repeat_end_date,
					is_dbdata : ev.is_dbdata,
					color : ev.color,
					c_target : ev.c_target,
					t_id : ev.t_id
				});
				rept_list_id.push("repeat_" + i + "_" + ev.id);
			}
			break;
		}
		rept_id_map.set(ev.id, rept_list_id);
	}
	
	// 검색시 엔터키 입력시
	function pressEnter() {
		if(event.keyCode == 13) {
			getTarget();
	    }
	}
</script>


</head>

<body>

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
					data-toggle="modal" data-target="#exampleModal">
					<i class="fa fa-user-circle-o"></i>회원 정보 수정
				</button>
				<button type="button" class="w3-bar-item w3-button"
					data-toggle="modal" data-target="#exampleModal2">
					<i class="fa fa-exclamation-triangle"></i>회원 정보 탈퇴
				</button>
				<a href="../user/householdAccount" class="w3-bar-item w3-button"><i
					class="fa fa-krw"></i>비상금 관리 내역</a>
			</c:if>

			<!-- 경조사관리 -->
			<a href="../target/excelTest" class="w3-bar-item w3-button"><i
				class="fa fa-address-book-o"></i> 경조사 관리</a>
		</div>

		<a class="navbar-brand topnav" href="javascript:w3_open()"><img
			src="../resources/user_settingIcon.png" style="height: 30px;">
		</a>

		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand topnav" href="../newhome">MSM</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../newhome">HOME</a></li>
					<li><a href="../accbook/Accbook">Account</a></li>
					<li><a href="calendarMainView">Calendar</a></li>
					<li><a href="../user/userLogout">LogOut</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</div>


	<!-- Header -->
	<div class="content_body">
		<div class="content_top">
			<!-- search입력 -->
			<div class="ui-widget">
				<div id="search_div">
					<input id="tx_search" type="text" class="form-control"
						placeholder="&nbsp;&nbsp;&nbsp;&nbsp;Search"
						style="width: 100%; border: 0px; border-radius: 20px; vertical-align: bottom; outline: none; box-sizing: border-box; float: left;">
					<button type="submit" class="btn btn-default"
						style="width: 20%; height: 34px; border: 0px; border-radius: 20px; vertical-align: bottom; box-sizing: border-box; margin-left: -20%; float: left;">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
			<!-- 			<div id="reportrange" class="form-control" -->
			<!-- 				style="background: #fff; cursor: pointer; width: auto; float: left;"> -->
			<!-- 				<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp; <span></span> -->
			<!-- 				<b class="caret"></b> -->
			<!-- 			</div> -->


			<!-- 			<img alt="refresh" src="../resources/refresh.png" -->
			<!-- 				style="width: 30px; height: 30px; float: left; margin-right: 5px;"> -->

			<!-- 			<button type="button" id="btn_create" class="btn btn-default" -->
			<!-- 				style="margin-right: 5px; float: left;">등록</button> -->

			<button type="button" class="btn btn-default" data-toggle="modal"
				data-target="#myModal" style="margin-left: 2%; float: left;">간단등록</button>

			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog modal-sm">

					<!--voice Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">스케쥴 간단등록</h4>
							<button id="start_button" onclick="startButton(event)">
								<img alt="mic" src="../resources/Img/Mic.png" id="mic_img">
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
							<button type="button" id="voicesubmit" class="btn btn-default" data-dismiss="modal">등록</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
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

			<!-- 			<img alt="excel" src="../resources/Excel.png" -->
			<!-- 				style="width: 30px; height: 30px; float: left; margin-right: 10px;"> -->

		</div>


		<div class="content_bottom">

			<!-- CALENDAR -->
			<div id="my_form">
				<table>
					<tr>
						<th>색상설정</th>
						<td><select id="sel_color" class="form-control">
								<option value="lightcoral"
									style="color: #D80027; font-size: 18px;">■빨강</option>
								<option value="orange" style="color: #FFDA44; font-size: 18px;">■주황</option>
								<option value="lightblue"
									style="color: #006DF0; font-size: 18px;">■파랑</option>
								<option value="lightgreen"
									style="color: #91DC5A; font-size: 18px;">■초록</option>
								<option value="violet" style="color: #933EC5; font-size: 18px;">■보라</option>
								<option value="peru" style="color: #848752; font-size: 18px;">■황토</option>
								<option value="lightgray" style="color: gray; font-size: 18px;">■회색</option>
						</select></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" class="form-control" id="description"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea id="content" rows="5" cols="50"></textarea></td>
					</tr>
					<tr>
						<th rowspan="2">시간설정</th>
						<td>
							<!-- 시간설정================================== --> 
							<input class="time_section form-control" type="text" id="timeSetStart"
							onclick="input_minical('timeSetStart')" style="width: 120px; float: left;" readonly="readonly">
							<select id="Sampm" class="form-control" style="width: 70px; float: left;">
								<option id="Sam">AM</option>
								<option id="Spm">PM</option>
							</select> 
							<select id="SHour" class="form-control" style="width: 70px; float: left;">
								<c:forEach var="i" begin="1" end="12">
									<option id="SHour_${i }">
										<c:if test="${i<10 }">
								0${i }
								</c:if>
										<c:if test="${i>=10 }">
								${i }
								</c:if>
									</option>
								</c:forEach>
							</select>
							<label style="float: left; font-size: 25px; font-weight: bold;"> : </label>
							<select id="SMin" class="form-control" style="width: 70px; float: left;">
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
							<label style="float: left; font-size: 20px; font-weight: bold;"> ~ </label>
							<input class="time_section form-control" style="width: 150px; float: left;" type="text" id="timeSetEnd"
							onclick="input_minical('timeSetEnd')" readonly="readonly">
							<select id="Eampm" class="form-control" style="width: 70px; float: left;">
								<option id="Eam">AM</option>
								<option id="Epm">PM</option>
							</select> 
							<select id="EHour" class="form-control" style="width: 70px; float: left;">
								<c:forEach var="i" begin="1" end="12">
									<option id="EHour_${i }">
										<c:if test="${i<10 }">
								0${i }
								</c:if>
										<c:if test="${i>=10 }">
								${i }
								</c:if>
									</option>
								</c:forEach>
							</select>
							<label style="float: left; font-size: 25px; font-weight: bold;"> : </label>
							<select id="EMin" class="form-control" style="width: 70px; float: left;">
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
							</select> <br> 
							<!-- 시간설정================================== -->
						</td>
					</tr>
					<tr>
						<td>
							<select id="repeat" class="form-control"
							style="float: left;" onchange="repeatChanged();">
								<option value="none">반복안함</option>
								<option value="daily">매일</option>
								<option value="monthly">매월</option>
								<option value="yearly">매년</option>
							</select> 
							<input type="checkbox" class="form-control" style="margin-top:7px; width:20px; height:20px; float: left;" 
							id="check_end_date" value="date_of_end" onclick="fnc_end_date();" /> 
							<input class="time_section form-control" style="width: 150px; float: left;"
							type="text" id="end_date" disabled="disabled" readonly="readonly"
							onclick="input_minical('end_date')" />
							<label style="margin-top:7px; float: left; font-size: 15px; font-weight: bold;">까지</label> 
						</td>
					</tr>
					<tr>
						<th>알람</th>
						<td><select id="alarm" class="form-control">
								<option value="none">알람없음</option>
								<option value="0">시작시간</option>
								<option value="5">5분전</option>
								<option value="10">10분전</option>
								<option value="60">1시간전</option>
								<option value="180">3시간전</option>
						</select></td>
					</tr>
					<tr>
						<th>타겟설정</th>
						<td><input type="hidden" id="t_id"> <input
							type="text" class="form-control" style="float: left;" readonly="readonly" disabled="disabled"
							id="t_setting"> <input type="button" class="btn btn-default"
							id="btn_search_target" style="float: left;" value="타겟검색" data-toggle="modal"
							data-target="#targetModal"></td>
					</tr>
					<tr>
						<th>장소설정</th>
						<td><input type="button" class="btn btn-default" id="btn_search_location"
							value="장소검색"></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;">
						<input type="button" class="btn btn-default" name="save" value="저장" id="save"
						style='width: 100px;' onclick="save_form()"> <input
						type="button" class="btn btn-default" name="close" value="닫기" id="close"
						style='width: 100px;' onclick="close_form()"> <input
						type="button" class="btn btn-default" name="delete" value="삭제" id="delete"
						style='width: 100px;' onclick="delete_event()">
						</td>
					</tr>
				</table>
			</div>

			<div id="scheduler_here" class="dhx_cal_container"
				style='width: 95%; height: 90%; margin: auto;'>
				<div class="dhx_cal_navline"> 
					<div class="dhx_cal_prev_button">&nbsp;</div>
					<div class="dhx_cal_next_button">&nbsp;</div>
					<div class="dhx_cal_today_button"></div>
					<div class="dhx_cal_date"></div>
					<!-- 미니캘린더 -->
					<!-- 					<div class="dhx_minical_icon" id="dhx_minical_icon" onclick="show_minical()">&nbsp;</div> 	 -->
					<div class="dhx_cal_tab" name="day_tab" style="right: 140px;"></div>
					<!-- 					<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div> -->
					<div class="dhx_cal_tab" name="month_tab" style="right: 76px;"></div>
				</div>
				<div class="dhx_cal_header"></div>
				<div class="dhx_cal_data"></div>
			</div>
			<!-- CALENDAR -->

			<div class="modal fade" id="targetModal" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content" style="width: 350px;">
						<div class="modal-header">
							<h4 class="modal-title">타겟설정</h4>
						</div>
						<div class="modal-body">
							<table>
								<tr>
									<td><select id="srch_type" class="form-control">
											<option value="all">전체</option>
											<option value="grp">그룹</option>
											<option value="nm" selected="selected">이름</option>
											<option value="ev">이벤트</option>
									</select></td>
									<td><input type="text" class="form-control"
										id="tar_search" onkeydown="pressEnter();"></td>
									<td><input type="button" class="btn btn-default"
										id="btn_search" value="검색"></td>
								</tr>
							</table>
							<div id="target_div"></div>
							<input type="hidden" name="page" id="page" value="1">
							<div align="center" id="target_pag_div" class="w3-bar"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">확인</button>
							<button type="button" id="tar_srch_close" class="btn btn-default"
								data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					
					<p class="copyright text-muted small">Copyright &copy; SCMaster
						C Class 2Group.</p>
				</div>
			</div>
		</div>
	</footer>

</body>

</html>
