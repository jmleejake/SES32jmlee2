package global.sesoc.project2.msm.calendar.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.calendar.controller.CalendarController;
import global.sesoc.project2.msm.calendar.mapper.ICalendarMapper;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;

/**
 * Calendar 관련 DB Access Object
 *
 */
@Repository
public class CalendarDAO {
	@Autowired
	SqlSession sqlSession;
	
	Logger log = LoggerFactory.getLogger(CalendarController.class);
	
	public ArrayList<CalendarVO> selectSchedule() {
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return mapper.selectSchedule();
	}
}
