package com.histudy.admin.model;

import java.util.Date;

public class ReportDTO {
	private int report_idx;
	private String report_type;
	private int target_idx;
	private int reporter_idx;
	private String report_content;
	private Date report_date;      
	private String report_status;

	private String reporter_name; 
	private String target_name; 
	private String report_photo;

	public ReportDTO() {
		
	}

	public int getReport_idx() {
		return report_idx;
	}

	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}

	public String getReport_type() {
		return report_type;
	}

	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}

	public int getTarget_idx() {
		return target_idx;
	}

	public void setTarget_idx(int target_idx) {
		this.target_idx = target_idx;
	}

	public int getReporter_idx() {
		return reporter_idx;
	}

	public void setReporter_idx(int reporter_idx) {
		this.reporter_idx = reporter_idx;
	}

	public String getReport_content() {
		return report_content;
	}

	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}

	public Date getReport_date() {
		return report_date;
	}

	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}

	public String getReport_status() {
		return report_status;
	}

	public void setReport_status(String report_status) {
		this.report_status = report_status;
	}

	public String getReporter_name() {
		return reporter_name;
	}

	public void setReporter_name(String reporter_name) {
		this.reporter_name = reporter_name;
	}

	public String getTarget_name() {
		return target_name;
	}

	public void setTarget_name(String target_name) {
		this.target_name = target_name;
	}

	public String getReport_photo() {
		return report_photo;
	}

	public void setReport_photo(String report_photo) {
		this.report_photo = report_photo;
	}

	
}