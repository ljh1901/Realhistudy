package com.histudy.lecture.model;

public class LectureNoteDTO {
   int note_idx;
   String note_title;
   String note_content;
   int user_idx;
   int lecture_idx;
   String lecture_name;
   
   
   public String getLecture_name() {
	return lecture_name;
}

public void setLecture_name(String lecture_name) {
	this.lecture_name = lecture_name;
}

public LectureNoteDTO() {
      // TODO Auto-generated constructor stub
   }
   
   public int getNote_idx() {
      return note_idx;
   }
   public void setNote_idx(int note_idx) {
      this.note_idx = note_idx;
   }
   public String getNote_title() {
      return note_title;
   }
   public void setNote_title(String note_title) {
      this.note_title = note_title;
   }
   public String getNote_content() {
      return note_content;
   }
   public void setNote_content(String note_content) {
      this.note_content = note_content;
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
   public LectureNoteDTO(int note_idx, String note_title, String note_content, int user_idx, int lecture_idx) {
      super();
      this.note_idx = note_idx;
      this.note_title = note_title;
      this.note_content = note_content;
      this.user_idx = user_idx;
      this.lecture_idx = lecture_idx;
   }
   
   
}
