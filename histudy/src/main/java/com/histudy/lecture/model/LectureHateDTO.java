package com.histudy.lecture.model;

public class LectureHateDTO {
	private int hate_idx,user_idx,lecture_idx;
	public LectureHateDTO() {
		// TODO Auto-generated constructor stub
	}
	public int getHate_idx() {
		return hate_idx;
	}

	public void setHate_idx(int hate_idx) {
		this.hate_idx = hate_idx;
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

	public LectureHateDTO(int hate_idx, int user_idx, int lecture_idx) {
		super();
		this.hate_idx = hate_idx;
		this.user_idx = user_idx;
		this.lecture_idx = lecture_idx;
	}
	
}
