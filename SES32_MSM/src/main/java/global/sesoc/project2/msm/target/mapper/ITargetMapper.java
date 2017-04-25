package global.sesoc.project2.msm.target.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.util.DataVO;

/**
 * 대상자 관련 쿼리접근파일
 */
public interface ITargetMapper {
	public int insertTarget(TargetVO vo);
	public int selectLatestTarget();
	public int insertTargetAccbook(TargetAccBookVO vo);
	public ArrayList<DataVO> selectTargetAccBook(HashMap<String, Object> param);
	public ArrayList<TargetVO> selectTargetList(HashMap<String, Object> param, RowBounds rb);
	public int updateTarget(HashMap<String, Object> param);
	public int deleteTarget(String t_id);
	public int selectTargetTotal(HashMap<String, Object> param);
}
