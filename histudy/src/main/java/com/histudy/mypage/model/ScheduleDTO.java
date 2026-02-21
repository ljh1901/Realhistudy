package com.histudy.mypage.model;

import java.sql.Date;

public class ScheduleDTO {
	private int schedule_idx;
	private String s_title;
	private String s_content;
	private Date s_end_date;
	private Date s_start_date;
	private int user_idx;
	private int study_idx;
	
	public ScheduleDTO() {
		// TODO Auto-generated constructor stub
	}
	public ScheduleDTO(int schedule_idx, String s_title, String s_content, Date s_end_date, Date s_start_date,
			int user_idx, int study_idx) {
		super();
		this.schedule_idx = schedule_idx;
		this.s_title = s_title;
		this.s_content = s_content;
		this.s_end_date = s_end_date;
		this.s_start_date = s_start_date;
		this.user_idx = user_idx;
		this.study_idx = study_idx;
	}
	public int getSchedule_idx() {
		return schedule_idx;
	}
	public void setSchedule_idx(int schedule_idx) {
		this.schedule_idx = schedule_idx;
	}
	public String getS_title() {
		return s_title;
	}
	public void setS_title(String s_title) {
		this.s_title = s_title;
	}
	public String getS_content() {
		return s_content;
	}
	public void setS_content(String s_content) {
		this.s_content = s_content;
	}
	public Date getS_end_date() {
		return s_end_date;
	}
	public void setS_end_date(Date s_end_date) {
		this.s_end_date = s_end_date;
	}
	public Date getS_start_date() {
		return s_start_date;
	}
	public void setS_start_date(Date s_start_date) {
		this.s_start_date = s_start_date;
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
	
	
}
