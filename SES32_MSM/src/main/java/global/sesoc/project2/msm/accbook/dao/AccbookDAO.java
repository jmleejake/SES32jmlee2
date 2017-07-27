package global.sesoc.project2.msm.accbook.dao;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import global.sesoc.project2.msm.accbook.mapper.IAccbookMapper;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.util.ExcelService;
import global.sesoc.project2.msm.util.securityUtil;

/**
 * 가계부 자 관련 DB Access Object
 */

@Repository
public class AccbookDAO {
	@Autowired
	SqlSession sqlSession;

	private static final Logger log = LoggerFactory.getLogger(AccbookDAO.class);

	/**
	 * 가계부 등록
	 * 
	 * @param accbook
	 * @return 성공 1 실패 0 반환
	 */
	public int registAccbook(AccbookVO accbook) {
		
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
	
		int result=0;
			result = mapper.insertAccbook(accbook);
		return result;

	}

	/**
	 * 가계부 검색
	 * 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public ArrayList<AccbookVO> getAccbook(int startRecord ,int countPerPage,AccbookSearchVO accbookSearch 
 ) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		ArrayList<AccbookVO> result = mapper.selectAccbook(accbookSearch,rb);
		
		return result;
	}
	/**
	 * 가계부 단일 검색
	 * 
	 * @param a_id
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public AccbookVO getAccbook3(String a_id
 ) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
		AccbookVO result = mapper.selectAccbook3(a_id);
		
		return result;
	}
	
	
	/**
	 * 가계부 검색
	 * 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public HashMap<String, Object>getAccbook2(AccbookSearchVO accbookSearch ) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
		ArrayList<AccbookVO> list = mapper.selectAccbook2(accbookSearch);
		HashMap<String, Object> result = new HashMap<>();
		
		int money=0;
		int credit=0;		
		int fixed_out=0;
		int out=0;
		int fixed_in=0;
		int in=0;
		String top[]= new String [5] ;
		int top_price[] = new int[5];
		int count=0;
		
		list.sort(new addSort());	
		ArrayList<AccbookVO> fixed_out_list = new ArrayList<>();
		ArrayList<AccbookVO> fixed_in_list = new ArrayList<>();
		ArrayList<AccbookVO>  in_list = new ArrayList<>();
		ArrayList<AccbookVO>  out_list = new ArrayList<>();
		
		for (AccbookVO accbookVO : list) {

			
			if(accbookVO.getPayment().equals("현금")){
				money+=accbookVO.getPrice();
			}
			if(accbookVO.getPayment().equals("카드")){
				credit+=accbookVO.getPrice();
			}
			if(accbookVO.getMain_cate().equals("지출")){
				out+=accbookVO.getPrice();
				out_list.add(accbookVO);
			}
			if(accbookVO.getMain_cate().equals("고정지출")){
				fixed_out+=accbookVO.getPrice();
				fixed_out_list.add(accbookVO);	
			}
			if(accbookVO.getMain_cate().equals("수입")){
				in+=accbookVO.getPrice();
				in_list.add(accbookVO);
			}
			if(accbookVO.getMain_cate().equals("고정수입")){
				fixed_in+=accbookVO.getPrice();
				fixed_in_list.add(accbookVO);
			}
			
		}
		result.put("money",money);
		result.put("credit", credit);
		result.put("fixed_out", fixed_out);
		result.put("out", out);
		result.put("fixed_in", fixed_in);
		result.put("in1", in);
		result.put("list", list);
		result.put("size",list.size());
		result.put("out_list", out_list);
		result.put("in_list", in_list);
		result.put("fixed_in_list", fixed_in_list);
		result.put("fixed_out_list", fixed_out_list);
		

		
		return result;
	}
	/**
	 * 년간  가계부분석
	 * 
	 * @param accbookSearch
	 * @return 조건에 맞는 가계부를 반환한다.
	 */
	public HashMap<String, Object>getAccbook4(AccbookSearchVO accbookSearch,String period) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		
		GregorianCalendar today = new GregorianCalendar ( );
		Calendar cal = Calendar.getInstance( );  
		
		HashMap<String, Object> result = new HashMap<>();
		int year = cal.get ( cal.YEAR )-1;
		
