package global.sesoc.project2.msm.accbook.dao;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import global.sesoc.project2.msm.accbook.mapper.IAccbookMapper;
import global.sesoc.project2.msm.accbook.vo.AccbookSearchVO;
import global.sesoc.project2.msm.accbook.vo.AccbookVO;
import global.sesoc.project2.msm.util.ExcelService;

/**
 * 가계부 자 관련 DB Access Object
 */

@Repository
public class AccbookDAO {
	@Autowired
	SqlSession sqlSession;

	

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
		for (AccbookVO accbookVO : list) {

			
			if(accbookVO.getPayment().equals("현금")){
				money+=accbookVO.getPrice();
			}
			if(accbookVO.getPayment().equals("카드")){
				credit+=accbookVO.getPrice();
			}
			if(accbookVO.getMain_cate().equals("지출")){
				out+=accbookVO.getPrice();
			}
			if(accbookVO.getMain_cate().equals("고정지출")){
				fixed_out+=accbookVO.getPrice();
			}
			if(accbookVO.getMain_cate().equals("수입")){
				in+=accbookVO.getPrice();
			}
			if(accbookVO.getMain_cate().equals("고정수입")){
				fixed_in+=accbookVO.getPrice();
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
	
	
	public int excelUpload(String file_name, String loginId) {
		System.out.println(file_name);
		int ret = 0;
		
		
		IAccbookMapper mapper = sqlSession.getMapper(IAccbookMapper.class);
		List<List<String>> data;
			data = ExcelService.getExcelList(file_name);

		
		// DB insert
		for (List<String> list : data) {
			// 날짜 yyyy-mm-dd 
			String date = list.get(0);
			String a_date = date.substring(0, 4)+"-" + date.substring(5, 7)+"-" + date.substring(8, 10);
			System.out.println(a_date);
			//타입
			String a_type = list.get(1);
			//유형 메인카테고리
			String main_cate = list.get(2);
			//서브카테고리
			String sub_cate = list.get(3);
			//결제수단
			String payment = list.get(4);
			//금액
			int price = Integer.parseInt(list.get(5));

			//메모
			String a_memo = list.get(6);
			
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
			System.out.println(aVO);
				
				// 2.  가계부 등록
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
}
