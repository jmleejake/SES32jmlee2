package global.sesoc.project2.msm.user.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.user.mapper.IUserMapper;
import global.sesoc.project2.msm.user.vo.UserVO;
import global.sesoc.project2.msm.util.ExpenditureInsertProcedure;

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
	
	public UserVO voReading(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		UserVO userVO = iUserMapper.voReading(u_id);
		return userVO;
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
	
	public int userUpdate2(UserVO vo){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.updateUser2(vo);
		return result;
	}
	
	public int deleteUser(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.deleteUser(u_id);
		return result;
	}
	
	public ArrayList<AccbookVO> releaseList1(String id, String date){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		ArrayList<AccbookVO> accList = new ArrayList<AccbookVO>();
		accList=iUserMapper.releaseList1(id, date);
		return accList;
	}
	
	public int checkIncome1(ArrayList<AccbookVO> list){
		int result=0;
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equals("INC")){
				if(vo.getMain_cate().equals("고정수입")){
				result+=vo.getPrice();
				}
			}
		}
		return result;
	}
	
	public int checkIncome2(ArrayList<AccbookVO> list, int income1){
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equals("OUT")){
				if(vo.getMain_cate().equals("고정지출")){
					income1-=vo.getPrice();
				}
			}
		}
		return income1;
	}
	
	public int checkExpense1(ArrayList<AccbookVO> list){
		
		int result=0;
			
		for(AccbookVO vo : list){
			if(vo.getA_type().equals("OUT")){
				if(vo.getMain_cate().equals("지출")){
					result+=vo.getPrice();
				}
			}
		}
		return result;
	}
	
	public int checkIncome3(String u_id){
		
		int result=0;
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		UserVO vo=iUserMapper.emergencyRelease(u_id);
		
		result=vo.getU_emergences();
		
		return result;
	}
	
	public int checkExpense2(String id, String beforeMonth){
		
		int reasonableSum = 0; // 생활 적정 금액 = 지난 달 대비 고정 지출에 변동 지출에 대한 범위 유지 설정 액수를 더한 값
		int regulatedScope = 0; // 전달 대비 변동 지출 허용 범위를 적용한 변동 지출 액수
		
		ArrayList<AccbookVO> list = new ArrayList<>();
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		list=iUserMapper.releaseList1(id, beforeMonth); // 사용자에 대한 지난달 내역 가져오기(비교 산정 목적)
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("OUT")){
				if(vo.getMain_cate().equals("고정지출")){
					reasonableSum+=vo.getPrice(); // 전월 기준
				}
			}
		}
		
		// 지난 달에 행해진 변동 지출의 총합을 구한다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("OUT")){
				if(vo.getMain_cate().equals("지출")){
					regulatedScope+=vo.getPrice(); // 전월 기준
				}
			}
		}
		
		// 지난달 대비 이번달 변동지출 허용 초과 범위 = 지난 달의 3% 내외
		int permissibleLimited = (regulatedScope/100)*3;  // 전월 기준

		int beforeMonthInt = Integer.parseInt(beforeMonth);
		
		// 규정 범위의 격차에 대한 일관성을 유지하기 위해 이번달이 짝수인지에 대한 유무에 따라 허용 범위 액수를 더할지 뺄지가 결정된다.
		if(beforeMonthInt%2==0){
			regulatedScope+=permissibleLimited;
		}
				
		if(beforeMonthInt%2!=0){
			regulatedScope-=permissibleLimited;
		}
		
		if(regulatedScope!=0){
			reasonableSum+=regulatedScope;
		}
		
		return reasonableSum;
	}
	
	public int remainCheckProcedure(String u_id){
		
		int remainCheck=0;
		
		ArrayList<AccbookVO> list = new ArrayList<>();
		UserVO userVO = new UserVO();
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		list=iUserMapper.releaseList2(u_id); // 전체 내역 가져오기
		
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("INC")){
				remainCheck+=vo.getPrice();
			}
		}
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("OUT")){
				remainCheck-=vo.getPrice();
			}
		}
		
		userVO=iUserMapper.voReading(u_id); // 현재 누적된 비상금 내역을 전체 잔여액수에서 차감한다.(비상금 별도 관리 목적)
		remainCheck-=userVO.getU_emergences();
		
		return remainCheck;
	}
	
	public ArrayList<AccbookVO> emergencyExpenseList(String u_id){
		
		ArrayList<AccbookVO> list = new ArrayList<>();
		ArrayList<AccbookVO> list2 = new ArrayList<>();
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		list=iUserMapper.releaseList2(u_id); // 전체 내역 가져오기
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("BIS")){
				if(vo.getMain_cate().equalsIgnoreCase("PLS")){
					list2.add(vo);
				}
			}
		}
		return list2;
	}
	
	public ArrayList<AccbookVO> emergencyExpenseList2(String u_id){
		
		ArrayList<AccbookVO> list = new ArrayList<>();
		ArrayList<AccbookVO> list2 = new ArrayList<>();
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		list=iUserMapper.releaseList2(u_id); // 전체 내역 가져오기
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("BIS")){
				if(vo.getMain_cate().equalsIgnoreCase("MIN")){
					list2.add(vo);
				}
			}
		}
		return list2;
	}
	
	public int insertList(AccbookVO result){
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result1 = iUserMapper.insertList(result);
		int result2 = 0;
		
		if(result1==1){
			if(result.getA_type().equalsIgnoreCase("BIS")){
				if(result.getMain_cate().equalsIgnoreCase("PLS")){
					UserVO vo = iUserMapper.voReading(result.getU_id());
					int emergency=vo.getU_emergences();
					emergency+=result.getPrice();
					vo.setU_emergences(emergency);
					result2=iUserMapper.updateUser2(vo);
				}
				
				else if(result.getMain_cate().equalsIgnoreCase("MIN")){
					UserVO vo = iUserMapper.voReading(result.getU_id());
					int emergency=vo.getU_emergences();
					emergency-=result.getPrice();
					vo.setU_emergences(emergency);
					result2=iUserMapper.updateUser2(vo);
				}
			}
		}
		return result2;
	}
}