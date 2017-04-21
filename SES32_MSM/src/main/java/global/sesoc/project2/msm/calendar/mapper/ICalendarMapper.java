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
	// 최신글번호 구하기
	public String selectLatestEventNum();
	// 일정 삭제
	public int deleteSchedule(String id);
	// 일정 수정
	public int updateSchedule(CalendarVO vo);
	// 아이디에 해당하는 알림시간 얻기
	public String selectAlarmTime(String id);
	// 키워드 검색 (자동완성 구현)
	public ArrayList<CalendarVO> selectSchedulesForSearch(HashMap<String, Object> param);
	// 한달남은 일정 목록 얻기 (메인화면을 위한)
	public ArrayList<CalendarVO> selectDdayMonthForMain(HashMap<String, Object> param);
}
