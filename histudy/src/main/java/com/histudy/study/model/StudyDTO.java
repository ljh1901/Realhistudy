package com.histudy.study.model;

import java.util.*;

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
   private Date study_begin_date;
   private int study_total_weeks;
   
   private String user_name;
   private String sc_name;
 
   
   public StudyDTO() {
      // TODO Auto-generated constructor stub
   }


	public StudyDTO(int study_idx, String study_title, String study_content, String study_start_date, String study_end_date,
			int study_current_members, int study_max_members, double study_location_lng, double study_location_lat,
			String study_addr, String study_upload_img, int sc_idx, int user_idx, Date study_begin_date,
			int study_total_weeks, String user_name, String sc_name) {
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
		this.user_name = user_name;
		this.sc_name = sc_name;
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


	public Date getStudy_begin_date() {
		return study_begin_date;
	}


	public void setStudy_begin_date(Date study_begin_date) {
		this.study_begin_date = study_begin_date;
	}


	public int getStudy_total_weeks() {
		return study_total_weeks;
	}


	public void setStudy_total_weeks(int study_total_weeks) {
		this.study_total_weeks = study_total_weeks;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getSc_name() {
		return sc_name;
	}


	public void setSc_name(String sc_name) {
		this.sc_name = sc_name;
	}

   
}