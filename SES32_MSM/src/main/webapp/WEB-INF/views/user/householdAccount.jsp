<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HouseholdAccountCheck</title>

<link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,900" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>

<style>
h1{
  font-size: 30px;
  color: #fff;
  text-transform: uppercase;
  font-weight: 300;
  text-align: center;
  margin-bottom: 15px;
}

table{
  width:100%;
  table-layout: fixed;
}

.tbl-header, .tbl-header2{
  background-color: rgba(255,255,255,0.3);
 }
 
.tbl-content, .tbl-content2{
  height:100px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}

th{
  padding: 20px 15px;
  text-align: left;
  font-weight: 500;
  font-size: 12px;
  color: #fff;
  text-transform: uppercase;
}

td{
  padding: 15px;
  text-align: left;
  vertical-align:middle;
  font-weight: 300;
  font-size: 12px;
  color: #fff;
  border-bottom: solid 1px rgba(255,255,255,0.1);
}

/* demo styles */
@import url(http://fonts.googleapis.com/css?family=Roboto:400,500,300,700);

body{
  background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  font-family: 'Roboto', sans-serif;
}

/* for custom scrollbar for webkit browser*/
section{
  margin: 50px;
}

::-webkit-scrollbar {
    width: 6px;
} 
::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
} 
::-webkit-scrollbar-thumb {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
}
</style>

<script type="text/javascript">
$(window).on("load resize ", function() {
	  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
	  $('.tbl-header').css({'padding-right':scrollWidth});

	}).resize();
	
window.onload = function(){
	 var c = new Calendar();

	 c.add("b", "t");
	}
	 
