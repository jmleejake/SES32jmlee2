package global.sesoc.project2.msm.accbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 가계부 관련 콘트롤러
 */
@Controller
@RequestMapping("accbook")
public class AccbookController {
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
	
	
	
}
