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
    public ModelAndView adminReportList(@RequestParam(value = "status", required = false) String status) {
        List<ReportDTO> list = adminReportService.getReportList(status);
        
        ModelAndView mav = new ModelAndView();
        mav.addObject("reportList", list);
        mav.addObject("currentStatus", status); 
        mav.setViewName("admin/adminReportList");
        return mav;
    }
    
    @RequestMapping("/adminReportProcess.do")
    public String reportProcess(@RequestParam("report_idx") int reportIdx, 
                                @RequestParam("action") String action) {
        
        String status = "완료".equals(action) ? "완료" : "거절";
        
        adminReportService.updateReportStatus(reportIdx, status);
        
        return "redirect:/adminReportList.do";
    }
}