Calendar = function(){
	 this.objs = [];
	 this.cal;
	 this.idx;
	 this.cal_id = "my_calendar"; //달력 div 객체 Id 로 지정할 이름
	 this.cal_class = "my_class";//일 별 td 에 적용할 클래스 이름
	 this.isSetting = false;
	 this.init(); 
	}
	Calendar.prototype = {
	 init : function(){
	  var This = this;
	  if(window.attachEvent)
	  {
	   document.documentElement.attachEvent("onclick", function(){ This.hide.call(This); });
	  }
	  else
	  {
	   document.documentElement.addEventListener("click", function(){ This.hide.call(This); }, false);
	  }
	 },
	 add : function(img, o, exp , ext){
	  var This = this;
	  img = This.getObj(img);  
	  img.style.cursor = "pointer"
	  if(window.attachEvent)
	  {
	   img.attachEvent("onclick", function(){This.show.call(This, img)});
	  }
	  else
	  {
	   img.addEventListener("click", function(){This.show.call(This, img)}, false);
	  }
	  this.objs.push({ "img" : img, "o" : This.getObj(o), "exp" : !exp ? "" : exp, "ext" : !ext ? "" : ext});  
	 },
	 dateSetting : function(o){ 
	  var date = (event.srcElement || event.target).getAttribute("date");  
	  var exp = this.objs[this.idx].exp;
	  var ext = this.objs[this.idx].ext;
	  var o = this.objs[this.idx].o;  
	  var val = date.substring(0,4) + exp + date.substring(4,6) + exp + date.substring(6,8) + ext;
	  if(o.getAttribute("maxlength"))
	  {
	   val = val.substring(0, o.getAttribute("maxlength"));
	  }  
	  o.value = val;  
	  this.isSetting = true;
	  this.hide();
	  if(event.stopPropagation)
	  {
	   event.stopPropagation();   
	  }
	  else
	  {
	   event.cancelBubble = true;
	  } 

	},
	 create : function(){
	  this.isSetting = false;
	  if(!this.cal)
	  {
	   this.cal = document.createElement("div");
	   this.cal.setAttribute("id", this.cal_id);     
	   this.cal.style.zIndex = "10";
	   this.cal.style.position = "absolute";   
	   document.body.appendChild(this.cal);
	  }
	  var xy = this.getPosition( this.objs[this.idx].img);
	  this.cal.style.left = xy.x + "px";
	  this.cal.style.top = (xy.y + this.objs[this.idx].img.offsetHeight) + "px";
	  this.cal.style.display = "block";
	 },
	 draw : function(date){
	  var This = this;  
	  var o = this.objs[this.idx].o;
	  var reg;
	  var val = o.value;
	  
	  if(typeof date == "number")
	  {
	   date = new Date(date);
	  }
	  else if(typeof date == "string")
	  {
	   date = this.getStringToDate(date);
	  }
	  else if(!date && o.value.length >= 6)
	  {   
	   if(!this.objs[this.idx].exp)
	   {
	    reg = new RegExp(this.objs[this.idx].exp, "g");
	    val = o.value.replace(reg, "");
	   }      
	   date = this.getStringToDate(val.substring(0,6)+"01");   
	  }
	  else
	  {
	   date = new Date(new Date().getFullYear(), new Date().getMonth(), 1);
	  } 
	  
	  var table = document.createElement("table");
	  table.setAttribute("bgColor","#f5f7f6");  
	  table.setAttribute("cellPadding","2"); 
	  table.setAttribute("borderColor", "#cccccc");
	  table.setAttribute("border","1");
	  table.style.border = "1px solid #cccccc";
	  table.style.borderCollapse = "collapse";

	  var day = ["일","월","화","수","목","금","토"];
	  var row = table.insertRow();
	  var cell;
	  row.style.backgroundColor = "#f7a72a";
	  for(var i=0; i<day.length; i++)
	  {  
	   cell = row.insertCell(row.cells.length);
	   cell.setAttribute("align","center");
	   cell.innerHTML = "<font size=2 "+(i==0 ? "color=red":(i==6 ? "color=blue":""))+"><b>"+day[i]+"</b></font>";
	   cell.className = this.cal_class;
	  }  
	  row = table.insertRow(table.rows.length);
	  row.style.backgroundColor = "#BFDFFF";
	  cell = row.insertCell(row.cells.length);
	  cell.setAttribute("colSpan","2");
	  cell.setAttribute("align","center");
	  cell.className = this.cal_class;  
	  cell.setAttribute("title", this.addDate(date, "year", -1).substring(0,4));
	  cell.style.cursor = "pointer";
	  cell.innerHTML = "◀";
	  if(window.attachEvent)
	  {
	   cell.attachEvent("onclick", function(){This.draw.call(This, This.addDate(date, "year", -1)) });    
	  }
	  else
	  {
	   cell.addEventListener("click", function(){This.draw.call(This, This.addDate(date, "year", -1)) }, false);
	  }
	  
	  cell = row.insertCell(row.cells.length);
	  cell.setAttribute("colSpan","3");
	  cell.setAttribute("align","center"); 
	  cell.className = this.cal_class;
	  cell.innerHTML = "<font size=2>"+date.getFullYear() + "년</font>";  
	  cell = row.insertCell(row.cells.length);
	  cell.setAttribute("colSpan","2");
	  cell.setAttribute("align","center");
	  cell.className = this.cal_class;  
	  cell.setAttribute("title", this.addDate(date, "year", 1).substring(0,4));
	  cell.style.cursor = "pointer";
	  cell.innerHTML = "▶";
	  if(window.attachEvent)
	  {
	   cell.attachEvent("onclick", function(){This.draw.call(This, This.addDate(date, "year", 1)) });    
	  }
	  else
	  {
	   cell.addEventListener("click", function(){This.draw.call(This, This.addDate(date, "year", 1)) }, false);
	  }

	  row = table.insertRow(table.rows.length);
	  row.style.backgroundColor = "#BFDFFF";
	  cell = row.insertCell(row.cells.length);
	  cell.setAttribute("colSpan","2");
	  cell.setAttribute("align","center");
	  cell.className = this.cal_class;
	  cell.setAttribute("title", this.addDate(date, "month", -1).substring(4,6));
	  cell.style.cursor = "pointer";
	  cell.innerHTML = "◀";
	  if(window.attachEvent)
	  {
	   cell.attachEvent("onclick", function(){This.draw.call(This, This.addDate(date, "month", -1)) });    
	  }
	  else
	  {
	   cell.addEventListener("click", function(){This.draw.call(This, This.addDate(date, "month", -1)) }, false);
	  }
	  
	  cell = row.insertCell(row.cells.length);
	  cell.setAttribute("colSpan","3");
	  cell.setAttribute("align","center"); 
	  cell.className = this.cal_class;
	  cell.innerHTML = "<font size=2>"+(date.getMonth()+1) + "월</font>";  
	  cell = row.insertCell(row.cells.length);
	  cell.setAttribute("colSpan","2");
	  cell.setAttribute("align","center"); 
	  cell.className = this.cal_class;
	  cell.setAttribute("title", this.addDate(date, "month", 1).substring(4,6));
	  cell.style.cursor = "pointer";
	  cell.innerHTML = "▶";
	  if(window.attachEvent)
	  {
	   cell.attachEvent("onclick", function(){This.draw.call(This, This.addDate(date, "month", 1)) });    
	  }
	  else
	  {
	   cell.addEventListener("click", function(){This.draw.call(This, This.addDate(date, "month", 1)) }, false);
	  }
	  
	  var firstDay = date.getDay();
	  var lastDay = this.getLastDay(date);
	  var count = 0;
	  var year = date.getFullYear();
	  var month = date.getMonth();
	  for(var i=0; i<firstDay; i++)
	  {
	   if(i==0) row = table.insertRow(table.rows.length);
	   cell = row.insertCell(row.cells.length);
	   cell.className = this.cal_class;
	   cell.innerHTML = "&nbsp;";
	   count++;
	  } 
	  for(var i=1; i<=lastDay; i++)
	  {   
	   if(count % 7 == 0) row = table.insertRow(table.rows.length);
	   cell = row.insertCell(row.cells.length);
	   cell.setAttribute("width", "20");
	   if(window.attachEvent)
	   {
	    cell.attachEvent("onmouseover", function(e){ (e.srcElement || e.target).setAttribute("bgColor","#FFFFCC"); });
	    cell.attachEvent("onmouseout", function(e){ (e.srcElement || e.target).removeAttribute("bgColor"); }); 
	   }
	   else
	   {
	    cell.addEventListener("mouseover", function(e){ (e.srcElement || e.target).setAttribute("bgColor","#FFFFCC"); }, false);
	    cell.addEventListener("mouseout", function(e){ (e.srcElement || e.target).removeAttribute("bgColor"); }, false);
	   }
	   cell.className = this.cal_class;
	   if(new Date().getFullYear() == date.getFullYear() && new Date().getMonth() == date.getMonth() && new Date().getDate() == i) 
	   {
	    cell.style.backgroundColor = "#ffdc86";
	   }
	   cell.style.fontSize = "13px";
	   if(count % 7 == 0)  cell.style.color = "red";
	   else if(count % 7 == 6) cell.style.color = "blue";
	   cell.innerHTML = i;
	   cell.style.cursor = "pointer";
	   cell.setAttribute("align","center");      
	   var setDate = This.getDateToString(new Date(year, month, i));   
	   cell.setAttribute("date", setDate);    
	   if(window.attachEvent)
	   {
	    cell.attachEvent("onclick", function(){ This.dateSetting.call(This); });    
	   }
	   else
	   {
	    cell.addEventListener("click", function(){ This.dateSetting.call(This); }, false);
	   }
	   count++;
	  }
	  if(count % 7 != 0)
	  {
	   for(var i=(7-(count%7)); i>0; i--)
	   {
	    cell = row.insertCell(row.cells.length);
	    cell.className = this.cal_class;
	    cell.innerHTML = "&nbsp;";
	   }
	  }
	  this.cal.innerHTML = "";  
	  this.cal.appendChild(table);  
	  this.cal.style.width = this.cal.offsetWidth + "px";
	  this.cal.style.height = this.cal.offsetHeight + "px";  
	  if(event.stopPropagation)
	  {
	   event.stopPropagation();   
	  }
	  else
	  {
	   event.cancelBubble = true;
	  } 
	 },
	 addDate : function(date, flag, cnt)
	 {  
	  if(date.constructor == Date) date = this.getDateToString(date);  
	  else date += "";

	  flag = flag.toLowerCase();
	  var year = Number(date.substring(0,4));
	  var month = Number(date.substring(4,6))-1;  

	  if(flag == "year")   year += cnt;
	  else if(flag == "month")
	  {
	   if(cnt < 0 && month == 0)
	   {
	    year--;
	    month = 11;
	   }
	   else if(cnt > 0 && month == 11)
	   {
	    year++;
	    month = 0;
	   }  
	   else month += cnt;   
	  }  
	  return this.getDateToString(new Date(year, month, 1));  
	 },
	 getDateToString : function(d){
	  year = d.getFullYear(); 
	  month = d.getMonth()+1 < 10 ? "0" + (d.getMonth()+1) : d.getMonth()+1;
	  day = d.getDate() < 10 ? "0" + d.getDate() : d.getDate();
	  hour = d.getHours() < 10 ? "0" + d.getHours() : d.getHours();
	  minute = d.getMinutes() < 10 ? "0" + d.getMinutes() : d.getMinutes();
	  second = d.getSeconds() < 10 ? "0" + d.getSeconds() : d.getSeconds();
	  
	  return year + "" + month + day + hour + minute + second;
	 },
	 getStringToDate : function(val){ 
	  var year, month, day, date;
	  if(val.length >= 4) year = val.substring(0,4);
	  else    date = new Date();
	  if(val.length >= 6) month = Number(val.substring(4,6))-1;  
	  if(val.length >= 8) 
	  {
	   day = val.substring(6,8);   
	   date = new Date(year, month, day);   
	  }
	  else if(typeof month == "number") date = new Date(year, month);

	  return date;
	 },
	 getLastDay : function(year, month){
	  if(year.constructor == Date)
	  {
	   month = year.getMonth();
	   year = year.getFullYear();   
	  }
	  var result = 31;
	  if(month == 3 || month == 5 || month == 8 || month == 10) result = 30;
	  else if(month == 1 && year % 4 == 0) result = 29;
	  else if(month == 1) result = 28;
	  return result;
	 },
	 show : function(o){
	  for(var i=0; i<this.objs.length; i++)
	  {
	   if(this.objs[i].img == o)
	   {
	    this.idx = i;
	    break;
	   }
	  }  
	  this.create();
	  this.draw();
	 },
	 hide : function(){ 
	   if(this.cal) this.cal.style.display = "none";  

	 }, 
	 checkObj : function(o){
	  for(var i=0; i<this.objs.length; i++)
	  {
	   if(o == this.objs[i].img) return false;
	  }
	  return true;
	 },
	 getPosition : function(o){
	  var x = o.offsetLeft;
	  var y = o.offsetTop;
	  var parentO = o.offsetParent;
	  while(parentO)
	  { 
	   x += parentO.offsetLeft;
	   y += parentO.offsetTop;
	   parentO = parentO.offsetParent;
	  }
	  return {"x" : x, "y" : y};
	 },
	 getObj : function(id){
	  return typeof id == "string" ? document.getElementById(id) : id;
	 }
};
</script>

