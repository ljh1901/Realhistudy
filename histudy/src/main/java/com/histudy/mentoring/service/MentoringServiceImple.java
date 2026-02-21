package com.histudy.mentoring.service;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Calendar;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;  
import com.histudy.mentoring.model.*;
import com.histudy.admin.model.ReportDTO;


public class MentoringServiceImple implements MentoringService {

    private MentoringDAO mentoringDAO;

    public MentoringServiceImple(MentoringDAO mentoringDAO) {
        this.mentoringDAO = mentoringDAO;
    }

    @Override
    public List<MentorListDTO> mentorList(Map<String, Object> map) {
        return mentoringDAO.mentorList(map);
    }

    @Override
    public int mentorTotalCnt(Map<String, Object> map) {
        return mentoringDAO.mentorTotalCnt(map);
    }

    @Override
    public int mentorProfileCreate(MentoProfileDTO dto) {
        return mentoringDAO.mentorProfileCreate(dto);
    }

    @Override
    public int mentorProfileCount(int user_idx) {
        return mentoringDAO.mentorProfileCount(user_idx);
    }

    @Override
    public Integer findMentorIdxAndUserIdx(int user_idx) {
        return mentoringDAO.findMentorIdxAndUserIdx(user_idx);
    }
    
    @Override
    public List<MentorApplicationDTO> selectMentorApplications(Map<String, Object> map) {
        return mentoringDAO.selectMentorApplications(map);
    }

    @Override
    public int mentorAppTotalCnt(Map<String, Object> map) {
        return mentoringDAO.mentorAppTotalCnt(map);
    }

    @Override
    public MentorApplicationDTO selectMentorApplicationDetail(int ma_id) {
      return mentoringDAO.selectMentorApplicationDetail(ma_id);
    }

    @Override
    public int approveMentorApplication(int ma_id) {
      return mentoringDAO.approveMentorApplication(ma_id);
    }

    @Override
    public int rejectMentorApplication(int ma_id) {
      java.util.Map<String, Object> map = new java.util.HashMap<>();
      map.put("ma_id", ma_id);
      return mentoringDAO.rejectMentorApplication(map);
    }
    
    @Transactional
    @Override
    public int deleteMentorApplication(int ma_id) {

        int result = mentoringDAO.deleteMentorApplication(ma_id);

        if (result > 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("ma_id", ma_id);
            mentoringDAO.insertMentoringRejectNotification(map);
        }
        
        return result;
    }
    
    @Override
    public MentorSummaryDTO selectMentorSummary(int mentor_idx) {
        MentorSummaryDTO dto = mentoringDAO.selectMentorSummary(mentor_idx);
        if (dto != null) {
            List<String> tags = mentoringDAO.selectMentorTags(mentor_idx);
            dto.setTags(tags);
        }
        return dto;
    }

    @Transactional
    @Override
    public int approveAndMatch(int ma_id) {
        int updated = mentoringDAO.approveMentorApplication(ma_id);
        if(updated <= 0) return 0; 
        
        MentorMatchDTO info = mentoringDAO.selectMatchInfoMaId(ma_id);
        if(info == null) return 1;
        
        int cnt = mentoringDAO.countMentoringMatch(info);
        if(cnt > 0) return 1; 

        int result = mentoringDAO.insertMentoringMatch(info);
        
        if(result > 0) {
            mentoringDAO.insertMentoringMatchNotification(ma_id);
        }

        mentoringDAO.updateMentoringStatusClose(info.getMentoring_idx());
        return 1;
    }

    @Override
    public List<Map<String, Object>> selectNotificationList(int user_idx) {
        return mentoringDAO.selectNotificationList(user_idx);
    }
    
    @Override
    public int selectLatestMentoringIdxByMentor(int mentor_idx) {
        return mentoringDAO.selectLatestMentoringIdxByMentor(mentor_idx);
    }


    @Override
    public MentoringDTO selectMentoringDetailForApply(int mentoring_idx) {
        return mentoringDAO.selectMentoringDetailForApply(mentoring_idx);
    }

