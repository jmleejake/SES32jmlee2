package global.sesoc.project2.msm;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.calendar.dao.CalendarDAO;
import global.sesoc.project2.msm.user.dao.UserDAO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	UserDAO dao;
	
	@Autowired
	AccbookDAO accDao;// 가계부 관련 데이터 처리 객체
	
	@Autowired
	CalendarDAO calDao; // main화면을 위한 캘린더 데이터 처리객체
	
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
	
	/**
	 *  안드로이드 로그인
	 * @param data 안드로이드에서 넘어온 로그인 데이터
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "android_login", method = RequestMethod.POST)
	public String methodForAndroidLogin(@RequestBody String data) {
		logger.debug("user : " + data);
		return dao.androidLogin(data);
	}
	
	/**
	 * 안드로이드에서 넘어온 카드 결제데이터 처리
	 * @param data 안드로이드에서 넘어온 결제데이터
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="android_data", method=RequestMethod.POST)
	public String methodForAndroidDataProcess(@RequestBody String data) {
		logger.debug("전송받은 문자열 : {}", data);
		return accDao.androidUpload(data);
	}
	
	/**
	 *  안드로이드 로그인 이후 메인페이지
	 * @param data 안드로이드에서 넘어온 로그인 데이터
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="android_main", method=RequestMethod.POST)
	public String methodForAndroidMain(@RequestBody String data) {
		logger.debug("methodForAndroidMain :: {}", data);
		return calDao.androidMain(data);
	}
}