<body>
<section>
  <h1>Income Figures</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
        </tr>
      </thead>
    </table>
  </div>
  
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
        <tr>
          <td>2017-04-04</td>
          <td>식비 </td>
          <td>2,000,000</td>
        </tr>
      </tbody>
    </table>
  </div>
</section>

<section>
  <h1>Expense Figures</h1>
  
  <div class="tbl-header">
    <table cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <th>일자</th>
          <th>내역</th>
          <th>금액</th>
        </tr>
      </thead>
    </table>
  </div>
  
  <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
        <tr>
          <td>2017-04-04</td>
          <td>식비 </td>
          <td>2,000,000</td>
        </tr>
      </tbody>
    </table>
  </div>
</section>
  
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">등록</button>
  
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">등록</h5>
	          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          		<span aria-hidden="true">&times;</span>
	        	</button>
	      </div>
	      			
	      <div class="modal-body">
	          <form>
	           <div class="form-group">
	             <label for="recipient-name" class="form-control-label">등록 일자</label>
	             <input type="text" class="form-control" id="acc_date">
	           </div>
	          
	           <div class="form-group">
	            <label for="recipient-name" class="form-control-label">내역</label>
	            <input type="text" class="form-control" id="acc_memo">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">액수</label>
	            <input type="text" class="form-control" id="acc_price">
	          </div>
	          
	          <div class="form-group">
	            <label for="recipient-name" class="form-control-label">구분</label>
	            <div align="center">수입 <input type="radio" name="acc_type"> 지출 <input type="radio" name="acc_type"></div>
	          </div>
	    	  </form>
          </div>
      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btn check" onclick="return checkForm()">확인</button>
		  </div>
	
	    </div>
	</div>
</div>
<br/>
<div>          
	<input type="button" value="조회 일자" id="b" ><input type="text" name="t" id="t">
</div>
</body>
</html>