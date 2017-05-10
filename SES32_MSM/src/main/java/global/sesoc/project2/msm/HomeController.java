package global.sesoc.project2.msm;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.project2.msm.user.dao.UserDAO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	UserDAO dao;
	
	/**
	 *  로그인 화면
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginnewhome() {
		logger.debug("go to login new home!");
		return "loginnewhome";
	}
	
	/**
	 *  로그인직후 메인화면
	 * @return
	 */
	@RequestMapping(value = "newhome", method = RequestMethod.GET)
	public String newhome2() {
		logger.debug("go to login new home!");
		return "newhome2";
	}
}