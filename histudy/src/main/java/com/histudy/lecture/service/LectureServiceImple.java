package com.histudy.lecture.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.histudy.lecture.model.LectureDAO;
import com.histudy.lecture.model.LectureDTO;
import com.histudy.lecture.model.LectureHateDTO;
import com.histudy.lecture.model.LectureLikeDTO;
import com.histudy.lecture.model.LectureNoteDTO;
import com.histudy.lecture.model.LectureReviewDTO;
public class LectureServiceImple implements LectureService {
   private LectureDAO lectureDao;
   public LectureServiceImple(LectureDAO lectureDao) {
      this.lectureDao=lectureDao;
   }
   @Override
   public List<LectureDTO> lectureList(int cp, int ls) throws Exception{
	  int start=(cp-1)*ls+1;
	  int end=cp*ls;
	  java.util.Map<String, Integer> map=new HashMap<>();
	  map.put("start", start);
	  map.put("end", end);
	  map.put("ls", ls);
	  map.put("cp", cp);
	  
	  List<LectureDTO> lists=lectureDao.lectureList(map);
      return lists;
   }
   @Override
   public LectureDTO lectureContent(int idx) {
      return lectureDao.lectureContent(idx);
   }
   @Override
	public LectureNoteDTO lectureMemoList(Map<String, Object> map) {
		return lectureDao.lectureMemoList(map);
	}
   @Override
   public int lectureNoteUpdate(LectureNoteDTO dto) {
      return lectureDao.lectureNoteUpdate(dto);
   }
   @Override
	public int getTotalCnt() {
	   return lectureDao.getTotalCnt();
	}
   @Override
	public int lectureNoteInsert(LectureNoteDTO dto) {
		// TODO Auto-generated method stub
		return lectureDao.lectureNoteInsert(dto);
	}
   @Override
	public List<LectureReviewDTO> reviewList(int lecture_idx) {
		return lectureDao.reviewList(lecture_idx);
	}
   @Override
	public int reviewInsert(LectureReviewDTO dto) {
		return lectureDao.reviewInsert(dto);
	}
   @Override
	public Integer lectureLike(LectureLikeDTO dto) {
		return lectureDao.lectureLike(dto);
	}
   @Override
	public Integer lectureHate(LectureHateDTO dto) {
		// TODO Auto-generated method stub
		return lectureDao.lectureHate(dto);
	}
   @Override
	public void lectureLikeUp(int idx) {
	   lectureDao.lectureLikeUp(idx);
	}
   @Override
	public void lectureLikeDown(int idx) {
		// TODO Auto-generated method stub
	   lectureDao.lectureLikeDown(idx);
	}
   @Override
	public void lectureHateUp(int idx) {
		// TODO Auto-generated method stub
	   lectureDao.lectureHateUp(idx);
	}
   @Override
	public void lectureHateDown(int idx) {
		// TODO Auto-generated method stub
	   lectureDao.lectureHateDown(idx);
	}
   @Override
	public void lectureLikeDelete(LectureLikeDTO dto) {
		// TODO Auto-generated method stub
	   lectureDao.lectureLikeDelete(dto);
	}
   @Override
	public void lectureHateDelete(LectureHateDTO dto) {
		// TODO Auto-generated method stub
	   lectureDao.lectureHateDelete(dto);
	}
   @Override
	public int lectureLikeInsert(LectureLikeDTO dto) {
		// TODO Auto-generated method stub
		return lectureDao.lectureLikeInsert(dto);
	}
   @Override
	public int lectureHateInsert(LectureHateDTO dto) {
		// TODO Auto-generated method stub
		return lectureDao.lectureHateInsert(dto);
	}
   @Override
	public int checkReviewCount(Map<String, Object> map) {
		return lectureDao.checkReviewCount(map);
	}
   @Override
   public Integer myReview(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return lectureDao.myReview(map);
	}
   @Override
	public int reviewUpdate(LectureReviewDTO dto) {
		// TODO Auto-generated method stub
		return lectureDao.reviewUpdate(dto);
	}
   @Override
	public int reviewDelete(int review_idx) {
		// TODO Auto-generated method stub
		return lectureDao.reviewDelete(review_idx);
	}
   @Override
	public String scIdx(int lecture_idx) {
		// TODO Auto-generated method stub
		return lectureDao.scIdx(lecture_idx);
	}
   @Override
	public Map<String, Object> getCounts() {
		// TODO Auto-generated method stub
		return lectureDao.getCounts();
	}
   @Override
	public Map<String, Object> lectureAvgCount(int lecture_idx) {
		// TODO Auto-generated method stub
		return lectureDao.lectureAvgCount(lecture_idx);
	}
}
