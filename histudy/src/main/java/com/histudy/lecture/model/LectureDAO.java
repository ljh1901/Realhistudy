package com.histudy.lecture.model;

import java.util.List;
import java.util.Map;

public interface LectureDAO {
   public List<LectureDTO> lectureList();
   public List<LectureDTO> lectureList(Map<String, Integer> map);
   public LectureDTO lectureContent(int idx);
   public LectureNoteDTO lectureMemoList(Map<String,Object> map);
   public int lectureNoteUpdate(LectureNoteDTO dto);
   public int getTotalCnt();
   public List<LectureReviewDTO> reviewList(int idx); 
   public int lectureNoteInsert(LectureNoteDTO dto);
   public int reviewInsert(LectureReviewDTO dto);
   public Integer lectureLike(LectureLikeDTO dto);
   public Integer lectureHate(LectureHateDTO dto);
   public void lectureLikeUp(int idx);
   public void lectureLikeDown(int idx);
   public void lectureHateUp(int idx);
   public void lectureHateDown(int idx);
   public void lectureLikeDelete(LectureLikeDTO dto);
   public void lectureHateDelete(LectureHateDTO dto);
   public int lectureLikeInsert(LectureLikeDTO dto);
   public int lectureHateInsert(LectureHateDTO dto);
   public int checkReviewCount(Map<String, Object> map);
   public Integer myReview(Map<String,Object> map);
   public int reviewUpdate(LectureReviewDTO dto);
   public int reviewDelete(int review_idx);
   public String scIdx(int lecture_idx);
   public Map<String, Object> getCounts();
   public Map<String, Object> lectureAvgCount(int lecture_idx);
}
