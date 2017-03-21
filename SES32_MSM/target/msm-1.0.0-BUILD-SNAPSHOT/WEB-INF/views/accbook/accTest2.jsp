<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 차트 API 끌어오기 -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
		/* 데이터 만들기  */
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);
		/* 옵션 설정*/
		
		
        var options = {
          title: 'My Daily Activities'
        };
		/* 차트 종류 선택  */
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		/* 차트 그리기 (데이터,제목)  */
        chart.draw(data, options);
      }
    </script>
<title>Insert title here</title>
</head>
<body>
    	
  <body>
  		<!-- 웹페이지에 띄우기 -->
    <div id="piechart" style="width: 900px; height: 500px;"></div>
  </body>
</html>

