package global.sesoc.project2.msm.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class test2 {
	public static void main(String[] args) {
		String data = "오늘 7시에 친구와 저녁 약속";
		String data2 ="내일 3시부터 12시까지 데이트";
		String []output = data.split(" ");
		
		String date ="(오늘 |내일 |다음 |다음 달)";
		String test="(부터|까지|에)";
		
		String time = "(1시|2시|3시|4시|5시|6시|7시|8시|9시|10시11시|12시)";
		Pattern p=Pattern.compile(time+test);
		Pattern p2=Pattern.compile(date);
			
		String text; // dhtmlx calendar: 제목
		String start_date; // dhtmlx calendar: 시작시간
		String end_date; // dhtmlx calendar: 종료시간
		String content; // dhtmlx calendar: 내용
			
		
		
		/*for (String string : output) {
			System.out.println(string);
			
			
		}*/
		
		Matcher m =p.matcher(data2);
		Matcher m2 =p2.matcher(data2);
		int cnt = 0;
		while (m.find()) {
			cnt++;
			
			
			
			System.out.println(m.group(0));
			System.out.println(m.group(1));
			
		}
		while (m2.find()) {
			cnt++;
			
			
			
			System.out.println(m2.group(0));
			System.out.println(m2.group(1));
			
		}
		
	
	}
}
