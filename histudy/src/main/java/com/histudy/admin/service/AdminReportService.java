package com.histudy.admin.service;

import java.util.*;

import com.histudy.admin.model.ReportDTO;

public interface AdminReportService {

	public List<ReportDTO> getReportList();
	public int resolveReport(int report_idx);
}
