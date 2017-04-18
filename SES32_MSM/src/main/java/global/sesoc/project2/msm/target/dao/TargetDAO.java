package global.sesoc.project2.msm.target.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.target.mapper.ITargetMapper;
import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.util.DataVO;
import global.sesoc.project2.msm.util.ExcelService;

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
	 * @return
	 */
	public int excelUpload(String file_name) {
		log.debug("excelUpload..... : filename? {}", file_name);
		
		int ret = 0;
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		List<List<String>> data;
		try {
			data = ExcelService.getExcelList(file_name);
			
			// DB insert
			for (List<String> list : data) {
				// 경조사 :: 입력형식 : yyyy-mm-dd 경조사명
				String event = list.get(0);
				// 경조사 일자
				String event_date = event.substring(0, event.lastIndexOf("-") + 3);
				// 경조사관련 메모
				String event_memo = event.substring(event.lastIndexOf("-") + 4, event.length());
				
				// 1. 대상자 등록
				TargetVO tVO = new TargetVO();
				tVO.setT_name(list.get(1));
				tVO.setT_group(list.get(3));
				tVO.setT_date(event_date);
				log.debug("before insert target : {}", tVO);
				ret = mapper.insertTarget(tVO);
				
				if(ret > 0) {
					// 대상자관련 가계부에 등록을 위한 대상자 아이디 얻기
					int t_id = mapper.selectLatestTarget();
					
					// 2. 대상자관련 가계부 등록
					TargetAccBookVO tAccVO = new TargetAccBookVO();
					tAccVO.setT_id(t_id);
					tAccVO.setTa_price(Integer.parseInt(list.get(2)));
					tAccVO.setTa_type("INC"); // 대상자가 낸 경조사비이기 때문에 수입으로 치고 IN을 입력하여 insert
					tAccVO.setTa_memo(event_memo);
					tAccVO.setTa_date(event_date);
					log.debug("before insert target accbook : {}", tAccVO);
					ret = mapper.insertTargetAccbook(tAccVO);
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
	public ArrayList<TargetVO> selectTargetList(HashMap<String, Object> param) {
		log.debug("selectTargetList : param::{}", param);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		return mapper.selectTargetList(param);
	}
	
	public int updateTarget(HashMap<String, Object> param) {
		log.debug("updateTarget : param::{}", param);
		ITargetMapper mapper = sqlSession.getMapper(ITargetMapper.class);
		return mapper.updateTarget(param);
	}
}
