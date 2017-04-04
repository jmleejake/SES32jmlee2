package global.sesoc.project2.msm.target.mapper;

import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;

/**
 * 대상자 관련 쿼리접근파일
 */
public interface ITargetMapper {
	public int insertTarget(TargetVO vo);
	public int selectLatestTarget();
	public int insertTargetAccbook(TargetAccBookVO vo);
}
