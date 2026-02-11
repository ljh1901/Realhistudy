package com.histudy.study.service;

import java.util.List;
import java.util.Map;

import com.histudy.study.model.StudyDTO;
import com.histudy.user.model.UserDTO;

public interface StudyService {
   
   public int createStudy(StudyDTO dto);
   public List<StudyDTO> getStudyList(Map<String, Integer> map);
   public int studyTotalCnt(Integer sc_idx);
   public UserDTO getStudyCreateUser(int user_idx);
   public int studyMaxCreate(int user_idx);
   public StudyDTO getStudyContent(int study_idx);
}
