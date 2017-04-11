package global.sesoc.project2.msm.accbook.vo;

import java.util.Arrays;

//상세검색을 위한 객체
public class AccbookSearchVO {
	
	private String u_id; //user 아이디
	private String start_date; // 검색 기간 시작 
	private String end_date;  // 검색 기간 끝
	private String [] main_cates; //메인 카테고리들이 담긴 배열 
	private String [] sub_cates; //서브 카테고리들이 담긴 배열
	private String type; //타입(수입,지출,비상금,전체)
	private String []payment; //결제 수단
	private String keyWord; //메모 검색 
	private int page; //현재페이지
	private int startPageGroup; //페이징 처리 시작
	private int endPageGroup;  //페이징 처리 끝
	
	public AccbookSearchVO() {
		super();
	}
	
	
	public String getU_id() {
		return u_id;
	}


	public void setU_id(String u_id) {
		this.u_id = u_id;
	}


	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String[] getMain_cates() {
		return main_cates;
	}
	public void setMain_cates(String[] main_cates) {
		this.main_cates = main_cates;
	}
	public String[] getSub_cates() {
		return sub_cates;
	}
	public void setSub_cates(String[] sub_cates) {
		this.sub_cates = sub_cates;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String[] getPayment() {
		return payment;
	}
	public void setPayment(String[] payment) {
		this.payment = payment;
	}
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}


	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		this.page = page;
	}


	public int getStartPageGroup() {
		return startPageGroup;
	}


	public void setStartPageGroup(int startPageGroup) {
		this.startPageGroup = startPageGroup;
	}


	public int getEndPageGroup() {
		return endPageGroup;
	}


	public void setEndPageGroup(int endPageGroup) {
		this.endPageGroup = endPageGroup;
	}


	@Override
	public String toString() {
		return "AccbookSearchVO [u_id=" + u_id + ", start_date=" + start_date + ", end_date=" + end_date
				+ ", main_cates=" + Arrays.toString(main_cates) + ", sub_cates=" + Arrays.toString(sub_cates)
				+ ", type=" + type + ", payment=" + payment + ", keyWord=" + keyWord + ", page=" + page + "]";
	}


	
	
	
	
	
}
