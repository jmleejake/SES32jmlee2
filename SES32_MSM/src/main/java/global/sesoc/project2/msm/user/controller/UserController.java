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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	//이전코드
	/*@RequestMapping(value="loginPage", method=RequestMethod.GET)
	public String loginPage_Enter(){
		return "user/loginPage";
	}
	
	@RequestMapping(value="showMap", method=RequestMethod.GET)
	public String mapAPI_Test_Enter3(
			Model model
			, @RequestParam(value="opener_type", defaultValue="tar")String type){
		model.addAttribute("opener_type", type);
		log.debug("type = {}", type);
		return "mapAPI/map";
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
	
	
	@ResponseBody
	@RequestMapping(value="userVarification", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Varification(String u_email, HttpSession session){
		
		String userID = dao.userIDSearching(u_email);
		
		if(userID==null){
			return "이메일에 해당하는 아이디가 존재하지 않습니다.";
		}
		
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
		
		String user_email = dao.userPWSearching(u_id, u_name);
		
		if(user_email==null){
			return "이메일이 존재하지 않습니다.";
		}
		
		if(!u_email.equals(user_email)){
			return "이메일이 일치하지 않습니다.";
		}
		
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
		
		String checkNumberForDelete = (String) session.getAttribute("checkNumberForDelete");
		String u_id = (String) session.getAttribute("loginID");
		
		if(checkDelteNumber.equals(checkNumberForDelete)){
			dao.deleteUser(u_id);
			session.invalidate();
			return "삭제 완료";
		}
		
		return "번호 불일치";
	}
	
	@ResponseBody
	@RequestMapping(value="emergencyChecking", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public HashMap<String, Object> plusEmergency(AccbookVO result, HttpSession session){
		HashMap<String, Object> ret = new HashMap<>();
		
		String id=(String) session.getAttribute("loginID");
		result.setU_id(id);
		result.setA_type("BIS");
		
		UserVO vo = dao.voReading(id);
		int u_emrgency = vo.getU_emergences();
		String alertMessage = Integer.toString(u_emrgency);
		
		if(result.getMain_cate().equalsIgnoreCase("MIN")){
			if(u_emrgency-result.getPrice()<0){
				ret.put("errmsg", "현재 비상금 잔여 액수는"+alertMessage+"입니다");
			}
		}
		
		int insert_ret = dao.insertList(result);
		if(insert_ret > 0 ) {
			ret.put("msg", "등록되었습니다.");
		} else {
			ret.put("errmsg", "등록실패!!");
		}
		
		return ret;
	}
	
	@ResponseBody
	@RequestMapping(value="emergencyChecking2", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public int emergencyChecking2(String a_id, int price, HttpSession session){
		
		String u_id=(String) session.getAttribute("loginID");
		int resultCheck=0;
		
		AccbookVO vo = new AccbookVO();
		vo=dao.checkAccForEmergency(a_id, u_id);
		
		if(vo.getMain_cate().equalsIgnoreCase("MIN")){
			resultCheck=dao.checkAccForEmergency2(a_id, u_id, price);
		}
		else if(vo.getMain_cate().equalsIgnoreCase("PLS")){
			resultCheck=dao.checkAccForEmergency3(a_id, u_id, price);
		}
		
		return resultCheck;
		
	}*/
	

	@RequestMapping(value="showMap", method=RequestMethod.GET)
	public String mapAPI_Test_Enter3(
			Model model
			, @RequestParam(value="opener_type", defaultValue="tar")String type){
		model.addAttribute("opener_type", type);
		log.debug("type = {}", type);
		return "mapAPI/map";
	}
	
	
	@RequestMapping(value="userLogin", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Login(String u_id, String u_pwd, HttpSession session,Model model){
		
		UserVO vo = dao.userLogin(u_id, u_pwd);
		//로그인 실패
		if(vo==null){
			System.out.println("bbb");
			model.addAttribute("errorMsg", "로그인실패");
			return "user/loginPage";
		}
			session.setAttribute("loginID", vo.getU_id());
		
		
		
	
		return "redirect:/newhome";
	}
	
	/**
	 * 비상금관리 화면 이동
	 * @return
	 */
	@RequestMapping("householdAccount")
	public String householdAccount(){
		return "user/householdAccount";
	}
	
	/**
	 * 비상금관리 데이터 조회 / 검색
	 * @param session
	 * @param start_date 검색 시작일자
	 * @param end_date 검색 종료일자
	 * @param keyword 검색 키워드 (메모)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="householdAccount", method=RequestMethod.POST)
	public HashMap<String, Object> householdAccount(
			HttpSession session
			, String start_date
			, String end_date
			, String keyword){
		log.debug("householdAccount :: POST start_date:{} end_date:{} keyword:{}");
		HashMap<String, Object> ret = new HashMap<>();
		
		String id = (String) session.getAttribute("loginID");
		
		Date date = new Date();
		String month =new SimpleDateFormat("MM").format(date);
		String day = new SimpleDateFormat("DD").format(date);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM"); 
		Calendar cal = Calendar.getInstance(); 
		cal.add(cal.MONTH, -1); 
		String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6);
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("u_id", id);
		param.put("start_date", start_date);
		param.put("end_date", end_date);
		param.put("keyword", keyword);
		
		return dao.emergencyExpenseList(param);
	}
	
	
	@ResponseBody
	@RequestMapping(value="userVarification", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String user_Varification(String u_email, HttpSession session){
		
		String userID = dao.userIDSearching(u_email);
		
		if(userID==null){
			return "이메일에 해당하는 아이디가 존재하지 않습니다.";
		}
		
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
		
		String user_email = dao.userPWSearching(u_id, u_name);
		
		if(user_email==null){
			return "이메일이 존재하지 않습니다.";
		}
		
		if(!u_email.equals(user_email)){
			return "이메일이 일치하지 않습니다.";
		}
		
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
		
		String checkNumberForDelete = (String) session.getAttribute("checkNumberForDelete");
		String u_id = (String) session.getAttribute("loginID");
		
		if(checkDelteNumber.equals(checkNumberForDelete)){
			dao.deleteUser(u_id);
			session.invalidate();
			return "삭제 완료";
		}
		
		return "번호 불일치";
	}
	
	@ResponseBody
	@RequestMapping(value="emergencyChecking", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public HashMap<String, Object> plusEmergency(AccbookVO result, HttpSession session){
		HashMap<String, Object> ret = new HashMap<>();
		
		String id=(String) session.getAttribute("loginID");
		result.setU_id(id);
		result.setA_type("BIS");
		
		UserVO vo = dao.voReading(id);
		int u_emrgency = vo.getU_emergences();
		String alertMessage = Integer.toString(u_emrgency);
		
		if(result.getMain_cate().equalsIgnoreCase("MIN")){
			if(u_emrgency-result.getPrice()<0){
				ret.put("errmsg", "현재 비상금 잔여 액수는"+alertMessage+"입니다");
			}
		}
		
		int insert_ret = dao.insertList(result);
		if(insert_ret > 0 ) {
			ret.put("msg", "등록되었습니다.");
		} else {
			ret.put("errmsg", "등록실패!!");
		}
		
		return ret;
	}
	
	@ResponseBody
	@RequestMapping(value="emergencyChecking2", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public int emergencyChecking2(String a_id, int price, HttpSession session){
		
		String u_id=(String) session.getAttribute("loginID");
		int resultCheck=0;
		
		AccbookVO vo = new AccbookVO();
		vo=dao.checkAccForEmergency(a_id, u_id);
		
		if(vo.getMain_cate().equalsIgnoreCase("MIN")){
			resultCheck=dao.checkAccForEmergency2(a_id, u_id, price);
		}
		else if(vo.getMain_cate().equalsIgnoreCase("PLS")){
			resultCheck=dao.checkAccForEmergency3(a_id, u_id, price);
		}
		
		return resultCheck;
		
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
			msg.append("<h3>인증번호 : ");
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
	
	//ID 찾기 (이름,이메일로 검색 후 있을시 메일 발송
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
				msg.append("<h3> 비밀번호 : ");
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
			
			System.out.println("test");
			System.out.println(user);
			
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
}