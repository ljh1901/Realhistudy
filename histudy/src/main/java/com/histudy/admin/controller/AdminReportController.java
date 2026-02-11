package com.histudy.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import java.util.*;

import com.histudy.admin.model.ReportDTO;
import com.histudy.admin.service.AdminReportService;

@Controller
public class AdminReportController {
	
    @Autowired
    private AdminReportService adminReportService;

    // 신고 목록 페이지
    @RequestMapping("/adminReportList.do")
    public ModelAndView adminReportList() {
        List<ReportDTO> list = adminReportService.getReportList();
        ModelAndView mav = new ModelAndView();
        mav.addObject("reportList", list);
        mav.setViewName("admin/adminReportList");
        return mav;
    }

    // 신고 처리 완료 처리
    @RequestMapping("/adminReportResolve.do")
    public String adminReportResolve(@RequestParam("report_idx") int report_idx) {
        adminReportService.resolveReport(report_idx);
        return "redirect:adminReportList.do";
    }
}
