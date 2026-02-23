package com.histudy.studycafe.model;

import java.util.List;

public class StudycafeReplyDTO {
	private int review_idx;
	private int user_idx;
	private int studycafe_idx;
	private String studycafe_reply;
	private double studycafe_rating;
	private String created_at;
	private List<StudycafeReplyFileDTO> fileList;
	
	public StudycafeReplyDTO() {
		super();
	}
	public StudycafeReplyDTO(int review_idx, int user_idx, int studycafe_idx, String studycafe_reply,
			double studycafe_rating, String created_at) {
		super();
		this.review_idx = review_idx;
		this.user_idx = user_idx;
		this.studycafe_idx = studycafe_idx;
		this.studycafe_reply = studycafe_reply;
		this.studycafe_rating = studycafe_rating;
		this.created_at = created_at;
	}
	
	
	
	
	public StudycafeReplyDTO(int review_idx, int user_idx, int studycafe_idx, String studycafe_reply,
			double studycafe_rating, String created_at, List<StudycafeReplyFileDTO> fileList) {
		super();
		this.review_idx = review_idx;
		this.user_idx = user_idx;
		this.studycafe_idx = studycafe_idx;
		this.studycafe_reply = studycafe_reply;
		this.studycafe_rating = studycafe_rating;
		this.created_at = created_at;
		this.fileList = fileList;
	}
	public List<StudycafeReplyFileDTO> getFileList() {
		return fileList;
	}
	public void setFileList(List<StudycafeReplyFileDTO> fileList) {
		this.fileList = fileList;
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
	public int getStudycafe_idx() {
		return studycafe_idx;
	}
	public void setStudycafe_idx(int studycafe_idx) {
		this.studycafe_idx = studycafe_idx;
	}
	public String getStudycafe_reply() {
		return studycafe_reply;
	}
	public void setStudycafe_reply(String studycafe_reply) {
		this.studycafe_reply = studycafe_reply;
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
	
	
}
