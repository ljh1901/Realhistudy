package com.histudy.lecture.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public class LectureDAOImple implements LectureDAO {
   private SqlSessionTemplate sqlSession;
   public LectureDAOImple(SqlSessionTemplate sqlSession) {
      this.sqlSession=sqlSession;
   }
   @Override
   public List<LectureDTO> lectureList() {
      return sqlSession.selectList("lectureList");
   }
   @Override
	public List<LectureDTO> lectureList(Map<String, Integer> map) {
	      return sqlSession.selectList("lectureList",map);
	}
   @Override
   public LectureDTO lectureContent(int idx) {
	   return sqlSession.selectOne("com.histudy.lecture.model.LectureDAO.lectureContent", idx);
   }
   @Override
	public LectureNoteDTO lectureMemoList(Map<String,Object> map) {
		return sqlSession.selectOne("com.histudy.lecture.model.LectureDAO.lectureMemoList",map);
	}
   @Override
	public int lectureNoteInsert(LectureNoteDTO dto) {
		return sqlSession.insert("com.histudy.lecture.model.LectureDAO.lectureNoteInsert", dto);
	}
   @Override
   public int lectureNoteUpdate(LectureNoteDTO dto) {
      return sqlSession.update("com.histudy.lecture.model.LectureDAO.lectureNoteUpdate",dto);
   }
   @Override
	public int getTotalCnt() {
		return sqlSession.selectOne("getTotalCnt");
	}
   @Override
	public List<LectureReviewDTO> reviewList(int lecture_idx) {
	   return sqlSession.selectList("com.histudy.lecture.model.LectureDAO.reviewList", lecture_idx);
   }
   @Override
	public int reviewInsert(LectureReviewDTO dto) {
		return sqlSession.insert("com.histudy.lecture.model.LectureDAO.reviewInsert",dto);
	}
   @Override
	public Integer lectureLike(LectureLikeDTO dto) {
		// TODO Auto-generated method stub
	   return sqlSession.selectOne("com.histudy.lecture.model.LectureDAO.lectureLike", dto);
   }	   
   @Override
	public Integer lectureHate(LectureHateDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("com.histudy.lecture.model.LectureDao.lectureHate",dto);
	}
   @Override
	public void lectureLikeUp(int idx) {
	   sqlSession.update("lectureLikeUp",idx);
	}
   @Override
	public void lectureLikeDown(int idx) {
		// TODO Auto-generated method stub
		sqlSession.update("lectureLikeDown",idx);
	}
   @Override
	public void lectureHateUp(int idx) {
		// TODO Auto-generated method stub
	   sqlSession.update("lectureHateUp",idx);
	}
   @Override
	public void lectureHateDown(int idx) {
		// TODO Auto-generated method stub
	   sqlSession.update("lectureHateDown",idx);
	}
   @Override
	public void lectureLikeDelete(LectureLikeDTO dto) {
		// TODO Auto-generated method stub
	   sqlSession.delete("lectureLikeDelete",dto);
	}
   @Override
	public void lectureHateDelete(LectureHateDTO dto) {
		// TODO Auto-generated method stub
	   sqlSession.delete("lectureHateDelete",dto);
	}
   @Override
	public int lectureLikeInsert(LectureLikeDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("lectureLikeInsert",dto);
	}
   @Override
	public int lectureHateInsert(LectureHateDTO dto) {
	   return sqlSession.insert("lectureHateInsert",dto);
	}
   @Override
	public int checkReviewCount(Map<String, Object> map) {
		return sqlSession.selectOne("com.histudy.lecture.model.LectureDAO.checkReviewCount",map);
	}
   @Override
	public Integer myReview(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myReview",user_idx);
	}
   @Override
	public int reviewUpdate(LectureReviewDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("reviewUpdate",dto);
	}
   @Override
	public int reviewDelete(int review_idx) {
		// TODO Auto-generated method stub
		return sqlSession.delete("reviewDelete",review_idx);
	}
   @Override
	public String selectName(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectName",user_idx);
	}
   @Override
	public String scIdx(int lecture_idx) {
		return sqlSession.selectOne("scIdx",lecture_idx);
	}
}
