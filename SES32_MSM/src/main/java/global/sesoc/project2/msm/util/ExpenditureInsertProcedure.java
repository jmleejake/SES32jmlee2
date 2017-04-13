package global.sesoc.project2.msm.util;

/**
 * 추가 지출 내역  기입 객체 2017. 4. 13 작성
 * 객체 사용 목적 : 지출 범위 규정에 따른 데이터 입력 처리 목적 매개 객체 
 * @author KIM TAE HEE
 *
 */

public class ExpenditureInsertProcedure {
	
	private int allowedExpenseRange; // 이번 달 변동 지출 허용 전체 범위 액수 - 지난 달 변동 지출 총 액수의 3% 내외 <초과 범위에 대해서만 규제> (ex. 388,207원)
	private int fixedExpenseRange; // 이번달 고정형 변동 지출 허용 범위 액수 
	private int floatingExpenseRange; // 이번달 유동형 변동 지출 허용 범위 액수
	private int fixedExpenseSum; // 이번달 내 누적 고정형 변동 지출 합계 액수
	private int floatingExpenseSum; // 이번달 누적 변동형 변동 지출 합계 액수
	private String subCategory; // 지출 대상의 서브 카테고리 내역
	private String memo; // 지출 내역에 대한 기타 메모
	private String alertMessage; // 범위 규정에 대한 알림 및 특정 사항에 대한 처리 지시 메세지
	
	public ExpenditureInsertProcedure() {
	}

	public ExpenditureInsertProcedure(int allowedExpenseRange, int fixedExpenseRange, int floatingExpenseRange, int fixedExpenseSum, int floatingExpenseSum, String subCategory, String memo, String alertMessage) {
		this.allowedExpenseRange = allowedExpenseRange;
		this.fixedExpenseRange = fixedExpenseRange;
		this.floatingExpenseRange = floatingExpenseRange;
		this.fixedExpenseSum = fixedExpenseSum;
		this.floatingExpenseSum = floatingExpenseSum;
		this.subCategory = subCategory;
		this.memo = memo;
		this.alertMessage = alertMessage;
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

	public String getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getAlertMessage() {
		return alertMessage;
	}

	public void setAlertMessage(String alertMessage) {
		this.alertMessage = alertMessage;
	}

	@Override
	public String toString() {
		return "ExpenditureInsertProcedure [allowedExpenseRange=" + allowedExpenseRange + ", fixedExpenseRange="
				+ fixedExpenseRange + ", floatingExpenseRange=" + floatingExpenseRange + ", fixedExpenseSum="
				+ fixedExpenseSum + ", floatingExpenseSum=" + floatingExpenseSum + ", subCategory=" + subCategory
				+ ", memo=" + memo + ", alertMessage=" + alertMessage + "]";
	}
}