package com.histudy.mentoring.service;

import java.util.List;
import java.util.Map;

import com.histudy.mentoring.model.*;


public interface MentoringService {
	public List<MentorListDTO> mentorList(Map<String, Object> map);
    public int mentorTotalCnt(Map<String, Object> map);
    
    public int mentorProfileCreate(MentoProfileDTO dto);
    public int mentorProfileCount(int user_idx);
    
    public Integer findMentorIdxAndUserIdx(int user_idx);

    public void createMentoring(MentoringDTO dto, String scheduleJson, String skillTags);
    
    public List<MentorApplicationDTO> selectMentorApplications(Map<String, Object> map);
    public int mentorAppTotalCnt(Map<String, Object> map);
    
    public MentorApplicationDTO selectMentorApplicationDetail(int ma_id);

    public int approveMentorApplication(int ma_id);
    public int rejectMentorApplication(int ma_id);
    public int deleteMentorApplication(int ma_id);

    public MentorSummaryDTO selectMentorSummary(int mentor_idx);
    
    public int approveAndMatch(int ma_id);

    public int selectLatestMentoringIdxByMentor(int mentor_idx);
    
    public MentoringDTO selectMentoringDetailForApply(int mentoring_idx);
    public MentorSummaryDTO selectMentorInfoByMentoringIdx(int mentoring_idx);
    public int applyMentoring(int mentoring_idx, int mentee_user_idx, String apply_content);

    public MentoringDetailDTO selectMentoringDetailByMentor(int mentor_idx);
    public List<MentoringReviewDTO> selectMentoringReviews(int mentor_idx);
    public Integer getWritableMatchId(int mentor_idx, int mentee_user_idx);
    public int writeReview(MentoringReviewDTO dto);
    
    public List<Map<String, Object>> selectNotificationList(int user_idx);

}
