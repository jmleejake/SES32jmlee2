package global.sesoc.project2.msm.calendar.vo;

/**
 * Calendar VO
 *
 */
public class CalendarVO {
	private int id; // dhtmlx calendar: 아이디
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
	private String _end_date; // dhtmlx calendar: 반복설정시 종료일자
	private String event_pid; // dhtmlx calendar: 반복설정시 parent_id 최초등록 이벤트으로 설정, 이후에는 최초 이벤트의 id로 세팅
	private long event_length; // dhtmlx calendar: 반복설정시 필요한 parameter
	private String _start_date; // dhtmlx calendar: 매월 반복 설정시 시작일자
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String get_end_date() {
		return _end_date;
	}
	public void set_end_date(String _end_date) {
		this._end_date = _end_date;
	}
	public String getEvent_pid() {
		return event_pid;
	}
	public void setEvent_pid(String event_pid) {
		this.event_pid = event_pid;
	}
	public long getEvent_length() {
		return event_length;
	}
	public void setEvent_length(long event_length) {
		this.event_length = event_length;
	}
	public String get_start_date() {
		return _start_date;
	}
	public void set_start_date(String _start_date) {
		this._start_date = _start_date;
	}
	
	@Override
	public String toString() {
		return "CalendarVO [id=" + id + ", u_id=" + u_id + ", t_id=" + t_id + ", text=" + text + ", start_date="
				+ start_date + ", end_date=" + end_date + ", c_target=" + c_target + ", c_location=" + c_location
				+ ", alarm_yn=" + alarm_yn + ", alarm_val=" + alarm_val + ", content=" + content + ", period_yn="
				+ period_yn + ", rec_type=" + rec_type + ", _end_date=" + _end_date + ", event_pid=" + event_pid
				+ ", event_length=" + event_length + ", _start_date=" + _start_date + "]";
	}
}
