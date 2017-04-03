package global.sesoc.project2.msm.accbook.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.project2.msm.accbook.mapper.IAccbookMapper;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;

/**
 * 가계부 자 관련 DB Access Object
 */

@Repository
public class AccbookDAO {
	@Autowired
	SqlSession sqlSession;

	/**
	 * 가계부 등록
	 * 
	 * @param accbook
	 * @return 성공 1 실패 0 반환
	 */
	public int registAccbook(AccbookVO accbook) {

		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		int result = mapper.insertAccbook(accbook);
		return result;

	}

	/**
	 * 가계부 검색
	 * 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public ArrayList<AccbookVO> getAccbook(int startRecord ,int countPerPage,AccbookSearchVO accbookSearch 
 ) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		ArrayList<AccbookVO> result = mapper.selectAccbook(accbookSearch,rb);
		
		return result;
	}
	/**
	 * 가계부 검색
	 * 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public ArrayList<AccbookVO> getAccbook2(AccbookSearchVO accbookSearch ) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
		ArrayList<AccbookVO> result = mapper.selectAccbook2(accbookSearch);
		
		return result;
	}

	/**
	 * 가계부 번호로 가계부를 삭제
	 * 
	 * @param a_id
	 * @return 성공 1 실패 0 반환
	 */
	public int deleteAccbook(int a_id) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);

		int result = mapper.deleteAccbook(a_id);
		return result;
	}

	/**
	 * 가계부 수정
	 * 
	 * @param accbook
	 * @return 성공 1 실패 0 반환
	 */
	public int updateAccbook(AccbookVO accbook){
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);

		int result = mapper.updateAccbook(accbook);
		return result;
	}
	
	public int getTotal(AccbookSearchVO accbookSearch){
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);

		int result = mapper.getTotal(accbookSearch);
		return result;
		
	}
}
