package global.sesoc.project2.msm.user.mapper;

import global.sesoc.project2.msm.user.vo.UserVO;

/**
 * 사용자에 대한 인터페이스
 * @author KIM TAE HEE
 *
 */
public interface IUserMapper {
	public int userInsert(UserVO userVO);
	public String userLogin(String u_id, String u_pwd);
	public String userIDSearching(String u_email);
	public String userPWSearching(String id, String name, String email);
	public int changePW(String id, String tPassword);
	public int modificationPW(String id, String newPassword);
	public String idCheck(String id);
}
