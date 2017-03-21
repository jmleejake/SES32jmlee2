package global.sesoc.project2.msm.accbook.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.accbook.mapper.IAccbookMapper;
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
	 * @param accbook 
	 * @return 성공 1  실패 0 반환
	 */
	public int insertAccbook(AccbookVO accbook){
		
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		int result = mapper.insertAccbook(accbook);
		return result;
		
	}
}
