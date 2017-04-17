package global.sesoc.project2.msm.util;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import global.sesoc.project2.msm.calendar.vo.CalendarVO;



public class MakeCalendar {
	
	
	int patternType;
	String text; // dhtmlx calendar: 제목
	String start_date; // dhtmlx calendar: 시작시간
	String end_date; // dhtmlx calendar: 종료시간
	String content; // dhtmlx calendar: 내용
	String time;   //시간정보 빼냄
	
	String  year;
	public MakeCalendar() {
		super();
	}
	public CalendarVO makeCalendar(String data){
		CalendarVO calendarVO =new CalendarVO();
		content =data;
		text="";
		
		Calendar cal = Calendar.getInstance( );  
		year = String.valueOf(cal.get ( cal.YEAR )); 
		

		
		time = patternSearch(data);
		
		String [] split = data.split(time);
		
		for (String string : split) {
			text+=string;
		}
		if(text.equals("")){
			text=time;
		}
		
		System.out.println(patternType);
		if(start_date!=null){
			if(start_date.length()==10){
				start_date+= " 00:00:00";
				
			}
		}
		if(end_date!=null){
			if(end_date.length()==10){	
				end_date+= " 00:00:00";
			}
		}
		if(end_date==null){
			end_date = start_date.substring(0,10)+" 23:59:59";
		}
		
		calendarVO.setStart_date(start_date);
		calendarVO.setEnd_date(end_date);
		calendarVO.setContent(content);
		calendarVO.setText(text);
		System.out.println(calendarVO);
		return  calendarVO;
		
	}
	
	
	
	

	public String check(String data){
		Calendar cal = Calendar.getInstance( );  // 현재 날짜/시간 등의 각종 정보 얻기

		
		 
	 
		String result =null;
		
		if(data.equals("이번 달")){
			if(cal.get ( cal.MONTH ) + 1 <10){
				result ="0"+ String.valueOf(cal.get ( cal.MONTH ) + 1);
				
			}else{
				String.valueOf(cal.get ( cal.MONTH ) + 1);
			}			
		}
		else if( data.equals("다음 달")){
			cal.add ( cal.MONTH, 1 ); 
			if(cal.get ( cal.MONTH ) + 1 <10){
				result ="0"+ String.valueOf(cal.get ( cal.MONTH ) + 1);
			}else{
				result = String.valueOf(cal.get ( cal.MONTH ) + 1);				
			}
		}
		if(data.equals("오늘")|| data.equals("오늘 ")){
			result = String.valueOf(cal.get ( cal.DATE ));
		}
		else if(data.equals("내일")|| data.equals("내일 ")){
			cal.add ( cal.DATE, 1 ); 
			result = String.valueOf(cal.get ( cal.DATE ));
		}
		

					
	
		
		year = String.valueOf(cal.get ( cal.YEAR ));
		
		
		
		return result;
	}
	
	
	public String monthChange(String month){
		String result="";
		if( month.equals("이번 달")||month.equals("다음 달")){
			result =check(month);
			return result;
		}
		
		if(month.length() == 3 ){
			result += month.substring(0,2);			
		}
		else if(month.length() == 2 ){
			result+="0"+ month.substring(0,1);			
		}	
		return result;
	}
	public String dayChange(String day){
		String result="";
		if(day.matches(".*내일.*") ||day.matches(".*오늘.*") || day.matches(".*이번주.*") || day.matches(".*다음주.*")){
			result =check(day);
			return result;
		}
		if(day.length() == 3 ){
			result += day.substring(0,2);			
		}
		else if(day.length() == 2 ){
			result+="0"+ day.substring(0,1);			
		}	
		
		return result;
	}
	public String timeChange(String time){
		String result="";
		result =time.substring(0,2);
		if(time.substring(0,2).equals("오전")	){
			if(time.length()==4){
				result ="0"+time.substring(2,3);		
				result += ":00:00";
				return result;
			}else{
				result =time.substring(3,5);
				result += ":00:00";
				return result;
			}
			
		}
		if(time.substring(0,2).equals("오후")	){
			int temp = 12;
			
			if(time.length()==4){
				temp+= Integer.parseInt(time.substring(2,3));
				result =String.valueOf(temp);			
			}else{
				result =time.substring(2,4);
				result =String.valueOf(temp);		
			}
		}else{
			if(time.length()==2){
				result ="0"+time.substring(0,1);				
			}else{
				result =time.substring(0,2);
			}
		}
		
		
		result += ":00:00";
		return result;
	}
	
	

