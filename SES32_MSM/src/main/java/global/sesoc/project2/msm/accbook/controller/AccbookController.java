package global.sesoc.project2.msm.accbook.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.project2.msm.HomeController;
import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
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
	@RequestMapping("accView")
	public String accView() {
		return "accbook/accView";
	}

	@RequestMapping(value = "insertAccbook", method = RequestMethod.GET)
	public String insertAccbook() {

		AccbookVO accbook;

		accbook = new AccbookVO("aaa", "2017-01-03", "IN", "test", "test2", "통장", 10000, "test3");

		dao.insertAccbook(accbook);

		return "redirect:list";
	}

	@RequestMapping(value = "searchAccbook", method = RequestMethod.GET)
	public String searchAccbook() {

		AccbookSearchVO accbookSearch = new AccbookSearchVO();
		accbookSearch.setStart_date("2017-02-22");
		accbookSearch.setEnd_date("2017-05-22");
		accbookSearch.setU_id("aaa");
		
		//String[] cate_test = { "test2" };
		String payment = "통장";
		String keyword="명품";
		//accbookSearch.setPayment(payment);
		accbookSearch.setKeyWord(keyword);
		ArrayList<AccbookVO> result = dao.searchAccbook(accbookSearch);

		for (AccbookVO accbookVO : result) {
			System.out.println(accbookVO);
		}

		return "redirect:list";
	}
	@RequestMapping(value = "updateAccbook", method = RequestMethod.GET)
	public String updateAccbook() {

		AccbookSearchVO accbookSearch = new AccbookSearchVO();
		accbookSearch.setStart_date("2017-02-22");
		accbookSearch.setEnd_date("2017-05-22");
		accbookSearch.setU_id("aaa");
		
		//String[] cate_test = { "test2" };
		String payment = "통장";
		String keyword="명품";
		//accbookSearch.setPayment(payment);
		accbookSearch.setKeyWord(keyword);
		ArrayList<AccbookVO> result = dao.searchAccbook(accbookSearch);

		for (AccbookVO accbookVO : result) {
			System.out.println(accbookVO);
			
			accbookVO.setA_memo("수정성공");
			int result2 = dao.updateAccbook(accbookVO);
			System.out.println(result2);
		}
		

		
		
		
		

		return "redirect:list";
	}
	@RequestMapping(value = "deleteAccbook", method = RequestMethod.GET)
	public String deleteAccbook() {
		
		int result = dao.deleteAccbook(25);
		System.out.println(result);
		return "redirect:list";
	}

}
