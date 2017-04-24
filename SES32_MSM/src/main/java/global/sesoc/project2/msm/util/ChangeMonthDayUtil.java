package global.sesoc.project2.msm.util;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ChangeMonthDayUtil {
	static final Logger log = LoggerFactory.getLogger(ChangeMonthDayUtil.class);
	
	public static String monthDay(String str) {
		log.debug("monthDay :: str : {}", str);
		
		String ret = "";
		
		HashMap<String, Object> chng = new HashMap<>();
		chng.put("MON", "월요일");
		chng.put("TUE", "화요일");
		chng.put("WED", "수요일");
		chng.put("THU", "목요일");
		chng.put("FRI", "금요일");
		chng.put("SAT", "토요일");
		chng.put("SUN", "일요일");
		chng.put("JAN", "1월");
		chng.put("FAB", "2월");
		chng.put("MAR", "3월");
		chng.put("APR", "4월");
		chng.put("MAY", "5월");
		chng.put("JUN", "6월");
		chng.put("JUL", "7월");
		chng.put("AUG", "8월");
		chng.put("SEP", "9월");
		chng.put("OCT", "10월");
		chng.put("NOV", "11월");
		chng.put("DEC", "12월");
		
		ret = chng.get(str).toString();
		log.debug("monthDay :: search result : {}", ret);
		
		return ret;
	}
}
