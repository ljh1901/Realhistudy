package com.histudy.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.admin.service.AdminStudyService;
import com.histudy.study.model.*;
import java.util.*;

import javax.servlet.http.HttpSession;

@Controller
public class AdminStudyController {

	@Autowired
	private AdminStudyService adminStudyService;

	//스터디모임 리스트
	@GetMapping("/adminStudyList.do")
	public ModelAndView adminStudyList() {
	    ModelAndView mav = new ModelAndView("admin/adminStudyList");
	    
	    List<StudyDTO> list = adminStudyService.getStudyList();
	    mav.addObject("studyList", list);
	    
	    return mav;
	}
	
	//스터디모임 삭제
		@RequestMapping("/adminStudyDelete.do")
		public ModelAndView adminStudyDelete(@RequestParam("study_idx")int study_idx) {
			int result = adminStudyService.deleteStudy(study_idx);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("admin/adminMsg");
			
			if(result>0) {
				mav.addObject("msg","삭제 완료");
				mav.addObject("url","adminStudyList.do");
			}else {
				mav.addObject("msg","삭제실패");
				mav.addObject("url","adminStudyList.do");
			}
			return mav;		
		}
	
}
