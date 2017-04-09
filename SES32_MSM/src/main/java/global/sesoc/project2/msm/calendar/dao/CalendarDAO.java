package global.sesoc.project2.msm.calendar.dao;

import java.text.ParseException;
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
		
		AlarmCronTrigger cron = new AlarmCronTrigger("00 46 21 * * ?", "1");
		cron.deleteJob();
		cron.createJob();
		
		return mapper.selectSchedules(param);
	}
	
	public CalendarVO selectSchedule(HashMap<String, Object> param) {
		log.debug("selectSchedule :: parameters={}", param);
		ICalendarMapper mapper = sqlSession.getMapper(ICalendarMapper.class);
		return mapper.selectSchedule(param);
	}
	
	public int registSchedule(CalendarVO vo) {
		int ret = 0;
		log.debug("-------------------- event save process start");
		
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
					try {
						
						do {
							try {
								// 최초pid세팅
								if(check_ret == 0) {
									recurring.setEvent_pid("0");
									/*
									 * 반복의 경우 종료시점을 _end_date로 설정하여 보내기 때문에
									 * while문에서의 compareTo비교문을 위해
									 * 최초 세팅시 main vo(dao로 넘어올때 받은 vo)의 end_date를 _end_date로 설정
									 * */
									vo.setEnd_date(vo.get_end_date());
									recurring.setEnd_date(vo.get_end_date());
								} else if(check_ret == 1) {
									// 최초 생성후 바로 다음 row에 들어가는 이벤트에는
								    // 최초생성당시의 start_date부터 해당일의 23:59:59까지로 세팅
									recurring.setRec_type(null);
									recurring.setStart_date(recurring.getStart_date());
									String end_date = recurring.getStart_date().split(" ")[0] + " 23:59:59";
									log.debug("end_date : {}", end_date);
									recurring.setEnd_date(end_date);
								}
								log.debug("before insert :: {}", recurring);
								ret = mapper.insertSchedule(recurring);
								if(ret > 0) {
									if(check_ret == 0) {
										// 최초 생성한 반복 이벤트의 id를 얻어 pid로 세팅
										String latest_id = mapper.selectLatestEventNum();
										recurring.setEvent_pid(latest_id);
									} else {
										// 최초생성과 생성후 바로다음 row가 아니면,
										// 최초 start_date, end_date에 하루를 더하여 각각을 세팅 
										recurring.setStart_date(mapper.selectNextDate(recurring.getStart_date()));
										recurring.setEnd_date(mapper.selectNextDate(recurring.getEnd_date()));
									}
									
									check_ret++;
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						} while (dateCheck(sdf.parse(recurring.getStart_date()), sdf.parse(vo.getEnd_date())) > 0);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					break;
					
				case "month": // 매월 반복
					recurring.setStart_date(vo.get_start_date());
					try {
						do {
							// 최초pid세팅
							if(check_ret == 0) {
								recurring.setEvent_pid("0");
								/*
								 * 반복의 경우 종료시점을 _end_date로 설정하여 보내기 때문에
								 * while문에서의 compareTo비교문을 위해
								 * 최초 세팅시 main vo(dao로 넘어올때 받은 vo)의 end_date를 _end_date로 설정
								 * */
								vo.setEnd_date(vo.get_end_date());
								recurring.setEnd_date(vo.get_end_date());
							} else if(check_ret == 1) {
								// 최초 생성후 바로 다음 row에 들어가는 이벤트에는
							    // 최초생성당시의 start_date부터 해당일의 23:59:59까지로 세팅
								recurring.setRec_type(null);
								recurring.setStart_date(recurring.getStart_date());
								String end_date = recurring.getStart_date().split(" ")[0] + " 23:59:59";
								log.debug("end_date : {}", end_date);
								recurring.setEnd_date(end_date);
							}
							log.debug("before insert :: {}", recurring);
							ret = mapper.insertSchedule(recurring);
							if(ret > 0) {
								if(check_ret == 0) {
									// 최초 생성한 반복 이벤트의 id를 얻어 pid로 세팅
									String latest_id = mapper.selectLatestEventNum();
									recurring.setEvent_pid(latest_id);
								} else {
									// 최초생성과 생성후 바로다음 row가 아니면,
									// 최초 start_date, end_date에 하루를 더하여 각각을 세팅 
									HashMap<String, Object> param = new HashMap<>();
									param.put("check_day", recurring.getStart_date());
									param.put("month", 1);
									recurring.setStart_date(mapper.selectNextDateForMonth(param));
									param.put("check_day", recurring.getEnd_date());
									recurring.setEnd_date(mapper.selectNextDateForMonth(param));
								}
								
								check_ret++;
							}
						} while (dateCheck(sdf.parse(recurring.getStart_date()), sdf.parse(vo.getEnd_date())) > 0);
					} catch (ParseException e) {
						e.printStackTrace();
					}
					
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
