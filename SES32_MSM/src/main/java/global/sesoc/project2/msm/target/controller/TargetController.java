package global.sesoc.project2.msm.target.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

/**
 * 대상자 관련 콘트롤러
 */
@Controller
@RequestMapping("target")
public class TargetController {
	Logger log = LoggerFactory.getLogger(TargetController.class);
	
	// config.properties사용하여 값 가져오기
	@Value("#{config['EXCEL_UPLOAD_PATH']}")
	String uploadPath;

	@RequestMapping(value="excelUpload", method=RequestMethod.POST)
	public String excelUpload(MultipartFile file_up) {
		
		
		log.info("excelUpload :: POST");
		log.info(uploadPath);
		
		log.info("contentType: {}", file_up.getContentType());
		log.info("name: {}", file_up.getName());
		log.info("original name: {}", file_up.getOriginalFilename());
		log.info("size: {}", file_up.getSize());
		
		if(!file_up.isEmpty()) {
			
		}
		
		return "";
	}
}
