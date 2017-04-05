package global.sesoc.project2.msm.accbook.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.util.FileService;
import global.sesoc.project2.msm.util.PageNavigator;

/**
 * 가계부 관련 콘트롤러
 */
@Controller
@RequestMapping("accbook")
public class AccbookController {

	static final int countPerPage = 10;// 페이지당 글수
	static final int pagePerGroup = 5; // 페이지 이동 그룹 당 표시할 페이지 수
	
	// config.properties사용하여 값 가져오기
	@Value("#{config['EXCEL_UPLOAD_PATH']}")
	String uploadPath; // 엑셀 업로드 기능 동작시 임시경로
	
	@Value("#{config['EXCEL_DOWNLOAD_PATH']}")
	String downloadPath; // 엑셀 다운로드 기능 동작시 임시경로
	
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
	public HashMap<String, Object> getAccbook(AccbookSearchVO accbookSearch,
			@RequestParam(value = "page", defaultValue = "1") int page) {
		// 전체 글 개수
		int total = dao.getTotal(accbookSearch);
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<AccbookVO> list = dao.getAccbook(navi.getStartRecord(), countPerPage, accbookSearch);
		// 계시판용 리스트
		System.out.println(total);
		HashMap<String, Object> result = new HashMap<>();
		
		System.out.println(navi.getCurrentGroup());
		System.out.println(navi.getStartPageGroup());
		System.out.println(navi.getEndPageGroup());
		result.put("list", list);
		result.put("startPageGroup", navi.getStartPageGroup());
		result.put("endPageGroup", navi.getEndPageGroup());
		result.put("currentPage", navi.getCurrentPage());
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "getAccbook2", method = RequestMethod.POST)
	public HashMap<String, Object> getAccbook2(AccbookSearchVO accbookSearch

	) {
		HashMap<String, Object> result = dao.getAccbook2(accbookSearch);
		
		
		
			
		
		
		return result;
	}

	@RequestMapping(value = "modifyAccbook", method = RequestMethod.GET)
	public String modifyAccbook() {

		AccbookSearchVO accbookSearch = new AccbookSearchVO();
		accbookSearch.setStart_date("2017-02-22");
		accbookSearch.setEnd_date("2017-05-22");
		accbookSearch.setU_id("aaa");

		// String[] cate_test = { "test2" };
		String payment = "통장";
		String keyword = "명품";
		// accbookSearch.setPayment(payment);
		accbookSearch.setKeyWord(keyword);
		// ArrayList<AccbookVO> result = dao.getAccbook(accbookSearch);

		return "redirect:list";
	}

	@RequestMapping(value = "deleteAccbook", method = RequestMethod.GET)
	public String deleteAccbook() {

		int result = dao.deleteAccbook(25);
		return "redirect:list";
	} 
	
	//엑셀 등록
	@RequestMapping(value = "uploadAccbook", method = RequestMethod.POST)
	public String upload(MultipartFile file,Model model, HttpSession session) {

		String loginId = (String)session.getAttribute("loginId");
		
		loginId="aaa";
		String ori_file = file.getOriginalFilename();
		String extension = ori_file.substring(ori_file.lastIndexOf(".")+1, ori_file.length());
		if(extension.contains("xls")) { // 유저가 업로드한 파일이 엑셀일때
			if(!file.isEmpty()) {
				// 특정 폴더에 엑셀파일 업로드
				String file_name = FileService.saveFile(file, uploadPath);
				
				// 업로드 완료후 return
				int ret = dao.excelUpload(uploadPath + "/" + file_name,loginId);
				if(ret > 0) {
					// 업로드 및 DB insert가 완료되면 파일을 삭제한다.
					FileService.deleteFile(uploadPath + "/" + file_name);
				}
			}
			model.addAttribute("acc_msg", "ok");
		} else { // 유저가 업로드한 파일이 엑셀이 아닌 다른 파일일때
			model.addAttribute("acc_msg", "only excel file!!!");
		}
		
		
		
		return "redirect:accView";
	} 
	

}
