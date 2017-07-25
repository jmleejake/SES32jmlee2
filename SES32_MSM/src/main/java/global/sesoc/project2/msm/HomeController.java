package global.sesoc.project2.msm;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.user.dao.UserDAO;
import global.sesoc.project2.msm.user.vo.UserVO;

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
	
	/**
	 *  안드로이드 로그인
	 * @param data 안드로이드에서 넘어온 로그인 데이터
	 * @return
	 * @throws JSONException
	 */
	@ResponseBody
	@RequestMapping(value = "android_login", method = RequestMethod.POST)
	public String methodForAndroidLogin(@RequestBody String data) throws JSONException {

		logger.debug("user : " + data);

		String jsonText = null;

		JSONArray array = new JSONArray(data);

		String id = null;
		String pw = null;

		for (int i = 0; i < array.length(); i++) {
			JSONObject json = array.getJSONObject(i);
			
			id = json.get("userid").toString();
			pw = json.get("userpw").toString();
			
			UserVO vo = dao.userLogin(id, pw);
			//로그인 실패
			if(vo==null){
				jsonText = "아이디나 비밀번호가 틀립니다.";
			} else {
				JSONObject obj = new JSONObject();
				obj.put("user_id", vo.getU_id());
				obj.put("user_name", vo.getU_name());
				JSONArray arr = new JSONArray();
				arr.put(obj);
				jsonText = arr.toString();
			}
		}

		return jsonText;
	}
	
	/**
	 * 안드로이드에서 넘어온 카드데이터 처리
	 * @param data 안드로이드에서 넘어온 로그인 데이터
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="android_data", method=RequestMethod.POST)
	public String methodForAndroidDataProcess(@RequestBody String data) {
		logger.debug("전송받은 문자열 : {}", data);
		String jsonText = "{'userlist':[{'num' : '01' , 'name' : 'leejongho' , 'phone' : '010-1234-1234'},"
				+ "{'num' : '02' , 'name' : 'leejongho2' , 'phone' : '010-1234-1235'}]}";
		JSONArray array;
		try {
			array = new JSONArray(data);
			
			for (int i = 0; i < array.length(); i++) {
				JSONObject obj = array.getJSONObject(i);
				logger.debug(obj.getString("tel"));
				logger.debug(obj.getString("date"));
				logger.debug(obj.getString("content"));
				
				String telNo = obj.getString("tel");
				String date = obj.getString("date");
				String content = obj.getString("content");
				
			}
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return jsonText;
	}
}