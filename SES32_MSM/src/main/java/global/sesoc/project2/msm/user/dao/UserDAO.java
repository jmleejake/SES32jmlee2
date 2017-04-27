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
	
	public String userPWSearching(String id, String name){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		String user_email = iUserMapper.userPWSearching(id, name);
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
	
	public void deleteUser(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);

		// delete 명령 후의 resultType은 삭제된 행의 개수로 반환된다. (1 또는 0의 boolean 형식 반환 X)
		iUserMapper.deleteAcc(u_id);
		iUserMapper.deleteTagetAcc();	
		iUserMapper.deleteTarget(u_id);
		iUserMapper.deleteUser(u_id);
	}
	
	public ArrayList<AccbookVO> releaseList1(String id, String date, String year){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		ArrayList<AccbookVO> accList = new ArrayList<AccbookVO>();
		
		String checkDate = year+"-"+date;
		
		accList=iUserMapper.releaseList1(id, checkDate);
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
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("BIS")){
				if(vo.getMain_cate().equalsIgnoreCase("MIN")){
					remainCheck-=vo.getPrice();
				}
			}
		}
		
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
	
	public AccbookVO checkAccForEmergency(String a_id, String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		AccbookVO vo = new AccbookVO();
		vo=iUserMapper.checkAccForEmergency(a_id, u_id);
		return vo;	
	}
	
	public int checkAccForEmergency2(String a_id, String u_id, int price){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int resultCheck = 0;
		
		int result1 = iUserMapper.checkAccForEmergency2(a_id, u_id);
		
		if(result1==1){
			UserVO vo = new UserVO();
			UserVO vo2 = new UserVO();
			vo=iUserMapper.voReading(u_id);
			int emergency = vo.getU_emergences()+price;
			
			vo2.setU_id(u_id);
			vo2.setU_emergences(emergency);
			resultCheck = iUserMapper.updateUser2(vo2);
		}
		
		return resultCheck;
	}
	
	public int checkAccForEmergency3(String a_id, String u_id, int price){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int resultCheck = 0;
		
		int result1 = iUserMapper.checkAccForEmergency2(a_id, u_id);
		
		if(result1==1){
			UserVO vo = new UserVO();
			UserVO vo2 = new UserVO();
			vo=iUserMapper.voReading(u_id);
			int emergency = vo.getU_emergences()-price;
			
			vo2.setU_id(u_id);
			vo2.setU_emergences(emergency);
			resultCheck = iUserMapper.updateUser2(vo2);
		}
		
		return resultCheck;
	}
	
	public String rangeCheck_1(ArrayList<AccbookVO> list2, int disposableIncome, int remainCheck){
		
		int fixedExpenseRange = disposableIncome/5; // 지난달 기준 고정형 변동지출의 범위
		int floatExpenseRange = (disposableIncome/100)*15; // 지난달 기준 유동형 변동지출의 범위
		int fixedExpenseSum = 0; // 이번달에 행해진 고정 변동 지출 합계
		int floatExpenseSum = 0; // 이번달에 행해진 유동 변동 지출 합계
		
		String [] fixedExpense = {"식비", "주거생활비", "학비", "유흥비", "사회생활비"};
		String [] floatingExpense = {"건강관리비", "의류미용비", "교통비", "문화생활비", "차량유지비", "금융보험비"};
		
		for(AccbookVO vo : list2){
			if(vo.getMain_cate().equalsIgnoreCase("OUT")){
				
				for(int i=0; i<fixedExpense.length; i++){
					if(vo.getSub_cate().equals(fixedExpense[i])){
						fixedExpenseSum+=vo.getPrice(); // 이번 달 마지막날까지의 고정 변동지출 합계
					}
				}
				
				for(int i=0; i<floatingExpense.length;i++){
					if(vo.getSub_cate().equals(floatingExpense[i])){
						floatExpenseSum+=vo.getPrice(); // 이번 달 마지막날까지의 유동 변동지출 합계
					}
				}
			}
		}
		
		if(remainCheck<=0){
			return "현재 실질 잔여 금액이 존재하지 않습니다! 주의하십시오!";
		}
		
		if(fixedExpenseRange>0){
			if(fixedExpenseRange<=fixedExpenseSum){ // 범위를 초과할 경우
				int check1=0, check2=0, check3=0, check4=0, check5=0;
				ArrayList<Integer> array = new ArrayList<>();
				
				for(AccbookVO vo : list2){
					if(vo.getSub_cate().equals("식비")){
						check1+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("주거생활비")){
						check2+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("학비")){
						check3+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("유흥비")){
						check4+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("사회생활비")){
						check5+=vo.getPrice();
					}
				}
				array.add(check1);
				array.add(check2);
				array.add(check3);
				array.add(check4);
				array.add(check5);
				
				int maximumValue = array.get(array.size()-1);
				
				if(maximumValue==check1){
					return "식비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check2){
					return "자택 관리비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check3){
					return "사교육비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check4){
					return "유흥비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check5){
					return "회식 참석을 자제하십시오!";
				}
			}
		}
		
		else if(floatExpenseRange>0){
			if(floatExpenseRange<=floatExpenseSum){
				int check1=0, check2=0, check3=0, check4=0, check5=0, check6=0;
				ArrayList<Integer> array = new ArrayList<>();
				
				for(AccbookVO vo : list2){
					if(vo.getSub_cate().equals("건강관리비")){
						check1+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("의류미용비")){
						check2+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("교통비")){
						check3+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("문화생활비")){
						check4+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("차량유지비")){
						check5+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("금융보험비")){
						check6+=vo.getPrice();
					}
				}
				array.add(check1);
				array.add(check2);
				array.add(check3);
				array.add(check4);
				array.add(check5);
				array.add(check6);
				
				int maximumValue = array.get(array.size()-1);
				
				if(maximumValue==check1){
					return "건강관리비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check2){
					return "의류미용비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check3){
					return "교통비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check4){
					return "문화생활비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check5){
					return "차량유지비 지출 액수를 감소시키십시오!";
				}
				else if(maximumValue==check6){
					return "금융보험비 지출 액수를 감소시킵시오!";
				}
			}
		}
		return "이번달 지출 경향은 양호합니다.";
	}
}