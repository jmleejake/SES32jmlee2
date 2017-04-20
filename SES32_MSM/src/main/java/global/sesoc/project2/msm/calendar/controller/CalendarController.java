package global.sesoc.project2.msm.calendar.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@RequestMapping("Calendar")
	public String Calendar() {
		log.debug("callTestPage");
		return "calendar/Calendar";
	}
	
	@RequestMapping("Calendar2")
	public String Calendar2() {
		log.debug("callTestPage");
		return "calendar/Calendar2";
	}
	
	
	@RequestMapping("calendarView")
	public String calendarView() {
		log.debug("calendarView");
		return "calendar/Calendar";
	}
	
	/**
	 * home에서 calendar클릭시
	 * @param model
	 * @return
	 */
	@RequestMapping("calendarMainView")
	public String calendarMainView(Model model) {
		log.debug("calendarMainView :: GET");
		model.addAttribute("id", "default");
		
		model.addAttribute("year", "default");
		return "calendar/calendarMainView";
	}
	
	/**
	 * home에서 스케쥴아이콘 클릭시
	 * @param id
	 * @param start_date
	 * @param model
	 * @return
	 */
	@RequestMapping(value="calendarMainView", method=RequestMethod.POST)
	public String calendarMainView(String id, String start_date, Model model) {
		log.debug("calendarMainView :: POST : id::{}, start_date::{}", id, start_date);
		// main에서 스케쥴아이콘을 클릭하여 넘어온 아이디값을 캘린더 화면에 넘겨줌
		model.addAttribute("id", id);
		String[] arr_date = start_date.split("-");
		
		model.addAttribute("year", arr_date[0]);
		model.addAttribute("month", arr_date[1]);
		model.addAttribute("day", arr_date[2]);
		return "calendar/calendarMainView";
	}
	
	/**
	 * 캘린더 출력
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getSchedule", method=RequestMethod.POST)
	public ArrayList<CalendarVO> getScheduleData(int thisYear, int thisMonth) {
		String date = thisYear+"-"+String.format("%02d", thisMonth)+"-01";
		log.debug("getScheduleData :: date={}", date);
		HashMap<String, Object> param = new HashMap<>();
		param.put("date", date);
		param.put("type", "getSchedule");
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
			, HttpSession session) {
		log.debug("cal :: \n{}", vo);
		log.debug("login user : {}", session.getAttribute("loginID").toString());
		
		vo.setU_id(session.getAttribute("loginID").toString());
		
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
	 * 간단등록 (음성등록)
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
	
	/**
	 * 스케쥴 검색
	 * @param keyword 검색어
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="searchSchedule", method=RequestMethod.POST)
	public ArrayList<CalendarVO> searchSchedule(String keyword) {
		log.debug("searchSchedule : keyword::{}", keyword);
		HashMap<String, Object> param = new HashMap<>();
		param.put("type", "search");
		param.put("keyword", keyword);
		return dao.selectSchedules(param);
	}
	
	/**
	 * 메인화면 스케쥴 얻기
	 * @return
	 */
	@ResponseBody
	@RequestMapping("mainSchedule")
	public ArrayList<CalendarVO> getMainSchedule() {
		log.debug("getMainSchedule");
		HashMap<String, Object> param = new HashMap<>();
		param.put("type", "main");
		return dao.selectSchedules(param);
	}
	
}
