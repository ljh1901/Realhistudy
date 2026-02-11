package com.histudy.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.histudy.admin.model.AdminReportDAO;
import com.histudy.admin.model.ReportDTO;

@Service
public class AdminReportServiceImple implements AdminReportService {
    @Autowired
    private AdminReportDAO adminReportDao;

    public AdminReportServiceImple(AdminReportDAO adminReportDao) {
		super();
		this.adminReportDao = adminReportDao;
	}

	@Override
    public List<ReportDTO> getReportList() {
        return adminReportDao.selectAllReportList();
    }

    @Override
    public int resolveReport(int report_idx) {
        return adminReportDao.updateReportStatus(report_idx);
    }

}
