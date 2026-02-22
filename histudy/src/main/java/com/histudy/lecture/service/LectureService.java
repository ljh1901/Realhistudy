package com.histudy.lecture.service;

import java.util.List;
import java.util.Map;

import com.histudy.lecture.model.LectureDTO;
import com.histudy.lecture.model.LectureHateDTO;
import com.histudy.lecture.model.LectureLikeDTO;
import com.histudy.lecture.model.LectureNoteDTO;
import com.histudy.lecture.model.LectureReviewDTO;

public interface LectureService {
   public List<LectureDTO> lectureList(int cp, int ls) throws Exception;
   public LectureDTO lectureContent(int idx);
   public LectureNoteDTO lectureMemoList(Map<String,Object> map);
   public int lectureNoteUpdate(LectureNoteDTO dto);
   public int getTotalCnt();
   public List<LectureReviewDTO> reviewList(int idx); 
   public int reviewInsert(LectureReviewDTO dto);
   public int lectureNoteInsert(LectureNoteDTO dto);
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
