package global.sesoc.project2.msm.user.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.user.vo.UserVO;

/**
 * 사용자에 대한 인터페이스
 * @author KIM TAE HEE
 *
 */
public interface IUserMapper {
/*	public int userInsert(UserVO userVO);
	public UserVO voReading(String u_id);
	public UserVO userLogin(String u_id, String u_pwd);
	public String userIDSearching(String u_email);
	public String userPWSearching(String id, String name);
	public int changePW(String id, String tPassword);
	public int modificationPW(String check_id, String renew_pwd);
	public String idCheck(String id);
	public int updateUser(UserVO vo);
	public int updateUser2(UserVO vo);
	public int deleteAcc(String u_id);
	public int deleteUser(String u_id);
	public ArrayList<TargetVO> selectTarget(String u_id);
	public ArrayList<TargetAccBookVO> selectTargetAcc(String t_id);
	public ArrayList<TargetAccBookVO> selectTargetAccBook();
	public int deleteTagetAcc();
	public int deleteTarget(String u_id);
	public int deleteCalender(String u_id);
	public ArrayList<AccbookVO> releaseList1(String u_id, String checkDate);
	public ArrayList<AccbookVO> releaseList2(String u_id);
	public int insertList(AccbookVO result);
	public AccbookVO checkAccForEmergency(String a_id, String u_id);
	public int checkAccForEmergency2(String a_id, String u_id);
	public UserVO emergencyRelease(String u_id);*/
	
	public int userInsert(UserVO userVO);
	public UserVO voReading(String u_id);
	public UserVO userLogin(String u_id, String u_pwd);
	public String userIDSearching(String u_email);
	public String userPWSearching(String id, String name);
	public String userSearching(String email);
	public int changePW(String id, String tPassword);
	public int modificationPW(String check_id, String renew_pwd);
	public String idCheck(String id);
	public int updateUser(UserVO vo);
	public int updateUser2(UserVO vo);
	public int deleteAcc(String u_id);
	public int deleteUser(String u_id);
	public ArrayList<TargetVO> selectTarget(String u_id);
	public ArrayList<TargetAccBookVO> selectTargetAcc(String t_id);
	public ArrayList<TargetAccBookVO> selectTargetAccBook();
	public int deleteTagetAcc();
	public int deleteTarget(String u_id);
	public int deleteCalender(String u_id);
	public ArrayList<AccbookVO> releaseList1(String u_id, String checkDate);
	public int insertList(AccbookVO result);
	public AccbookVO checkAccForEmergency(String a_id, String u_id);
	public int checkAccForEmergency2(String a_id, String u_id);
	public UserVO emergencyRelease(String u_id);
	
	//ID 찾기 (가입 체크, ID,PW 찾기)
	public UserVO userIDSearch(UserVO user);
	//회원 정보수정
	public int user_Update(UserVO user);
	// 가계부리스트 얻기 (비상금관리 데이터 조회 / 검색 + )
	public ArrayList<AccbookVO> selectAccountList(HashMap<String, Object> param);
}