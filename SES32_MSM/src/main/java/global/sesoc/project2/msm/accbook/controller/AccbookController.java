package global.sesoc.project2.msm.accbook.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.project2.msm.accbook.dao.AccbookDAO;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.util.DataVO;
import global.sesoc.project2.msm.util.ExcelService;
import global.sesoc.project2.msm.util.FileService;
import global.sesoc.project2.msm.util.PageNavigator;
import global.sesoc.project2.msm.util.securityUtil;

/**
 * 가계부 관련 콘트롤러
 */
@Controller
@RequestMapping("accbook")
public class AccbookController {

	// config.properties사용하여 값 가져오기
	@Value("#{config['EXCEL_UPLOAD_PATH']}")
	String uploadPath; // 엑셀 업로드 기능 동작시 임시경로

	@Value("#{config['EXCEL_DOWNLOAD_PATH']}")
	String downloadPath; // 엑셀 다운로드 기능 동작시 임시경로

	@Value("#{config['SAMPLE_EXCEL']}")
	String samplePath; // 엑셀업로드 샘플파일 경로
	
	@Value("#{config['SAMPLE_EXCEL2']}")
	String samplePath2; // 엑셀업로드 샘플파일 경로
	
	@Value("#{config['COUNT_PER_PAGE']}")
	int countPerPage; // 페이지당 글수
	
	@Value("#{config['PAGE_PER_GROUP']}")
	int pagePerGroup; // 페이지 이동 그룹 당 표시할 페이지 수

	private static final Logger log = LoggerFactory.getLogger(AccbookController.class);
	@Autowired
	AccbookDAO dao;// 가계부 관련 데이터 처리 객체

	//검색 모달
	@RequestMapping("layer")
	public String layer() {
		log.debug("가계부 메인화면 검색 모달열기 :: GET");
		return "accbook/layer";
	}
	//등록 모달
	@RequestMapping("registAccbookView")
	public String registAccbookView() {
		log.debug("가계부 메인화면 등록 모달열기 :: GET");
		return "accbook/registView";
	}
	//가계부 메인화면
	@RequestMapping(value = "Accbook", method = RequestMethod.GET)
	public String Accbook() {
		log.debug("가계부 메인화면 이동:: GET");
		return "accbook/Accbook";
	}

	// 가계부 등록
	@ResponseBody
	@RequestMapping(value = "registAccbook", method = RequestMethod.POST)
	public void registAccbook(AccbookVO accbookVO, Model model, HttpSession session) {
		log.debug("가계부 등록  :: POST");
		log.debug("accbookVO :: \n{}", accbookVO);
		
		if (accbookVO.getA_memo().equals("")) {
			accbookVO.setA_memo("없음");
		}
		if(accbookVO.getA_memo()!=null){
			accbookVO.setA_memo(securityUtil.checkData(accbookVO.getA_memo()));
		}

		accbookVO.setU_id((String) session.getAttribute("loginID"));
		int result = dao.registAccbook(accbookVO);
	


	}

