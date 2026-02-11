package com.histudy.study.model;

import java.util.*;
import com.histudy.user.model.*;

public interface StudyDAO {
   
   public int createStudy(StudyDTO dto);
   public List<StudyDTO> getStudyList(Map<String, Integer> map);
   public int studyTotalCnt(Integer sc_idx);
   public UserDTO getStudyCreateUser(int user_idx);
   public int studyMaxCreate(int user_idx);
   public StudyDTO getStudyContent(int study_idx);
}
