package global.sesoc.project2.msm.accbook.mapper;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;

/**
 * 가계부 관련 쿼리접근파일
 */
public interface IAccbookMapper {
	
	/**
	 * 가계부 등록
	 * @param accbook 
	 * @return 성공 1  실패 0 반환
	 */
	public int insertAccbook(AccbookVO accbook);
	/**
	 * 가계부 검색 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public ArrayList<AccbookVO> selectAccbook(AccbookSearchVO accbookSearch,RowBounds rb);
	
	/**
	 * 단일 가계부 검색 
	 * @param a_id
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public AccbookVO selectAccbook3(String a_id);
	
	
	
	/**
	 * 그래프용 가계부검색
	 * @param accbookSearch
	 * @return 
	 */
	public ArrayList<AccbookVO> selectAccbook2(AccbookSearchVO accbookSearch);
	
	/**
	 * 년간  가계부분석
	 * 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public ArrayList<AccbookVO>selectAccbook4(AccbookSearchVO accbookSearch);
	
	/**
	 * 가계부 번호로 가계부를 삭제
	 * @param a_id
	 * @return 성공 1 실패 0 반환
	 */
	public int deleteAccbook(int a_id);
	/**
	 * 가계부 수정
	 * @param accbook
	 * @return 성공 1 실패 0 반환
	 */
	public int updateAccbook(AccbookVO accbook); 
	/**
	 * 가계부 숫자 
	 * @return 
	 */
	public int getTotal(AccbookSearchVO accbookSearch);
	
	
}