	// 가계부 테이블 정보 가져오기 페이징 된 내용만
	@ResponseBody
	@RequestMapping(value = "getAccbook", method = RequestMethod.POST)
	public HashMap<String, Object> getAccbook(AccbookSearchVO accbookSearch,
			@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session) {
		log.debug("가계부 테이블 내용 가져오기(페이징된 내용)  :: POST");
		log.debug("accbookSearch :: \n{}", accbookSearch);
		// 검색 값 설정
		
		accbookSearch.setU_id((String) session.getAttribute("loginID"));
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				accbookSearch.setType(null);
			}
		}

		if (accbookSearch.getKeyWord() != null) {
			accbookSearch.setKeyWord(securityUtil.checkData(accbookSearch.getKeyWord()));

			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
			}
		}

		if (accbookSearch.getPayment().length == 0) {
			accbookSearch.setPayment(null);
		}
		if (accbookSearch.getSub_cates().length == 0) {
			accbookSearch.setSub_cates(null);
		}
		
		String start=accbookSearch.getStart_date().substring(2);
		String end = accbookSearch.getEnd_date().substring(2);
		accbookSearch.setStart_date(start.replaceAll("-", "/"));
		accbookSearch.setEnd_date(end.replaceAll("-", "/"));

		// 검색 된 글 개수

		int total = dao.getTotal(accbookSearch);
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<AccbookVO> list = dao.getAccbook(navi.getStartRecord(), countPerPage, accbookSearch);
		// 계시판용 리스트
		HashMap<String, Object> result = new HashMap<>();

		result.put("list", list);
		// 페이징 처리용
		result.put("startPageGroup", navi.getStartPageGroup());
		result.put("endPageGroup", navi.getEndPageGroup());
		result.put("currentPage", navi.getCurrentPage());
		return result;
	}

	// 검색된 차트용 데이터
	@ResponseBody
	@RequestMapping(value = "getAccbook2", method = RequestMethod.POST)
	public HashMap<String, Object> getAccbook2(AccbookSearchVO accbookSearch, HttpSession session) {
		log.debug("가계부 차트 내용 가져오기(검색 내용)  :: POST");
		log.debug("accbookSearch :: \n{}", accbookSearch);
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				accbookSearch.setType(null);
			}
		}
		if (accbookSearch.getKeyWord() != null) {
			accbookSearch.setKeyWord(securityUtil.checkData(accbookSearch.getKeyWord()));
			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
			}
		}
		if (accbookSearch.getPayment() != null) {
			if (accbookSearch.getPayment().length == 0) {
				accbookSearch.setPayment(null);
			}
		}
		if (accbookSearch.getSub_cates() != null) {
			if (accbookSearch.getSub_cates().length == 0) {
				accbookSearch.setSub_cates(null);
			}
		}

		String start=accbookSearch.getStart_date().substring(2);
		String end = accbookSearch.getEnd_date().substring(2);
		accbookSearch.setStart_date(start.replaceAll("-", "/"));
		accbookSearch.setEnd_date(end.replaceAll("-", "/"));
		accbookSearch.setU_id((String) session.getAttribute("loginID"));


		HashMap<String, Object> result = dao.getAccbook2(accbookSearch);

		ArrayList<AccbookVO> list = (ArrayList<AccbookVO>) result.get("list");

		return result;
	}
	//단일 가계부 내역 가져오기
	@ResponseBody
	@RequestMapping(value = "getAccbook3", method = RequestMethod.POST)
	public AccbookVO getAccbook3(String a_id) {
		log.debug("가계부 내용 가져오기  :: POST");
		log.debug("a_id :: \n{}", a_id);
		AccbookVO result = dao.getAccbook3(a_id);
		return result;
	}
	
	
	// 검색된 차트용 데이터
	@ResponseBody
	@RequestMapping(value = "getAccbook4", method = RequestMethod.POST)
	public HashMap<String, Object> getAccbook4(AccbookSearchVO accbookSearch, HttpSession session,String period) {
		log.debug(" 메인화면 차트용 데이터 가져오기  :: POST");
		log.debug("accbookSearch :: \n{}", accbookSearch);
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				accbookSearch.setType(null);
			}
		}
		if (accbookSearch.getKeyWord() != null) {
			accbookSearch.setKeyWord(securityUtil.checkData(accbookSearch.getKeyWord()));
			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
			}
		}
		if (accbookSearch.getPayment() != null) {
			if (accbookSearch.getPayment().length == 0) {
				accbookSearch.setPayment(null);
			}
		}
		if (accbookSearch.getSub_cates() != null) {
			if (accbookSearch.getSub_cates().length == 0) {
				accbookSearch.setSub_cates(null);
			}
		}

		String start=accbookSearch.getStart_date().substring(2);
		String end = accbookSearch.getEnd_date().substring(2);
		accbookSearch.setStart_date(start.replaceAll("-", "/"));
		accbookSearch.setEnd_date(end.replaceAll("-", "/"));
		accbookSearch.setU_id((String) session.getAttribute("loginID"));


		HashMap<String, Object> result = new HashMap<>();
		result.put("pie", dao.getAccbook2(accbookSearch));		
		result.put("year", dao.getAccbook4(accbookSearch,"1년"));
		result.put("sang", dao.getAccbook4(accbookSearch,"상반기"));	
		result.put("haban", dao.getAccbook4(accbookSearch,"하반기"));	

		return result;
	}

	@RequestMapping(value = "modifyAccbook", method = RequestMethod.GET)
	public String modifyAccbook() {
		log.debug("가계부 메인화면 수정화면 모달 열기  :: GET");
		return "accbook/modifyAccbook";
	}

	@ResponseBody
	@RequestMapping(value = "modifyAccbook", method = RequestMethod.POST)
	public void modifyAccbook(AccbookVO accbookVO, HttpSession session) {
		log.debug("가계부 수정   :: POST");
		log.debug("accbookVO :: \n{}", accbookVO);
		accbookVO.setU_id((String) session.getAttribute("loginID"));
		if (accbookVO.getA_memo().equals("")) {
			accbookVO.setA_memo("없음");
		}
		if(accbookVO.getA_memo()!=null){
			accbookVO.setA_memo(securityUtil.checkData(accbookVO.getA_memo()));
		}
		

		int result = dao.updateAccbook(accbookVO);

	}

	@ResponseBody
	@RequestMapping(value = "deleteAccbook", method = RequestMethod.POST)
	public void deleteAccbook(String[] a_id) {
		log.debug("가계부 삭제  :: POST");
		log.debug("a_id :: \n{}", a_id);
		
		int result = 0;
		for (String s : a_id) {
			result += dao.deleteAccbook(Integer.parseInt(s));
		}

	}

	// 엑셀 등록
	@RequestMapping(value = "uploadAccbook", method = RequestMethod.POST)
	public String upload(MultipartFile file, Model model, HttpSession session , RedirectAttributes redirectAttributes) {
		
		log.debug("excelUpload :: POST");
		
		log.debug("contentType: {}", file.getContentType());
		log.debug("name: {}", file.getName());
		log.debug("original name: {}", file.getOriginalFilename());
		log.debug("size: {}", file.getSize());
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
			redirectAttributes.addFlashAttribute("errorMsg", "ok");
		} else { // 유저가 업로드한 파일이 엑셀이 아닌 다른 파일일때
			redirectAttributes.addFlashAttribute("errorMsg", "엑셀 파일이 아닙니다.");
		}
		
		return "redirect:Accbook";
	}

	@RequestMapping(value = "excelDownAccbook", method = RequestMethod.POST)
	public void downloadDataToExcel(HttpServletResponse resp, AccbookSearchVO accbookSearch, HttpSession session) {
		log.debug("excelDownload :: POST");
		if (accbookSearch.getType() != null) {
			if (accbookSearch.getType().equals("") || accbookSearch.getType().equals("ALL")) {
				accbookSearch.setType(null);

			}

		}
		if (accbookSearch.getKeyWord() != null) {
			accbookSearch.setKeyWord(securityUtil.checkData(accbookSearch.getKeyWord()));
			if (accbookSearch.getKeyWord().equals("")) {
				accbookSearch.setKeyWord(null);
			}
		}

		if (accbookSearch.getPayment() != null) {
			if (accbookSearch.getPayment().length == 0) {
				accbookSearch.setPayment(null);
			}
		}
		if (accbookSearch.getSub_cates() != null) {
			if (accbookSearch.getSub_cates().length == 0) {
				accbookSearch.setSub_cates(null);
			}
		}

		accbookSearch.setU_id((String) session.getAttribute("loginID"));

		try {
			resp.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("가계부내역.xls", "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		HashMap<String, Object> param = new HashMap<>();
		param.put("group_name", "보리");

		String[] members = { "a_date", "main_cate", "sub_cate", "payment", "price", "a_memo" };
		String[] cell_headers = { "일자", "유형", "카테고리", "결제방법", "가격", "항목" };
		int[] cell_widths = { 20, 20, 30, 20, 20, 20 };

		try {
			// 저장 폴더가 없으면 생성
			File path = new File(downloadPath);
			if (!path.isDirectory()) {
				path.mkdirs();
			}

			String save_path = downloadPath + "/test.xls";

			HashMap<String, Object> result = dao.getAccbook2(accbookSearch);
			ArrayList<DataVO> list = (ArrayList<DataVO>) result.get("list");
		
			ExcelService.simpleExcelWrite(new File(save_path), list, members, cell_headers, cell_widths);

			FileInputStream in = null;
			ServletOutputStream out = null;
			try {
				in = new FileInputStream(save_path);
				out = resp.getOutputStream();

				FileCopyUtils.copy(in, out);
			} catch (FileNotFoundException e) {
				// log.error(e.getMessage());
			} catch (IOException e) {
				// log.error(e.getMessage());
			} finally {
				try {
					if (in != null)
						in.close();
					if (out != null)
						out.close();
				} catch (IOException e) {
					// log.error(e.getMessage());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("sampleDown2")
	public void sampleDown2(HttpServletResponse resp
			, HttpServletRequest req) {
		log.debug("excelDownloadsample :: GET");
		
		try {
			resp.setHeader("Content-Disposition", 
						"attachment;filename=" 
						+ URLEncoder.encode("가계부업로드샘플.xlsx", "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		String down_path = req.getSession().getServletContext().getRealPath(samplePath2);
		
		FileInputStream in = null;
		ServletOutputStream out = null;
		try {
			in = new FileInputStream(down_path);
			out = resp.getOutputStream();
			
			FileCopyUtils.copy(in, out);
		} catch (FileNotFoundException e) {
		} catch (IOException e) {
		} finally {
			try {
				if(in != null) in.close();
				if(out != null) out.close();
			} catch (IOException e) {
			}
		}
	}
	
}
