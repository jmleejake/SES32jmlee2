package global.sesoc.project2.msm.accbook.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.project2.msm.HomeController;
import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;

/**
 * 가계부 관련 콘트롤러
 */
@Controller
@RequestMapping("accbook")
public class AccbookController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(AccbookController.class);
	@Autowired
	AccbookDAO dao;// 가계부 관련 데이터 처리 객체

	@RequestMapping("accTest")
	public String callTestPage() {
		return "accbook/accTest";
	}

	@RequestMapping("accTest1")
	public String callTestPage1() {
		return "accbook/accTest1";
	}

	@RequestMapping("accTest2")
	public String callTestPage2() {
		return "accbook/accTest2";
	}

	@RequestMapping(value = "insertAccbook", method = RequestMethod.GET)
	public String insertAccbook() {
		AccbookVO accbook = new AccbookVO("aaa", "2017-03-21", "IN", "test", "test2", "통장", 10000, "test3");
		
		int result =dao.insertAccbook(accbook);
		if(result ==0){
			System.out.println("실패");
		}else{
			System.out.println("성공");
		}
		return "redirect:list";
	}

}
