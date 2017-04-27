package global.sesoc.project2.msm.util;

public class securityUtil {
	//Cross_site_Scripting 방지 글자 입력시 HTML 태그로 인한 작동 불가능
	
	public static String checkData(String checkData){
		if(checkData!=null){
			checkData = checkData.replaceAll("<", "&lt");
			checkData = checkData.replaceAll(">", "&gt");
			/*checkData = checkData.replaceAll("&","&amp;");
			checkData = checkData.replaceAll("\"","&quot;");
			checkData = checkData.replaceAll("\'","&#x27;");
			checkData = checkData.replaceAll("/","&#x2F;");
			checkData = checkData.replaceAll("(","&#40;");
			checkData = checkData.replaceAll(")","&#41;");*/
		}
		return checkData;
	}
	
	/*크로스사이트 요청 위조  :  사용자의 의도하지 않은 상황에서 수정 삭제가 이루어질 경우 -> GET으로 파라미터 값을 전달 사용하면 일어날 수 있음CSRF 공격에 노출 
	대처방법 -  POST 폼으로 히든값 넣어 발송 및 보안용 토큰 사용 */
	
	//정수 오버플로우 : 정수형 변수의 사이즈가 너무 크면 아주 작은수 혹은 음수가 될 수 있으므로 그 값의 길이를 제한하여 -대처 입력받게하고 있음


	
	
}
