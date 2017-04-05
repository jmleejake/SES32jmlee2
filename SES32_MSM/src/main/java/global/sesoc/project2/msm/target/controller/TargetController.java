package global.sesoc.project2.msm.target.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.project2.msm.target.dao.TargetDAO;
import global.sesoc.project2.msm.target.vo.TargetVO;
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
					int ret = dao.excelUpload(uploadPath + "/" + file_name);
					if(ret > 0) {
						// 업로드 및 DB insert가 완료되면 파일을 삭제한다.
						FileService.deleteFile(uploadPath + "/" + file_name);
					}
				}
				model.addAttribute("up_ret", "ok");
			} else { // 유저가 업로드한 파일이 엑셀이 아닌 다른 파일일때
				model.addAttribute("up_ret", "only excel file!!!");
			}
			
			
			
			return "target/excelService";
		}
}
