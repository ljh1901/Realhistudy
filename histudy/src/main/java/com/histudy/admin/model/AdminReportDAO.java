package com.histudy.admin.model;

import java.util.*;

public interface AdminReportDAO {
	
	public List<ReportDTO> getReportList(String status);
	public void updateReportStatus(Map<String, Object> map);
}