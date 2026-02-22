package com.histudy.study.model;

public class StudyDTO {

	private int study_idx;
	private String study_title;
	private String study_content;
	private String study_start_date;
	private String study_end_date;
	private int study_current_members;
	private int study_max_members;
	private double study_location_lng;
	private double study_location_lat;
	private String study_addr;
	private String study_upload_img;
	private int sc_idx;
	private int user_idx;
	private String study_begin_date;
	private int study_total_weeks;
	private int study_status;
	
	private String sysdate;
	
	private int study_current_weeks;

	private String user_name;
	private String user_email;
	private String sc_name;

	private int taskCount; // 개설자가 쓰는 과제 카운팅
	private int taskCount2; // 참여자가 쓰는 과제 카운팅
	private int studyProgress;

	private int dday;

	private String profile_img;
	
	public StudyDTO() {
		// TODO Auto-generated constructor stub
	}

	public StudyDTO(int study_idx, String study_title, String study_content, String study_start_date,
			String study_end_date, int study_current_members, int study_max_members, double study_location_lng,
			double study_location_lat, String study_addr, String study_upload_img, int sc_idx, int user_idx,
			String study_begin_date, int study_total_weeks, int study_status, String sysdate, int study_current_weeks,
			String user_name, String user_email, String sc_name, int taskCount, int taskCount2, int studyProgress,
			int dday, String profile_img) {
		super();
		this.study_idx = study_idx;
		this.study_title = study_title;
		this.study_content = study_content;
		this.study_start_date = study_start_date;
		this.study_end_date = study_end_date;
		this.study_current_members = study_current_members;
		this.study_max_members = study_max_members;
		this.study_location_lng = study_location_lng;
		this.study_location_lat = study_location_lat;
		this.study_addr = study_addr;
		this.study_upload_img = study_upload_img;
		this.sc_idx = sc_idx;
		this.user_idx = user_idx;
		this.study_begin_date = study_begin_date;
		this.study_total_weeks = study_total_weeks;
		this.study_status = study_status;
		this.sysdate = sysdate;
		this.study_current_weeks = study_current_weeks;
		this.user_name = user_name;
		this.user_email = user_email;
		this.sc_name = sc_name;
		this.taskCount = taskCount;
		this.taskCount2 = taskCount2;
		this.studyProgress = studyProgress;
		this.dday = dday;
		this.profile_img = profile_img;
	}

	public int getStudy_idx() {
		return study_idx;
	}

	public void setStudy_idx(int study_idx) {
		this.study_idx = study_idx;
	}

	public String getStudy_title() {
		return study_title;
	}

	public void setStudy_title(String study_title) {
		this.study_title = study_title;
	}

	public String getStudy_content() {
		return study_content;
	}

	public void setStudy_content(String study_content) {
		this.study_content = study_content;
	}

	public String getStudy_start_date() {
		return study_start_date;
	}

	public void setStudy_start_date(String study_start_date) {
		this.study_start_date = study_start_date;
	}

	public String getStudy_end_date() {
		return study_end_date;
	}

	public void setStudy_end_date(String study_end_date) {
		this.study_end_date = study_end_date;
	}

	public int getStudy_current_members() {
		return study_current_members;
	}

	public void setStudy_current_members(int study_current_members) {
		this.study_current_members = study_current_members;
	}

	public int getStudy_max_members() {
		return study_max_members;
	}

	public void setStudy_max_members(int study_max_members) {
		this.study_max_members = study_max_members;
	}

	public double getStudy_location_lng() {
		return study_location_lng;
	}

	public void setStudy_location_lng(double study_location_lng) {
		this.study_location_lng = study_location_lng;
	}

	public double getStudy_location_lat() {
		return study_location_lat;
	}

	public void setStudy_location_lat(double study_location_lat) {
		this.study_location_lat = study_location_lat;
	}

	public String getStudy_addr() {
		return study_addr;
	}

	public void setStudy_addr(String study_addr) {
		this.study_addr = study_addr;
	}

	public String getStudy_upload_img() {
		return study_upload_img;
	}

	public void setStudy_upload_img(String study_upload_img) {
		this.study_upload_img = study_upload_img;
	}

	public int getSc_idx() {
		return sc_idx;
	}

	public void setSc_idx(int sc_idx) {
		this.sc_idx = sc_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getStudy_begin_date() {
		return study_begin_date;
	}

	public void setStudy_begin_date(String study_begin_date) {
		this.study_begin_date = study_begin_date;
	}

	public int getStudy_total_weeks() {
		return study_total_weeks;
	}

	public void setStudy_total_weeks(int study_total_weeks) {
		this.study_total_weeks = study_total_weeks;
	}

	public int getStudy_status() {
		return study_status;
	}

	public void setStudy_status(int study_status) {
		this.study_status = study_status;
	}

	public String getSysdate() {
		return sysdate;
	}

	public void setSysdate(String sysdate) {
		this.sysdate = sysdate;
	}

	public int getStudy_current_weeks() {
		return study_current_weeks;
	}

	public void setStudy_current_weeks(int study_current_weeks) {
		this.study_current_weeks = study_current_weeks;
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

	public String getSc_name() {
		return sc_name;
	}

	public void setSc_name(String sc_name) {
		this.sc_name = sc_name;
	}

	public int getTaskCount() {
		return taskCount;
	}

	public void setTaskCount(int taskCount) {
		this.taskCount = taskCount;
	}

	public int getTaskCount2() {
		return taskCount2;
	}

	public void setTaskCount2(int taskCount2) {
		this.taskCount2 = taskCount2;
	}

	public int getStudyProgress() {
		return studyProgress;
	}

	public void setStudyProgress(int studyProgress) {
		this.studyProgress = studyProgress;
	}

	public int getDday() {
		return dday;
	}

	public void setDday(int dday) {
		this.dday = dday;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}


	


}