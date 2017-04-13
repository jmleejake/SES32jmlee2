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
	
	public int userInsert(UserVO userVO){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.userInsert(userVO);
		
		if(result==1){
			iUserMapper.accountProduction(userVO.getU_id());
		}
		
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
	
	public int deleteUser(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.deleteUser(u_id);
		return result;
	}
	
	public int updateUser2(UserVO vo){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);	
		int result = iUserMapper.updateUser2(vo);

		if(result==1){
			iUserMapper.insertEmergencies(vo);
		}
		
		return result;
	}
	
	public int remainEmergencesCheck(String id){
		HashMap<String, Object> result = new HashMap<String, Object> ();
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		result = iUserMapper.emergencyExpensePrepared(id);
		Object check1 = result.get("E_ACC");
		
		int emergenciesAccount = Integer.parseInt(check1.toString());
		
		return emergenciesAccount;
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
			if(vo2.getA_type().equalsIgnoreCase("in")){
				if(vo2.getMain_cate().equals("고정수입")){
					originalIncome = vo2.getPrice();
				}
			}
		}
		return originalIncome;
	}
	
	public int originalIncomeCheck2(ArrayList<AccbookVO> result2, int originalIncome){
		
		for(AccbookVO vo2 : result2){
			if(vo2.getA_type().equalsIgnoreCase("in")){
				if(vo2.getMain_cate().equals("변동수입")){
					originalIncome +=vo2.getPrice();
				}
			}
		}
		return originalIncome;
	}
	
	public int origianlIncomeCheck3(ArrayList<AccbookVO> result2, int incomeSum){
		
		for(AccbookVO vo2 : result2){
			if(vo2.getA_type().equalsIgnoreCase("out")){
				if(vo2.getMain_cate().equals("고정지출")){
					incomeSum-=vo2.getPrice();
				}
			}
		}
		return incomeSum;
	}
	
	public int origianlIncomeCheck4(ArrayList<AccbookVO> result2, int incomeSum2){
		
		for(AccbookVO vo2 : result2){
			if(vo2.getA_type().equalsIgnoreCase("out")){
				if(vo2.getMain_cate().equals("변동지출")){
					incomeSum2-=vo2.getPrice();
				}
			}
		}
		return incomeSum2;
	}	
	
	public int emergencyExpensePrepared(String loginID){
		
		int moneySum = 0; // 비상 대비 의무 입금액(월 저축 통장 + 연간 지출 통장)
		HashMap<String, Object> result = new HashMap<String, Object> (); // 통장에 입급된 액수를 각각 구분해서 가져온다.
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		result = iUserMapper.emergencyExpensePrepared(loginID);
		
		/*
		Iterator iterator =  result.entrySet().iterator();
		
		while(iterator.hasNext()){
			Entry entry = (Entry) iterator.next();
			System.out.println(entry.getKey());
			System.out.println(entry.getValue());
		}
		*/
		
		Object check1 = result.get("A_ACC");
		Object check2 = result.get("S_ACC");
		
		int AnnualAcc = Integer.parseInt(check1.toString());
		int SavingsAcc = Integer.parseInt(check2.toString());
		
		moneySum = AnnualAcc+SavingsAcc;

		return moneySum; 
	}
	
	public int depositAccount(String u_id, int compulsorySavingsAmount, int anualSpendingAmount){
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);

		HashMap map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("compulsorySavingsAmount", compulsorySavingsAmount);
		map.put("anualSpendingAmount", anualSpendingAmount);
		
		int result = iUserMapper.depositAccount(map);
		return result;
	}
	
	public int rangeDesignation(ArrayList<AccbookVO> list, int monthInt){
		int regulatedScope = 0;
		
		// 지난 달에 행해진 변동 지출의 총합을 구한다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("out")){
				if(vo.getMain_cate().equals("변동지출")){
					regulatedScope+=vo.getPrice();
				}
			}
		}
		
		// 지난달 대비 이번달 변동지출 허용 초과 범위 = 지난 달의 3% 내외
		int permissibleLimited = (regulatedScope/100)*3; 
		
		// 규정 범위의 격차에 대한 일관성을 유지하기 위해 이번달이 짝수인지에 대한 유무에 따라 허용 범위 액수를 더할지 뺄지가 결정된다.
		if(monthInt%2==0){
			regulatedScope+=permissibleLimited;
		}
		
		if(monthInt%2!=0){
			regulatedScope-=permissibleLimited;
		}
		return regulatedScope;
	}
	
	public int checkVariableExpense(ArrayList<AccbookVO> list){
		
		int disposableIncome=0; // 이번달 가처분 소득 액수
		int fixedExpenseRange=0; // 고정적인 변동 지출에 대한 허용 범위
		
		// 먼저 고정수입 총 액수를 가져온다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("in")){
				if(vo.getMain_cate().equals("고정수입")){
					disposableIncome+=vo.getPrice();
				}
			}
		}
		
		// 고정 수입 총 액수에 변동수입을 더하여 총 수입 액수를 구한다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("in")){
				if(vo.getMain_cate().equals("변동수입")){
					disposableIncome+=vo.getPrice();
				}
			}
		}
		
		// 총 수입 액수에서 고정 지출 액수를 빼서 최종 가처분 소득 액수를 구한다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("out")){
				if(vo.getMain_cate().equals("고정지출")){
					disposableIncome-=vo.getPrice();
				}
			}
		}
		
		// 고정적인 변동 지출 범위는 가처분 소득의 20%로 규정
		fixedExpenseRange=disposableIncome/5;
		return fixedExpenseRange;
	}
	
	public int checkVariableExpense2(ArrayList<AccbookVO> list){
		
		int disposableIncome=0; // 이번달 가처분 소득 액수
		int floatingExpenseRange=0; // 유동적인 변동 지출에 대한 허용 범위
		
		// 먼저 고정수입 총 액수를 가져온다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("in")){
				if(vo.getMain_cate().equals("고정수입")){
					disposableIncome+=vo.getPrice();
				}
			}
		}
				
		// 고정 수입 총 액수에 변동수입을 더하여 총 수입 액수를 구한다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("in")){
				if(vo.getMain_cate().equals("변동수입")){
					disposableIncome+=vo.getPrice();
				}
			}
		}
				
		// 총 수입 액수에서 고정 지출 액수를 빼서 최종 가처분 소득 액수를 구한다.
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("out")){
				if(vo.getMain_cate().equals("고정지출")){
					disposableIncome-=vo.getPrice();
				}
			}
		}
		
		// 유동적인 변동 지출 범위는 가처분 소득의 15%로 규정
		floatingExpenseRange=(disposableIncome/100)*15;
		return floatingExpenseRange;
	}
	
	public int checkVariableExpense3(ArrayList<AccbookVO> list){
		
		// 이번 달 내 현재까지 행해진 고정적인 변동지출의 총합을 구한다.(식비, 외식비, 유흥비)
		int fixedExpenseSum=0;
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("out")){
				if(vo.getMain_cate().equals("변동지출")){
					if(vo.getSub_cate().equals("식비")){
						fixedExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("외식비")){
						fixedExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("유흥비")){
						fixedExpenseSum+=vo.getPrice();
					}
				}
			}
		}
		return fixedExpenseSum;
	}
	
	public int checkVariableExpense4(ArrayList<AccbookVO> list){
		
		// 이번 달 내 현재까지 행해진 유동적인 변동지출의 총합을 구한다.(교통비, 생활용품, 미용, 영화, 의료비, 경조사비)
		int floatingExpenseSum=0;
		
		for(AccbookVO vo : list){
			if(vo.getA_type().equalsIgnoreCase("out")){
				if(vo.getMain_cate().equals("변동지출")){
					if(vo.getSub_cate().equals("교통비")){
						floatingExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("생활용품")){
						floatingExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("미용")){
						floatingExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("영화")){
						floatingExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("의료비")){
						floatingExpenseSum+=vo.getPrice();
					}
					else if(vo.getSub_cate().equals("경조사비")){
						floatingExpenseSum+=vo.getPrice();
					}
				}
			}
		}
		return floatingExpenseSum;
	}
}