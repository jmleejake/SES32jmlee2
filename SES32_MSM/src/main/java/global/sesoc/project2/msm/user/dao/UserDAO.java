package global.sesoc.project2.msm.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	public int userInsert(UserVO userVO){
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.userInsert(userVO);
		return result;
	}
	
	public String userLogin(String u_id, String u_pwd){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String loginID = iUserMapper.userLogin(u_id, u_pwd);
		return loginID;
	}
	
	public String userIDSearching(String u_email){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String id = iUserMapper.userIDSearching(u_email);
		return id;
	}
	
	public String userPWSearching(String id, String name, String email){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String user_email = iUserMapper.userPWSearching(id, name, email);
		return user_email;
	}
	
	public int userPWChangingTemporary(String id, String tPassword){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.changePW(id, tPassword);
		return result;
	}
	
	public int userPWModification(String id, String newPassword){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.modificationPW(id, newPassword);
		return result;
	}
	
	public String idCheck(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String result = iUserMapper.idCheck(u_id);
		return result;
	}
}
