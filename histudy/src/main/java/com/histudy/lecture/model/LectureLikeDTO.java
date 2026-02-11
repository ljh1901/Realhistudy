package com.histudy.lecture.model;

public class LectureLikeDTO {
	private int like_idx,user_idx,lecture_idx;
public LectureLikeDTO() {
	// TODO Auto-generated constructor stub
}
	public LectureLikeDTO(int like_idx, int user_idx, int lecture_idx) {
		super();
		this.like_idx = like_idx;
		this.user_idx = user_idx;
		this.lecture_idx = lecture_idx;
	}
	public int getLike_idx() {
		return like_idx;
	}
	public void setLike_idx(int like_idx) {
		this.like_idx = like_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getLecture_idx() {
		return lecture_idx;
	}
	public void setLecture_idx(int lecture_idx) {
		this.lecture_idx = lecture_idx;
	}
	
}
