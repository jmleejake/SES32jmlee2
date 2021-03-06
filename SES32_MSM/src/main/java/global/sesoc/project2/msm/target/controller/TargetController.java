package global.sesoc.project2.msm.target.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import global.sesoc.project2.msm.target.dao.TargetDAO;
import global.sesoc.project2.msm.target.vo.TargetAccBookVO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.util.DataVO;
import global.sesoc.project2.msm.util.ExcelService;
import global.sesoc.project2.msm.util.FileService;
import global.sesoc.project2.msm.util.PageNavigator;
import global.sesoc.project2.msm.util.securityUtil;

/**
 * 대상자 관련 콘트롤러
 */
@Controller
@RequestMapping("target")
public class TargetController {
	Logger log = LoggerFactory.getLogger(TargetController.class);
	
	// config.properties사용하여 값 가져오기
	@Value("#{config['EXCEL_UPLOAD_PATH']}")
	String uploadPath; // 엑셀 업로드 기능 동작시 임시경로
	
	@Value("#{config['EXCEL_DOWNLOAD_PATH']}")
	String downloadPath; // 엑셀 다운로드 기능 동작시 임시경로
	
	@Value("#{config['SAMPLE_EXCEL']}")
	String samplePath; // 엑셀업로드 샘플파일 경로
	
	@Value("#{config['COUNT_PER_PAGE']}")
	int countPerPage; // 페이지당 글수
	
	@Value("#{config['PAGE_PER_GROUP']}")
	int pagePerGroup; // 페이지 이동 그룹 당 표시할 페이지 수
	
	@Autowired
	TargetDAO dao;
	
	/**
	 * 경조사 관리 화면 이동
	 * @param model
	 * @param session 세션객체
	 * @return
	 */
	@RequestMapping("targetManage")
	public String excelServicePage(Model model, HttpSession session) {
		log.debug("excelServicePage - test page이동");
		return "target/test"; 
	}

