package com.histudy.admin.model;

import org.apache.ibatis.session.SqlSession;
import java.util.*;
import com.histudy.study.model.*;

public class AdminStudyDAOImple implements AdminStudyDAO {

	private SqlSession session;

	public AdminStudyDAOImple(SqlSession session) {
		super();
		this.session = session;
	}

	@Override
	public List<StudyDTO> selectAllStudyList() {       
		return session.selectList("selectAllStudyList");
	}
	@Override
	public int deleteStudy(int study_idx) {
		return session.delete("deleteStudy",study_idx);
	}

}
