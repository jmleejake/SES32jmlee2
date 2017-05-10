package global.sesoc.project2.msm.user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.Session;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.user.dao.UserDAO;
import global.sesoc.project2.msm.user.vo.UserVO;
import global.sesoc.project2.msm.util.SendMail;
import global.sesoc.project2.msm.util.securityUtil;

/**
 * 유저 컨트롤러
 * @author KIM TAE HEE
 */
@Controller
@RequestMapping("user")
public class UserController {
	int fail_cnt=0;
	@Autowired
	UserDAO dao;
	
	Logger log = LoggerFactory.getLogger(UserController.class);
	

	// 경조사관리/일정관리 - 장소찾기 실행시
	@RequestMapping(value="showMap", method=RequestMethod.GET)
	public String mapAPI_Test_Enter3(
			Model model
			, @RequestParam(value="opener_type", defaultValue="tar")String type){
		model.addAttribute("opener_type", type);
		log.debug("type = {}", type);
		return "mapAPI/map";
	}
	
	
	// 로그인
	@RequestMapping(value="userLogin", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Login(String u_id, String u_pwd, HttpSession session,Model model){
		
		UserVO vo = dao.userLogin(u_id, u_pwd);
		//로그인 실패
		if(vo==null){
			fail_cnt++;
			log.debug("fail_cnt :{}",fail_cnt);
			model.addAttribute("errorMsg", "로그인실패");
			return "user/loginPage";
		}
			session.setAttribute("loginID", vo.getU_id());
		
		
		
	
		return "redirect:/newhome";
	}
	
	// 아이디 존재여부
	@ResponseBody
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public String idCheck(String u_id){
		
		String result=dao.idCheck(u_id);
		return result;
	}
	
	//가입 이메일 체크
	@ResponseBody
	@RequestMapping(value="emailCheckSend", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String emailCheckSend(UserVO user){
		String email = user.getU_email();
		UserVO resultUser = dao.userIDSearch(user);
		System.out.println(resultUser);
		String check="";
		if(resultUser!=null){
			check="불가";
		}else{
			int accreditation = (int) (Math.random() * 1000000);
			check= String.valueOf(accreditation);
			String title = "[MSM] 회원가입 인증번호 발송";
			StringBuffer msg = new StringBuffer();
			msg.append("<h3> 인증번호 발송  ");
			msg.append("</h3>");
			msg.append("<hr>");
			msg.append("●");
			msg.append("인증번호 : ");
			msg.append(accreditation);
			msg.append("</h3>");
			msg.append("<hr>");
			msg.append("Sincerely SCMaster C Class 2Group");
			new SendMail(email, title, msg.toString());
		}

		return check;
		
	}
	
	//로그인페이지 이동
	@RequestMapping(value="loginPage", method=RequestMethod.GET)
	public String loginPage_Enter(){
		return "user/loginPage";
	}
	
	//회원등록
	@RequestMapping(value="userInsert", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Insert(UserVO userVO, Model model) {

				userVO.setU_pwd(securityUtil.checkData(userVO.getU_pwd()));
				userVO.setU_name(securityUtil.checkData(userVO.getU_name()));
				userVO.setU_address(securityUtil.checkData(userVO.getU_address()));
				
				int result =dao.userInsert(userVO);
		
		System.out.println(userVO);
		
		if(result==1){
			model.addAttribute("errorMsg", "등록성공");
		}else{
			model.addAttribute("errorMsg", "등록실패");
		}
		return "user/loginPage";
	}
	
	//로그아웃
	@RequestMapping(value="userLogout", method=RequestMethod.GET)
	public String userLogout(HttpSession session){
		session.removeAttribute("loginID");
		
		return "redirect:/";
	}
	
	//ID 찾기 (이름,이메일로 검색 후 있을시 메일 발송)
	@RequestMapping(value="userIDSearch", method=RequestMethod.POST)
	public String userIDSearch(UserVO user ,Model model){
		
		UserVO result = dao.userIDSearch(user);
		
		//있는 경우
		if(result !=null){
			model.addAttribute("errorMsg", "검색성공");
			String title = "[MSM] ID 찾기";
			StringBuffer msg = new StringBuffer();
			String email = result.getU_email();
			msg.append("<h3> ID 찾기  ");
			msg.append("</h3>");
			msg.append("<hr>");
			msg.append("●");
			msg.append(" ID :  ");
			msg.append(result.getU_id());
			msg.append("<hr>");
			msg.append("Sincerely SCMaster C Class 2Group");
			new SendMail(email, title, msg.toString());	
		}else{
			model.addAttribute("errorMsg", "검색실패");
		}

		return "user/loginPage";
	}
	
	
	//PW 찾기 (ID,이름,이메일로 검색 후 있을시 메일 발송
	@RequestMapping(value="userPWSearch", method=RequestMethod.POST)
	public String userPWSearch(UserVO user ,Model model){
		UserVO result = dao.userIDSearch(user);
		//있는 경우
		if(result !=null){
			model.addAttribute("errorMsg", "검색성공");
			String title = "[MSM] 비밀번호 찾기";
			StringBuffer msg = new StringBuffer();
			String email = result.getU_email();
			msg.append("<h3> 비밀번호 찾기  ");					
			msg.append("</h3>");
			msg.append("<hr>");
			msg.append("●");
			msg.append(" 비밀번호 :  ");
			msg.append(result.getU_pwd());
			msg.append("</h3>");
			msg.append("<hr>");
			msg.append("Sincerely SCMaster C Class 2Group");
			new SendMail(email, title, msg.toString());	
		}else{
			model.addAttribute("errorMsg", "검색실패");
		}

		return "user/loginPage";
	}
	
	//회원정보 수정
	@RequestMapping(value="user_Update", method=RequestMethod.POST)
	public String user_Update(UserVO user ,RedirectAttributes redirectAttributes,HttpSession session){
		
		String loginID = (String)session.getAttribute("loginID");
		user.setU_id(loginID);
		
		if(user.getU_pwd().equals("")){
			user.setU_pwd(null);
		}
		
		user.setU_pwd(securityUtil.checkData(user.getU_pwd()));
		user.setU_name(securityUtil.checkData(user.getU_name()));
		user.setU_address(securityUtil.checkData(user.getU_address()));
		
		int result= dao.user_Update(user);
		if(result==1){
			System.out.println("test3");
			redirectAttributes.addFlashAttribute("errorMsg","수정성공" );				
		}else{
			redirectAttributes.addFlashAttribute("errorMsg","수정실패" );
		}
		
		
		return "redirect:/newhome";
	}
	
	//회원정보 수정 모달창
	@RequestMapping(value="userUpdatemodal", method=RequestMethod.GET)
	public String userUpdatemodal(){
		return "user/userUpdate";
	}
	
	//회원정보 수정 값 셋팅
	@ResponseBody
	@RequestMapping(value="userUpdateSet", method=RequestMethod.POST)
	public UserVO userUpdateSet(UserVO user , HttpSession session){
		String loginID= (String)session.getAttribute("loginID");
		user.setU_id(loginID);
		UserVO result = dao.userIDSearch(user);
		System.out.println(result);
		return result;
	}
	
	//회원 탈퇴 
	@RequestMapping(value="userDelete", method=RequestMethod.GET)
	public String userDelete(HttpSession session){
		
		String loginID= (String)session.getAttribute("loginID");
		System.out.println(loginID);
		
		int result = dao.userDelete(loginID);
		session.invalidate();
		return "redirect:/";
	}
	
	// 수정시 이메일 존재여부 체크
	@ResponseBody
	@RequestMapping(value="emailCheck", method=RequestMethod.POST)
	public String emailCheck(UserVO user , HttpSession session){
		String loginID= (String)session.getAttribute("loginID");
		
		String email = user.getU_email();
		//이메일로 검색
		UserVO checkEmail = dao.userIDSearch(user);
		user.setU_id(loginID);
		//본인 아이디 메일인지 확인
		UserVO checkEmail2 = dao.userIDSearch(user);
		System.out.println(checkEmail2);
		//없으면 가능
		if(checkEmail==null){
			return "ok";
		}else{
			if(checkEmail2 != null){
				return "";
			}else{
				return "no";
			}
			
		}

	}
	
}