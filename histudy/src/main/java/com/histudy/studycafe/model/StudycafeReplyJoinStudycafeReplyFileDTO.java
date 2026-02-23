package com.histudy.studycafe.model;

public class StudycafeReplyJoinStudycafeReplyFileDTO {
	private String user_name;
	private int review_idx;
	private int user_idx;
	private String studycafe_reply;
	private int studycafe_idx;
	private double studycafe_rating;
	private String created_at;
	private int review_file_idx;
	private String file_path;
	private String file_type;
	private int file_order;
	
	
	public StudycafeReplyJoinStudycafeReplyFileDTO() {
		super();
	}


	public StudycafeReplyJoinStudycafeReplyFileDTO(String user_name,int review_idx, int user_idx, String studycafe_reply,
			int studycafe_idx, double studycafe_rating, String created_at, int review_file_idx, String file_path,
			String file_type, int file_order) {
		super();
		this.user_name = user_name;
		this.review_idx = review_idx;
		this.user_idx = user_idx;
		this.studycafe_reply = studycafe_reply;
		this.studycafe_idx = studycafe_idx;
		this.studycafe_rating = studycafe_rating;
		this.created_at = created_at;
		this.review_file_idx = review_file_idx;
		this.file_path = file_path;
		this.file_type = file_type;
		this.file_order = file_order;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public int getReview_idx() {
		return review_idx;
	}


	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}


	public int getUser_idx() {
		return user_idx;
	}


	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}


	public String getStudycafe_reply() {
		return studycafe_reply;
	}


	public void setStudycafe_reply(String studycafe_reply) {
		this.studycafe_reply = studycafe_reply;
	}


	public int getStudycafe_idx() {
		return studycafe_idx;
	}


	public void setStudycafe_idx(int studycafe_idx) {
		this.studycafe_idx = studycafe_idx;
	}


	public double getStudycafe_rating() {
		return studycafe_rating;
	}


	public void setStudycafe_rating(double studycafe_rating) {
		this.studycafe_rating = studycafe_rating;
	}


	public String getCreated_at() {
		return created_at;
	}


	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}


	public int getReview_file_idx() {
		return review_file_idx;
	}


	public void setReview_file_idx(int review_file_idx) {
		this.review_file_idx = review_file_idx;
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
	
	
	
	
}
