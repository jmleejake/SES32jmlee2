package global.sesoc.project2.msm.util;

/**
 * 추가 지출 내역  기입 객체 2017. 4. 13 작성
 * 객체 사용 목적 : 지출 범위 규정에 따른 데이터 입력 처리 목적 매개 객체 
 * @author KIM TAE HEE
 *
 */

public class ExpenditureInsertProcedure {
	
	private String expenseDate; // 지출 기입 일자
	private String subCategory; // 지출 대상의 서브 카테고리 내역
	private String expensePayment; //결제 수단
	private String memo; // 지출 내역에 대한 기타 메모
	private int relevantPrice; // 현재 지출 희망 가격
	private int allowedExpenseRange; // 이번 달 변동 지출 허용 전체 범위 액수 - 지난 달 변동 지출 총 액수의 3% 내외 <초과 범위에 대해서만 규제> (ex. 388,207원)
	private int fixedExpenseRange; // 이번달 고정형 변동 지출 허용 범위 액수 
	private int floatingExpenseRange; // 이번달 유동형 변동 지출 허용 범위 액수
	private int fixedExpenseSum; // 이번달 내 누적 고정형 변동 지출 합계 액수
	private int floatingExpenseSum; // 이번달 누적 변동형 변동 지출 합계 액수
	private String alertMessage; // 범위 규정에 대한 알림 및 특정 사항에 대한 처리 지시 메세지
	
	public ExpenditureInsertProcedure() {
	}

	public ExpenditureInsertProcedure(String expenseDate, String subCategory, String expensePayment, String memo,
			int relevantPrice, int allowedExpenseRange, int fixedExpenseRange, int floatingExpenseRange,
			int fixedExpenseSum, int floatingExpenseSum, String alertMessage) {
		this.expenseDate = expenseDate;
		this.subCategory = subCategory;
		this.expensePayment = expensePayment;
		this.memo = memo;
		this.relevantPrice = relevantPrice;
		this.allowedExpenseRange = allowedExpenseRange;
		this.fixedExpenseRange = fixedExpenseRange;
		this.floatingExpenseRange = floatingExpenseRange;
		this.fixedExpenseSum = fixedExpenseSum;
		this.floatingExpenseSum = floatingExpenseSum;
		this.alertMessage = alertMessage;
	}

	public String getExpenseDate() {
		return expenseDate;
	}

	public void setExpenseDate(String expenseDate) {
		this.expenseDate = expenseDate;
	}

	public String getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}

	public String getExpensePayment() {
		return expensePayment;
	}

	public void setExpensePayment(String expensePayment) {
		this.expensePayment = expensePayment;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getRelevantPrice() {
		return relevantPrice;
	}

	public void setRelevantPrice(int relevantPrice) {
		this.relevantPrice = relevantPrice;
	}

	public int getAllowedExpenseRange() {
		return allowedExpenseRange;
	}

	public void setAllowedExpenseRange(int allowedExpenseRange) {
		this.allowedExpenseRange = allowedExpenseRange;
	}

	public int getFixedExpenseRange() {
		return fixedExpenseRange;
	}

	public void setFixedExpenseRange(int fixedExpenseRange) {
		this.fixedExpenseRange = fixedExpenseRange;
	}

	public int getFloatingExpenseRange() {
		return floatingExpenseRange;
	}

	public void setFloatingExpenseRange(int floatingExpenseRange) {
		this.floatingExpenseRange = floatingExpenseRange;
	}

	public int getFixedExpenseSum() {
		return fixedExpenseSum;
	}

	public void setFixedExpenseSum(int fixedExpenseSum) {
		this.fixedExpenseSum = fixedExpenseSum;
	}

	public int getFloatingExpenseSum() {
		return floatingExpenseSum;
	}

	public void setFloatingExpenseSum(int floatingExpenseSum) {
		this.floatingExpenseSum = floatingExpenseSum;
	}

	public String getAlertMessage() {
		return alertMessage;
	}

	public void setAlertMessage(String alertMessage) {
		this.alertMessage = alertMessage;
	}

	@Override
	public String toString() {
		return "ExpenditureInsertProcedure [expenseDate=" + expenseDate + ", subCategory=" + subCategory
				+ ", expensePayment=" + expensePayment + ", memo=" + memo + ", relevantPrice=" + relevantPrice
				+ ", allowedExpenseRange=" + allowedExpenseRange + ", fixedExpenseRange=" + fixedExpenseRange
				+ ", floatingExpenseRange=" + floatingExpenseRange + ", fixedExpenseSum=" + fixedExpenseSum
				+ ", floatingExpenseSum=" + floatingExpenseSum + ", alertMessage=" + alertMessage + "]";
	}
}