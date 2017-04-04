package global.sesoc.project2.msm.user.vo;
/**
 * 사용자 객체 2017. 3.20 작성
 * 객체 변수 : 아이디, 패스워드, 성명, 이메일, 전화번호, 생년월일, 주소
 * @author KIM TAE HEE
 *
 */
public class UserVO {
	private String u_id;
	private String u_pwd;
	private String u_name;
	private String u_email;
	private String u_phone;
	private String u_birth;
	private String u_address;
	private int u_emergences;
	
	public UserVO() {
	}

	public UserVO(String u_id, String u_pwd, String u_name, String u_email, String u_phone, String u_birth, String u_address, int u_emergences) {
		this.u_id = u_id;
		this.u_pwd = u_pwd;
		this.u_name = u_name;
		this.u_email = u_email;
		this.u_phone = u_phone;
		this.u_birth = u_birth;
		this.u_address = u_address;
		this.u_emergences = u_emergences;
	}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getU_pwd() {
		return u_pwd;
	}

	public void setU_pwd(String u_pwd) {
		this.u_pwd = u_pwd;
	}

	public String getU_name() {
		return u_name;
	}

	public void setU_name(String u_name) {
		this.u_name = u_name;
	}

	public String getU_email() {
		return u_email;
	}

	public void setU_email(String u_email) {
		this.u_email = u_email;
	}

	public String getU_phone() {
		return u_phone;
	}

	public void setU_phone(String u_phone) {
		this.u_phone = u_phone;
	}

	public String getU_birth() {
		return u_birth;
	}

	public void setU_birth(String u_birth) {
		this.u_birth = u_birth;
	}

	public String getU_address() {
		return u_address;
	}

	public void setU_address(String u_address) {
		this.u_address = u_address;
	}

	public int getU_emergences() {
		return u_emergences;
	}

	public void setU_emergences(int u_emergences) {
		this.u_emergences = u_emergences;
	}

	@Override
	public String toString() {
		return "UserVO [u_id=" + u_id + ", u_pwd=" + u_pwd + ", u_name=" + u_name + ", u_email=" + u_email
				+ ", u_phone=" + u_phone + ", u_birth=" + u_birth + ", u_address=" + u_address + ", u_emergences="
				+ u_emergences + "]";
	}
}