package global.sesoc.project2.msm.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.user.dao.UserDAO;
import global.sesoc.project2.msm.user.vo.UserVO;
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
		
		String id = (String) session.getAttribute("loginID");
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		if(id==null){
			return "user/loginPage";
		}
		
		ArrayList<AccbookVO> accResult=dao.accList(id, month);
		session.setAttribute("accResult", accResult);
		
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
		
		int result=dao.updateUser2(u_emergences);
		session.setAttribute("u_emergences", u_emergences);
		
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
	public String additionalIncome(AccbookVO vo, HttpSession session){
		
		String u_id = (String) session.getAttribute("loginID");
		vo.setU_id(u_id);
		int result = dao.additionalIncome(vo);
		
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		int originalIncome = 0; // 저축통장에 입금해야 하는 최저 기준을 정하기 위한 고정수입
		int incomeSum = 0;
		
		if(result==1){
			ArrayList<AccbookVO> result2 = dao.accList(u_id, month);
			
			originalIncome = dao.originalIncomeCheck(result2);
			System.out.println(originalIncome);
			
			// 세션에 고정수입을 담아 페이지에서 비상지출 대비 개별 고정 지출 기준을 유동적으로 변동시켜주도록 한다.
			session.setAttribute("originalIncome", originalIncome);
			
			/*
			
			// 추가된 변동 수입을 고정수입에 합산시킨다.
			for(int i=0; i<result2.size(); i++){
				if(result2.get(i).getA_type().equals(in)){
					incomeSum+=result2.get(i).getPrice();
				}
			}
			
			// 전체 수입에서 고정 지출을 빼서 가처분 소득액을 구한다.
			for(int i=0; i<result2.size(); i++){
				if(result2.get(i).getA_type().equals(out)){
					if(result2.get(i).getMain_cate().equals("고정지출")){
						incomeSum-=result2.get(i).getPrice();
					}
				}
			}
			
			// 전체 수입에서 변동 지출을 빼서 실저축 금액을 구한다.(변동 지출에 대한 범위 규정 및 제재기능은 다른 곳에서 진행)
			for(int i=0; i<result2.size(); i++){
				if(result2.get(i).getA_type().equals(out)){
					if(result2.get(i).getMain_cate().equals("변동지출")){
						incomeSum-=result2.get(i).getPrice();
					}
				}
			}*/
			
			// 세션에 실저축 가능 액수를 저장하여 페이지에서 저축 및 연간지출 통장 출금 후의 비상금 액수를 산정하도록 한다.
			session.setAttribute("incomeSum", incomeSum);
			
			return "추가 수입에 대한 처리가 완료되었습니다.";
		}
		return "데이터 저장 중 오류가 발생하였습니다.";
	}
}