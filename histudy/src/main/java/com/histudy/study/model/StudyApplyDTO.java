package com.histudy.study.model;

public class StudyApplyDTO {
	
	private int sa_idx;
	private String sa_intro;
	private String sa_status;
	private String sa_reason;
	private int user_idx;
	private int study_idx;
	private String join_date;
	private String login_time;
	private String logout_time;
	
	private String ActiveStatus;
	private String user_name;
	private String user_email;
	
	private int taskSubmitCount;
	private int progress;
	
	private int activeCount;
	private String profile_img;
	
	public StudyApplyDTO() {
		// TODO Auto-generated constructor stub
	}

	public StudyApplyDTO(int sa_idx, String sa_intro, String sa_status, String sa_reason, int user_idx, int study_idx,
			String join_date, String login_time, String logout_time, String activeStatus, String user_name,
			String user_email, int taskSubmitCount, int progress, int activeCount, String profile_img) {
		super();
		this.sa_idx = sa_idx;
		this.sa_intro = sa_intro;
		this.sa_status = sa_status;
		this.sa_reason = sa_reason;
		this.user_idx = user_idx;
		this.study_idx = study_idx;
		this.join_date = join_date;
		this.login_time = login_time;
		this.logout_time = logout_time;
		ActiveStatus = activeStatus;
		this.user_name = user_name;
		this.user_email = user_email;
		this.taskSubmitCount = taskSubmitCount;
		this.progress = progress;
		this.activeCount = activeCount;
		this.profile_img = profile_img;
	}

	public int getSa_idx() {
		return sa_idx;
	}

	public void setSa_idx(int sa_idx) {
		this.sa_idx = sa_idx;
	}

	public String getSa_intro() {
		return sa_intro;
	}

	public void setSa_intro(String sa_intro) {
		this.sa_intro = sa_intro;
	}

	public String getSa_status() {
		return sa_status;
	}

	public void setSa_status(String sa_status) {
		this.sa_status = sa_status;
	}

	public String getSa_reason() {
		return sa_reason;
	}

	public void setSa_reason(String sa_reason) {
		this.sa_reason = sa_reason;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getStudy_idx() {
		return study_idx;
	}

	public void setStudy_idx(int study_idx) {
		this.study_idx = study_idx;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getLogin_time() {
		return login_time;
	}

	public void setLogin_time(String login_time) {
		this.login_time = login_time;
	}

	public String getLogout_time() {
		return logout_time;
	}

	public void setLogout_time(String logout_time) {
		this.logout_time = logout_time;
	}

	public String getActiveStatus() {
		return ActiveStatus;
	}

	public void setActiveStatus(String activeStatus) {
		ActiveStatus = activeStatus;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public int getTaskSubmitCount() {
		return taskSubmitCount;
	}

	public void setTaskSubmitCount(int taskSubmitCount) {
		this.taskSubmitCount = taskSubmitCount;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}

	public int getActiveCount() {
		return activeCount;
	}

	public void setActiveCount(int activeCount) {
		this.activeCount = activeCount;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	

}
