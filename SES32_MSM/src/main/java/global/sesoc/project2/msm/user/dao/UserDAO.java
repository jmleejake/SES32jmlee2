package global.sesoc.project2.msm.user.dao;

import java.util.ArrayList;

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
	
	public int userInsert(UserVO userVO){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.userInsert(userVO);
		return result;
	}
	
	public UserVO userLogin(String u_id, String u_pwd){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		UserVO userVO = iUserMapper.userLogin(u_id, u_pwd);
		return userVO;
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
	
	public int userPWModification(String check_id, String renew_pwd){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.modificationPW(check_id, renew_pwd);
		return result;
	}
	
	public String idCheck(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String result = iUserMapper.idCheck(u_id);
		return result;
	}
	
	public int userUpdate(UserVO vo){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.updateUser(vo);
		return result;
	}
	
	public int deleteUser(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.deleteUser(u_id);
		return result;
	}
	
	public int updateUser2(int u_emergences){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.updateUser2(u_emergences);
		return result;
	}
	
	public ArrayList<AccbookVO> accList(String id, String month){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		ArrayList<AccbookVO> result = iUserMapper.accList(id, month);
		return result;
	}
	
	public int additionalIncome(AccbookVO vo){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.additionalIncome(vo);
		return result;
	}
	
	public int originalIncomeCheck(ArrayList<AccbookVO> result2){
		
		int originalIncome=0;

		for (AccbookVO vo2 : result2) {
			
			char type = 'i';
			System.out.println(vo2.getA_type());
			
			if(vo2.getA_type().equalsIgnoreCase("i")){
				
				System.out.println(vo2.getMain_cate());
				
				if(vo2.getMain_cate().equals("고정수입")){
					originalIncome = vo2.getPrice();
					System.out.println(originalIncome);
				}
			}
		}
		
		return originalIncome;
	}
}
