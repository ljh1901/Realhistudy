package com.histudy.admin.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.histudy.admin.model.AdminStudyDAO;
import com.histudy.study.model.StudyDTO;

@Service
public class AdminStudyServiceImple implements AdminStudyService {

    @Autowired
    private AdminStudyDAO adminStudyDAO;

    public AdminStudyServiceImple(AdminStudyDAO adminStudyDAO) {
		super();
		this.adminStudyDAO = adminStudyDAO;
	}
    
	@Override
    public List<StudyDTO> getStudyList() {
        return adminStudyDAO.selectAllStudyList();
    }
	
	@Override
	public int deleteStudy(int study_idx) {
		return adminStudyDAO.deleteStudy(study_idx);
	}
	
}