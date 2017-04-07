package global.sesoc.project2.msm.user.mapper;

import java.util.ArrayList;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.user.vo.UserVO;

/**
 * 사용자에 대한 인터페이스
 * @author KIM TAE HEE
 *
 */
public interface IUserMapper {
	public int userInsert(UserVO userVO);
	public UserVO userLogin(String u_id, String u_pwd);
	public String userIDSearching(String u_email);
	public String userPWSearching(String id, String name, String email);
	public int changePW(String id, String tPassword);
	public int modificationPW(String check_id, String renew_pwd);
	public String idCheck(String id);
	public int updateUser(UserVO vo);
	public int deleteUser(String u_id);
	public int updateUser2(int u_emergences);
	
	public ArrayList<AccbookVO> accList(String id, String month);
	public int additionalIncome(AccbookVO vo);
}
