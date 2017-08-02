package global.sesoc.project2.msm.calendar.dao;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.accbook.mapper.IAccbookMapper;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.calendar.controller.CalendarController;
import global.sesoc.project2.msm.calendar.mapper.ICalendarMapper;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;
import global.sesoc.project2.msm.user.mapper.IUserMapper;
import global.sesoc.project2.msm.user.vo.UserVO;
import global.sesoc.project2.msm.util.AlarmCronTrigger;
import global.sesoc.project2.msm.util.ChangeMonthDayUtil;

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
			UserVO user = new UserVO();
			user.setU_id(vo.getU_id());
			UserVO u_vo = u_mapper.userIDSearch(user);
			
			StringBuffer msg = new StringBuffer();
			msg.append("<h3>※스케쥴이 곧 시작됩니다!!</h3>");
			msg.append("<hr>");
			
			if(exist != null) {
				if("T".equals(exist.getAlarm_yn())) {
					log.debug("-------------------- UPDATE mail sending process start");
					String alarm_time = mapper.selectAlarmTime(param.get("id").toString());
					log.debug("alarm at {}", alarm_time);
					
					msg.append(String.format("● 내용: %s<br>", exist.getContent()));
					
					String start_date = exist.getStart_date();
					String[] sd = start_date.split(" ");
					
					String yyyy = sd[3] + "년 ";
					String mm = ChangeMonthDayUtil.monthDay(sd[1]) + " ";
					String dd = sd[2] + "일 ";
					String day = ChangeMonthDayUtil.monthDay(sd[0]) + " ";
					String hh = sd[4];
					
					msg.append(String.format("● 시작하는 시간: %s<br>", yyyy+mm+dd+day+hh));
					
					String end_date = exist.getEnd_date();
					String[] ed = end_date.split(" ");
					
					yyyy = ed[3] + "년 ";
					mm = ChangeMonthDayUtil.monthDay(ed[1]) + " ";
					dd = ed[2] + "일 ";
					day = ChangeMonthDayUtil.monthDay(ed[0]) + " ";
					hh = ed[4];
					
					msg.append(String.format("● 끝나는 시간: %s<br>", yyyy+mm+dd+day+hh));
					msg.append("<hr>");
					msg.append("Sincerely SCMaster C Class 2Group");
					
					AlarmCronTrigger cron = new AlarmCronTrigger(alarm_time, param.get("id").toString(), 
							u_vo.getU_email(), exist.getText(),  msg.toString());
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
					
					msg.append(String.format("● 내용: %s<br>", latest_vo.getContent()));
					String start_date = latest_vo.getStart_date();
					String[] sd = start_date.split(" ");
					
					String yyyy = sd[3] + "년 ";
					String mm = ChangeMonthDayUtil.monthDay(sd[1]) + " ";
					String dd = sd[2] + "일 ";
					String day = ChangeMonthDayUtil.monthDay(sd[0]) + " ";
					String hh = sd[4];
					
					msg.append(String.format("● 시작하는 시간: %s<br>", yyyy+mm+dd+day+hh));
					
					String end_date = latest_vo.getEnd_date();
					String[] ed = end_date.split(" ");
					
					yyyy = ed[3] + "년 ";
					mm = ChangeMonthDayUtil.monthDay(ed[1]) + " ";
					dd = ed[2] + "일 ";
					day = ChangeMonthDayUtil.monthDay(ed[0]) + " ";
					hh = ed[4];
					
					msg.append(String.format("● 끝나는 시간: %s<br>", yyyy+mm+dd+day+hh));
					msg.append("<hr>");
					msg.append("Sincerely SCMaster C Class 2Group");
					
					AlarmCronTrigger cron = new AlarmCronTrigger(alarm_time, latest_id, 
							u_vo.getU_email(), latest_vo.getText(), msg.toString());
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
	
	/**
	 *  안드로이드 로그인 이후 메인페이지
	 * @param data 안드로이드에서 넘어온 로그인 데이터
	 * @return
	 */
	public String androidMain(String data) {
		log.debug("androidMain :: data : {}", data);
		
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		IAccbookMapper accMapper = sqlSession.getMapper(IAccbookMapper.class);
		
		String ret = null;
		JSONArray array;
		JSONObject obj;
		
		try {
			obj = new JSONObject(data);
			
			String user_id = obj.getString("user_id");
			
			// 전날 소비 금액을 알기 위해 처리
			Calendar cal = new GregorianCalendar();
			cal.add(Calendar.DATE, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date d = cal.getTime();
			String yesterday = sdf.format(d);
			
			AccbookSearchVO accbookVO = new AccbookSearchVO();
			accbookVO.setStart_date(yesterday);
			accbookVO.setEnd_date(yesterday);
			accbookVO.setU_id(user_id);
			ArrayList<AccbookVO> accList = accMapper.selectAccbook2(accbookVO);
			
			array = new JSONArray();
			obj = new JSONObject();
			obj.put("l_title", "Summary");
			obj.put("r_title", yesterday + ": 지출 금액");
			obj.put("r_content", 0 + "원");
			for (AccbookVO vo : accList) {
				obj.put("r_content", vo.getPrice() + "원");
			}
			array.put(obj);
			
			HashMap<String, Object> param = new HashMap<>();
			param.put("u_id", user_id);
			ArrayList<CalendarVO> calList = mapper.selectDdayMonthForMain(param);
			
			for (CalendarVO vo : calList) {
				obj = new JSONObject();
				obj.put("l_title", vo.getDday());
				obj.put("r_title", vo.getStart_date() + ": " + vo.getText());
				String cal_content = vo.getContent();
				if(cal_content != null && cal_content.equals("")) {
					obj.put("r_content", vo.getContent());
				} else {
					obj.put("r_content", "");
				}
				array.put(obj);
			}
			log.debug("before return :: {}", array.toString());
			
			try {
				ret = URLEncoder.encode(array.toString(), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		log.debug("androidMain :: RET: {}", ret);
		return ret;
	}
}
