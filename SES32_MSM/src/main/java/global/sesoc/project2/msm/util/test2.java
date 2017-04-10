package global.sesoc.project2.msm.util;

import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.PatternMatchUtils;

public class test2 {
	public static void main(String[] args) {
		String data = "오늘 7시에 친구와 저녁 약속";
		String data2 ="내일 3시부터 12시까지 데이트";
		String data3 ="7일 3시 약속";
		String date4 ="다음 달 3시부터 12시까지 데이트";
		
		
		String date ="(오늘 |내일 |다음 |다음 달 |1일 |2일 |3일 |4일 |5일 |6일 |7일 |8일 )";
		String test="(부터 |까지 |에 )";
		
		String time = "(1시 |2시 |3시 |4시 |5시 |6시 |7시 |8시 |9시 |10시 11시 |12시 )";
		String time2 = "(1시|2시|3시|4시|5시|6시|7시|8시|9시|10시11시|12시)";
		String month="(1월 |2월 |3월 |4월 |5월 |6월 |7월 |8월 |9월 |10월 |11월 |12월 )";
		Pattern p=Pattern.compile(time+test);
		
		
		Pattern p2=Pattern.compile(date+time2+test+time2+test);
		
		Pattern p3=Pattern.compile(month+date+time);
		Pattern p4=Pattern.compile(date+time);
		String text; // dhtmlx calendar: 제목
		String start_date; // dhtmlx calendar: 시작시간
		String end_date; // dhtmlx calendar: 종료시간
		String content; // dhtmlx calendar: 내용
			
		String month1="";
		
		
		/*for (String string : output) {
			System.out.println(string);
			
			
		}*/
		
		Matcher m =p.matcher(data2);
		Matcher m2 =p2.matcher(data2);
		Matcher m3 = p3.matcher(data3);
		Matcher m4 = p4.matcher(data3);
		int cnt = 0;
		System.out.println(m3);
		System.out.println(m4);
		
		while (m4.find()) {
			cnt++;
			System.out.println(m4);
			
			System.out.println(m4.group(0));
			String t=m4.group().substring(0,2);
			month1= t.replace("일","");
			System.out.println(m4.group(1));
			System.out.println(m4.group(2));	
			System.out.println(month1);
		}
		while (m3.find()) {
			cnt++;
			System.out.println(m3);
		
			System.out.println(m3.group(0));;
			
			System.out.println(m3.group(1));
			System.out.println(m3.group(2));
			
		}
		while (m2.find()) {
			cnt++;
			System.out.println(m2);
		
			System.out.println(m2.group(0));;
			
			System.out.println(m2.group(1));
			System.out.println(m2.group(2));
			System.out.println(m2.group(3));
			System.out.println(m2.group(4));
			System.out.println(m2.group(5));
			
		}
	
	}
}
