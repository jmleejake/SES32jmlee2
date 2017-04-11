package global.sesoc.project2.msm.calendar.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;

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
	
	Logger log = LoggerFactory.getLogger(CalendarController.class);
	
	public ArrayList<CalendarVO> selectSchedules(HashMap<String, Object> param) {
		log.debug("selectSchedules :: parameters={}", param);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return mapper.selectSchedules(param);
	}
	
	public CalendarVO selectSchedule(HashMap<String, Object> param) {
		log.debug("selectSchedule :: parameters={}", param);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return mapper.selectSchedule(param);
	}
	
	public int registSchedule(CalendarVO vo) {
		log.debug("-------------------- event save process start");
		int ret = 0;
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		
		// 시작일자 종료일자의 월에 대한 세팅
		HashMap<String, Object> month_map = new HashMap<String, Object>();
		//month_short:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
		month_map.put("Jan", "01");
		month_map.put("Feb", "02");
		month_map.put("Mar", "03");
		month_map.put("Apr", "04");
		month_map.put("May", "05");
		month_map.put("Jun", "06");
		month_map.put("Jul", "07");
		month_map.put("Aug", "08");
		month_map.put("Sep", "09");
		month_map.put("Oct", "10");
		month_map.put("Nov", "11");
		month_map.put("Dec", "12");
		
		StringTokenizer st_start_date = new StringTokenizer(vo.getStart_date(), " ");
		StringTokenizer st_end_date = new StringTokenizer(vo.getEnd_date(), " ");
		
		StringTokenizer st_recurring_end_date = null;
		StringTokenizer st_recurring_start_date = null;
		
		int i=0;
		log.debug("+++++++++++++");
		// 시작일자 세팅
		String syear = "";
		String smonth = "";
		String sday = "";
		String stime = "";
		while (st_start_date.hasMoreElements()) {
			// month-short
			if(i==1) smonth = month_map.get(st_start_date.nextElement().toString()).toString();
			// day
			else if(i==2) sday = st_start_date.nextElement().toString();
			// year
			else if(i==3) syear = st_start_date.nextElement().toString();
			// time
			else if(i==4) stime = st_start_date.nextElement().toString();
			// others
			else st_start_date.nextElement();
			
			i++;
		}
		
		log.debug("start_time: {}-{}-{} {}", syear, smonth, sday, stime);
		
		log.debug("+++++++++++++");
		
		// 종료일자 세팅
		String eyear = "";
		String emonth = "";
		String eday = "";
		String etime = "";
		i=0;
		
		while (st_end_date.hasMoreElements()) {
			// month-short
			if(i==1) emonth = month_map.get(st_end_date.nextElement().toString()).toString();
			// day
			else if(i==2) eday = st_end_date.nextElement().toString();
			// year
			else if(i==3) eyear = st_end_date.nextElement().toString();
			// time
			else if(i==4) etime = st_end_date.nextElement().toString();
			// others
			else st_end_date.nextElement();
			
			i++;
		}
		
		log.debug("end_time: {}-{}-{} {}", eyear, emonth, eday, etime);
		
		vo.setStart_date(syear+ "-" + smonth + "-" + sday + " " + stime);
		vo.setEnd_date(eyear+ "-" + emonth + "-" + eday + " " + etime);
		
		
		// 매월 반복 설정시 시작일자 세팅
		i=0;
		if(vo.get_start_date() != null) {
			if(!vo.get_start_date().equals("")) {
				st_recurring_start_date = new StringTokenizer(vo.get_start_date(), " ");
				
				while (st_recurring_start_date.hasMoreElements()) {
					// month-short
					if(i==1) smonth = month_map.get(st_recurring_start_date.nextElement().toString()).toString();
					// day
					else if(i==2) sday = st_recurring_start_date.nextElement().toString();
					// year
					else if(i==3) syear = st_recurring_start_date.nextElement().toString();
					// time
					else if(i==4) stime = st_recurring_start_date.nextElement().toString();
					// others
					else st_recurring_start_date.nextElement();
					
					i++;
				}
				
				log.debug("start_time: {}-{}-{} {}", syear, smonth, sday, stime);
				vo.set_start_date(syear+ "-" + smonth + "-" + sday + " " + stime);
			}
		}
		
		// 반복설정시 종료일자 세팅
		i=0;
		if(vo.get_end_date() != null) {
			if(!vo.get_end_date().equals("")) {
				st_recurring_end_date = new StringTokenizer(vo.get_end_date(), " ");
				
				while (st_recurring_end_date.hasMoreElements()) {
					// month-short
					if(i==1) emonth = month_map.get(st_recurring_end_date.nextElement().toString()).toString();
					// day
					else if(i==2) eday = st_recurring_end_date.nextElement().toString();
					// year
					else if(i==3) eyear = st_recurring_end_date.nextElement().toString();
					// time
					else if(i==4) etime = st_recurring_end_date.nextElement().toString();
					// others
					else st_recurring_end_date.nextElement();
					
					i++;
				}
				
				if(vo.getRec_type() != null) {
					String[] arr_rec = vo.getRec_type().split("#");
					for (int j = 0; j < arr_rec.length; j++) {
						log.debug("{} : {}", j, arr_rec[j]);
					}
					log.debug("check rec end_date :: length={}", arr_rec.length);
					/*
					 * 반복이 no end date로 설정 되었을때는 DB insert를 고려하여
					 * 1년치에 대해서만 insert한다.
					 * */
					if(arr_rec.length > 1) {
						if("no".equals(arr_rec[1])) { 
							log.debug("no end date!!!");
							eyear = (Integer.parseInt(syear) + 1) + "";
							emonth = smonth;
							log.debug("{}-{}-{}", eyear, emonth, eday);
						}
					}
				}
				
				log.debug("_end_date: {}-{}-{} {}", eyear, emonth, eday, etime);
				vo.set_end_date(eyear+ "-" + emonth + "-" + eday + " " + etime);
			}
		}
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("id", vo.getId());
		CalendarVO exist = selectSchedule(param);
		log.debug("exist: {}", exist);
		
		if(exist != null) {
			log.debug("-------------------- event update process start");
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
	
	public int insertSchedule(CalendarVO vo) {
		log.debug("insertSchedule :: \nvo:{}", vo);
		
		int ret = 0;
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		
//		if(vo.getRec_type() != null) {
		if(!vo.getRec_type().equals("")) {
			CalendarVO recurring = new CalendarVO();
			recurring.setStart_date(vo.getStart_date());
			recurring.setEnd_date(vo.getEnd_date());
			recurring.setContent(vo.getContent());
			recurring.setRec_type(vo.getRec_type());
			recurring.setText(vo.getText());
			recurring.setU_id(vo.getU_id());
			recurring.setT_id(vo.getT_id());
			recurring.setC_target(vo.getC_target());
			recurring.setAlarm_val(vo.getAlarm_val());
			String[] arr_rec = recurring.getRec_type().split("_");
			log.debug("check rec_type");
			for (int i = 0; i < arr_rec.length; i++) {
				log.debug("{} : {}", i, arr_rec[i]);
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			
			log.debug("SWITCHING :: {}", arr_rec[0]);
			
			int check_ret = 0; // dhtmlx calendar pid세팅
			switch (arr_rec[0]) {
				case "day": // 매일 반복
					break;
					
				case "month": // 매월 반복
					break;
					
				case "year": // 매년 반복
					break;

				default:
					break;
			}
		} else {
			try {
				ret = mapper.insertSchedule(vo);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return ret;
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
