package global.sesoc.project2.msm.user.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	UserDAO dao;
	
	@RequestMapping(value="mapAPI_Test", method=RequestMethod.GET)
	public String mapAPI_Test_Enter(){
		return "mapAPI/mapAPI_Test";
	}
	
	@RequestMapping(value="userPage", method=RequestMethod.GET)
	public String userPage_Enter(){
		return "user/userPage";
	}
	
	@RequestMapping(value="userInsert", method=RequestMethod.POST)
	public String user_Insert(UserVO userVO){
		
		System.out.println(userVO);
		
		dao.userInsert(userVO);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="userLogin", method=RequestMethod.POST)
	public String user_Login(String u_id, String u_pwd, HttpSession session){
		
		UserVO vo = dao.userLogin(u_id, u_pwd);
		session.setAttribute("vo", vo);
		
		System.out.println(vo);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="userLogout", method=RequestMethod.GET)
	public String user_Logout(HttpSession session){
		
		session.removeAttribute("vo");
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="userVarification", method=RequestMethod.GET)
	public String user_Varification(String u_email){
		
		String title="인증 번호";
		String message=UUID.randomUUID().toString();
		
		String varification=message.substring(0, 7);
		
		SendMail sendMail = new SendMail(u_email, title, message.substring(0, 7));
		
		return varification;
	}
	
	@RequestMapping(value="IDSearchingForm", method=RequestMethod.GET)
	public String IDSearchingForm(String varification, String email, Model model){
		
		model.addAttribute("varification", varification);
		model.addAttribute("email", email);
		
		return "user/IDSearchingForm";
	}
	
	@ResponseBody
	@RequestMapping(value="IdSearching", method=RequestMethod.POST)
	public String user_IDSearching(String u_email){
		
		System.out.println(u_email);
		
		String userID = dao.userIDSearching(u_email);
		
		System.out.println(userID);
		
		return userID;
	}
	
	@RequestMapping(value="passwordCheckForm", method=RequestMethod.GET)
	public String passwordCheckForm(){
		
		return "user/passwordCheckForm";
	}
	
	@ResponseBody
	@RequestMapping(value="pwdVarification1", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String pwdVarification(String u_id, String u_name, String u_email){
		
		String user_email = dao.userPWSearching(u_id, u_name, u_email);
		
		System.out.println(user_email);
		
		String title="임시 비밀번호";
		String tPassword=UUID.randomUUID().toString();
		
		SendMail sendMail = new SendMail(user_email, title, tPassword.substring(0, 7));
		
		int i= dao.userPWChangingTemporary(u_id, tPassword.substring(0, 7));
		
		System.out.println(i);
		
		return "임시 비밀번호는 이메일로 전송 확인 부탁드립니다.";
	}
	
	@RequestMapping(value="pwdVarification2", method=RequestMethod.POST)
	public String pwdModification(String id, String newPassword, HttpSession session){
		
		int result=dao.userPWModification(id, newPassword);
		
		if(result==1){
			session.setAttribute("loginID", id);
		}
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public String idCheck(String u_id){
		
		System.out.println(u_id);
		
		String result=dao.idCheck(u_id);
		
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value="userUpdate", method=RequestMethod.POST)
	public String userUpdate(UserVO vo){
		
		System.out.println(vo);
		
		int result=dao.userUpdate(vo);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="userDelete", method=RequestMethod.POST)
	public void userUpdate(String u_id, HttpSession session){
		
		System.out.println(u_id);
		
		int result = dao.deleteUser(u_id);
		
		if(result==1){
			session.removeAttribute("loginID");
		}
	}
}