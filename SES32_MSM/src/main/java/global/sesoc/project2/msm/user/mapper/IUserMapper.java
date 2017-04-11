package global.sesoc.project2.msm.user.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.user.vo.UserVO;

/**
 * 사용자에 대한 인터페이스
 * @author KIM TAE HEE
 *
 */
public interface IUserMapper {
	public int userInsert(UserVO userVO);
	public int accountProduction(String u_id);
	public UserVO voReading(String u_id);
	public UserVO userLogin(String u_id, String u_pwd);
	public String userIDSearching(String u_email);
	public String userPWSearching(String id, String name, String email);
	public int changePW(String id, String tPassword);
	public int modificationPW(String check_id, String renew_pwd);
	public String idCheck(String id);
	public int updateUser(UserVO vo);
	public int deleteUser(String u_id);
	public int updateUser2(UserVO vo);
	public ArrayList<AccbookVO> accList(String id, String month);
	public int additionalIncome(AccbookVO vo);
	public HashMap<String, Object> emergencyExpensePrepared(String id);
	public int depositAccount(HashMap<String, Object> result);
}