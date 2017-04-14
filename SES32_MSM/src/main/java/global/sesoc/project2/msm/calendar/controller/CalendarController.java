package global.sesoc.project2.msm.calendar.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.calendar.dao.CalendarDAO;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;
import global.sesoc.project2.msm.util.MakeCalendar;

@Controller
@RequestMapping("calendar")
public class CalendarController {
	@Autowired
	CalendarDAO dao;
	
	Logger log = LoggerFactory.getLogger(CalendarController.class);
	
	/**
	 * 캘린더 테스트페이지로 이동
	 * @return
	 */
	@RequestMapping("calTest")
	public String callTestPage() {
		log.debug("callTestPage");
		return "calendar/calTest";
	}
	
	@RequestMapping("calendarView")
	public String calendarView() {
		log.debug("calendarView");
		return "calendar/Calendar";
	}
	@RequestMapping(value = "calendarMainView", method = RequestMethod.GET)
	public String calendarMainView() {
	
		
		return "calendar/calendarMainView";
	}

	
	
	
	/**
	 * 캘린더 출력 (TODO: 추후 상세검색 및 검색부분 추가 예정)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getSchedule", method=RequestMethod.POST)
	public ArrayList<CalendarVO> getScheduleData(int thisYear, int thisMonth) {
		String date = thisYear+"-"+String.format("%02d", thisMonth)+"-01";
		log.debug("getScheduleData :: date={}", date);
		HashMap<String, Object> param = new HashMap<>();
		param.put("date", date);
		return dao.selectSchedules(param);
	}
	
	/**
	 * 일정 등록
	 * @param vo 캘린더 vo객체
	 * @param _end_date 반복설정시 종료일자
	 * @param _start_date 매월 반복 설정시 시작일자
	 * @param session 세션객체
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="regist", method=RequestMethod.POST)
	public int registSchedule(
			CalendarVO vo
			, String _end_date
			, String _start_date
			, HttpSession session) {
		log.debug("cal :: \n{}", vo);
		log.debug("_end_date: {}", _end_date);
		log.debug("_start_date: {}", _start_date);
		log.debug("login user : {}", session.getAttribute("loginID").toString());
		
		vo.setU_id(session.getAttribute("loginID").toString());
		/*
		 * _end_date와 _start_date는 spring에서 지원하는 vo의 형식이 아니라서
		 * String으로 따로 받아 vo에 넣는다.
		 * */
		if(_end_date != null) vo.set_end_date(_end_date);
		if(_start_date != null) vo.set_start_date(_start_date);
		
		return dao.registSchedule(vo);
	}
	
	/**
	 * 일정 삭제
	 * @param id 삭제할 아이디 값
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="del", method=RequestMethod.POST)
	public int deleteSchedule(String id) {
		log.debug("deleteSchedule :: delete id : {}", id);
		return dao.deleteSchedule(id);
	}
	/**
	 * 
	 * @param vo 캘린더 vo객체
	 * @param session 세션객체
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="registScheduleVoice", method=RequestMethod.POST)
	public int registScheduleVoice(
			String voiceData
			, HttpSession session) {
		
		MakeCalendar makeCalendar = new MakeCalendar();
				
		CalendarVO vo = makeCalendar.makeCalendar(voiceData);
		log.debug("login user : {}", session.getAttribute("loginID").toString());
		System.out.println(vo);
		//vo.setU_id(session.getAttribute("loginID").toString());
	
		
		
		//dao.registSchedule(vo);
		
		
		return 1;
	}
	
}
