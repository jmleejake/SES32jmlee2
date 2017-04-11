package global.sesoc.project2.msm.util;
/**
 * 사용자 객체 2017. 4. 7 작성
 * 객체 사용 목적 : Ajax json 객체 활용
 * @author KIM TAE HEE
 */
public class EmergencyExpense {
	private int originalIncome; // 고정 수입
	private int disposableIncome; // 가처분 소득액수(고정 수입-고정 지출)
	private int disposableSavings; // 실저축 액수(가처분 소득 - 변동 지출)
	private int recentEmergencies; // 최근 비상금 액수
	private int pureRemaings; // 순수 잔여 금액
	private int sumAllSavings; // 비상 대비 저축 총 액수(저축 통장+연간 지출)
	
	public EmergencyExpense() {
	}

	public EmergencyExpense(int originalIncome, int disposableIncome, int disposableSavings, int recentEmergencies, int pureRemaings, int sumAllSavings) {
		this.originalIncome = originalIncome;
		this.disposableIncome = disposableIncome;
		this.disposableSavings = disposableSavings;
		this.recentEmergencies = recentEmergencies;
		this.pureRemaings = pureRemaings;
		this.sumAllSavings = sumAllSavings;
	}

	public int getOriginalIncome() {
		return originalIncome;
	}

	public void setOriginalIncome(int originalIncome) {
		this.originalIncome = originalIncome;
	}

	public int getDisposableIncome() {
		return disposableIncome;
	}

	public void setDisposableIncome(int disposableIncome) {
		this.disposableIncome = disposableIncome;
	}

	public int getDisposableSavings() {
		return disposableSavings;
	}

	public void setDisposableSavings(int disposableSavings) {
		this.disposableSavings = disposableSavings;
	}

	public int getRecentEmergencies() {
		return recentEmergencies;
	}

	public void setRecentEmergencies(int recentEmergencies) {
		this.recentEmergencies = recentEmergencies;
	}

	public int getPureRemaings() {
		return pureRemaings;
	}

	public void setPureRemaings(int pureRemaings) {
		this.pureRemaings = pureRemaings;
	}

	public int getSumAllSavings() {
		return sumAllSavings;
	}

	public void setSumAllSavings(int sumAllSavings) {
		this.sumAllSavings = sumAllSavings;
	}

	@Override
	public String toString() {
		return "EmergencyExpense [originalIncome=" + originalIncome + ", disposableIncome=" + disposableIncome
				+ ", disposableSavings=" + disposableSavings + ", recentEmergencies=" + recentEmergencies
				+ ", pureRemaings=" + pureRemaings + ", sumAllSavings=" + sumAllSavings + "]";
	}
}