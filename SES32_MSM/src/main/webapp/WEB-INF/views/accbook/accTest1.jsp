<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 차트 API 끌어오기 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load("current", {
		packages : [ 'corechart' ]
	});
	//로딩 완료시 함수 실행하여 차트 생성
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		/* 데이터 만들기  */
		var data = google.visualization.arrayToDataTable([
				[ "Element", "Density", {
					role : "style"
				} ], [ "Copper", 8.94, "#b87333" ],
				[ "Silver", 10.49, "silver" ], [ "Gold", 19.30, "gold" ],
				[ "Platinum", 21.45, "color: #e5e4e2" ],
				[ "test3", 44.45, "color: green" ] ]);

		//옵션 설정
		var options = {
			title : "막대 차트 test",
			width : 600,
			height : 400,
			bar : {
				groupWidth : "95%"
			},

			legend : {
				position : "none"
			},
		};

		//그래프 view 설정 
		var view = new google.visualization.DataView(data);
		view.setColumns([ 0, 1, {
			calc : "stringify",

			type : "string",
			role : "annotation"
		}, 2 ]);

		var chart = new google.visualization.ColumnChart(document
				.getElementById("columnchart_values"));
		chart.draw(view, options);

/* 		var data = google.visualization.arrayToDataTable([
				[ 'Genre', 'Fantasy & Sci Fi', 'Romance', 'Mystery/Crime',
						'General', 'Western', 'Literature' ],
				[ '2010', 10, 24, 20, 32, 18, 5 ],
				[ '2020', 16, 22, 23, 30, 16, 9 ],
				[ '2030', 28, 19, 29, 30, 12, 13 ] ]);
		//값으로 출력
		var options = {
			width : 600,
			height : 400,
			legend : {
				position : 'top',
				maxLines : 3
			},
			bar : {
				groupWidth : '75%'
			},
			isStacked : true,
		};

		var options_stacked = {
			isStacked : true,
			height : 300,
			legend : {
				position : 'top',
				maxLines : 3
			},
			vAxis : {
				minValue : 0
			}
		};

		//백 분율 출력  
		var options_fullStacked = {
			isStacked : 'percent',
			height : 300,
			legend : {
				position : 'top',
				maxLines : 3
			},
			vAxis : {
				minValue : 0,
				ticks : [ 0, .3, .6, .9, 1 ]
			}
		};

		//그래프 view 설정 
		var view = new google.visualization.DataView(data);
		view.setColumns([ 0, 1, 2, 3, 4, 5, 6, {
			calc : "stringify",

			type : "string",
			role : "annotation"
		}, 2 ]);

		var chart = new google.visualization.ColumnChart(document
				.getElementById("columnchart_values"));
		chart.draw(view, options_fullStacked); */

	}
</script>
<body>
	<h2>account book test page!!</h2>
	<div id="columnchart_values" style="width: 300px; height: 300px;"></div>

	<h1>test</h1>
</body>
</html>