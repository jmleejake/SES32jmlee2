package global.sesoc.project2.msm.user.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
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
	
	public int deleteAcc(String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		int result = iUserMapper.deleteAcc(u_id);
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
	
	public int pureRemainCombinedCheck(String id){
		HashMap<String, Object> result = new HashMap<String, Object>();
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		result = iUserMapper.emergencyExpensePrepared(id);
		Object check1 = result.get("P_ACC");
		
		int pureRemainCheck = Integer.parseInt(check1.toString());
		
		return pureRemainCheck;
	}
	
	public int pureRemainCombinedCheck2(int pureCombinedAmount, String u_id){
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		HashMap map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("pureCombinedAmount", pureCombinedAmount);
		
		int result = iUserMapper.pureRemainAccountUpdate(map);
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
	
	public int depositAccount(String u_id, int compulsorySavingsAmount, int anualSpendingAmount, int pureCombinedAmount){
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);

		HashMap map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("compulsorySavingsAmount", compulsorySavingsAmount);
		map.put("anualSpendingAmount", anualSpendingAmount);
		map.put("pureCombinedAmount", pureCombinedAmount);
		
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
		
		// 고정 수입 액수에서 고정 지출 액수를 빼서 최종 가처분 소득 액수를 구한다.
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
				
		// 고정 수입 액수에서 고정 지출 액수를 빼서 최종 가처분 소득 액수를 구한다.
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
					else if(vo.getSub_cate().equals("유동형_보충")){
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
					else if(vo.getSub_cate().equals("고정형_보충")){
						floatingExpenseSum+=vo.getPrice();
					}
				}
			}
		}
		return floatingExpenseSum;
	}
	
	public int expenseUpdateProcedure1(ExpenditureInsertProcedure vo, String u_id){
		
		int result2=0;
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);	
		int exceededAmount = vo.getFixedExpenseSum()-vo.getFixedExpenseRange(); // 고정형 변동 지출 범위에서 초과된 금액
		
		AccbookVO acc1 = new AccbookVO(); // 고정형 변동 지출 저장 객체(고정형 변동 지출 범위까지의 지출 액수)
		AccbookVO acc2 = new AccbookVO(); // 유동형 변동 지출 저장 객체(나머지 보충 액수 저장 객체)
		
		acc1.setU_id(u_id);
		acc2.setU_id(u_id);
		
		acc1.setA_date(vo.getExpenseDate());
		acc2.setA_date(vo.getExpenseDate());
		
		acc1.setSub_cate(vo.getSubCategory());
		acc2.setSub_cate("고정형_보충");
		
		acc1.setPayment(vo.getExpensePayment());
		acc2.setPayment(vo.getExpensePayment());
		
		acc1.setA_memo(vo.getMemo());
		acc2.setA_memo(vo.getMemo()+ " 고정형 지출 규정 범위 초과 내역");
		
		acc1.setPrice(vo.getRelevantPrice()-exceededAmount);
		acc2.setPrice(exceededAmount);
			
		int result1 = iUserMapper.additionalIncome2(acc1);
		
		if(result1==1){
			result2=iUserMapper.additionalIncome2(acc2);
			
			HashMap<String, Object> result = new HashMap<String, Object> ();
			result=iUserMapper.emergencyExpensePrepared(u_id);
			
			Object check = result.get("P_ACC");
			int pureAccount = Integer.parseInt(check.toString());
			pureAccount-=acc1.getPrice();
			
			if(result2==1){
				pureAccount-=acc2.getPrice();
				
				result.put("pureCombinedAmount", pureAccount);
				result.put("u_id", u_id);
				
				iUserMapper.pureRemainAccountUpdate(result);
			}
		}
		return result2;
	}
	
	public int expenseUpdateProcedure2(ExpenditureInsertProcedure vo, String u_id){
		
		int result3=0;
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);	
		int exceededAmount = vo.getFloatingExpenseSum()-vo.getFloatingExpenseRange(); // 변동형 변동 지출 범위에서 초과된 금액
		
		AccbookVO acc1 = new AccbookVO(); // 고정형 변동 지출 저장 객체(나머지 보충 액수 저장 객체)
		AccbookVO acc2 = new AccbookVO(); // 유동형 변동 지출 저장 객체(유동형 변동 지출 범위까지의 지출 액수)
		
		acc1.setU_id(u_id);
		acc2.setU_id(u_id);
		
		acc1.setA_date(vo.getExpenseDate());
		acc2.setA_date(vo.getExpenseDate());
		
		acc1.setSub_cate("유동형_보충");
		acc2.setSub_cate(vo.getSubCategory());
		
		acc1.setPayment(vo.getExpensePayment());
		acc2.setPayment(vo.getExpensePayment());
		
		acc1.setA_memo(vo.getMemo()+" 유동형 지출 규정 범위 초과 내역");
		acc2.setA_memo(vo.getMemo());
		
		acc1.setPrice(exceededAmount);
		acc2.setPrice(vo.getRelevantPrice()-exceededAmount);
			
		int result1 = iUserMapper.additionalIncome2(acc2);
		
		if(result1==1){
			result3=iUserMapper.additionalIncome2(acc1);
			
			HashMap<String, Object> result = new HashMap<String, Object> ();
			result=iUserMapper.emergencyExpensePrepared(u_id);
			
			Object check = result.get("P_ACC");
			int pureAccount = Integer.parseInt(check.toString());
			pureAccount-=acc1.getPrice();
			
			if(result3==1){
				pureAccount-=acc2.getPrice();
				
				result.put("pureCombinedAmount", pureAccount);
				result.put("u_id", u_id);
				
				iUserMapper.pureRemainAccountUpdate(result);
			}	
		}
		return result3;
	}
	
	public int expenseUpdateProcedure3(ExpenditureInsertProcedure vo, String u_id){
		
		int result4=0;
		
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		HashMap<String, Object> result1 = new HashMap<String, Object> ();

		result1 = iUserMapper.emergencyExpensePrepared(u_id);
		
		Object check1 = result1.get("E_ACC");
		int emergencyAccount = Integer.parseInt(check1.toString());
		
		if(emergencyAccount>=vo.getRelevantPrice()){
			
			HashMap<String, Object> result2 = new HashMap<String, Object> ();
			emergencyAccount-=vo.getRelevantPrice();
			
			result2.put("emergencyAccount", emergencyAccount);
			result2.put("u_id", u_id);
			
			int check2 = iUserMapper.emergencyAccountUpdate(result2);
			
			if(check2==1){
				AccbookVO acc = new AccbookVO();
				acc.setU_id(u_id);
				acc.setA_date(vo.getExpenseDate());
				acc.setSub_cate("비상금");
				acc.setPayment(vo.getExpensePayment());
				acc.setA_memo(vo.getMemo());
				acc.setPrice(vo.getRelevantPrice());
				
				result4 = iUserMapper.additionalIncome2(acc);
			}
		}
		else if(emergencyAccount==0){
			return result4;
		}
		else if(emergencyAccount<vo.getRelevantPrice()){
			int exceededAmount = vo.getRelevantPrice() - emergencyAccount;
			emergencyAccount=0;
			
			HashMap<String, Object> result3 = new HashMap<String, Object> ();
			result3.put("emergencyAccount", emergencyAccount);
			result3.put("u_id", u_id);
			
			int check3 = iUserMapper.emergencyAccountUpdate(result3);
			
			if(check3==1){
				AccbookVO acc2 = new AccbookVO();
				acc2.setU_id(u_id);
				acc2.setA_date(vo.getExpenseDate());
				acc2.setSub_cate("비상금");
				acc2.setPayment(vo.getExpensePayment());
				acc2.setA_memo(vo.getMemo());
				acc2.setPrice(vo.getRelevantPrice()-exceededAmount);
				
				int result3_2 = iUserMapper.additionalIncome2(acc2);
				
				if(result3_2==1){
					HashMap<String, Object> result3_3 = new HashMap<String, Object> ();
					result3_3=iUserMapper.emergencyExpensePrepared(u_id);
					
					Object check = result3_3.get("P_ACC");
					int pureAccount = Integer.parseInt(check.toString());
					
					pureAccount-=exceededAmount;
					
					result3_3.put("pureCombinedAmount", pureAccount);
					result3_3.put("u_id", u_id);
					
					result4=iUserMapper.pureRemainAccountUpdate(result3_3);
					
					if(result4==1){
						AccbookVO acc3 = new AccbookVO();
						acc3.setU_id(u_id);
						acc3.setA_date(vo.getExpenseDate());
						acc3.setSub_cate("순수잔여");
						acc3.setPayment(vo.getExpensePayment());
						acc3.setA_memo(vo.getMemo());
						acc3.setPrice(exceededAmount);
						
						iUserMapper.additionalIncome2(acc3);
					}
				}
			}
		}
		return result4;
	}
	
	public int expenseUpdateProcedure4(ExpenditureInsertProcedure vo, String u_id){
		
		int result5=0;
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		HashMap<String, Object> result1 = new HashMap<String, Object> ();
		
		result1 = iUserMapper.emergencyExpensePrepared(u_id);
		Object check1 = result1.get("A_ACC");
		int annualAccount = Integer.parseInt(check1.toString());
		
		if(vo.getRelevantPrice()<=annualAccount){
			annualAccount-=vo.getRelevantPrice();
			result1.put("annualAccount", annualAccount);
			result1.put("u_id", u_id);
			
			result5=iUserMapper.annualAccountUpdate(result1);
		}
		else if(vo.getRelevantPrice()>annualAccount || annualAccount==0){
			return result5;
		}
		
		return result5;
	}
	
	public int expenseUpdateProcedure5(ExpenditureInsertProcedure vo, String u_id){
		
		int result6=0;
		IUserMapper iUserMapper = sqlSession.getMapper(IUserMapper.class);
		
		AccbookVO accVO = new AccbookVO();
		accVO.setA_date(vo.getExpenseDate());
		accVO.setU_id(u_id);
		accVO.setA_memo(vo.getMemo());
		accVO.setPayment(vo.getExpensePayment());
		accVO.setPrice(vo.getRelevantPrice());
		accVO.setSub_cate(vo.getSubCategory());
		
		result6=iUserMapper.additionalIncome2(accVO);
		
		if(result6==1){
			HashMap<String, Object> result = new HashMap<String, Object> ();
			result=iUserMapper.emergencyExpensePrepared(u_id);
			
			Object check = result.get("P_ACC");
			int pureAccount = Integer.parseInt(check.toString());
			pureAccount-=accVO.getPrice();
			
			result.put("pureCombinedAmount", pureAccount);
			result.put("u_id", u_id);
			
			iUserMapper.pureRemainAccountUpdate(result);
		}
		
		return result6;
	}
}