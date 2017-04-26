package global.sesoc.project2.msm.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
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
	
	Logger log = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value="loginPage", method=RequestMethod.GET)
	public String loginPage_Enter(){
		return "user/loginPage";
	}
	
	@RequestMapping(value="mapAPI_Test3", method=RequestMethod.GET)
	public String mapAPI_Test_Enter3(
			Model model
			, @RequestParam(value="opener_type", defaultValue="tar")String type){
		model.addAttribute("opener_type", type);
		log.debug("type = {}", type);
		return "mapAPI/mapAPI_Test3";
	}
	
	@ResponseBody
	@RequestMapping(value="userInsert", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Insert(UserVO userVO, HttpSession session){
		
		int result =dao.userInsert(userVO);
		session.setAttribute("memberRegistrationCheck", "memberRegistrationCheck");
		
		if(result==1){
			return "회원가입 완료되었습니다.";
		}
		
		return "회원가입 중 오류가 발생했습니다.";
	}
	
	@RequestMapping(value="userLogout", method=RequestMethod.GET)
	public String userLogout(HttpSession session){
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="userLogin", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Login(String u_id, String u_pwd, HttpSession session){
		
		UserVO vo = dao.userLogin(u_id, u_pwd);
		
		if(vo==null){
			session.setAttribute("loginFail", "loginFail");
			return "user/loginPage";
		}
		
		session.removeAttribute("loginFail");
		session.setAttribute("loginID", vo.getU_id());
		session.setAttribute("vo", vo);
		
		String varification = (String) session.getAttribute("varification2");
		
		if(varification!=null){
			return "user/loginPage";
		}
			
		return "redirect:/newhome";
	}
	
	@RequestMapping(value="userLoginAgain", method=RequestMethod.GET)
	public String userLoginAgain(HttpSession session){
		
		String id = (String) session.getAttribute("loginID");
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		
		return "redirect:/newhome";
	}
	
	@RequestMapping(value="householdAccount", method=RequestMethod.GET)
	public String householdAccount(HttpSession session){
		
		String id = (String) session.getAttribute("loginID");
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		String day = new SimpleDateFormat("DD").format(date);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM"); 
		Calendar cal = Calendar.getInstance(); 
		cal.add(cal.MONTH, -1); 
		String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
		
		ArrayList<AccbookVO> list = new ArrayList<>();
		list=dao.emergencyExpenseList(id);
		session.setAttribute("list", list);
		
		ArrayList<AccbookVO> list2 = new ArrayList<>();
		list2=dao.emergencyExpenseList2(id);
		session.setAttribute("list2", list2);
		
		return "user/householdAccount";
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
	public String user_IDSearching(String u_email, String check, HttpSession session){
		
		session.removeAttribute("varification");
		session.removeAttribute("email");
		
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
		return "redirect:/newhome";
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
	public String userUpdate2(String u_id, int u_emergences, HttpSession session){
		
		UserVO vo = new UserVO();
		vo.setU_id(u_id);
		vo.setU_emergences(u_emergences);
		
		int result=dao.userUpdate2(vo);
		
		if(result==1){
			return "수정 완료하였습니다.";
		}
		return "수정 중 오류 발생하였습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value="userDeleteCheck", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userDeleteCheck(String pwd, String u_email, HttpSession session){
		
		String u_id = (String) session.getAttribute("loginID");
		UserVO vo = new UserVO();
		
		if(u_id==null){
			return "reject!!!";
		}
		
		vo=dao.voReading(u_id);
		
		if(!vo.getU_pwd().equals(pwd)){
			return "reject!!!";
		}
		
		String title="인증 번호";
		String message=UUID.randomUUID().toString();
		String varification=message.substring(0, 7);
		
		SendMail sendMail = new SendMail(u_email, title, message.substring(0, 7));
		
		session.setAttribute("checkNumberForDelete", varification);
		
		return "success!!!";
	}
	
	@ResponseBody
	@RequestMapping(value="userDelete", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String userDelete(String checkDelteNumber, HttpSession session){
		
		int result=0;
		
		String checkNumberForDelete = (String) session.getAttribute("checkNumberForDelete");
		String u_id = (String) session.getAttribute("loginID");
		
		if(checkDelteNumber.equals(checkNumberForDelete)){
			result = dao.deleteUser(u_id);
		}
		
		if(result==1){
			return "삭제 완료";
		}
		
		return "번호 불일치";
	}
	
	@ResponseBody
	@RequestMapping(value="emergencyChecking", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String plusEmergency(AccbookVO result, HttpSession session){
		
		String id=(String) session.getAttribute("loginID");
		result.setU_id(id);
		result.setA_type("BIS");
		
		int check= dao.insertList(result);
		
		if(check==1){
			return "수정 완료하였습니다.";
		}
		return "수정 중 오류 발생하였습니다.";
	}
}