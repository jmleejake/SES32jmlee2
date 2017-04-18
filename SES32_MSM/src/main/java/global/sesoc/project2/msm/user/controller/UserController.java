package global.sesoc.project2.msm.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.user.dao.UserDAO;
import global.sesoc.project2.msm.user.vo.UserVO;
import global.sesoc.project2.msm.util.EmergencyExpense;
import global.sesoc.project2.msm.util.ExpenditureChangeProcedure;
import global.sesoc.project2.msm.util.ExpenditureInsertProcedure;
import global.sesoc.project2.msm.util.SendMail;

/**
 * 유저 컨트롤러
 * @author KIM TAE HEE
 */
@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	UserDAO dao;
	
	@RequestMapping(value="loginPage", method=RequestMethod.GET)
	public String loginPage_Enter(){
		return "user/loginPage";
	}
	
	@RequestMapping(value="mapAPI_Test", method=RequestMethod.GET)
	public String mapAPI_Test_Enter(){
		return "mapAPI/mapAPI_Test";
	}
	
	@RequestMapping(value="calculator", method=RequestMethod.GET)
	public String calculator(){
		return "user/calculator";
	}
	
	@ResponseBody
	@RequestMapping(value="userInsert", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Insert(UserVO userVO){
		
		int result =dao.userInsert(userVO);
		
		if(result==1){
			return "회원가입 완료되었습니다.";
		}
		
		return "회원가입 중 오류가 발생했습니다.";
	}
	
	@RequestMapping(value="userLogin", method=RequestMethod.POST)
	public String user_Login(String u_id, String u_pwd, HttpSession session){
		
		UserVO vo = dao.userLogin(u_id, u_pwd);
		
		if(vo==null){
			return "user/loginPage";
		}
		
		session.setAttribute("loginID", vo.getU_id());
		session.setAttribute("vo", vo);
		
		String varification = (String) session.getAttribute("varification2");
		
		if(varification!=null){
			return "user/loginPage";
		}
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		ArrayList<AccbookVO> additionalList = new ArrayList<AccbookVO>(); // 변동수입란에 넣을 데이터 리스트
		
		ArrayList<AccbookVO> accResult=dao.accList(vo.getU_id(), month); // 이번 달에 대한 내역만을 가져오기
		session.setAttribute("accResult", accResult); // 해당 회원에 대한 MSM_ACC_BOOK 정보 읽어오기 
		
		for (AccbookVO vo2 : accResult) {
			if(vo2.getA_type().equalsIgnoreCase("in")){
				if(vo2.getMain_cate().equals("변동수입")){
					additionalList.add(vo2);
				}	
			}
		}
		
		if(additionalList!=null){
			session.setAttribute("additionalList", additionalList); // 세션에 데이터 리스트를 담아 화면에 모두 출력하도록 한다.
		}
		
		int fixedIncome = dao.originalIncomeCheck(accResult); // 총합 정리 내역 - 월 고정 수입란
		int expenditureIncomeResult=dao.originalIncomeCheck2(accResult, fixedIncome); // 총합 정리 내역 - 월 변동 수입 총합란 
		int disposableIncomeResult = dao.origianlIncomeCheck3(accResult, fixedIncome); // 총합 정리 내역- 월 가처분소득란
		int realSavingsResult = dao.origianlIncomeCheck4(accResult, disposableIncomeResult);
		int expenditureExpense = disposableIncomeResult-realSavingsResult;// 총합 정리 내역 - 월 변동 지출 총합란
		int emergencyExpensePrepared = dao.emergencyExpensePrepared(vo.getU_id()); // 총합 정리 내역 - 비상 지출 대비 입금 총 액수
		int remainEmergencesAccount = dao.remainEmergencesCheck(vo.getU_id()); // 총합 정리 내역 - 비상금 적재 잔여 액수
		int pureDisposableIncomeResult = dao.pureRemainCombinedCheck(vo.getU_id());
		// 화면 출력 時 누적 결과값만 가져온다. - 순수 잔여 금액을 정산하는 과정은 특정 날짜의 비상지출 대비 통장 입금 및 추가 지출 때 동적으로 이루어지도록 한다.
		// 순수 잔여 금액 정산식 : 월 가처분소득 - 변동 지출 총합 - 비상 지출 대비 입금 - 개인 지정 비상금  - 특정 날짜 정산일 때 최초로 정산된 후, 수입/감소가 최종 액수에서 계산되도록 유도한다.
		
		session.setAttribute("originalIncome", fixedIncome);
		session.setAttribute("fluctuationIncome", expenditureIncomeResult-fixedIncome);
		session.setAttribute("disposableIncome", disposableIncomeResult);
		session.setAttribute("expenditureChange", expenditureExpense);
		session.setAttribute("emergencyPreparednessDeposit", emergencyExpensePrepared);
		session.setAttribute("remainEmergencesAccount", remainEmergencesAccount); 
		session.setAttribute("updateRemainingAmount", pureDisposableIncomeResult);
		
		return "redirect:/newhome";
	}
	
	@RequestMapping(value="userLogout", method=RequestMethod.GET)
	public String user_Logout(HttpSession session){
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="userVarification", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Varification(String u_email, HttpSession session){
		
		String title="인증 번호";
		String message=UUID.randomUUID().toString();
		String varification=message.substring(0, 7);
		
		SendMail sendMail = new SendMail(u_email, title, message.substring(0, 7));
		
		session.setAttribute("varification", varification);
		session.setAttribute("email", u_email);
		
		return "이메일에서 인증번호를 확인하시고, 다시 아이디 찾기를 확인하십시오.";
	}
	
	@ResponseBody
	@RequestMapping(value="IdSearching", method=RequestMethod.POST)
	public String user_IDSearching(String u_email, String check){
		
		String userID = dao.userIDSearching(u_email);
		return userID;
	}
	
	@ResponseBody
	@RequestMapping(value="pwdVarification1", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String pwdVarification(String u_id, String u_name, String u_email, HttpSession session){
		
		String user_email = dao.userPWSearching(u_id, u_name, u_email);
		
		String title="임시 비밀번호";
		String tPassword=UUID.randomUUID().toString();
		
		SendMail sendMail = new SendMail(user_email, title, tPassword.substring(0, 7));
		
		int i= dao.userPWChangingTemporary(u_id, tPassword.substring(0, 7));
		
		if(i==1){
			session.setAttribute("varification2", tPassword);
			return "임시 비밀번호는 이메일로 전송 확인 부탁드립니다.";
		}
		return "회원 정보를 정확히 입력하여 주십시오.";
	}
	
	@RequestMapping(value="pwdVarification2", method=RequestMethod.POST)
	public String pwdModification(String check_id, String renew_pwd, HttpSession session){
		
		int result=dao.userPWModification(check_id, renew_pwd);
		
		if(result==1){
			session.setAttribute("loginID", check_id);
		}
		else if(result==0){
			return "user/loginPage"; 
		}
		return "newhome";
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public String idCheck(String u_id){
		
		String result=dao.idCheck(u_id);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="userUpdate", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userUpdate(UserVO vo, HttpSession session){
		
		int result=dao.userUpdate(vo);
		
		if(result==1){
			session.invalidate();
			return "수정 완료하였습니다.";
		}
		return "수정 중 오류 발생하였습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value="userUpdate2", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userUpdate2(UserVO vo, HttpSession session){
		
		String u_id = (String) session.getAttribute("loginID");
		
		if(u_id!=null){
			vo.setU_id(u_id);
		}
		
		int result=dao.updateUser2(vo);
		
		if(result==1){
			return "입력 완료되었습니다.";
		}
		return "입력 중 오류가 발생하였습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value="userUpdate3", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userUpdate3(String u_id, int pureRemainMoney){
		
		int result = dao.pureRemainCombinedCheck2(pureRemainMoney, u_id);
		
		if(result==1){
			return "입력 완료되었습니다.";
		}
		
		return "입력 중 오류가 발생하였습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value="userDeleteCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userDelete1(String pwd, String email, HttpSession session){
		
		UserVO vo = (UserVO) session.getAttribute("vo");
		String passwordCheck=vo.getU_pwd();
		
		if(pwd.equals(passwordCheck)){
			String title="재확인용 비밀번호";
			String checkDelteNumber=UUID.randomUUID().toString();
			
			SendMail sendMail = new SendMail(email, title, checkDelteNumber.substring(0, 7));
			session.setAttribute("checkDelteNumber", checkDelteNumber.substring(0, 7));
			return "이메일에 전송한 인증번호를 확인하십시오.";
		}
		return "비밀번호가 일치하지 않습니다. 다시 재입력하십시오.";
	}
	
	@ResponseBody
	@RequestMapping(value="userDelete", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userDelete2(String checkDelteNumber, HttpSession session){
		
		String check = (String) session.getAttribute("checkDelteNumber");
		
		if(check.equals(checkDelteNumber)){
			String u_id = (String) session.getAttribute("loginID");
			
			int result = dao.deleteAcc(u_id);
			
			if(result==1){
				int result2 = dao.deleteUser(u_id);
			
				if(result2==1){
					session.invalidate();
					return "회원 삭제 완료되었습니다.";
				}
			}
		}
		
		return "입력 번호가 일치하지 않습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value="additionalIncome", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public EmergencyExpense additionalIncome(AccbookVO vo, HttpSession session){
		
		EmergencyExpense emergencyExpense = new EmergencyExpense();
		
		String u_id = (String) session.getAttribute("loginID");
		vo.setU_id(u_id); // 해당 회원에 대한 정보란에 입력
		int result = dao.additionalIncome(vo); // 입력한 변동 수입내역에 저장
		
		UserVO userVO = dao.voReading(u_id);
		int recentEmergencies = userVO.getU_emergences(); // 최근 설정 비상금 액수
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		int originalIncome = 0; // 저축통장에 입금해야 하는 최저 기준을 정하기 위한 고정수입
		int incomeSum = 0; // 전체 수입 액수(고정 수입+변동 수입)
		
		if(result==1){
			ArrayList<AccbookVO> result2 = dao.accList(u_id, month);
						
			originalIncome = dao.originalIncomeCheck(result2);
			
			// (1) 세션에 고정수입을 담아 페이지에서 비상지출 대비 개별 고정 지출 기준을 유동적으로 변동시켜주도록 한다.
			session.setAttribute("originalIncome", originalIncome);
			
			// 추가된 변동 수입이 합산된 전체 수입 금액(고정 수입+변동 수입)을 구한다.
			incomeSum = dao.originalIncomeCheck2(result2, originalIncome);
			
			// (2) 변동 수입 총 액수를 세션에 보관해두고 테이블에 출력하도록 하기 위함.
			session.setAttribute("fluctuationIncome", incomeSum-originalIncome);
			
			// 고정 수입에서 고정 지출을 빼서 가처분 소득액을 구한다.
			int incomeSum2 = dao.origianlIncomeCheck3(result2, originalIncome);
			
			// (3) 가처분 소득액수 출력
			session.setAttribute("disposableIncome", incomeSum2);
			
			// 가처분 소득에서 변동 지출을 빼서 실저축 가능 금액을 구한다.(변동 지출에 대한 범위 규정 및 제재기능은 다른 곳에서 진행)
			int incomeSum3 = dao.origianlIncomeCheck4(result2, incomeSum2);
			
			// (4) 변동 지출 총 액수 출력 
			session.setAttribute("expenditureChange", incomeSum2-incomeSum3);
			
			// 해당 회원에 대한 현재 저축통장, 연간 이벤트 대비 지출 통장에 입급되어 있는 금액 총합을 가져온다.
			int savingsSum = dao.emergencyExpensePrepared(u_id);
			
			// (5) 비상 지출 대비 의무 입급액 출력 
			session.setAttribute("emergencyPreparednessDeposit", savingsSum);
			
			// 현재까지 누적된 잔여금액을 기초로 하여 가져온다.
			int pureCombinedAmount = dao.pureRemainCombinedCheck(u_id);
			
			// 변동 수입을 잔여 액수에 지속적으로 누적시킨다.
			pureCombinedAmount+=vo.getPrice();
			
			int updateResult = dao.pureRemainCombinedCheck2(pureCombinedAmount, u_id);
			
			if(updateResult==1){
			// (6) 순수 잔여 액수 출력
				session.setAttribute("updateRemainingAmount", pureCombinedAmount);
			}
			
			// util 패키지로 별도로 생성된 객체로 받아내어 json 객체로 전송한다 (매월 특정한 날짜에 저축통장, 연간 이벤트 대비 통장 의무 입금에 대한 처리 목적)
			emergencyExpense.setOriginalIncome(originalIncome); // 고정 수입 금액
			emergencyExpense.setDisposableIncome(incomeSum2); // 가처분 소득 금액
			emergencyExpense.setDisposableSavings(incomeSum3); // 실저축 가능 액수
			emergencyExpense.setRecentEmergencies(recentEmergencies); // 최근 비상금 설정 액수
			
			return emergencyExpense;
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value="emergencyExpense", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public EmergencyExpense emergencyExpense(int savings, int originalIncome, int disposableIncome, int recentEmergencies, HttpSession session){
		// 매개 변수 : 실저축 가능 액수, 고정 수입 액수, 가처분 소득 액수, 이전 지정 비상금 액수
		
		EmergencyExpense emergencyExpense = new EmergencyExpense();
		
		int compulsorySavingsAmount = originalIncome/10; // 의무 저축액 : 월 고정 수입의 10%
		int anualSpendingAmount = disposableIncome/12; // 연간 1회성 지출액수(1년) = 월 가처분 소득(1개월)
		
		int obligatedDepositSum = compulsorySavingsAmount + anualSpendingAmount; // 해당 날짜의 의무 입금 총액
		
		String u_id = (String) session.getAttribute("loginID");
		
		// 매월 특정한 날짜에 비상 대비 입금 時 산정된 잔여금액을 기초로 하여 가져온다.
		int pureCombinedAmount = dao.pureRemainCombinedCheck(u_id);
		
		// 매월 특정한 날짜에 행해진 정산 후 잔여금액 결과값 = 실저축 가능 액수 - 의무 입금 총액 - 이전 지정 비상금 액수
		int remainAdjustment = savings-obligatedDepositSum-recentEmergencies;
		
		// 현재까지 누적된 순수 잔여금액에서 정산 후의 잔여금액을 누적시킨다. (비상금 누적 작업은 후에 비상금 재설정으로 인해 추후 작업으로 이루어진다.)
		pureCombinedAmount = pureCombinedAmount+remainAdjustment;
		
		int result = dao.depositAccount(u_id, compulsorySavingsAmount, anualSpendingAmount, pureCombinedAmount);
		
		if(result==1){
			emergencyExpense.setPureRemaings(pureCombinedAmount); // 정산 후 누적된 순수 잔여금액
			emergencyExpense.setRecentEmergencies(recentEmergencies); // 이전 지정 비상금 액수
		}
		return emergencyExpense;
	}
	
	@ResponseBody
	@RequestMapping(value="expenseUpdate", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ExpenditureInsertProcedure expenseUpdate(ExpenditureChangeProcedure vo, HttpSession session){
		
		ExpenditureInsertProcedure checkResult = new ExpenditureInsertProcedure();
		checkResult.setExpenseDate(vo.getExpenseDate()); // 지출 기입 일자
		checkResult.setExpensePayment(vo.getExpensePayment()); // 결제 수단
		checkResult.setRelevantPrice(vo.getExpensePrice()); // 지출 희망 액수 (총 변동지출 누적 합계 이전의 지출 행위 자체)
		
		String alertMessage="정상적인 지출 행위 가능"; // 범위 초과에 대한 알림과 특정사항에 따른 처리 여부 전달 목적 메세지
		String [] kindsOfFixed = {"식비", "외식비", "유흥비", "유동형_보충"}; // 고정형 변동지출 해당 카테고리
		String [] kindsOfFloating = {"교통비", "생활용품", "미용", "영화", "의료비", "경조사비", "고정형_보충"}; // 유동형 변동지출 해당 카테고리
		
		checkResult.setSubCategory(vo.getExpenseSubCategory());
		checkResult.setMemo(vo.getExpenseMemo());
		
		String id = (String) session.getAttribute("loginID"); // 로그인되어 있는 아이디를 가져오기
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM"); 
		Calendar cal = Calendar.getInstance(); 
		cal.add(cal.MONTH,-1); 
		String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6); 
		int monthInt = Integer.parseInt(month);

		// 지난 달에 대한 리스트를 모두 가져오기
		ArrayList<AccbookVO> accResult=dao.accList(id, beforeMonth);
		
		// (1) 이번 달 변동 지출 허용 전체 범위 = 지난 달 변동 지출 총 액수의 3% 내외(초과 범위에 대해서만 규제) ex) 388,207원
		int allowedExpenseRange = dao.rangeDesignation(accResult, monthInt); 
		checkResult.setAllowedExpenseRange(allowedExpenseRange);
		
		// 이번 달에 대한 리스트를 모두 가져오기
		ArrayList<AccbookVO> accResult2=dao.accList(id, month);
		
		// (2) 이번달 고정적인 변동 지출 허용 범위  ex) 312,620원
		int fixedExpenseRange = dao.checkVariableExpense(accResult2);
		checkResult.setFixedExpenseRange(fixedExpenseRange);
		
		// (3) 이번달 유동적인 변동 지출 허용 범위  ex) 234,465원
		int floatingExpenseRange = dao.checkVariableExpense2(accResult2);
		checkResult.setFloatingExpenseRange(floatingExpenseRange);
		
		// (4) 이번달 내 현재까지 행해진 고정적인 변동 지출의 총 합계 액수를 구한다.(추가 기입 지출 내역 저장 前) ex) 247,340원
		int fixedExpenseSum = dao.checkVariableExpense3(accResult2);
		checkResult.setFixedExpenseSum(fixedExpenseSum);
		
		// (5) 이번달 내 현재까지 행해진 유동적인 변동 지출의 총 합계 액수를 구한다.(추가 기입 지출 내역 저장 前) ex) 38,300원
		int floatingExpenseSum = dao.checkVariableExpense4(accResult2); 
		checkResult.setFloatingExpenseSum(floatingExpenseSum);
		
		// 상단에 정의된 카테고리 배열에 해당되는 항목에 따라 (4)와 (5)에 누적시킨다.(추가 기입 지출 내역 저장 前)
		for(int i=0; i<kindsOfFixed.length; i++){
			if(vo.getExpenseSubCategory().equals(kindsOfFixed[i])){
				if(vo.getExpenseMemo().equals("회식")){
					
					alertMessage="(D) 회식은 개인 비상금으로 지출됩니다.";
					checkResult.setAlertMessage(alertMessage);
					return checkResult;
				}
				fixedExpenseSum+=vo.getExpensePrice();
				checkResult.setFixedExpenseSum(fixedExpenseSum);
			}
		}
			
		for(int j=0; j<kindsOfFloating.length; j++){
			if(vo.getExpenseSubCategory().equals(kindsOfFloating[j])){
				if(vo.getExpenseSubCategory().equals("경조사비")){
					
					alertMessage="(E) 예정되어 있지 않은 경조사에 대한 비용은 비상 지출 대비 통장에서 출금됩니다.";
					// 경조사비에 대해서는 특별 취급을 하여 이번달 허용 지출 액수가 초과되더라도 비상대비 입금 통장에서 출금하여 보충할 수 있다.
					// 먼저 연간 이벤트 지출 통장(비상금 제외)에서 출금한다.
					// 연간 이벤트 지출 통장으로도 보충할 수 없으면, 그 잔여금액은 저축통장으로 출금하도록 한다.
					checkResult.setAlertMessage(alertMessage);
					return checkResult;
				}
				floatingExpenseSum+=vo.getExpensePrice();
				checkResult.setFixedExpenseSum(fixedExpenseSum);
			}
		}
	
		
		// (1) ~ (5) 값들을 가지고 페이지에 보낼 메세지의 종류를 결정하여 규정 범위에 따라 지출 행위를 규제한다.
		if(allowedExpenseRange<fixedExpenseSum+floatingExpenseSum){
			alertMessage="(A) 이번달 허용 지출 액수는 모두 소진되었습니다. 더 이상의 지출 활동은 불가능합니다.";
			checkResult.setAlertMessage(alertMessage);
			
			return checkResult;
		}
		
		// <1> 고정형 변동 지출 허용 범위를 초과 時에 대한 처리 여부 결정 
		if(fixedExpenseSum>fixedExpenseRange){
			int exceededAmount = fixedExpenseSum-fixedExpenseRange; // 고정형 변동 지출 범위에서 초과된 금액
			
			if(fixedExpenseSum + floatingExpenseSum < allowedExpenseRange){ // 초과된 고정형 변동 지출과 현재 누적된 유동형 변동 지출의 합계 < 전체 허용 범위
				int usableRemainAmount = allowedExpenseRange - fixedExpenseRange + floatingExpenseSum; // 전체 허용 범위 내 사용 가능 금액
				                                             // 고정형 변동 지출 규정 범위 + 현 유동형 변동 누적 합계 지출
				if(usableRemainAmount>exceededAmount){
					alertMessage="(B) 고정형 변동 지출 범위 초과, 유동형 변동 지출 보충 가능.";
					checkResult.setAlertMessage(alertMessage);
					return checkResult;
				}
			}
			alertMessage="(A) 이번달 허용 지출 액수는 모두 소진되었습니다. 더 이상의 지출 활동은 불가능합니다.";
			checkResult.setAlertMessage(alertMessage);
			return checkResult;
		}
		
		// <2> 유동형 변동 지출 허용 범위를 초과 時에 대한 처리 여부 결정 
		if(floatingExpenseSum>floatingExpenseRange){
			int exceededAmount = floatingExpenseSum-floatingExpenseRange; // 유동형 변동 지출 범위에서 초과된 금액
					
			if(fixedExpenseSum + floatingExpenseSum < allowedExpenseRange){ // 초과된 유동형 변동 지출과 현재 누적된 유동형 변동 지출의 합계 < 전체 허용 범위
				int usableRemainAmount = allowedExpenseRange - floatingExpenseRange + fixedExpenseSum; // 전체 허용 범위 내 사용 가능 금액
						
				if(usableRemainAmount>exceededAmount){
					alertMessage="(C) 유동형 변동 지출 범위 초과, 고정형 변동 지출 보충 가능.";
					checkResult.setAlertMessage(alertMessage);
					return checkResult;
				}
			}		
			alertMessage="(A) 이번달 허용 지출 액수는 모두 소진되었습니다. 더 이상의 지출 활동은 불가능합니다.";
			checkResult.setAlertMessage(alertMessage);
			return checkResult;
		}
		
		alertMessage="(F) 정상적인 지출 행위가 가능합니다.";
		checkResult.setAlertMessage(alertMessage);
		return checkResult;
	}
	
	@ResponseBody
	@RequestMapping(value="expenseUpdate2", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String expenseUpdate2(ExpenditureInsertProcedure vo, HttpSession session){

		String result=null;
		
		String u_id=(String) session.getAttribute("loginID");
		
		String check = vo.getAlertMessage().substring(0, 3);
		
		if(check.equalsIgnoreCase("(B)")){
			int result2 = dao.expenseUpdateProcedure1(vo, u_id);
			result=Integer.toString(result2);
		}
		
		else if(check.equalsIgnoreCase("(C)")){
			int result3 = dao.expenseUpdateProcedure2(vo, u_id);
			result=Integer.toString(result3);
		}
		else if(check.equalsIgnoreCase("(D)")){
			int result4 = dao.expenseUpdateProcedure3(vo, u_id);
			result=Integer.toString(result4);
		}
		else if(check.equalsIgnoreCase("(E)")){
			int result5 = dao.expenseUpdateProcedure4(vo, u_id);
			result=Integer.toString(result5);
		}
		else if(check.equalsIgnoreCase("(F)")){
			int result6 = dao.expenseUpdateProcedure5(vo, u_id);
			result=Integer.toString(result6);
		}
		return result;
	}
}