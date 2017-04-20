package global.sesoc.project2.msm.target.vo;

import global.sesoc.project2.msm.util.DataVO;

/**
 * 대상자관련 가계부
 */
public class TargetAccBookVO extends DataVO {
	private int ta_id;
	private String t_id;
	private String ta_date;
	private int ta_price;
	private String ta_type;
	private String ta_memo;
	private String t_name;
	private String t_birth;
	private String t_group;
	
	public int getTa_id() {
		return ta_id;
	}
	public void setTa_id(int ta_id) {
		this.ta_id = ta_id;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getTa_date() {
		return ta_date;
	}
	public void setTa_date(String ta_date) {
		this.ta_date = ta_date;
	}
	public int getTa_price() {
		return ta_price;
	}
	public void setTa_price(int ta_price) {
		this.ta_price = ta_price;
	}
	public String getTa_type() {
		return ta_type;
	}
	public void setTa_type(String ta_type) {
		this.ta_type = ta_type;
	}
	public String getTa_memo() {
		return ta_memo;
	}
	public void setTa_memo(String ta_memo) {
		this.ta_memo = ta_memo;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	public String getT_birth() {
		return t_birth;
	}
	public void setT_birth(String t_birth) {
		this.t_birth = t_birth;
	}
	public String getT_group() {
		return t_group;
	}
	public void setT_group(String t_group) {
		this.t_group = t_group;
	}
	
	@Override
	public String toString() {
		return "TargetAccBookVO [ta_id=" + ta_id + ", t_id=" + t_id + ", ta_date=" + ta_date + ", ta_price=" + ta_price
				+ ", ta_type=" + ta_type + ", ta_memo=" + ta_memo + ", t_name=" + t_name + ", t_birth=" + t_birth
				+ ", t_group=" + t_group + "]";
	}
}
