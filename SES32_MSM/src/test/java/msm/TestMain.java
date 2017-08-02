package msm;

import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.Base64.Encoder;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.UUID;

public class TestMain {
	
	public static void main(String[] args) {
		System.out.println(UUID.randomUUID().toString());
		
		Calendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = cal.getTime();
		System.out.println(sdf.format(d));
	}
}