    @Override
    public MentorSummaryDTO selectMentorInfoByMentoringIdx(int mentoring_idx) {
        return mentoringDAO.selectMentorInfoByMentoringIdx(mentoring_idx);
    }

    @Override
    public int applyMentoring(int mentoring_idx, int mentee_user_idx, String apply_content) {
        Map<String, Object> map = new java.util.HashMap<>();
        map.put("mentoring_idx", mentoring_idx);
        map.put("mentee_user_idx", mentee_user_idx);
        map.put("apply_content", apply_content);
        return mentoringDAO.insertMentoringApplication(map);
    }

    @Override
    public MentoringDetailDTO selectMentoringDetailByMentor(int mentor_idx) {
      MentoringDetailDTO detail = mentoringDAO.selectMentoringDetailByMentor(mentor_idx);
      
      if (detail != null) {

          List<String> tags = mentoringDAO.selectMentorTags(mentor_idx);
          List<MentoringScheduleDTO> schedules = mentoringDAO.selectMentoringSchedule(detail.getMentoring_idx());
          detail.setSchedules(schedules);
          
          detail.setTags(tags);
      }
      
      return detail;
    }

    @Override
    public List<MentoringReviewDTO> selectMentoringReviews(int mentor_idx) {
      return mentoringDAO.selectMentoringReviews(mentor_idx);
    }

    @Override
    public Integer getWritableMatchId(int mentor_idx, int mentee_user_idx) {
      Map<String, Object> map = new HashMap<>();
      map.put("mentor_idx", mentor_idx);
      map.put("mentee_user_idx", mentee_user_idx);
      return mentoringDAO.selectWritableMatchId(map);
    }

    @Override
    public int writeReview(MentoringReviewDTO dto) {
      return mentoringDAO.insertMentoringReview(dto);
    }

    @Override
    @Transactional
    public void createMentoring(MentoringDTO dto, String scheduleJson, String skillTags) {
        
        mentoringDAO.insertMentoring(dto);
        int mentoring_idx = dto.getMentoring_idx();
        

        if (skillTags != null) skillTags = skillTags.trim();
        if (skillTags != null && !skillTags.isEmpty()) {

            String[] arr = skillTags.split(",");

            for (String raw : arr) {
                String tag = raw.trim();
                if (tag.isEmpty()) continue;

                Integer skillId = mentoringDAO.findSkillIdByName(tag);

                if (skillId == null) {
                    mentoringDAO.insertSkill(tag);
                    skillId = mentoringDAO.findSkillIdByName(tag);
                }
                Map<String, Object> smap = new HashMap<>();
                smap.put("mentoring_idx", mentoring_idx);
                smap.put("skill_idx", skillId);

                mentoringDAO.insertMentoringSkillMap(smap);
            }
        }


        ObjectMapper om = new ObjectMapper();
        List<Map<String, String>> slots;

        try {
            slots = om.readValue(scheduleJson, new TypeReference<List<Map<String, String>>>() {});
        } catch (Exception e) {
            throw new IllegalArgumentException("스케줄 데이터 형식이 잘못되었습니다.");
        }

        if (slots == null || slots.isEmpty()) {
            throw new IllegalArgumentException("최소 하나 이상의 스케줄을 선택해야 합니다.");
        }

        for (Map<String, String> m : slots) {
            String actualDate = m.get("date");
            String time = m.get("time");

            Date start = parseDateTime(actualDate, time);
            if (start != null) {
                Date end = add1Hour(start);

                MentoringScheduleDTO sdto = new MentoringScheduleDTO();
                sdto.setMentoring_idx(mentoring_idx); 
                sdto.setStatus("가능");
                sdto.setMentoring_starttime(start); 
                sdto.setMentoring_endtime(end); 

                mentoringDAO.insertMentoringSchedule(sdto);
            }
        }
    }

    private Date parseDateTime(String date, String time) {
        if (date == null || time == null) return null;
        try {
            return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + time);
        } catch (Exception e) {
            return null;
        }
    }

    private Date add1Hour(Date d) {
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        c.add(Calendar.HOUR, 1);
        return c.getTime();
    }
    
}
