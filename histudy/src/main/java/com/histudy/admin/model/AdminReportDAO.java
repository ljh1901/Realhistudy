package com.histudy.admin.model;

import java.util.*;

public interface AdminReportDAO {
	
	public List<ReportDTO> getReportList(String status);
	public int updateReportStatus(int report_idx);
}