package com.histudy.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.histudy.admin.model.AdminReportDAO;
import com.histudy.admin.model.ReportDTO;

public class AdminReportServiceImple implements AdminReportService {
	
    private AdminReportDAO adminReportDao;

    public AdminReportServiceImple(AdminReportDAO adminReportDao) {
		super();
		this.adminReportDao = adminReportDao;
	}

	@Override
	public List<ReportDTO> getReportList(String status) {
	    return adminReportDao.getReportList(status);
	}

    @Override
    public int resolveReport(int report_idx) {
        return adminReportDao.updateReportStatus(report_idx);
    }

}
