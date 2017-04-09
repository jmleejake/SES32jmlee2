package global.sesoc.project2.msm.util;
/**
 * 사용자 객체 2017. 4. 7 작성
 * 객체 변수 : 고정수입(originalIncome), 가처분 소득액(disposableIncome), 실저축 가능액(disposableSavings), 최근 설정 비상금액(recentEmergencies), 순수 잔여금액(pureRemaings)
 * 객체 목적 : Ajax json 객체 활용
 * @author KIM TAE HEE
 */
public class EmergencyExpense {
	private int originalIncome;
	private int disposableIncome;
	private int disposableSavings;
	private int recentEmergencies;
	private int pureRemaings;
	
	public EmergencyExpense() {
	}

	public EmergencyExpense(int originalIncome, int disposableIncome, int disposableSavings, int recentEmergencies, int pureRemaings) {
		this.originalIncome = originalIncome;
		this.disposableIncome = disposableIncome;
		this.disposableSavings = disposableSavings;
		this.recentEmergencies = recentEmergencies;
		this.pureRemaings = pureRemaings;
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

	@Override
	public String toString() {
		return "EmergencyExpense [originalIncome=" + originalIncome + ", disposableIncome=" + disposableIncome
				+ ", disposableSavings=" + disposableSavings + ", recentEmergencies=" + recentEmergencies
				+ ", pureRemaings=" + pureRemaings + "]";
	}
}