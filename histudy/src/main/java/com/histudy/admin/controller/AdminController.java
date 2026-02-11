package com.histudy.admin.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;
import com.histudy.admin.model.*;
import com.histudy.admin.service.*;

@Controller
public class AdminController {

	@Autowired
	private AdminService adminService;

	// 관리자 메인 대시보드
	@GetMapping("/adminMain.do")
	public String adminMain() {
		return "admin/adminMain";	
	} 
	// 스터디 카페 전체 목록
	@GetMapping("/adminCafeList.do")
	public ModelAndView adminList() {
		List<StudycafeDTO> list = adminService.getCafeList(); 

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminCafeList");
		mav.addObject("cafeList", list);

		return mav;
	}

	// 스터디 카페 상세 보기
	@GetMapping("/adminCafeDetail.do")
	public ModelAndView adminCafeDetail(@RequestParam("studycafe_idx") int idx) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminCafeDetail");
		return mav;
	}
	// 스터디 카페 매출화면

	@GetMapping("/adminCafeSales.do")
	public ModelAndView adminCafeSales(@RequestParam Map<String, Object> params) {
		List<Map<String, Object>> salesData = adminService.getSalesList(params);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminCafeSales");
		mav.addObject("salesData", salesData);

		return mav;
	}
	// 스터디 카페 좌석현황
	@GetMapping("/adminCafeSeat.do")
	public String adminCafeSeat() {
		return "admin/adminCafeSeat";
	} 
	// 스터디 카페 문의사항
	@GetMapping("/adminCafeInquiryList.do")
	public String adminCafeInquiryList() {
		return "admin/adminCafeInquiryList";
	}

	// 스터디 카페 요금제 리스트
	@GetMapping("/adminCafePrice.do")
	public ModelAndView adminCafePrice(@RequestParam("studycafe_idx") int idx) {
		ModelAndView mav = new ModelAndView("admin/adminCafePrice");

		List<TicketCategoryDTO> categoryList = adminService.getTicketCategoryList();
		List<TicketJoinTicketCategoryDTO> ticketList = adminService.getTicketList(idx);

		mav.addObject("categoryList", categoryList);
		mav.addObject("ticketList", ticketList);
		return mav;
	}
	//스터디 카페 요금제 등록하기
	@PostMapping("/addTicketAction.do")
	@ResponseBody
	public Map<String, Object> addTicket(@RequestBody Map<String, Object> data) {
		int newIdx = adminService.registerTicket(data);

		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("newIdx", newIdx);
		return result;
	}
	// 스터디 카페 좌석 등록 에디터
	@GetMapping("/studycafeEditor.do")
	public ModelAndView studycafeEditor(@RequestParam("studycafe_idx") int studycafe_idx) {
		List<Map<String, Object>> layoutList = adminService.getLayoutList(studycafe_idx);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/studycafeEditor");
		mav.addObject("layoutList", layoutList);
		mav.addObject("studycafe_idx", studycafe_idx);

		return mav;
	}

	// 스터디 카페 좌석 저장하기
	@PostMapping("/saveCafeLayoutAction.do")
	@ResponseBody
	public Map<String, Object> saveLayout(@RequestBody Map<String, Object> params) {
		int studycafe_idx = Integer.parseInt(params.get("studycafe_idx").toString());
		List<Map<String, Object>> layoutData = (List<Map<String, Object>>) params.get("layout");

		adminService.updateCafeLayout(studycafe_idx, layoutData);

		Map<String, Object> response = new HashMap<>();
		response.put("status", "success");
		return response;
	}
	
	@GetMapping("/adminInquiryList.do")
	public String adminInquiryList() {
		return ("admin/adminInquiryList");
	}
}
