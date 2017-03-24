package global.sesoc.project2.msm.accbook.vo;
/**
 * 가계부 VO
 */
public class AccbookVO {
	private int a_id;    // 가계부 넘버 
	private String u_id;  // 회원 ID
	private String a_date; // 가계부 등록 날짜
	private String a_type; // 가계부 타입(수입,지출,경조사)
	private String main_cate; //메인카테고리 
	private String sub_cate;  //서브카테고리
	private String payment;   //결제수단
	private int price;        //가격
	private String a_memo;    //메모
	
	
	
	public AccbookVO(String u_id, String a_date, String a_type, String main_cate, String sub_cate, String payment,
			int price, String a_memo) {
		super();
		this.u_id = u_id;
		this.a_date = a_date;
		this.a_type = a_type;
		this.main_cate = main_cate;
		this.sub_cate = sub_cate;
		this.payment = payment;
		this.price = price;
		this.a_memo = a_memo;
	}
	public AccbookVO() {
		super();
	}
	public int getA_id() {
		return a_id;
	}
	public void setA_id(int a_id) {
		this.a_id = a_id;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getA_date() {
		return a_date;
	}
	public void setA_date(String a_date) {
		this.a_date = a_date;
	}
	public String getA_type() {
		return a_type;
	}
	public void setA_type(String a_type) {
		this.a_type = a_type;
	}
	public String getMain_cate() {
		return main_cate;
	}
	public void setMain_cate(String main_cate) {
		this.main_cate = main_cate;
	}
	public String getSub_cate() {
		return sub_cate;
	}
	public void setSub_cate(String sub_cate) {
		this.sub_cate = sub_cate;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getA_memo() {
		return a_memo;
	}
	public void setA_memo(String a_memo) {
		this.a_memo = a_memo;
	}
	@Override
	public String toString() {
		return "AccbookVO [a_id=" + a_id + ", u_id=" + u_id + ", a_date=" + a_date + ", a_type=" + a_type
				+ ", main_cate=" + main_cate + ", sub_cate=" + sub_cate + ", payment=" + payment + ", price=" + price
				+ ", a_memo=" + a_memo + "]";
	}
	
	
}
