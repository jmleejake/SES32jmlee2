package global.sesoc.project2.msm.calendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("calendar")
public class CalendarController {
	@RequestMapping("calTest")
	public String callTestPage() {
		return "calendar/calTest";
	}
}
