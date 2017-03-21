package global.sesoc.project2.msm.accbook.mapper;

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
}
