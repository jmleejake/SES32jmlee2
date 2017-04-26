package global.sesoc.project2.msm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); 
		Calendar cal = Calendar.getInstance(); 
		cal.add(cal.MONTH, -1); 
		String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
		int lastDay=cal.getMaximum(Calendar.DAY_OF_MONTH); // 마지막 날짜
		String today = dateFormat.format(date).substring(6,8);
		int todayInt = Integer.parseInt(today); // 오늘 날짜
		
		ArrayList<AccbookVO> accList = new ArrayList<AccbookVO>();
		ArrayList<AccbookVO> accList2 = new ArrayList<AccbookVO>();
		
		accList=dao.releaseList1(id, beforeMonth);
		accList2=dao.releaseList1(id, month);
		
		int income1=dao.checkIncome1(accList); // 지난 달 내역에 대한 고정 수입
		
		int income2=dao.checkIncome2(accList, income1); // (지난달 내역 內) 고정 수입 총 액수 - 고정지출 총 액수 = 가처분 소득
		
		int expense1= dao.checkExpense1(accList); // 지난달 변동 지출 총 액수
		
		int expense3 = dao.checkExpense1(accList2); // 이번달 변동 지출 총 액수
		
		int income3=dao.checkIncome3(id); // 사용자 회원 계정에 누적된 현재 비상금 액수
		
		int expense2 = dao.checkExpense2(id, beforeMonth); // 생활 적정 금액 산정
		
		int remainCheck=dao.remainCheckProcedure(id); // 총 잔여 금액(=전체 수입 - 전체 지출 - 현재 누적 비상금 액수)
		
		session.setAttribute("UsableIncome", income2);
		session.setAttribute("floatingExpense", expense1);
		session.setAttribute("floatingExpense2", expense3);
		session.setAttribute("currentEmergency", income3);
		session.setAttribute("reasonableExpense", expense2);
		session.setAttribute("pureRemain", remainCheck);
		
		if(lastDay==todayInt){
			String alertMessage=dao.rangeCheck_1(accList2, income2);
			session.setAttribute("alertMessage", alertMessage);
		}
		
		return "newhome2";
	}
	
	@RequestMapping(value = "newhome3", method = RequestMethod.GET)
	public String newhome3(HttpSession session) {
		
		String id = (String) session.getAttribute("loginID");
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM"); 
		Calendar cal = Calendar.getInstance(); 
		cal.add(cal.MONTH, -1); 
		String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
		
		ArrayList<AccbookVO> accList = new ArrayList<AccbookVO>();
		ArrayList<AccbookVO> accList2 = new ArrayList<AccbookVO>();
		
		accList=dao.releaseList1(id, beforeMonth);
		accList2=dao.releaseList1(id, month);
		
		int income1=dao.checkIncome1(accList); // 지난 달 내역에 대한 고정 수입
		
		int income2=dao.checkIncome2(accList, income1); // (지난달 내역 內) 고정 수입 총 액수 - 고정지출 총 액수 = 가처분 소득
		
		int expense1= dao.checkExpense1(accList); // 지난달 변동 지출 총 액수
		
		int expense3 = dao.checkExpense1(accList2); // 이번달 변동 지출 총 액수
		
		int income3=dao.checkIncome3(id); // 사용자 회원 계정에 누적된 현재 비상금 액수
		
		int expense2 = dao.checkExpense2(id, beforeMonth); // 생활 적정 금액 산정
		
		int remainCheck=dao.remainCheckProcedure(id); // 총 잔여 금액(=전체 수입 - 전체 지출 - 현재 누적 비상금 액수)
		
		session.setAttribute("UsableIncome", income2);
		session.setAttribute("floatingExpense", expense1);
		session.setAttribute("floatingExpense2", expense3);
		session.setAttribute("currentEmergency", income3);
		session.setAttribute("reasonableExpense", expense2);
		session.setAttribute("pureRemain", remainCheck);
		
		return "newhome3";
	}
}