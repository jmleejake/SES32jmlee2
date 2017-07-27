package global.sesoc.project2.msm.user.dao;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.user.mapper.IUserMapper;
import global.sesoc.project2.msm.user.vo.UserVO;
/**
 * 사용자에 대한 데이터베이서 접근 지정자
 * @author KIM TAE HEE
 *
 */
@Repository
public class UserDAO {
	@Autowired
	SqlSession sqlSession;
	
	private static final Logger log = LoggerFactory.getLogger(UserDAO.class);
	
	// 회원가입
	public int userInsert(UserVO userVO){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.userInsert(userVO);
		return result;
	}
	
	// 로그인
	public UserVO userLogin(String u_id, String u_pwd){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		UserVO userVO = iUserMapper.userLogin(u_id, u_pwd);
		return userVO;
	}
	
	// 아이디 중복체크
	public String idCheck(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String result = iUserMapper.idCheck(u_id);
		return result;
	}
	
	//ID 찾기 (가입 체크, ID,PW 찾기)
	public UserVO userIDSearch(UserVO user){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		UserVO result = iUserMapper.userIDSearch(user);
		return result;
	}
	
	//회원정보 수정
	public int user_Update(UserVO user){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.user_Update(user);
		return result;
	}
	
	//회원 탈퇴
	public int userDelete(String loginID){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.userDelete(loginID);
		return result;
	}
	
	/**
	 * 안드로이드 로그인
	 * @param data 안드로이드에서 입력한 유저데이터
	 * @return
	 */
	public String androidLogin(String data) {
		String ret = null;
		JSONArray array;
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		try {
			array = new JSONArray(data);
			
			String id = null;
			String pw = null;

			for (int i = 0; i < array.length(); i++) {
				JSONObject json = array.getJSONObject(i);
				
				id = json.get("user_id").toString();
				pw = json.get("user_pw").toString();
				
				UserVO vo = iUserMapper.userLogin(id, pw);
				JSONObject obj = new JSONObject();
				
				//로그인 실패
				if(vo==null){
					obj.put("err", "아이디나 비밀번호가 틀립니다.");
					ret = URLEncoder.encode(obj.toString(), "UTF-8");
				} else {
					obj.put("user_id", vo.getU_id());
					obj.put("user_name", vo.getU_name());
					JSONArray arr = new JSONArray();
					arr.put(obj);
					JSONObject main_obj = new JSONObject();
					main_obj.put("user_list", arr);
					ret = URLEncoder.encode(main_obj.toString(), "UTF-8");
				}
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		log.debug("androidLogin :: RET: {}", ret);
		return ret;
	}
	
}