package com.histudy.mentoring.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import com.histudy.admin.model.ReportDTO;


public class MentoringDAOImple implements MentoringDAO {

    private SqlSessionTemplate sqlSession;

    @Autowired
    public MentoringDAOImple(SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    //멘토리스트
    @Override
    public List<MentorListDTO> mentorList(Map<String, Object> map) {
        return sqlSession.selectList("com.histudy.mentoring.mentorList", map);
    }

    //멘토 총 개수 (카테고리 있으면 조건, 없으면 전체)
    @Override
    public int mentorTotalCnt(Map<String, Object> map) {
        return sqlSession.selectOne("com.histudy.mentoring.mentorTotalCnt",map);
    }
    
    @Override
    public int mentorProfileCreate(MentoProfileDTO dto) {
        return sqlSession.insert("com.histudy.mentoring.mentorProfileCreate", dto);
    }
    
    @Override
    public int mentorProfileCount(int user_idx) {
       return sqlSession.selectOne("com.histudy.mentoring.mentorProfileCount", user_idx);
    }
    
    @Override
    public Integer findMentorIdxAndUserIdx(int user_idx) {
        return sqlSession.selectOne("com.histudy.mentoring.findMentorIdxAndUserIdx", user_idx);
    }

    @Override
    public int insertMentoring(MentoringDTO dto) {
        return sqlSession.insert("com.histudy.mentoring.insertMentoring", dto);
    }

    @Override
    public int insertMentoringSchedule(MentoringScheduleDTO dto) {
        return sqlSession.insert("com.histudy.mentoring.insertMentoringSchedule", dto);
    }

    @Override
    public List<MentorApplicationDTO> selectMentorApplications(Map<String, Object> map) {
        return sqlSession.selectList("com.histudy.mentoring.selectMentorApplications", map);
    }

    //  신청현황 총 개수
    @Override
    public int mentorAppTotalCnt(Map<String, Object> map) {
        return sqlSession.selectOne("com.histudy.mentoring.mentorAppTotalCnt", map);
    }

    @Override
    public MentorApplicationDTO selectMentorApplicationDetail(int ma_id) {
      return sqlSession.selectOne("com.histudy.mentoring.selectMentorApplicationDetail", ma_id);
    }

    @Override
    public int approveMentorApplication(int ma_id) {
      return sqlSession.update("com.histudy.mentoring.approveMentorApplication", ma_id);
    }

    @Override
    public int rejectMentorApplication(Map<String, Object> map) {
      return sqlSession.update("com.histudy.mentoring.rejectMentorApplication", map);
    }
    
    @Override
    public int deleteMentorApplication(int ma_id) {
        return sqlSession.update("com.histudy.mentoring.deleteMentorApplication", ma_id);
    }
    
    @Override
    public MentorSummaryDTO selectMentorSummary(int mentor_idx) {
        return sqlSession.selectOne("com.histudy.mentoring.selectMentorSummary", mentor_idx);
    }

    @Override
    public List<String> selectMentorTags(int mentor_idx) {
        return sqlSession.selectList("com.histudy.mentoring.selectMentorTags", mentor_idx);
    }
 
    @Override
    public MentorMatchDTO selectMatchInfoMaId(int ma_id) {
        return sqlSession.selectOne("com.histudy.mentoring.selectMatchInfoMaId", ma_id);
    }

    @Override
    public int insertMentoringMatch(MentorMatchDTO dto) {
        return sqlSession.insert("com.histudy.mentoring.insertMentoringMatch", dto);
    }

    @Override
    public int countMentoringMatch(MentorMatchDTO dto) {
        return sqlSession.selectOne("com.histudy.mentoring.countMentoringMatch", dto);
    }

    @Override
    public int selectLatestMentoringIdxByMentor(int mentor_idx) {
        Integer v = sqlSession.selectOne("com.histudy.mentoring.selectLatestMentoringIdxByMentor", mentor_idx);
        return (v == null) ? 0 : v;
    }

    @Override
    public MentoringDTO selectMentoringDetailForApply(int mentoring_idx) {
        return sqlSession.selectOne("com.histudy.mentoring.selectMentoringDetailForApply", mentoring_idx);
    }

    @Override
    public MentorSummaryDTO selectMentorInfoByMentoringIdx(int mentoring_idx) {
        return sqlSession.selectOne("com.histudy.mentoring.selectMentorInfoByMentoringIdx", mentoring_idx);
    }

    @Override
    public int insertMentoringApplication(Map<String, Object> map) {
        return sqlSession.insert("com.histudy.mentoring.insertMentoringApplication", map);
    }

    @Override
    public MentoringDetailDTO selectMentoringDetailByMentor(int mentor_idx) {
      return sqlSession.selectOne("com.histudy.mentoring.selectMentoringDetailByMentor", mentor_idx);
    }

    @Override
    public List<MentoringReviewDTO> selectMentoringReviews(int mentor_idx) {
      return sqlSession.selectList("com.histudy.mentoring.selectMentoringReviews", mentor_idx);
    }

    @Override
    public Integer selectWritableMatchId(Map<String, Object> map) {
      return sqlSession.selectOne("com.histudy.mentoring.selectWritableMatchId", map);
    }

    @Override
    public int insertMentoringReview(MentoringReviewDTO dto) {
      return sqlSession.insert("com.histudy.mentoring.insertMentoringReview", dto);
    }
    
    @Override
    public Integer findSkillIdByName(String skill_name) {
        return sqlSession.selectOne("com.histudy.mentoring.findSkillIdByName", skill_name);
    }

    @Override
    public int insertSkill(String skill_name) {
        return sqlSession.insert("com.histudy.mentoring.insertSkill", skill_name);
    }

    @Override
    public int insertMentoringSkillMap(Map<String, Object> map) {
        return sqlSession.insert("com.histudy.mentoring.insertMentoringSkillMap", map);
    }

    @Override
    public List<MentoringScheduleDTO> selectMentoringSchedule(int mentoring_idx) {
        return sqlSession.selectList("com.histudy.mentoring.selectMentoringSchedule", mentoring_idx);
    }
    
    @Override
    public int updateMentoringStatusClose(int mentoring_idx) {
        return sqlSession.update("com.histudy.mentoring.updateMentoringStatusClose", mentoring_idx);
    }

    @Override
    public int insertMentoringMatchNotification(int ma_id) {
        return sqlSession.insert("com.histudy.mentoring.insertMentoringMatchNotification", ma_id);
    }

    @Override
    public List<Map<String, Object>> selectNotificationList(int user_idx) {
        return sqlSession.selectList("com.histudy.mentoring.selectNotificationList", user_idx);
    }
    
    @Override
    public int insertMentoringRejectNotification(Map<String, Object> map) {
    	return sqlSession.insert("com.histudy.mentoring.insertMentoringRejectNotification", map);
    }
    
    @Override
    public int insertReport(ReportDTO dto) {
        return sqlSession.insert("com.histudy.mentoring.insertReport", dto);
    }
}