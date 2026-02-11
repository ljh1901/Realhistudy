package com.histudy.admin.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.*;

public class AdminReportDAOImple implements AdminReportDAO {
    
	@Autowired
    private SqlSessionTemplate session;

    public AdminReportDAOImple(SqlSessionTemplate session) {
		super();
		this.session = session;
	}

	@Override
    public List<ReportDTO> selectAllReportList() {
        return session.selectList("selectAllReportList");
    }

    @Override
    public int updateReportStatus(int report_idx) {
        return session.update("updateReportStatus", report_idx);
    }
}
