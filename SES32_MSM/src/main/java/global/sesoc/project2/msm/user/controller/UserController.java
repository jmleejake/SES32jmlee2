package global.sesoc.project2.msm.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.project2.msm.user.vo.UserVO;

/**
 * 유저 컨트롤러
 * @author KIM TAE HEE
 *
 */
@Controller
@RequestMapping("user")
public class UserController {
	@RequestMapping(value="userPage", method=RequestMethod.GET)
	public String userPage_Enter(){
		return "user/userPage";
	}
	
	@RequestMapping(value="userInsert", method=RequestMethod.POST)
	public String user_Insert(UserVO userVo){
		
		return "redirect:/";
	}
}