	public String patternSearch(String data){
		String month="(1월 |2월 |3월 |4월 |5월 |6월 |7월 |8월 |9월 |10월 |11월 |12월 "
				+ "|1월|2월|3월|4월|5월|6월|7월|8월|9월|10월|11월|12월|다음 달 |이번 달 )";
		String date ="(오늘|내일|오늘 |내일 |1일 |2일 |3일 |4일 |5일 |6일 |7일 |8일 |9일"
				+ " |11일 |12일 |13일 |14일 |15일 |16일 |17일 |18일 |19일 |20일 "
				+ " |21일 |22일 |23일 |24일 |25일 |26일 |27일 |28일 |29일 |30일 |31일 "
				+ " |1일|2일|3일|4일|5일|6일|7일|8일|9일"
				+ "|11일|12일|13일|14일|15일|16일|17일|18일|19일|20일"
				+ "|21일|22일|23일|24일|25일|26일|27일|28일|29일|30일|31일)";
		String plus="(부터|까지|에|부터 |까지 |에 | 부터 | 까지 | 에 )";
		String time = "(1시 |2시 |3시 |4시 |5시 |6시 |7시 |8시 |9시 |10시 11시 |12시 |13시 |14시 |15시 |16시 |17시 |18시 |19시 |20시 |21시 |22시 |23시 |24시  "
				+ "|1시|2시|3시|4시|5시|6시|7시|8시|9시|10시|11시|12시|13시|14시|15시|16시|17시|18시|19시|20시|21시|22시|23시|24시"
				+ "| 1시| 2시| 3시| 4시| 5시| 6시| 7시| 8시| 9시| 10시| 11시| 12시| 13시| 14시| 15시| 16시| 17시| 18시| 19시| 20시| 21시| 22시| 23시| 24시"
				+ "| 오후 1시 | 오후 2시 | 오후 3시 | 오후 4시 | 오후 5시 | 오후 6시 | 오후 7시 | 오후 8시 | 오후 9시 | 오후 10시 | 오후 11시 | 오후 12시 "
				+ "| 오전 1시 | 오전 2시 | 오전 3시 | 오전 4시 | 오전 5시 | 오전 6시 | 오전 7시 | 오전 8시 | 오전 9시 | 오전 10시 | 오전 11시 | 오전 12시 "
				+ "|오후 1시 |오후 2시 |오후 3시 |오후 4시 |오후 5시 |오후 6시 |오후 7시 |오후 8시 |오후 9시 |오후 10시 |오후 11시 |오후 12시 "
				+ "|오전 1시 |오전 2시 |오전 3시 |오전 4시 |오전 5시 |오전 6시 |오전 7시 |오전 8시 |오전 9시 |오전 10시 |오전 11시 |오전 12시 "
				+ "|오후 1시|오후 2시|오후 3시|오후 4시|오후 5시|오후 6시|오후 7시|오후 8시|오후 9시|오후 10시|오후 11시|오후 12시"
				+ "|오전 1시|오전 2시|오전 3시|오전 4시|오전 5시|오전 6시|오전 7시|오전 8시|오전 9시|오전 10시|오전 11시|오전 12시)";
		Pattern p1=Pattern.compile(month+date+time+plus+month+date+time+plus);
		Pattern p2=Pattern.compile(month+date+plus+date);
		Pattern p3=Pattern.compile(month+date+time+plus);
		Pattern p4=Pattern.compile(month+date+time);
		Pattern p5=Pattern.compile(month+date);
		Pattern p6=Pattern.compile(date+time+plus+date+time+plus);
		Pattern p7=Pattern.compile(date+time+plus+time+plus);
		Pattern p8=Pattern.compile(date+time+plus+time);
		Pattern p9=Pattern.compile(date+plus+date+plus);
		Pattern p10=Pattern.compile(date+time);
		Pattern p11=Pattern.compile(date);
		Pattern p12=Pattern.compile(month+date+plus+month+date+plus);
		Pattern p13=Pattern.compile(month+date+time+plus+time);
		
		Matcher m1 =p1.matcher(data);
		Matcher m2 =p2.matcher(data);
		Matcher m3 =p3.matcher(data);
		Matcher m4 =p4.matcher(data);
		Matcher m5 =p5.matcher(data);
		Matcher m6 =p6.matcher(data);
		Matcher m7 =p7.matcher(data);
		Matcher m8 =p8.matcher(data);
		Matcher m9 =p9.matcher(data);
		Matcher m10 =p10.matcher(data);
		Matcher m11 =p11.matcher(data);
		Matcher m12 =p12.matcher(data);
		Matcher m13 =p13.matcher(data);
		while(m1.find()){
			patternType=1;

			
				start_date=year+"-"+monthChange(m1.group(1).replace(" ", ""))+"-"+dayChange(m1.group(2).replace(" ", ""))+" "+timeChange(m1.group(3).replace(" ", ""));
				end_date=year+"-"+monthChange(m1.group(5).replace(" ", ""))+"-"+dayChange(m1.group(6).replace(" ", ""))+" "+timeChange(m1.group(7).replace(" ", ""));				
		
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m1.group(0);
		}
		while(m2.find()){
			patternType=2;
			System.out.println(m2.group(0));
			start_date=year+"-"+monthChange(m2.group(1).replace(" ", ""))+"-"+dayChange(m2.group(2).replace(" ", ""));
			end_date=year+"-"+monthChange(m2.group(1).replace(" ", ""))+"-"+dayChange(m2.group(4).replace(" ", ""));
			
			
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m2.group(0);
		}
		
		while(m13.find()){
			patternType=1;
			System.out.println(m13.group(0));
			System.out.println(m13.group(3).replace(" ", ""));
				start_date=year+"-"+monthChange(m13.group(1).replace(" ", ""))+"-"+dayChange(m13.group(2).replace(" ", ""))+" "+timeChange(m13.group(3).replace(" ", ""));
				end_date=year+"-"+monthChange(m13.group(1).replace(" ", ""))+"-"+dayChange(m13.group(2).replace(" ", ""))+" "+timeChange(m13.group(5).replace(" ", ""));
		
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m13.group(0);
		}
		while(m3.find()){
			System.out.println(m3.group(0));
			patternType=3;
			
			start_date=year+"-"+monthChange(m3.group(1).replace(" ", ""))+"-"+dayChange(m3.group(2).replace(" ", ""))+" "+timeChange(m3.group(3).replace(" ", ""));
			System.out.println("start_date:"+start_date);
			return m3.group(0);
		}
		while(m12.find()){
			patternType=1;
			System.out.println(m12.group(0));
			
				start_date=year+"-"+monthChange(m12.group(1).replace(" ", ""))+"-"+dayChange(m12.group(2).replace(" ", ""));
				end_date=year+"-"+monthChange(m12.group(4).replace(" ", ""))+"-"+dayChange(m12.group(5).replace(" ", ""));
		
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m12.group(0);
		}
		
	
		
		while(m4.find()){
			System.out.println(m4.group(0));
			patternType=4;
			System.out.println(m4.group(0).matches(".*시.*"));
			if(m4.group(0).matches(".*시.*")){
				
				start_date=year+"-"+monthChange(m4.group(1).replace(" ", ""))+"-"+dayChange(m4.group(2).replace(" ", ""))+" "+timeChange(m4.group(3).replace(" ", ""));;
			}else{
				start_date=year+"-"+monthChange(m4.group(1).replace(" ", ""))+"-"+dayChange(m4.group(2).replace(" ", ""));	
			}
				System.out.println("start_date:"+start_date);
			return m4.group(0);
		}
		while(m5.find()){
			System.out.println(m5.group(0));
			patternType=5;
			start_date=year+"-"+monthChange(m5.group(1).replace(" ", ""))+"-"+dayChange(m5.group(2).replace(" ", ""));	
			return m5.group(0);
		}
		while(m6.find()){
			System.out.println(m6.group(0));
			patternType=6;
			if(m6.group(0).matches(".*시.*")){
				start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m6.group(1).replace(" ", ""))+" "+timeChange(m6.group(2).replace(" ", ""));
				end_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m6.group(4).replace(" ", ""))+" "+timeChange(m6.group(5).replace(" ", ""));
			}else{
				start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m6.group(1).replace(" ", ""));
				end_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m6.group(4).replace(" ", ""));
			}
			
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m6.group(0);
		}
		while(m7.find()){
			System.out.println(m7.group(0));
			patternType=7;
			start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m7.group(1).replace(" ", ""))+" "+timeChange(m7.group(2).replace(" ", ""));
			end_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m7.group(1).replace(" ", ""))+" "+timeChange(m7.group(4).replace(" ", ""));
			
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m7.group(0);
		}
		while(m8.find()){
			System.out.println(m8.group(0));
			patternType=8;
			if(m8.group(0).matches(".*시.*")){
			start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m8.group(1).replace(" ", ""))+" "+timeChange(m8.group(2).replace(" ", ""));
			end_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m8.group(1).replace(" ", ""))+" "+timeChange(m8.group(4).replace(" ", ""));
			}else{
				start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m8.group(1).replace(" ", ""))+" "+timeChange(m8.group(2).replace(" ", ""));
			}
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			return m8.group(0);
		}
		while(m9.find()){
			System.out.println(m9.group(0));
			
			start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m9.group(1).replace(" ", ""));
			end_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m9.group(3).replace(" ", ""));
			System.out.println("start_date:"+start_date);
			System.out.println("end_date:"+end_date);
			
			patternType=9;
			return m9.group(0);
		}
		while(m10.find()){
			System.out.println(m10.group(0));
			patternType=10;
			
			if(m10.group(0).length()>3  ){
				start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m10.group(1).replace(" ", ""))+" "+timeChange(m10.group(2).replace(" ", ""));
				
			}else{
				start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m10.group(1).replace(" ", ""));
			}
			
			System.out.println("start_date:"+start_date);
			
			
			return m10.group(0);
		}
		while(m11.find()){
			System.out.println(m11.group(0));
			start_date=year+"-"+monthChange("이번 달")+"-"+dayChange(m11.group(1).replace(" ", ""));
			
			patternType=11;
			return m11.group(0);
		}

		
		return null;
		
	}

	public static void main(String[] args) {
		
	MakeCalendar makeCalendar = new MakeCalendar();
		
	/* 12월 13일 3시부터 12월 14일 7시까지 	처리
	1.month+date+time+plus+month+date+time+plus
	 12월 13일부터 12월 14일까지 여행 		-12번으로 처리
	2.month+date+plus+month+date+plus	
	8월 16일부터 20일까지 해외여행
	2.month+date+plus+date+plus
	 12월 13일 6시에		처리
	3.month+date+time+plus
	 12월 13일 6시         처리
	4.month+date+time
	  12월 13일         - 4번 으로 처리
	5.month+date
	  14일 3시부터 15일 7시까지    처리
	6.date+time+plus+date+time+plus
	  14일 3시부터 8시까지   처리
	7.date+time+plus+time+plus
	  14일 7시부터 8시       처리
	8.date+time+plus+time
	  14일부터 18일까지   6번으로 처리
	9.date+plus+date+plus   
          14일 4시		처리
	10.date+time
	  15일                10번으로 처리
	11.date
	  12월 27일 오전 5시 30분부터 6시 30분까지
	13.month+date+time+plus+time
	*/
	
/*  String voice = "친구랑 12월 27일 오전 5시부터 6시까지 강남역에서 약속있음";
      
      String voice = "친구랑 오늘 오전 5시부터 6시까지 강남역에서 약속있음";
      
     String voice = "친구랑 오늘부터 내일까지 박람회 일정있음";
      
      
      String voice = "친구랑 내일 오전 5시부터 6시 분까지 강남역에서 약속있음";
  */
	String data ="친구랑 오늘부터 내일까지 박람회 일정있음";
	
	makeCalendar.makeCalendar(data);
	

	
		
		

	}
}
