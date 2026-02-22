package com.histudy.admin.model;

import org.mybatis.spring.SqlSessionTemplate;
import java.util.*;

public class AdminReportDAOImple implements AdminReportDAO {
    
    private SqlSessionTemplate session;

    public AdminReportDAOImple(SqlSessionTemplate session) {
		super();
		this.session = session;
	}

	@Override
	public List<ReportDTO> getReportList(String status) {
	    return session.selectList("selectAllReportList", status);
	}
    
    @Override
    public void updateReportStatus(Map<String, Object> map) {
       session.update("updateReportStatus", map);
    }
}
