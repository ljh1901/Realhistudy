package com.histudy.mentoring.model;

import java.util.List;
import java.util.Map;
import com.histudy.admin.model.ReportDTO;

public interface MentoringDAO {
	public List<MentorListDTO> mentorList(Map<String, Object> map);
	public int mentorTotalCnt(Map<String, Object> map);
    public int mentorProfileCreate(MentoProfileDTO dto);
    
    public int mentorProfileCount(int user_idx);
    
    public Integer findMentorIdxAndUserIdx(int user_idx);

    public int insertMentoring(MentoringDTO dto);

    public int insertMentoringSchedule(MentoringScheduleDTO dto);
    
    public List<MentorApplicationDTO> selectMentorApplications(Map<String, Object> map);
    public int mentorAppTotalCnt(Map<String, Object> map);
    
    public MentorApplicationDTO selectMentorApplicationDetail(int ma_id);

    public int approveMentorApplication(int ma_id);
    public int rejectMentorApplication(Map<String, Object> map);
    public int deleteMentorApplication(int ma_id);

    public MentorSummaryDTO selectMentorSummary(int mentor_idx);
    public List<String> selectMentorTags(int mentor_idx);

    public MentorMatchDTO selectMatchInfoMaId(int ma_id);
    public int insertMentoringMatch(MentorMatchDTO dto);
    public int countMentoringMatch(MentorMatchDTO dto);

    public int selectLatestMentoringIdxByMentor(int mentor_idx);

    public MentoringDTO selectMentoringDetailForApply(int mentoring_idx);
    public MentorSummaryDTO selectMentorInfoByMentoringIdx(int mentoring_idx);
    public int insertMentoringApplication(java.util.Map<String, Object> map);

    public  MentoringDetailDTO selectMentoringDetailByMentor(int mentor_idx);
    public List<MentoringReviewDTO> selectMentoringReviews(int mentor_idx);
    public  Integer selectWritableMatchId(Map<String, Object> map);
    public int insertMentoringReview(MentoringReviewDTO dto);

    public Integer findSkillIdByName(String skill_name);
    public int insertSkill(String skill_name);
    public int insertMentoringSkillMap(Map<String, Object> map);

    public List<MentoringScheduleDTO> selectMentoringSchedule(int mentoring_idx);
    public int updateMentoringStatusClose(int mentoring_idx);
    
    public int insertMentoringMatchNotification(int ma_id);
    public List<Map<String, Object>> selectNotificationList(int user_idx);

    int insertMentoringRejectNotification(Map<String, Object> map);
    
    int insertReport(ReportDTO dto);
}
