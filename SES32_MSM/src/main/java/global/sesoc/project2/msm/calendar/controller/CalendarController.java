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

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.calendar.dao.CalendarDAO;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;
import global.sesoc.project2.msm.util.MakeCalendar;

@Controller
@RequestMapping("calendar")
public class CalendarController {
	@Autowired
	CalendarDAO dao;
	
	@Autowired
	AccbookDAO accDao;// 가계부 관련 데이터 처리 객체
	
	Logger log = LoggerFactory.getLogger(CalendarController.class);
	
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
	 * @param thisYear 년도
	 * @param thisMonth 월
	 * @param session 세션객체
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getSchedule", method=RequestMethod.POST)
	public ArrayList<CalendarVO> getScheduleData(
			int thisYear
			, int thisMonth
			, HttpSession session) {
		String date = thisYear+"-"+String.format("%02d", thisMonth)+"-01";
		log.debug("getScheduleData :: date={}", date);
		HashMap<String, Object> param = new HashMap<>();
		param.put("date", date);
		param.put("type", "getSchedule");
		param.put("u_id", session.getAttribute("loginID").toString());
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
		vo.setU_id(session.getAttribute("loginID").toString());
		
		return dao.registSchedule(vo);
	}
	
	/**
	 * 스케쥴 검색
	 * @param keyword 검색어
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="searchSchedule", method=RequestMethod.POST)
	public ArrayList<CalendarVO> searchSchedule(
			String keyword
			, HttpSession session) {
		log.debug("searchSchedule : keyword::{}", keyword);
		HashMap<String, Object> param = new HashMap<>();
		param.put("type", "search");
		param.put("keyword", keyword);
		param.put("u_id", session.getAttribute("loginID").toString());
		return dao.selectSchedules(param);
	}
	
	/**
	 * 메인화면 스케쥴 얻기
	 * @return
	 */
	@ResponseBody
	@RequestMapping("mainSchedule")
	public HashMap<String, Object> getMainSchedule(
			AccbookSearchVO accbookSearch
			, HttpSession session) {
		log.debug("getMainSchedule");
		String start = accbookSearch.getStart_date().substring(2);
		String end = accbookSearch.getEnd_date().substring(2);
		accbookSearch.setStart_date(start.replaceAll("-", "/"));
		accbookSearch.setEnd_date(end.replaceAll("-", "/"));
		accbookSearch.setU_id(session.getAttribute("loginID").toString());
		
		// 전날 지출 총액수를 구하기위해 accDao에서 결과값 얻기
		// (ajax를 2개 보내자니 success function timing issue가 있어 현 상황과 같이 처리)
		HashMap<String, Object> ret = accDao.getAccbook2(accbookSearch);
		HashMap<String, Object> param = new HashMap<>();
		param.put("type", "main");
		param.put("u_id", session.getAttribute("loginID").toString());
		
		// response 결과물에 스케쥴 리스트 세팅
		ret.put("schList", dao.selectSchedules(param));
		
		return ret;
	}
	
	@RequestMapping("callTargetModal")
	public String callTargetSearchModal() {
		log.debug("callTargetSearchModal!!");
		return "calendar/targetSearchModal";
	}
	
}
