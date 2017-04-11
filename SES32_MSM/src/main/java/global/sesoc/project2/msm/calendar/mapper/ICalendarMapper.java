package global.sesoc.project2.msm.calendar.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.project2.msm.calendar.vo.CalendarVO;

/**
 * Calendar 관련 Query 접근 파일
 *
 */
public interface ICalendarMapper {
	// 월단위 일정 조회
	public ArrayList<CalendarVO> selectSchedules(HashMap<String, Object> param);
	// 아이디에 해당하는 이벤트 존재여부 구하기 (수정/등록 분기처리시 사용)
	public CalendarVO selectSchedule(HashMap<String, Object> param);
	// 일정 등록
	public int insertSchedule(CalendarVO vo);
	// 최신글번호 구하기 (반복등록시 필요)
	public String selectLatestEventNum();
	// 날짜 구하기 (반복등록시 필요)
	public String selectNextDate(String current_date);
	// 날짜 구하기 (매월) (반복등록시 필요)
	public String selectNextDateForMonth(HashMap<String, Object> param);
	// 일정 삭제
	public int deleteSchedule(String id);
	// 일정 수정
	public int updateSchedule(CalendarVO vo);
	// 아이디에 해당하는 알림시간 얻기
	public String selectAlarmTime(String id);
}
