<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- jquery  -->
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/Guriddo_jqGrid_JS_5.2.0/css/ui.jqgrid.css" />
<script type="text/javascript" src="../resources/Guriddo_jqGrid_JS_5.2.0/js/i18n/grid.locale-en.js"></script>
 
<script type="text/javascript" src="../resources/Guriddo_jqGrid_JS_5.2.0/js/jquery.jqGrid.min.js"></script> 
<link href="../resources/jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="../resources/jquery-ui-1.12.1/jquery-ui.js"></script>






<!-- jquery-ui resource embed end -->
 <script>
 $(document).ready(function(){
	 
	 $(function(){
		    $("#list").jqGrid({ 
		        //ajax 호출할 페이지
		        url:'/result.jsp',
		        //로딩중일때 출력시킬 로딩내용
		        loadtext : '로딩중..',
		        //응답값
		        datatype: "json",
		        height: 250,
		        colNames:['시퀀스','제목', '등록일', '등록자명','조회수'],
		        colModel:[
		            {name:'seq'},
		            {name:'title'},
		            {name:'create_date'},
		            {name:'create_name'},
		            {name:'hitnum'}    
		        ],
		        caption: "그리드 목록"
		    });
		})


	
		})
		


		
	</script>

</head>
<body>
<table id=list>
</body>
</html>

