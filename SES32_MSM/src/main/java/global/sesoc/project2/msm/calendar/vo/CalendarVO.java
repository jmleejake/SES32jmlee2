package global.sesoc.project2.msm.calendar.vo;

/**
 * Calendar VO
 *
 */
public class CalendarVO {
	private int c_id;
	private String u_id;
	private int t_id;
	private String c_title;
	private String c_start_time;
	private String c_end_time;
	private String c_target;
	private String c_location;
	private String alarm_yn;
	private String alarm_val;
	private String c_memo;
	private String period_yn;
	private String period_val;
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public String getC_title() {
		return c_title;
	}
	public void setC_title(String c_title) {
		this.c_title = c_title;
	}
	public String getC_start_time() {
		return c_start_time;
	}
	public void setC_start_time(String c_start_time) {
		this.c_start_time = c_start_time;
	}
	public String getC_end_time() {
		return c_end_time;
	}
	public void setC_end_time(String c_end_time) {
		this.c_end_time = c_end_time;
	}
	public String getC_target() {
		return c_target;
	}
	public void setC_target(String c_target) {
		this.c_target = c_target;
	}
	public String getC_location() {
		return c_location;
	}
	public void setC_location(String c_location) {
		this.c_location = c_location;
	}
	public String getAlarm_yn() {
		return alarm_yn;
	}
	public void setAlarm_yn(String alarm_yn) {
		this.alarm_yn = alarm_yn;
	}
	public String getAlarm_val() {
		return alarm_val;
	}
	public void setAlarm_val(String alarm_val) {
		this.alarm_val = alarm_val;
	}
	public String getC_memo() {
		return c_memo;
	}
	public void setC_memo(String c_memo) {
		this.c_memo = c_memo;
	}
	public String getPeriod_yn() {
		return period_yn;
	}
	public void setPeriod_yn(String period_yn) {
		this.period_yn = period_yn;
	}
	public String getPeriod_val() {
		return period_val;
	}
	public void setPeriod_val(String period_val) {
		this.period_val = period_val;
	}
	@Override
	public String toString() {
		return "CalendarVO [c_id=" + c_id + ", u_id=" + u_id + ", t_id=" + t_id + ", c_title=" + c_title
				+ ", c_start_time=" + c_start_time + ", c_end_time=" + c_end_time + ", c_target=" + c_target
				+ ", c_location=" + c_location + ", alarm_yn=" + alarm_yn + ", alarm_val=" + alarm_val + ", c_memo="
				+ c_memo + ", period_yn=" + period_yn + ", period_val=" + period_val + "]";
	}
}
