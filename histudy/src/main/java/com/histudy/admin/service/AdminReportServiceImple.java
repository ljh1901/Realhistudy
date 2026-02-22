package com.histudy.admin.service;

import java.util.*;

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
    public void updateReportStatus(int reportIdx, String status) {
        Map<String, Object> map = new HashMap<>();
        map.put("reportIdx", reportIdx);
        map.put("status", status);
        
        adminReportDao.updateReportStatus(map);
    }

}
