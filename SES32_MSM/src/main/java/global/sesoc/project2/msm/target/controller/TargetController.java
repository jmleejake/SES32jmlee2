package global.sesoc.project2.msm.target.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.project2.msm.target.vo.TargetVO;

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
	public String excelUpload(
			TargetVO vo
			, MultipartFile upload
			, Model model) {
		
		log.debug("excelUpload :: POST");
		log.debug(uploadPath);
		log.debug("vo :: {}", vo);
		
		log.debug("contentType: {}", upload.getContentType());
		log.debug("name: {}", upload.getName());
		log.debug("original name: {}", upload.getOriginalFilename());
		log.debug("size: {}", upload.getSize());
		
		if(!upload.isEmpty()) {
			
		}
		model.addAttribute("up_ret", "ok");
		return "calendar/calTest";
	}
}
