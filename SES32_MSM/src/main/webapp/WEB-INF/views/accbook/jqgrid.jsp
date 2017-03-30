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
	 
	 var str2 = '<a href="javascript:pageset('4')">◁◁</a>';

		str2+='<a href="javascript:pageset('1')">◀</a>';
		
		str2+='<c:forEach var="n" begin="'+start+'" end="'+end+'">';
		str2+='<a href="javascript:pageset('+currentPage+')">n</a>';

		str2+='</c:forEach>';
			
		str2+='<a href="javascript:pageset('4')">▶</a>';
		str2+='<a href="javascript:pageset('2')">▷▷</a>';
		
		alert(str2);

		


		
	</script>

</head>
<body>
<table id=list>
</body>
</html>

