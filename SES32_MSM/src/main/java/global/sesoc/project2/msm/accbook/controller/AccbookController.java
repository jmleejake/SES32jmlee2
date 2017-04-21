package global.sesoc.project2.msm.accbook.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.util.DataVO;
import global.sesoc.project2.msm.util.ExcelService;
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
	
	@Value("#{config['SAMPLE_EXCEL']}")
	String samplePath; // 엑셀업로드 샘플파일 경로

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

	@RequestMapping("layer")
	public String layer() {
		return "accbook/layer";
	}

	@RequestMapping("registAccbookView")
	public String registAccbookView() {
		return "accbook/registView";
	}
	
	@RequestMapping(value = "Accbook", method = RequestMethod.GET)
	public String Accbook() {
	
		
		return "accbook/Accbook";
	}


	//가계부 등록
	@ResponseBody
	@RequestMapping(value = "registAccbook", method = RequestMethod.POST)
	public void registAccbook(AccbookVO accbookVO ,HttpSession hs,Model model ,HttpSession session) {

		if(accbookVO.getA_memo().equals("")){
			accbookVO.setA_memo("없음");
		}
		
		accbookVO.setU_id((String)session.getAttribute("loginID"));
		System.out.println(accbookVO);
		int result = dao.registAccbook(accbookVO);
		System.out.println(result);
		String msg=null;
		if(result==0){
			msg ="등록 실패";
		}else{
			msg ="등록 성공";
		}
		
		System.out.println(msg);
		
	}
	//가계부 테이블 정보 가져오기 페이징 된 내용만
	@ResponseBody
	@RequestMapping(value = "getAccbook", method = RequestMethod.POST)
	public HashMap<String, Object> getAccbook(AccbookSearchVO accbookSearch,
			@RequestParam(value = "page", defaultValue = "1") int page,
			HttpSession session) {
		//검색 값 설정
		
		accbookSearch.setU_id((String)session.getAttribute("loginID"));
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				System.out.println("test");
				accbookSearch.setType(null);
				System.out.println("확인" + accbookSearch);
			}
		}
		
		
		if (accbookSearch.getKeyWord() != null) {
			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
				System.out.println("확인" + accbookSearch);
			}
		}
		
		if(accbookSearch.getPayment().length==0){
			accbookSearch.setPayment(null);
		}
		if(accbookSearch.getSub_cates().length==0){
			accbookSearch.setSub_cates(null);
		}
		
		
		System.out.println("최종:" + accbookSearch);

		// 검색 된 글 개수

		int total = dao.getTotal(accbookSearch);
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<AccbookVO> list = dao.getAccbook(navi.getStartRecord(), countPerPage, accbookSearch);
		// 계시판용 리스트
		HashMap<String, Object> result = new HashMap<>();

		

		result.put("list", list);
		//페이징 처리용
		result.put("startPageGroup", navi.getStartPageGroup());
		result.put("endPageGroup", navi.getEndPageGroup());
		result.put("currentPage", navi.getCurrentPage());
		return result;
	}
	//검색된 차트용 데이터
	@ResponseBody
	@RequestMapping(value = "getAccbook2", method = RequestMethod.POST)
	public HashMap<String, Object> getAccbook2(AccbookSearchVO accbookSearch ,HttpSession session) {
		
		
		
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				System.out.println("test");
				accbookSearch.setType(null);

			}

		}
		if (accbookSearch.getKeyWord() != null) {
			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
				System.out.println("확인" + accbookSearch);
			}
		}
		
		if(accbookSearch.getPayment().length==0){
			accbookSearch.setPayment(null);
		}
		if(accbookSearch.getSub_cates().length==0){
			accbookSearch.setSub_cates(null);
		}
		
	
	
		
		accbookSearch.setU_id((String)session.getAttribute("loginID"));
		

		System.out.println(accbookSearch);

		HashMap<String, Object> result = dao.getAccbook2(accbookSearch);

		ArrayList<AccbookVO> list =(ArrayList<AccbookVO>)result.get("list");
		for (AccbookVO accbookVO : list) {
			System.out.println("test : " +accbookVO );
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "getAccbook3", method = RequestMethod.POST)
	public AccbookVO getAccbook3(String a_id) {
		
		
		AccbookVO result = dao.getAccbook3(a_id);
		return result;
	}
	
	@RequestMapping(value = "modifyAccbook", method = RequestMethod.GET)
	public String modifyAccbook() {

	
		return "accbook/modifyAccbook";
	}
	@ResponseBody
	@RequestMapping(value = "modifyAccbook", method = RequestMethod.POST)
	public void modifyAccbook(AccbookVO accbook ,HttpSession session) {
		
		
		accbook.setU_id((String)session.getAttribute("loginID"));
		if(accbook.getA_memo().equals("")){
			accbook.setA_memo("없음");
		}
		
		
		int result = dao.updateAccbook(accbook);
		

	}
	@ResponseBody
	@RequestMapping(value = "deleteAccbook", method = RequestMethod.POST)
	public void deleteAccbook(String []  a_id) {
		int result=0;
		for (String s : a_id) {
			result += dao.deleteAccbook(Integer.parseInt(s));
		}
		
	}

	// 엑셀 등록
	@RequestMapping(value = "uploadAccbook", method = RequestMethod.POST)
	public String upload(MultipartFile file, Model model, HttpSession session) {

		String loginId = (String) session.getAttribute("loginID");

		String ori_file = file.getOriginalFilename();
		String extension = ori_file.substring(ori_file.lastIndexOf(".") + 1, ori_file.length());
		if (extension.contains("xls")) { // 유저가 업로드한 파일이 엑셀일때
			if (!file.isEmpty()) {
				// 특정 폴더에 엑셀파일 업로드
				String file_name = FileService.saveFile(file, uploadPath);

				// 업로드 완료후 return
				int ret = dao.excelUpload(uploadPath + "/" + file_name, loginId);
				if (ret > 0) {
					// 업로드 및 DB insert가 완료되면 파일을 삭제한다.
					FileService.deleteFile(uploadPath + "/" + file_name);
				}
			}
			model.addAttribute("acc_msg", "ok");
		} else { // 유저가 업로드한 파일이 엑셀이 아닌 다른 파일일때
			model.addAttribute("acc_msg", "only excel file!!!");
		}

		return "redirect:Accbook";
	}
	
	@RequestMapping(value = "excelDownAccbook", method = RequestMethod.POST)
	public void downloadDataToExcel(HttpServletResponse resp ,AccbookSearchVO accbookSearch ,HttpSession session) {
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				System.out.println("test");
				accbookSearch.setType(null);

			}

		}
		if (accbookSearch.getKeyWord() != null) {
			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
				System.out.println("확인" + accbookSearch);
			}
		}
		
		
		
		if(accbookSearch.getPayment().length==0){
			accbookSearch.setPayment(null);
		}
		if(accbookSearch.getSub_cates().length==0){
			accbookSearch.setSub_cates(null);
		}

		accbookSearch.setU_id((String)session.getAttribute("loginID"));
		
		try {
			resp.setHeader("Content-Disposition", 
						"attachment;filename=" 
						+ URLEncoder.encode("가계부내역.xls", "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		HashMap<String, Object> param = new HashMap<>();
		param.put("group_name", "보리");
		
		
		
		
		String[] members = {"a_date", "main_cate", "sub_cate", "payment","price","a_memo"};
		String[] cell_headers = {"일자", "유형", "카테고리", "결제방법","가격","항목"};
		int[] cell_widths = {20, 20, 30,  20, 20, 20};
		
		try {
			//저장 폴더가 없으면 생성
			File path = new File(downloadPath);
			if (!path.isDirectory()) {
				path.mkdirs();
			}
			
			String save_path = downloadPath + "/test.xls";
		
			HashMap<String, Object> result = dao.getAccbook2(accbookSearch);
			ArrayList<DataVO> list = (ArrayList<DataVO>) result.get("list");
			for (DataVO dataVO : list) {
				
				System.out.println("zzz"+dataVO);
			}
			ExcelService.simpleExcelWrite(new File(save_path)
					, list, members, cell_headers, cell_widths);
			
			FileInputStream in = null;
			ServletOutputStream out = null;
			try {
				in = new FileInputStream(save_path);
				out = resp.getOutputStream();
				
				FileCopyUtils.copy(in, out);
			} catch (FileNotFoundException e) {
				//log.error(e.getMessage());
			} catch (IOException e) {
				//log.error(e.getMessage());
			} finally {
				try {
					if(in != null) in.close();
					if(out != null) out.close();
				} catch (IOException e) {
				//	log.error(e.getMessage());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
