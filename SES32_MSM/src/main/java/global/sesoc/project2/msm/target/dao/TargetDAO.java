package global.sesoc.project2.msm.target.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import global.sesoc.project2.msm.calendar.mapper.ICalendarMapper;
import global.sesoc.project2.msm.calendar.vo.CalendarVO;
import global.sesoc.project2.msm.target.mapper.ITargetMapper;
import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.user.mapper.IUserMapper;
import global.sesoc.project2.msm.user.vo.UserVO;
import global.sesoc.project2.msm.util.AlarmCronTrigger;
import global.sesoc.project2.msm.util.ChangeMonthDayUtil;
import global.sesoc.project2.msm.util.DataVO;
import global.sesoc.project2.msm.util.ExcelService;
import global.sesoc.project2.msm.util.securityUtil;

/**
 * 대상자 관련 DB Access Object
 */
@Repository
public class TargetDAO {
	Logger log = LoggerFactory.getLogger(TargetDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 엑셀 업로드
	 * @param file_name 저장될 파일 경로
	 * @param u_id 로그인 유저 아이디
	 * @return
	 */
	@Transactional
	public int excelUpload(String file_name, String u_id) {
		log.debug("excelUpload..... : filename? {}", file_name);
		
		int ret = 0;
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		List<List<String>> data;
		try {
			data = ExcelService.getExcelList(file_name);
			
			// DB insert
			for (List<String> list : data) {
				// 경조사 :: 입력형식 : yyyy-mm-dd 경조사명
				String event = securityUtil.checkData(list.get(0));
				// 경조사 일자
				String event_date = securityUtil.checkData(event.substring(0, event.lastIndexOf("-") + 3));
				// 경조사관련 메모
				String event_memo = securityUtil.checkData(event.substring(event.lastIndexOf("-") + 4, event.length()));
				
				// 1. 대상자 등록
				TargetVO tVO = new TargetVO();
				tVO.setT_name(securityUtil.checkData(list.get(1)));
				tVO.setT_group(securityUtil.checkData(list.get(3)));
				tVO.setT_date(event_date);
				tVO.setU_id(u_id);
				log.debug("before insert target : {}", tVO);
				ret = mapper.insertTarget(tVO);
				
				if(ret > 0) {
					// 대상자관련 가계부에 등록을 위한 대상자 아이디 얻기
					int t_id = mapper.selectLatestTarget();
					
					// 2. 대상자관련 가계부 등록
					TargetAccBookVO tAccVO = new TargetAccBookVO();
					tAccVO.setT_id(t_id+"");
					tAccVO.setTa_price(Integer.parseInt(list.get(2)));
					tAccVO.setTa_type("INC"); // 대상자가 낸 경조사비이기 때문에 수입으로 치고 IN을 입력하여 insert
					tAccVO.setTa_memo(event_memo);
					tAccVO.setTa_date(event_date);
					log.debug("before insert target accbook : {}", tAccVO);
					ret = mapper.insertTargetAccbook(tAccVO);
					
					if(ret > 0) {
						// 타겟에 대한 스케쥴 등록처리
						ICalendarMapper cMapper = sqlSession.getMapper(ICalendarMapper.class);
						CalendarVO cVo = new CalendarVO();
						cVo.setIn_type("tar");
						cVo.setText(securityUtil.checkData(tVO.getT_name() + " :: " + tAccVO.getTa_memo()));
						cVo.setU_id(u_id);
						cVo.setContent(securityUtil.checkData(tVO.getT_name() + " :: " + tAccVO.getTa_memo()));
						cVo.setC_location("");
						cVo.setAlarm_val("none");
						cVo.setT_id(securityUtil.checkData(tAccVO.getT_id()));
						cVo.setC_target(tVO.getT_name());
						cVo.setStart_date(event_date + " 11:00");
						cVo.setEnd_date(event_date + " 12:00");
						cVo.setRepeat_type("none");
						ret = cMapper.insertSchedule(cVo);
					}
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return ret;
	}
	
	/**
	 * 가계부 내역 얻기
	 * @param param 검색어 hashmap
	 * @return
	 */
	public ArrayList<DataVO> selectTargetAccBook(HashMap<String, Object> param) {
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		return mapper.selectTargetAccBook(param);
	}
	
	/**
	 * 경조사 타겟 목록얻기
	 * @return
	 */
	public ArrayList<TargetVO> selectTargetList(int startRecord, int countPerPage, HashMap<String, Object> param) {
		log.debug("selectTargetList : param::{}", param);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		// 페이징 위한 처리
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		return mapper.selectTargetList(param, rb);
	}
	
	/**
	 * 타겟 수정
	 * @param param
	 * @return
	 */
	public int updateTarget(HashMap<String, Object> param) {
		log.debug("updateTarget : param::{}", param);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		return mapper.updateTarget(param);
	}
	
	/**
	 * 타겟 가계부 등록
	 * @param vo
	 * @param login_id
	 * @return
	 */
	public int insertTargetAccbook(
			TargetAccBookVO vo
			, String login_id
			, String url
			, String address) {
		int ret = 0;
		log.debug("insertTargetAccbook : vo::{}, login_id::{}", vo, login_id);
		log.debug("url:{}, address:{}", url, address);
		
		String[] ta_date = vo.getTa_date().split("T");
		String ori_memo = vo.getTa_memo();
		vo.setTa_date(ta_date[0]);
		vo.setTa_memo(ta_date[1] + " " + ori_memo);
		// 타겟 가계부 등록 처리 
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		ret = mapper.insertTargetAccbook(vo);
		if(ret > 0) {
			// 타겟에 대한 스케쥴 등록처리
			ICalendarMapper cMapper = sqlSession.getMapper(ICalendarMapper.class);
			CalendarVO cVo = new CalendarVO();
			cVo.setIn_type("tar");
			cVo.setText(vo.getT_name() + " :: " + ori_memo);
			cVo.setU_id(login_id);
			cVo.setContent(vo.getT_name() + " :: " + ta_date[1] + " " + ori_memo + "(" + address + ") \n위치정보URL> " + url + " : " + vo.getTa_price()+"원");
			cVo.setC_location(ori_memo);
			cVo.setAlarm_val("60"); // default로 약속시간 한시간전에 메일을 보내는것으로 설정. (추후 캘린더화면에서 수정 가능::TEST완료)
			cVo.setT_id(vo.getT_id());
			cVo.setC_target(vo.getT_name());
			cVo.setStart_date(ta_date[0] + " " + ta_date[1]);
			cVo.setEnd_date(ta_date[0] + " " + ta_date[1]);
			cVo.setRepeat_type("none");
			ret = cMapper.insertSchedule(cVo);
			
			// 알림세팅
			if(ret > 0) {
				IUserMapper u_mapper = sqlSession.getMapper(IUserMapper.class);
				UserVO u_vo = u_mapper.voReading(cVo.getU_id());
				
				HashMap<String, Object> param = new HashMap<>();
				
				String latest_id = cMapper.selectLatestEventNum();
				param.put("u_id", cVo.getU_id());
				param.put("id", latest_id);
				CalendarVO latest_vo = cMapper.selectSchedule(param);
				if("T".equals(latest_vo.getAlarm_yn())) {
					log.debug("-------------------- CREATE mail sending process start");
					String alarm_time = cMapper.selectAlarmTime(latest_id);
					log.debug("alarm at {}", alarm_time);
					StringBuffer msg = new StringBuffer();
					msg.append("<h3>※스케쥴이 곧 시작됩니다!!</h3>");
					msg.append("<hr>");
					msg.append(String.format("● 내용: %s<br>", latest_vo.getContent()));
					
					String start_date = latest_vo.getStart_date();
					String[] sd = start_date.split(" ");
					
					String yyyy = sd[3] + "년 ";
					String mm = ChangeMonthDayUtil.monthDay(sd[1]) + " ";
					String dd = sd[2] + "일 ";
					String day = ChangeMonthDayUtil.monthDay(sd[0]) + " ";
					String hh = sd[4];
					
					msg.append(String.format("● 시작하는 시간: %s<br>", yyyy+mm+dd+day+hh));
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
		return ret;
	}
	
	/**
	 * 타겟 삭제
	 * @param t_id
	 * @return
	 */
	public int deleteTarget(String t_id) {
		log.debug("updateTarget : t_id::{}", t_id);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		return mapper.deleteTarget(t_id);
	}
	
	/**
	 * 페이징을 위한 전체row수 얻기
	 * @param param
	 * @return
	 */
	public int selectTargetTotal(HashMap<String, Object> param) {
		log.debug("selectTargetTotal : param::{}", param);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		return mapper.selectTargetTotal(param);
	}
	
	/**
	 * 타겟 등록
	 * @param vo
	 * @param u_id
	 * @return
	 */
	@Transactional
	public int insertTarget(TargetAccBookVO vo, String u_id) {
		int ret = 0;
		log.debug("updateTarget : target accbook vo::{}", vo);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		
		// 1. 타겟등록
		TargetVO tVO = new TargetVO();
		tVO.setU_id(u_id);
		tVO.setT_name(securityUtil.checkData(vo.getT_name()));
		tVO.setT_date(securityUtil.checkData(vo.getTa_date()));
		tVO.setT_group(securityUtil.checkData(vo.getT_group()));
		tVO.setT_birth(securityUtil.checkData(vo.getT_birth()));
		ret = mapper.insertTarget(tVO);
		
		// 2. 타겟 가계부 등록
		if(ret > 0) {
			// 대상자관련 가계부에 등록을 위한 대상자 아이디 얻기
			int t_id = mapper.selectLatestTarget();
			
			vo.setT_id(t_id+"");
			vo.setTa_type("INC");
			ret = mapper.insertTargetAccbook(vo);
			
			// 3. 타겟에 대한 스케쥴 등록처리
			if(ret > 0) {
				ICalendarMapper cMapper = sqlSession.getMapper(ICalendarMapper.class);
				CalendarVO cVo = new CalendarVO();
				cVo.setIn_type("tar");
				cVo.setText(securityUtil.checkData(tVO.getT_name() + " :: " + vo.getTa_memo()));
				cVo.setU_id(u_id);
				cVo.setContent(securityUtil.checkData(tVO.getT_name() + " :: " + vo.getTa_memo()));
				cVo.setC_location("");
				cVo.setAlarm_val("none");
				cVo.setT_id(vo.getT_id());
				cVo.setC_target(securityUtil.checkData(tVO.getT_name()));
				cVo.setStart_date(vo.getTa_date() + " 11:00");
				cVo.setEnd_date(vo.getTa_date() + " 12:00");
				cVo.setRepeat_type("none");
				ret = cMapper.insertSchedule(cVo);
			}
		}
		return ret;
	}
}
