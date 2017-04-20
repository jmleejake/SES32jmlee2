package global.sesoc.project2.msm.target.vo;

/**
 * 대상자
 */
public class TargetVO {
	private String t_id;
	private String t_name;
	private String t_date;
	private String t_birth;
	private String t_group;
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	public String getT_date() {
		return t_date;
	}
	public void setT_date(String t_date) {
		this.t_date = t_date;
	}
	public String getT_birth() {
		return t_birth != null ? t_birth : "";
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
		return "TargetVO [t_id=" + t_id + ", t_name=" + t_name + ", t_date=" + t_date + ", t_birth=" + t_birth
				+ ", t_group=" + t_group + "]";
	}
}
