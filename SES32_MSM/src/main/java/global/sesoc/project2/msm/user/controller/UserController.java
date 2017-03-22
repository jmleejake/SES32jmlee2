package global.sesoc.project2.msm.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.project2.msm.user.vo.UserVO;

/**
 * 유저 컨트롤러
 * @author KIM TAE HEE
 */
@Controller
@RequestMapping("user")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
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
		
		logger.debug("객체 : {}", userVO);
		
		return "redirect:/";
	}
}