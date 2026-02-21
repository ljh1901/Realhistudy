package com.histudy.lecture.model;
import java.sql.*;
public class LectureReviewDTO {
   private Integer review_idx;
   private String review_title;
   private String review_content;
   private int review_score;
   private Date review_date;
   private Integer user_idx;
   private Integer lecture_idx;
   private String user_name;
   public int getReview_idx() {
      return review_idx;
   }
   
   public LectureReviewDTO() {
	// TODO Auto-generated constructor stub
}
public String getUser_name() {
	return user_name;
}


public void setUser_name(String user_name) {
	this.user_name = user_name;
}


public String getReview_title() {
	return review_title;
}
public void setReview_title(String review_title) {
	this.review_title = review_title;
}
public String getReview_content() {
	return review_content;
}
public void setReview_content(String review_content) {
	this.review_content = review_content;
}
public int getReview_score() {
	return review_score;
}
public void setReview_score(int review_score) {
	this.review_score = review_score;
}
public Date getReview_date() {
	return review_date;
}
public void setReview_date(Date review_date) {
	this.review_date = review_date;
}
public Integer getUser_idx() {
	return user_idx;
}
public void setUser_idx(Integer user_idx) {
	this.user_idx = user_idx;
}
public Integer getLecture_idx() {
	return lecture_idx;
}
public void setLecture_idx(Integer lecture_idx) {
	this.lecture_idx = lecture_idx;
}
public void setReview_idx(Integer review_idx) {
	this.review_idx = review_idx;
}
public LectureReviewDTO(Integer review_idx, String review_title, String review_content, int review_score,
		Date review_date, Integer user_idx, Integer lecture_idx) {
	super();
	this.review_idx = review_idx;
	this.review_title = review_title;
	this.review_content = review_content;
	this.review_score = review_score;
	this.review_date = review_date;
	this.user_idx = user_idx;
	this.lecture_idx = lecture_idx;
}
   
   
}
