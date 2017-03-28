package global.sesoc.project2.msm.calendar.vo;

/**
 * Calendar VO
 *
 */
public class CalendarVO {
	private int c_id;
	private String u_id;
	private int t_id;
	private String text; // dhtmlx calendar: 제목
	private String start_date; // dhtmlx calendar: 시작시간
	private String end_date; // dhtmlx calendar: 종료시간
	private String c_target;
	private String c_location;
	private String alarm_yn;
	private String alarm_val; // dhtmlx calendar: 알람설정
	private String content; // dhtmlx calendar: 내용
	private String period_yn;
	private String rec_type; // dhtmlx calendar: 반복설정
	
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
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPeriod_yn() {
		return period_yn;
	}
	public void setPeriod_yn(String period_yn) {
		this.period_yn = period_yn;
	}
	public String getRec_type() {
		return rec_type;
	}
	public void setRec_type(String rec_type) {
		this.rec_type = rec_type;
	}
	
	@Override
	public String toString() {
		return "CalendarVO [c_id=" + c_id + ", u_id=" + u_id + ", t_id=" + t_id + ", text=" + text + ", start_date="
				+ start_date + ", end_date=" + end_date + ", c_target=" + c_target + ", c_location=" + c_location
				+ ", alarm_yn=" + alarm_yn + ", alarm_val=" + alarm_val + ", content=" + content + ", period_yn="
				+ period_yn + ", rec_type=" + rec_type + "]";
	}
}
