package global.sesoc.project2.msm.accbook.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.util.PageNavigator;

/**
 * 가계부 관련 콘트롤러
 */
@Controller
@RequestMapping("accbook")
public class AccbookController {

	static final int countPerPage = 10;// 페이지당 글수
	static final int pagePerGroup = 5; // 페이지 이동 그룹 당 표시할 페이지 수
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
	@RequestMapping("zindex")
	public String zindex() {
		return "accbook/zindex";
	}
	@RequestMapping("layer")
	public String layer() {
		return "accbook/layer";
	}
	@RequestMapping("registAccbookView")
	public String registAccbookView() {
		return "accbook/registView";
	}
	@RequestMapping("jqgrid")
	public String jqgrid() {
		return "accbook/jqgrid";
	}
	
	

	@RequestMapping(value = "registAccbook", method = RequestMethod.GET)
	public String registAccbook() {

		AccbookVO accbook;

		accbook = new AccbookVO("aaa", "2017-01-03", "IN", "test", "test2", "통장", 10000, "test3");

		dao.registAccbook(accbook);

		return "redirect:list";
	}
	@ResponseBody
	@RequestMapping(value = "getAccbook", method = RequestMethod.POST)
	public ArrayList<AccbookVO> getAccbook(AccbookSearchVO accbookSearch
			,@RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {

		// 전체 글 개수
		int total = dao.getTotal(accbookSearch);
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		// 목록 읽기
		ArrayList<AccbookVO> result = dao.getAccbook(navi.getStartRecord(),countPerPage,accbookSearch);


		return result;
	}
	@RequestMapping(value = "modifyAccbook", method = RequestMethod.GET)
	public String modifyAccbook() {

		AccbookSearchVO accbookSearch = new AccbookSearchVO();
		accbookSearch.setStart_date("2017-02-22");
		accbookSearch.setEnd_date("2017-05-22");
		accbookSearch.setU_id("aaa");
		
		//String[] cate_test = { "test2" };
		String payment = "통장";
		String keyword="명품";
		//accbookSearch.setPayment(payment);
		accbookSearch.setKeyWord(keyword);
		//ArrayList<AccbookVO> result = dao.getAccbook(accbookSearch);

			
		

		
		
		
		

		return "redirect:list";
	}
	@RequestMapping(value = "deleteAccbook", method = RequestMethod.GET)
	public String deleteAccbook() {
		
		int result = dao.deleteAccbook(25);
		System.out.println(result);
		return "redirect:list";
	}
	
	

}
