package global.sesoc.project2.msm.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
	
	@RequestMapping(value="householdAccount", method=RequestMethod.GET)
	public String householdAccount(HttpSession session){
		
		String id = (String) session.getAttribute("loginID"); // 로그인되어 있는 아이디를 가져오기
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		ArrayList<AccbookVO> additionalList = new ArrayList<AccbookVO>(); // 변동수입란에 넣을 데이터 리스트
		
		if(id==null){
			return "user/loginPage";
		}
		
		ArrayList<AccbookVO> accResult=dao.accList(id, month); // 이번 달에 대한 내역만을 가져오기
		session.setAttribute("accResult", accResult); // 해당 회원에 대한 MSM_ACC_BOOK 정보 읽어오기 
		
		for (AccbookVO vo : accResult) {
			if(vo.getA_type().equalsIgnoreCase("in")){
				if(vo.getMain_cate().equals("변동수입")){
					additionalList.add(vo);
				}	
			}
		}
		
		if(additionalList!=null){
			session.setAttribute("additionalList", additionalList); // 세션에 데이터 리스트를 담아 화면에 모두 출력하도록 한다.
		}
		
		int fixedIncome = dao.originalIncomeCheck(accResult); // 총합 정리 내역 - 월 고정 수입란
		int expenditureIncomeResult=dao.originalIncomeCheck2(accResult, fixedIncome); // 총합 정리 내역 - 월 변동 수입 총합란 
		int disposableIncomeResult = dao.origianlIncomeCheck3(accResult, expenditureIncomeResult); // 총합 정리 내역- 월 가처분소득란
		int realSavingsResult = dao.origianlIncomeCheck4(accResult, disposableIncomeResult);
		int expenditureExpense = disposableIncomeResult-realSavingsResult;// 총합 정리 내역 - 월 변동 지출 총합란
		
		int emergencyExpensePrepared = dao.emergencyExpensePrepared(id); // 총합 정리 내역 - 비상 지출 대비 입금 총 액수
		
		UserVO vo =  dao.voReading(id);
		int emergencyPersonal = vo.getU_emergences(); // 총합 정리 내역 - 개인 지정 비상금 액수
		
		int pureDisposableIncomeResult = disposableIncomeResult-expenditureExpense-emergencyExpensePrepared-emergencyPersonal;
		// 총합 정리 내역 - 순수 잔여금액(월 가처분소득 - 변동 지출 총합 - 비상 지출 대비 입금 - 개인 지정 비상금)
		
		session.setAttribute("originalIncome", fixedIncome);
		session.setAttribute("fluctuationIncome", expenditureIncomeResult-fixedIncome);
		session.setAttribute("disposableIncome", disposableIncomeResult);
		session.setAttribute("expenditureChange", expenditureExpense);
		session.setAttribute("emergencyPreparednessDeposit", emergencyExpensePrepared);
		session.setAttribute("newEmergencies", emergencyPersonal);
		session.setAttribute("updateRemainingAmount", pureDisposableIncomeResult);
		
		return "user/householdAccount";
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
		
		return "redirect:/";
	}
	
	@RequestMapping(value="userLogout", method=RequestMethod.GET)
	public String user_Logout(HttpSession session){
		
		session.invalidate();
		
		return "user/loginPage";
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
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public String idCheck(String u_id){
		
		String result=dao.idCheck(u_id);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="userUpdate", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userUpdate(UserVO vo){
		
		int result=dao.userUpdate(vo);
		
		if(result==1){
			return "수정 완료하였습니다.";
		}
		return "수정 중 오류 발생하였습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value="userUpdate2", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userUpdate2(int u_emergences, HttpSession session){
		
		String u_id = (String) session.getAttribute("loginID");
		
		UserVO vo = new UserVO();	
		vo.setU_id(u_id);
		vo.setU_emergences(u_emergences);
		
		int result=dao.updateUser2(vo);
		
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
	public String userDelete2(HttpSession session){
		
		String u_id = (String) session.getAttribute("loginID");
		int result = dao.deleteUser(u_id);
		
		if(result==1){
			session.invalidate();
			return "회원 삭제 완료되었습니다.";
		}
		return "삭제 도중 오류 발생되었습니다.";
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
			
			// (1) 세션에 고정수입을 담아 페이지에서 비상지출 대비 개별 고정 지출 기준을 유동적으로 변동시켜주도록 한다. (2,000,000원)
			session.setAttribute("originalIncome", originalIncome);
			
			// 추가된 변동 수입이 합산된 전체 수입 금액(고정 수입+변동 수입)을 구한다. (변동 수입 100,000원 추가 시, 2,100,000원)
			incomeSum = dao.originalIncomeCheck2(result2, originalIncome);
			
			// (2) 변동 수입 총 액수를 세션에 보관해두고 테이블에 출력하도록 하기 위함.
			session.setAttribute("fluctuationIncome", incomeSum-originalIncome);
			
			// 전체 수입에서 고정 지출을 빼서 가처분 소득액을 구한다.
			int incomeSum2 = dao.origianlIncomeCheck3(result2, incomeSum);
			
			// (3) 가처분 소득액수 출력
			session.setAttribute("disposableIncome", incomeSum2);
			
			// 가처분 소득에서 변동 지출을 빼서 실저축 가능 금액을 구한다.(변동 지출에 대한 범위 규정 및 제재기능은 다른 곳에서 진행)
			int incomeSum3 = dao.origianlIncomeCheck4(result2, incomeSum2);
			
			// (4) 변동 지출 총 액수 출력  354,640원
			session.setAttribute("expenditureChange", incomeSum2-incomeSum3);
			
			// 해당 회원에 대한 현재 저축통장, 연간 이벤트 대비 지출 통장에 입급되어 있는 금액 총합을 가져온다.
			int savingsSum = dao.emergencyExpensePrepared(u_id);
			
			// (5) 비상 지출 대비 의무 입급액 출력 
			session.setAttribute("emergencyPreparednessDeposit", savingsSum);
			
			// (6) 최근 지정 비상금 액수 출력 
			session.setAttribute("newEmergencies", recentEmergencies);
			
			// 실저축 가능 액수에서 비상대비 의무 입금액과 최근 지정 비상금을 빼서 순수 잔여금액을 구한다.
			int pureCombinedAmount = incomeSum3-savingsSum-recentEmergencies;
			
			// (7) 순수 잔여 액수 출력
			session.setAttribute("updateRemainingAmount", pureCombinedAmount);
			
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
	public EmergencyExpense emergencyExpense(int savings, int originalIncome, int disposableIncome, HttpSession session){
		// 매개 변수 : 실저축 가능 액수, 고정 수입 액수, 가처분 소득 액수
		
		EmergencyExpense emergencyExpense = new EmergencyExpense();
		
		int compulsorySavingsAmount = originalIncome/10; // 의무 저축액 : 월 고정 수입의 10%
		int anualSpendingAmount = disposableIncome/12; // 연간 1회성 지출액수(1년) = 월 가처분 소득(1개월)
		
		String u_id = (String) session.getAttribute("loginID");
		UserVO vo = dao.voReading(u_id);
		
		int result = dao.depositAccount(u_id, compulsorySavingsAmount, anualSpendingAmount);
		
		if(result==1){
			int emergences = vo.getU_emergences(); // 회원가입 초기 또는 회원이 도중에 갱신한 비상금액

			savings-=compulsorySavingsAmount; // 의무 저축액 출금(입금형 고정 지출)
			savings-=anualSpendingAmount; // 비상 대비 지출액 출금(입금형 고정 지출)
			savings-=emergences; // 비상 대비 지축액 출금(비상금 및 입금형 고정 지출) > 연간 1회성 지출의 합계 : 연간 1회성 지출 대비 입금 + 비상금 입금
		
			emergencyExpense.setPureRemaings(savings);
			emergencyExpense.setRecentEmergencies(emergences);
		}
		return emergencyExpense;
	}
}