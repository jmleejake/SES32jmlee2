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
	// 회원가입
	public int userInsert(UserVO userVO);
	// 로그인
	public UserVO userLogin(String u_id, String u_pwd);
	// 아이디 중복체크
	public String idCheck(String id);
	//ID 찾기 (가입 체크, ID,PW 찾기)
	public UserVO userIDSearch(UserVO user);
	//회원 정보수정
	public int user_Update(UserVO user);
	// 가계부리스트 얻기 (비상금관리 데이터 조회 / 검색 + )
	public ArrayList<AccbookVO> selectAccountList(HashMap<String, Object> param);
	//회원 탈퇴
	public int userDelete(String loginID);
}