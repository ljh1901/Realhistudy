package com.histudy.studycafe.model;

public class StudycafeReplyFile {
	private int review_file_idx;
	private int review_idx;
	private String file_path;
	private String file_type;
	private int file_order;
	private String created_at;
	public StudycafeReplyFile() {
		super();
	}
	public StudycafeReplyFile(int review_file_idx, int review_idx, String file_path, String file_type, int file_order,
			String created_at) {
		super();
		this.review_file_idx = review_file_idx;
		this.review_idx = review_idx;
		this.file_path = file_path;
		this.file_type = file_type;
		this.file_order = file_order;
		this.created_at = created_at;
	}
	public int getReview_file_idx() {
		return review_file_idx;
	}
	public void setReview_file_idx(int review_file_idx) {
		this.review_file_idx = review_file_idx;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public int getFile_order() {
		return file_order;
	}
	public void setFile_order(int file_order) {
		this.file_order = file_order;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
}