		switch (period) {
		case "1년":
			for(int i=0;i<12;i++){			
				today.set(year, i, 1);
				int maxday = today.getActualMaximum ( ( today.DAY_OF_MONTH ) );
				String start_date = year+"-"+(i+1)+"-"+1;
				String end_date = year+"-"+(i+1)+"-"+maxday;
				accbookSearch.setStart_date(start_date);
				accbookSearch.setEnd_date(end_date);
				
			
				ArrayList<AccbookVO> list = mapper.selectAccbook4(accbookSearch);
				list.sort(new addSort());	
				result.put("size",list.size());
				result.put('m'+String.valueOf((i+1)), list);
				result.put("type",period);
				
			}
			break;
		case "상반기":
			for(int i=0;i<6;i++){			
				today.set(year, i, 1);
				int maxday = today.getActualMaximum ( ( today.DAY_OF_MONTH ) );
				
				String start_date = year+"-"+(i+1)+"-"+1;
				String end_date = year+"-"+(i+1)+"-"+maxday;
				accbookSearch.setStart_date(start_date);
				accbookSearch.setEnd_date(end_date);
	
				
				ArrayList<AccbookVO> list = mapper.selectAccbook4(accbookSearch);

				list.sort(new addSort());	
				result.put("size",list.size());
				result.put('m'+String.valueOf((i+1)), list);
				result.put("type",period);

					
			}
			break;
		case "하반기":
			for(int i=6;i<12;i++){			
				today.set(year, i, 1);
				int maxday = today.getActualMaximum ( ( today.DAY_OF_MONTH ) );
				String start_date = year+"-"+(i+1)+"-"+1;
				String end_date = year+"-"+(i+1)+"-"+maxday;
				accbookSearch.setStart_date(start_date);
				accbookSearch.setEnd_date(end_date);

	
				
				ArrayList<AccbookVO> list = mapper.selectAccbook4(accbookSearch);
				list.sort(new addSort());	
				result.put("size",list.size());
				result.put('m'+String.valueOf((i+1)), list);
				result.put("type",period);
					
			}

			break;	
		default:
			break;
		}
		
			
	
		
		return result;
	}

	/**
	 * 가계부 번호로 가계부를 삭제
	 * 
	 * @param a_id
	 * @return 성공 1 실패 0 반환
	 */
	public int deleteAccbook(int a_id) {
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);

		int result = mapper.deleteAccbook(a_id);
		return result;
	}

	/**
	 * 가계부 수정
	 * 
	 * @param accbook
	 * @return 성공 1 실패 0 반환
	 */
	public int updateAccbook(AccbookVO accbook){
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);

		int result = mapper.updateAccbook(accbook);
		return result;
	}
	
	public int getTotal(AccbookSearchVO accbookSearch){
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);

		int result = mapper.getTotal(accbookSearch);
		return result;
		
	}
	
	@Transactional
	public int excelUpload(String file_name, String loginId) {
		int ret = 0;
		
		
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		List<List<String>> data;
			data = ExcelService.getExcelList(file_name);

		
		// DB insert
		for (List<String> list : data) {
			// 날짜 yyyy-mm-dd 
			String date = securityUtil.checkData(list.get(0));
			String a_date = date.substring(0, 4)+"-" + date.substring(5, 7)+"-" + date.substring(8, 10);
			//타입
			String a_type = securityUtil.checkData(list.get(1));
			//유형 메인카테고리
			String main_cate = securityUtil.checkData(list.get(2));
			//서브카테고리
			String sub_cate =null;
			if(a_type.equals("OUT") && list.get(3).equals("기타")){
				sub_cate = securityUtil.checkData("지출"+list.get(3));				
			}else if(a_type.equals("INC") && list.get(3).equals("기타")){
				sub_cate = securityUtil.checkData("수입"+list.get(3));		
			}else{
				sub_cate = securityUtil.checkData(list.get(3));	
			}
			//결제수단
			String payment = securityUtil.checkData(list.get(4));
			//금액
			int price = Integer.parseInt(list.get(5));

			//메모
			String a_memo = securityUtil.checkData(list.get(6));
			
			//1. 가계부 등록
			AccbookVO aVO = new AccbookVO();
			aVO.setU_id(loginId);
			aVO.setA_date(a_date);
			aVO.setA_type(a_type);
			aVO.setMain_cate(main_cate);
			aVO.setSub_cate(sub_cate);
			aVO.setPayment(payment);
			aVO.setPrice(price);
			aVO.setA_memo(a_memo);
				
			ret  += mapper.insertAccbook(aVO);
		}
		
		return ret;
	}
	
	//정렬
	private static class addSort implements Comparator<AccbookVO> {

		@Override
		public int compare(AccbookVO o1, AccbookVO o2) {
			return o2.getPrice() - o1.getPrice();
		}

	}
	
	/**
	 * 안드로이드 카드결제관련 문자메시지 등록처리
	 * @param data 안드로이드에서 넘어온 결제데이터 
	 * @return
	 */
	@Transactional
	public String androidUpload(String data) {
		log.debug("androidUpload :: \n{}", data);
		
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		String ret = null;
		
		JSONArray array;
		try {
			array = new JSONArray(data);
			
			String user_id = array.getJSONObject(0).getString("user_id");
			int insertRet = 0;
			
			for (int i = 0; i < array.length(); i++) {
				JSONObject obj = array.getJSONObject(i);
				
				String date = obj.getString("date");
				String content = obj.getString("content");
				
				AccbookVO vo = new AccbookVO();
				vo.setU_id(user_id);
				vo.setA_date(date);
				vo.setA_type("OUT");
				vo.setMain_cate("지출");
				vo.setSub_cate("기타");
				vo.setPayment("카드");
				
				String price = null;
				
				Pattern p = Pattern.compile("[\\d,\\-]+원");
				Matcher m = p.matcher(content);
				if (m.find()) {
					price = m.group();
					price = price.replace("원", "").replace(",", "");
				} else {
					log.debug("일치되지 않음!");
				}
				
				vo.setPrice(Integer.parseInt(price));
				vo.setA_memo(content);
				
				log.debug("androidUpload :: before insert\n{}", vo);
				
				insertRet = mapper.insertAccbook(vo);
			}
			
			JSONObject obj = new JSONObject();
			if(insertRet > 0) {
				obj.put("result", "처리 성공했습니다. MSM홈페이지에서 확인하세요.");
			} else {
				obj.put("result", "처리에 실패했습니다.");
			}
			
			try {
				ret = URLEncoder.encode(obj.toString(), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		log.debug("androidUpload :: RET: {}", ret);
		return ret;
	}
}
