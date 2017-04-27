package global.sesoc.project2.msm.util;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class msmExceptionHandler {

	@ExceptionHandler(Exception.class)
	public String errorHandler() {

		return "/error"; // views 폴더의 error.jsp로 포워딩
	}
}
