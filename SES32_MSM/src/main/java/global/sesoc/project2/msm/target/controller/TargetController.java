package global.sesoc.project2.msm.target.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.project2.msm.target.dao.TargetDAO;
import global.sesoc.project2.msm.target.vo.TargetVO;
import global.sesoc.project2.msm.util.ExcelService;
import global.sesoc.project2.msm.util.FileService;

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
	
	@Autowired
	TargetDAO dao;
	
	@RequestMapping("excelTest")
	public String excelServicePage() {
		log.debug("excelServicePage - test page이동");
		return "target/excelService"; 
	}

	@RequestMapping(value="excelUpload", method=RequestMethod.POST)
	public String excelUpload(
			MultipartFile upload
			, Model model) {
		
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
				int ret = dao.excelUpload(up_path);
				if(ret > 0) {
					// 업로드 및 DB insert가 완료되면 파일을 삭제한다.
					boolean del_ret = FileService.deleteFile(up_path);
					log.debug("del?! {}", del_ret);
					log.debug("-----------------엑셀업로드 기능 끝-----------------");
				}
			}
			model.addAttribute("up_ret", "ok");
		} else { // 유저가 업로드한 파일이 엑셀이 아닌 다른 파일일때
			model.addAttribute("up_ret", "only excel file!!!");
		}
		return "target/excelService";
	}
	
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
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		} finally {
			try {
				if(in != null) in.close();
				if(out != null) out.close();
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
	}
	
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
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			} finally {
				try {
					if(in != null) in.close();
					if(out != null) out.close();
				} catch (IOException e) {
					log.error(e.getMessage());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