	/**
	 * 엑셀업로드
	 * @param upload
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="excelUpload", method=RequestMethod.POST)
	public String excelUpload(
			MultipartFile upload
			, Model model
			, HttpSession session
			, RedirectAttributes redirectAttributes) {
		
		log.debug("excelUpload :: POST");
		
		log.debug("contentType: {}", upload.getContentType());
		log.debug("name: {}", upload.getName());
		log.debug("original name: {}", upload.getOriginalFilename());
		log.debug("size: {}", upload.getSize());
		
		String ori_file = upload.getOriginalFilename();
		String extension = ori_file.substring(ori_file.lastIndexOf(".")+1, ori_file.length());
		log.debug("extension : {}", extension);
		if(extension.contains("xls")) { // 유저가 업로드한 파일이 엑셀일때
			if(!upload.isEmpty()) {
				// 특정 폴더에 엑셀파일 업로드
				String file_name = FileService.saveFile(upload, uploadPath);
				
				// 업로드 완료후 return
				String up_path = uploadPath + "/" + file_name;
				log.debug("{}", up_path);
				int ret = dao.excelUpload(up_path, session.getAttribute("loginID").toString());
				if(ret > 0) {
					// 업로드 및 DB insert가 완료되면 파일을 삭제한다.
					boolean del_ret = FileService.deleteFile(up_path);
					log.debug("del?! {}", del_ret);
					log.debug("-----------------엑셀업로드 기능 끝-----------------");
				}
			}
			redirectAttributes.addFlashAttribute("up_ret", "ok");
		} else { // 유저가 업로드한 파일이 엑셀이 아닌 다른 파일일때
			redirectAttributes.addFlashAttribute("up_ret", "only excel file!!!");
		}
		return "redirect:targetManage";
	}
	
	/**
	 * 업로드 샘플파일(양식) 다운로드
	 * @param resp
	 * @param req
	 */
	@RequestMapping("sampleDown")
	public void sampleExcelDownload(
			HttpServletResponse resp
			, HttpServletRequest req) {
		try {
			resp.setHeader("Content-Disposition", 
						"attachment;filename=" 
						+ URLEncoder.encode("업로드샘플.xlsx", "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		log.debug(req.getSession().getServletContext().getRealPath(samplePath)); // 서버메인 root_path
		
		String down_path = req.getSession().getServletContext().getRealPath(samplePath);
		
		FileInputStream in = null;
		ServletOutputStream out = null;
		try {
			in = new FileInputStream(down_path);
			out = resp.getOutputStream();
			
			FileCopyUtils.copy(in, out);
		} catch (FileNotFoundException e) {
//			log.error(e.getMessage());
		} catch (IOException e) {
//			log.error(e.getMessage());
		} finally {
			try {
				if(in != null) in.close();
				if(out != null) out.close();
			} catch (IOException e) {
//				log.error(e.getMessage());
			}
		}
	}
	
	/**
	 * 엑셀 다운로드
	 * @param resp
	 */
	@RequestMapping("excelDown")
	public void downloadDataToExcel(HttpServletResponse resp) {
		log.debug("downloadDataToExcel");
		try {
			resp.setHeader("Content-Disposition", 
						"attachment;filename=" 
						+ URLEncoder.encode("경조사가계부내역.xls", "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		HashMap<String, Object> param = new HashMap<>();
		param.put("group_name", "보리");
		
		String[] members = {"ta_date", "ta_memo", "t_group", "t_name", "ta_price"};
		String[] cell_headers = {"일자", "경조사", "소속", "이름", "금액"};
		int[] cell_widths = {20, 30, 30, 20, 10};
		
		try {
			//저장 폴더가 없으면 생성
			File path = new File(downloadPath);
			if (!path.isDirectory()) {
				path.mkdirs();
			}
			
			String save_path = downloadPath + "/test.xls";
			
			ExcelService.simpleExcelWrite(new File(save_path)
					, dao.selectTargetAccBook(param), members, cell_headers, cell_widths);
			
			FileInputStream in = null;
			ServletOutputStream out = null;
			try {
				in = new FileInputStream(save_path);
				out = resp.getOutputStream();
				
				FileCopyUtils.copy(in, out);
			} catch (FileNotFoundException e) {
//				log.error(e.getMessage());
			} catch (IOException e) {
//				log.error(e.getMessage());
			} finally {
				try {
					if(in != null) in.close();
					if(out != null) out.close();
				} catch (IOException e) {
//					log.error(e.getMessage());
				}
			}
		} catch (Exception e) {
//			e.printStackTrace();
		}
	}
	
	/**
	 * 타겟리스트 얻기
	 * @param srch_val
	 * @param srch_type
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="showTarget", method=RequestMethod.POST)
	public HashMap<String, Object> showTargetList(
			String srch_val
			, String srch_type
			, @RequestParam(value = "page", defaultValue = "1") int page
			, HttpSession session) {
		log.debug("showTargetList : search_type::{}, search_val::{}, page::{}", srch_type, srch_val, page);
		HashMap<String, Object> ret = new HashMap<>();
				
		HashMap<String, Object> param = new HashMap<>();
		param.put("srch_val", srch_val);
		param.put("srch_type", srch_type);
		param.put("u_id", session.getAttribute("loginID").toString());
		
		int total = dao.selectTargetTotal(param);
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<TargetVO> t_list = dao.selectTargetList(navi.getStartRecord(), countPerPage, param);
		
		ret.put("list", t_list);
		// 페이징 처리용
		ret.put("startPageGroup", navi.getStartPageGroup());
		ret.put("endPageGroup", navi.getEndPageGroup());
		ret.put("currentPage", navi.getCurrentPage());
		
		return ret;
	}
	
	/**
	 * 타겟 정보 수정
	 * @param vo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="updateTarget", method=RequestMethod.POST)
	public int updateTarget(TargetVO vo) {
		log.debug("updateTarget : vo::{}", vo);
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("t_birth", securityUtil.checkData(vo.getT_birth()));
		param.put("t_id", securityUtil.checkData(vo.getT_id()));
		param.put("t_name", securityUtil.checkData(vo.getT_name()));
		param.put("t_group", securityUtil.checkData(vo.getT_group()));
		
		
	
		return dao.updateTarget(param);
	}
	
	/**
	 * 타겟관련 가계부 리스트얻기
	 * @param t_id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getTargetAccList")
	public ArrayList<DataVO> getTargetAccBookList(String t_id, String ta_type) {
		log.debug("getTargetAccBookList : t_id::{}", t_id);
		HashMap<String, Object> param = new HashMap<>();
		param.put("t_id", t_id);
		param.put("ta_type", ta_type);
		return dao.selectTargetAccBook(param);
	}
	
	/**
	 * 타겟 가계부 등록
	 * @param vo 가계부 객체
	 * @param t_url 타겟주소의 정보가 있는 url
	 * @param address 타겟의 주소 (도로명 혹은 지번)
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="addAccbook"
	, method=RequestMethod.POST
	, produces="application/json;charset=UTF-8")
	public int addAccBook(
			TargetAccBookVO vo
			, String t_url
			, String address
			, HttpSession session) {
		log.debug("addAccBook : vo :: {}", vo);
		
	
		
		vo.setT_id(securityUtil.checkData(vo.getT_id()));
		vo.setTa_date(securityUtil.checkData(vo.getTa_date()));
		vo.setTa_memo(securityUtil.checkData(vo.getTa_memo()));
		vo.setT_name(securityUtil.checkData(vo.getT_name()));
		vo.setT_id(securityUtil.checkData(vo.getT_id()));
		vo.setT_group(securityUtil.checkData(vo.getT_group()));
		
		
		return dao.insertTargetAccbook(vo, 
				session.getAttribute("loginID").toString(), t_url, address);
	}
	
	/**
	 * 타겟 삭제
	 * @param t_id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="deleteTarget", method=RequestMethod.POST)
	public int deleteTarget(String t_id) {
		log.debug("deleteTarget : t_id::{}", t_id);
		return dao.deleteTarget(t_id);
	}
	
	/**
	 * 타겟 등록
	 * @param vo 타겟의 정보
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="addTarget", method=RequestMethod.POST)
	public int insertTarget(TargetAccBookVO vo, HttpSession session) {
		log.debug("addTarget : vo::{}", vo);
		
		
		vo.setT_id(securityUtil.checkData(vo.getT_id()));
		vo.setTa_date(securityUtil.checkData(vo.getTa_date()));
		vo.setTa_memo(securityUtil.checkData(vo.getTa_memo()));
		vo.setT_name(securityUtil.checkData(vo.getT_name()));
		vo.setT_id(securityUtil.checkData(vo.getT_id()));
		vo.setT_group(securityUtil.checkData(vo.getT_group()));
		
		return dao.insertTarget(vo, session.getAttribute("loginID").toString());
	}
}
