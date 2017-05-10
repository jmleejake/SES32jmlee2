package global.sesoc.project2.msm.user.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
}