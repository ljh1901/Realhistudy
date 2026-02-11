package com.histudy.admin.service;

import java.util.List;
import com.histudy.study.model.StudyDTO;

public interface AdminStudyService {

	public List<StudyDTO> getStudyList();
	public int deleteStudy(int study_idx);
}
