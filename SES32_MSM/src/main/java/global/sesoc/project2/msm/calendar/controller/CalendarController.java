package global.sesoc.project2.msm.calendar.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.calendar.dao.CalendarDAO;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;

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
	
	/**
	 * 캘린더 출력 (TODO: 추후 상세검색 및 검색부분 추가 예정)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getSchedule", method=RequestMethod.POST)
	public ArrayList<CalendarVO> getScheduleData(CalendarVO vo) {
		System.out.println(String.format("vo:{}", vo));
		log.debug("getScheduleData :: \nvo:{}", vo);
		return dao.selectSchedule();
	}
	
	/**
	 * 일정 등록 (TODO: 반복일정 추가 예정)
	 * @param vo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="add", method=RequestMethod.POST)
	public int addSchedule(CalendarVO vo) {
		log.debug("addSchedule :: \nvo:{}", vo);
		return dao.insertSchedule(vo);
	}
}
