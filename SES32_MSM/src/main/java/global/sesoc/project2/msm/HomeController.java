package global.sesoc.project2.msm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.user.dao.UserDAO;
import global.sesoc.project2.msm.user.vo.UserVO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	UserDAO dao;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginnewhome() {
		logger.debug("go to login new home!");
		return "loginnewhome";
	}
	
	@RequestMapping(value = "newhome2", method = RequestMethod.GET)
	public String newhome2() {
		logger.debug("go to login new home!");
		return "newhome2";
	}
	
	@RequestMapping(value = "newhome", method = RequestMethod.GET)
	public String newhome(HttpSession session) {
		
		String id = (String) session.getAttribute("loginID");
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		ArrayList<AccbookVO> additionalList = new ArrayList<AccbookVO>(); // 변동수입란에 넣을 데이터 리스트
		
		ArrayList<AccbookVO> accResult=dao.accList(id, month); // 이번 달에 대한 내역만을 가져오기
		session.setAttribute("accResult", accResult); // 해당 회원에 대한 MSM_ACC_BOOK 정보 읽어오기 
		
		for (AccbookVO vo2 : accResult) {
			if(vo2.getA_type().equalsIgnoreCase("INC")){
				if(vo2.getMain_cate().equals("수입")){
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
		int emergencyExpensePrepared = dao.emergencyExpensePrepared(id); // 총합 정리 내역 - 비상 지출 대비 입금 총 액수
		int remainEmergencesAccount = dao.remainEmergencesCheck(id); // 총합 정리 내역 - 비상금 적재 잔여 액수
		int pureDisposableIncomeResult = dao.pureRemainCombinedCheck(id);
		// 화면 출력 時 누적 결과값만 가져온다. - 순수 잔여 금액을 정산하는 과정은 특정 날짜의 비상지출 대비 통장 입금 및 추가 지출 때 동적으로 이루어지도록 한다.
		// 순수 잔여 금액 정산식 : 월 가처분소득 - 변동 지출 총합 - 비상 지출 대비 입금 - 개인 지정 비상금  - 특정 날짜 정산일 때 최초로 정산된 후, 수입/감소가 최종 액수에서 계산되도록 유도한다.
		
		session.setAttribute("originalIncome", fixedIncome);
		session.setAttribute("fluctuationIncome", expenditureIncomeResult-fixedIncome);
		session.setAttribute("disposableIncome", disposableIncomeResult);
		session.setAttribute("expenditureChange", expenditureExpense);
		session.setAttribute("emergencyPreparednessDeposit", emergencyExpensePrepared);
		session.setAttribute("remainEmergencesAccount", remainEmergencesAccount); 
		session.setAttribute("updateRemainingAmount", pureDisposableIncomeResult);
		
		return "newhome2";
	}
	
	@RequestMapping(value = "newhome3", method = RequestMethod.GET)
	public String newhome3(HttpSession session) {
		
		String id = (String) session.getAttribute("loginID");
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		ArrayList<AccbookVO> additionalList = new ArrayList<AccbookVO>(); // 변동수입란에 넣을 데이터 리스트
		
		ArrayList<AccbookVO> accResult=dao.accList(id, month); // 이번 달에 대한 내역만을 가져오기
		session.setAttribute("accResult", accResult); // 해당 회원에 대한 MSM_ACC_BOOK 정보 읽어오기 
		
		for (AccbookVO vo2 : accResult) {
			if(vo2.getA_type().equalsIgnoreCase("INC")){
				if(vo2.getMain_cate().equals("수입")){
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
		int emergencyExpensePrepared = dao.emergencyExpensePrepared(id); // 총합 정리 내역 - 비상 지출 대비 입금 총 액수
		int remainEmergencesAccount = dao.remainEmergencesCheck(id); // 총합 정리 내역 - 비상금 적재 잔여 액수
		int pureDisposableIncomeResult = dao.pureRemainCombinedCheck(id);
		// 화면 출력 時 누적 결과값만 가져온다. - 순수 잔여 금액을 정산하는 과정은 특정 날짜의 비상지출 대비 통장 입금 및 추가 지출 때 동적으로 이루어지도록 한다.
		// 순수 잔여 금액 정산식 : 월 가처분소득 - 변동 지출 총합 - 비상 지출 대비 입금 - 개인 지정 비상금  - 특정 날짜 정산일 때 최초로 정산된 후, 수입/감소가 최종 액수에서 계산되도록 유도한다.
		
		session.setAttribute("originalIncome", fixedIncome);
		session.setAttribute("fluctuationIncome", expenditureIncomeResult-fixedIncome);
		session.setAttribute("disposableIncome", disposableIncomeResult);
		session.setAttribute("expenditureChange", expenditureExpense);
		session.setAttribute("emergencyPreparednessDeposit", emergencyExpensePrepared);
		session.setAttribute("remainEmergencesAccount", remainEmergencesAccount); 
		session.setAttribute("updateRemainingAmount", pureDisposableIncomeResult);
		
		return "newhome3";
	}
}