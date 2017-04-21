package global.sesoc.project2.msm.calendar.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.calendar.controller.CalendarController;
import global.sesoc.project2.msm.calendar.mapper.ICalendarMapper;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;
import global.sesoc.project2.msm.user.mapper.IUserMapper;
import global.sesoc.project2.msm.user.vo.UserVO;
import global.sesoc.project2.msm.util.AlarmCronTrigger;

/**
 * Calendar 관련 DB Access Object
 *
 */
@Repository
public class CalendarDAO {
	@Autowired
	SqlSession sqlSession;
	
	private final String NONE = "none";
	private final String DAILY = "daily";
	private final String MONTHLY = "monthly";
	private final String YEARLY = "yearly";
	
	Logger log = LoggerFactory.getLogger(CalendarController.class);
	
	/**
	 * 일정 목록 얻기
	 * @param param
	 * @return
	 */
	public ArrayList<CalendarVO> selectSchedules(HashMap<String, Object> param) {
		log.debug("selectSchedules :: parameters={}", param);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		if(param.get("type").equals("search")) { // 자동완성 검색시
			return mapper.selectSchedulesForSearch(param); 
		} else if(param.get("type").equals("main")) { // 메인화면 출력시
			return mapper.selectDdayMonthForMain(param);
		} else { // 아이디에 해당하는 이벤트 존재여부 구하기
			return mapper.selectSchedules(param);
		}
	}
	
	/**
	 * 일정 상세 얻기
	 * @param param
	 * @return
	 */
	public CalendarVO selectSchedule(HashMap<String, Object> param) {
		log.debug("selectSchedule :: parameters={}", param);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return mapper.selectSchedule(param);
	}
	
	/**
	 * 일정 등록/수정 객체 세팅후 분기처리
	 * @param vo
	 * @return
	 */
	public int registSchedule(CalendarVO vo) {
		log.debug("-------------------- event save process start");
		int ret = 0;
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("id", vo.getId());
		param.put("u_id", vo.getU_id());
		CalendarVO exist = selectSchedule(param);
		log.debug("exist: {}", exist);
		
		if(exist != null) {
			log.debug("-------------------- event update process start");
			
			if(!vo.getRepeat_type().equals("none")) {
				vo.setStart_date(exist.getStart_date());
				vo.setEnd_date(exist.getEnd_date());
				log.debug("recurring update start & end date setting");
			}
			
			ret = updateSchedule(vo);
			log.debug("-------------------- event update process end");
		} else {
			log.debug("-------------------- event create process start");
			ret = insertSchedule(vo);
			log.debug("-------------------- event create process end");
		}
		
		// 알림세팅 
		if(ret > 0) {
			IUserMapper u_mapper = sqlSession.getMapper(IUserMapper.class);
			UserVO u_vo = u_mapper.voReading(vo.getU_id());
			if(exist != null) {
				if("T".equals(exist.getAlarm_yn())) {
					log.debug("-------------------- UPDATE mail sending process start");
					String alarm_time = mapper.selectAlarmTime(param.get("id").toString());
					log.debug("alarm at {}", alarm_time);
					AlarmCronTrigger cron = new AlarmCronTrigger(alarm_time, param.get("id").toString(), 
							u_vo.getU_email(), exist.getText(), exist.getContent() + " Start Time: " + exist.getStart_date());
					cron.deleteJob();
					cron.createJob();
					log.debug("-------------------- UPDATE mail sending process end");
				}
			} else {
				String latest_id = mapper.selectLatestEventNum();
				param.put("id", latest_id);
				CalendarVO latest_vo = selectSchedule(param);
				if("T".equals(latest_vo.getAlarm_yn())) {
					log.debug("-------------------- CREATE mail sending process start");
					String alarm_time = mapper.selectAlarmTime(latest_id);
					log.debug("alarm at {}", alarm_time);
					AlarmCronTrigger cron = new AlarmCronTrigger(alarm_time, latest_id, 
							u_vo.getU_email(), latest_vo.getText(), latest_vo.getContent() + " Start Time: " + latest_vo.getStart_date());
					cron.deleteJob();
					cron.createJob();
					log.debug("-------------------- CREATE mail sending process end");
				}
			}
		}
		
		log.debug("-------------------- event save process end");
		return ret;
	}
	
	/**
	 *  일정 등록
	 * @param vo 스케쥴 vo객체
	 * @return
	 */
	public int insertSchedule(CalendarVO vo) {
		log.debug("insertSchedule :: \nvo:{}", vo);
		
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		switch (vo.getRepeat_type()) {
			case DAILY: // 매일 반복
				vo.setRepeat_type(DAILY);
				break;
				
			case MONTHLY: // 매월 반복
				vo.setRepeat_type(MONTHLY);
				break;
				
			case YEARLY: // 매년 반복
				vo.setRepeat_type(YEARLY);
				break;
				
			default:
				vo.setRepeat_type(NONE);
				break;
		}
		
		return mapper.insertSchedule(vo);
	}
	
	/**
	 * 일정 수정
	 * @param vo 스케쥴 vo객체
	 * @return
	 */
	public int updateSchedule(CalendarVO vo) {
		log.debug("updateSchedule \n{}", vo);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return  mapper.updateSchedule(vo);
	}
	
	/**
	 * 날짜값 비교
	 * @param a 시작일자
	 * @param b 종료일자
	 * @return
	 */
	protected int dateCheck(Date a, Date b) {
		log.debug("dateCheck :: {} - {}",a,b);
		
		int ret = 0;
		
		if(a.compareTo(b) > 0) {
			ret = -1; //a가 b보다 느린날짜일때
		} else if(a.compareTo(b) < 0) {
			ret = 1; // a가 b보다 빠른 날짜일때
		}
		
		log.debug("dateCheck RET == {}", ret);
		
		return ret;
	}
	
	/**
	 * 일정 삭제
	 * @param id 삭제할 아이디 값
	 * @return
	 */
	public int deleteSchedule(String id) {
		log.debug("deleteSchedule :: delete id : {}", id);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return mapper.deleteSchedule(id);
	}
}
