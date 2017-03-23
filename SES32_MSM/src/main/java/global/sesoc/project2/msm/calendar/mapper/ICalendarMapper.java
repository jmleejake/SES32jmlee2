package global.sesoc.project2.msm.calendar.mapper;

import java.util.ArrayList;

import global.sesoc.project2.msm.calendar.vo.CalendarVO;

/**
 * Calendar 관련 Query 접근 파일
 *
 */
public interface ICalendarMapper {
	public ArrayList<CalendarVO> selectSchedule();
}
