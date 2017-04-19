package global.sesoc.project2.msm.calendar.vo;

/**
 * Calendar VO
 *
 */
public class CalendarVO {
	private String id; // dhtmlx calendar: 아이디
	private String u_id;
	private String t_id;
	private String text; // dhtmlx calendar: 제목
	private String start_date; // dhtmlx calendar: 시작시간
	private String end_date; // dhtmlx calendar: 종료시간
	private String c_target;
	private String c_location;
	private String alarm_yn;
	private String alarm_val; // dhtmlx calendar: 알람설정
	private String content; // dhtmlx calendar: 내용
	private String repeat_type; // dhtmlx calendar: 반복설정
	private String repeat_end_date; // dhtmlx calendar: 반복 종료일자
	private String is_dbdata; // dhtmlx calendar: 수정/등록 판별변수
	private String color; // dhtmlx calendar: 색상설정
	private String dday; // 메인화면에 출력시 항목중 하나인 d-day
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
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
	public String getRepeat_type() {
		return repeat_type;
	}
	public void setRepeat_type(String repeat_type) {
		this.repeat_type = repeat_type;
	}
	public String getRepeat_end_date() {
		return repeat_end_date;
	}
	public void setRepeat_end_date(String repeat_end_date) {
		this.repeat_end_date = repeat_end_date;
	}
	public String getIs_dbdata() {
		return is_dbdata;
	}
	public void setIs_dbdata(String is_dbdata) {
		this.is_dbdata = is_dbdata;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getDday() {
		return dday;
	}
	public void setDday(String dday) {
		this.dday = dday;
	}
	
	@Override
	public String toString() {
		return "CalendarVO [id=" + id + ", u_id=" + u_id + ", t_id=" + t_id + ", text=" + text + ", start_date="
				+ start_date + ", end_date=" + end_date + ", c_target=" + c_target + ", c_location=" + c_location
				+ ", alarm_yn=" + alarm_yn + ", alarm_val=" + alarm_val + ", content=" + content + ", repeat_type="
				+ repeat_type + ", repeat_end_date=" + repeat_end_date + ", is_dbdata=" + is_dbdata + ", color=" + color
				+ ", dday=" + dday + "]";
	}
	
}
