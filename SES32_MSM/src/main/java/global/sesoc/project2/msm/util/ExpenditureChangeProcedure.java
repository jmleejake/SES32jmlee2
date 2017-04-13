package global.sesoc.project2.msm.util;
/**
 * 추가 지출 내역  기입 객체 2017. 4. 12 작성
 * 객체 사용 목적 : 추가로 지출된 내역을 업데이트 시키기 위한 매개 역할 
 * @author KIM TAE HEE
 *
 */

public class ExpenditureChangeProcedure {
	
	private String expenseDate; // 기입 일자
	private String expenseSubCategory; // 지출 내용(하위 카테고리 내역)
	private String expensePayment; // 결제 수단
	private int expensePrice; // 결제 가격
	private String expenseMemo; // 메모
	
	public ExpenditureChangeProcedure() {
	}

	public ExpenditureChangeProcedure(String expenseDate, String expenseSubCategory, String expensePayment, int expensePrice, String expenseMemo) {
		this.expenseDate = expenseDate;
		this.expenseSubCategory = expenseSubCategory;
		this.expensePayment = expensePayment;
		this.expensePrice = expensePrice;
		this.expenseMemo = expenseMemo;
	}

	public String getExpenseDate() {
		return expenseDate;
	}

	public void setExpenseDate(String expenseDate) {
		this.expenseDate = expenseDate;
	}

	public String getExpenseSubCategory() {
		return expenseSubCategory;
	}

	public void setExpenseSubCategory(String expenseSubCategory) {
		this.expenseSubCategory = expenseSubCategory;
	}

	public String getExpensePayment() {
		return expensePayment;
	}

	public void setExpensePayment(String expensePayment) {
		this.expensePayment = expensePayment;
	}

	public int getExpensePrice() {
		return expensePrice;
	}

	public void setExpensePrice(int expensePrice) {
		this.expensePrice = expensePrice;
	}

	public String getExpenseMemo() {
		return expenseMemo;
	}

	public void setExpenseMemo(String expenseMemo) {
		this.expenseMemo = expenseMemo;
	}

	@Override
	public String toString() {
		return "ExpenditureChangeProcedure [expenseDate=" + expenseDate + ", expenseSubCategory=" + expenseSubCategory
				+ ", expensePayment=" + expensePayment + ", expensePrice=" + expensePrice + ", expenseMemo="
				+ expenseMemo + "]";
	}
}
