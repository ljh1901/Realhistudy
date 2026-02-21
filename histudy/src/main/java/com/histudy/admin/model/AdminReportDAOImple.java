package com.histudy.admin.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
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
    public int updateReportStatus(int report_idx) {
        return session.update("updateReportStatus", report_idx);
    }
}
