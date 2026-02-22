package com.histudy.admin.service;

import java.util.*;

import com.histudy.admin.model.ReportDTO;

public interface AdminReportService {

	public List<ReportDTO> getReportList(String status);
	public void updateReportStatus(int reportIdx, String status);
}
