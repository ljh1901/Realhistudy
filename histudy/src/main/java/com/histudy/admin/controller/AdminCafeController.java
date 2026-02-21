package com.histudy.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.admin.model.TicketCategoryDTO;
import com.histudy.admin.service.AdminCafeService;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

@Controller
public class AdminCafeController {
	
	@Autowired
	private AdminCafeService adminService;
	
	// 스터디 카페 전체 목록
		@GetMapping("/adminCafeList.do")
		public ModelAndView adminList() {
			List<StudycafeDTO> list = adminService.getCafeList(); 

			ModelAndView mav = new ModelAndView();
			mav.setViewName("admin/adminCafe/adminCafeList");
			mav.addObject("cafeList", list);

			return mav;
		}

		// 스터디 카페 상세 보기
		@GetMapping("/adminCafeDetail.do")
		public ModelAndView adminCafeDetail(@RequestParam("studycafe_idx") int idx) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("admin/adminCafe/adminCafeDetail");
			return mav;
		}
		// 스터디 카페 매출화면

		@GetMapping("/adminCafeSales.do")
		public ModelAndView adminCafeSales(@RequestParam Map<String, Object> params) {
			
            int studycafe_idx = Integer.parseInt(params.get("studycafe_idx").toString());
			List<Map<String, Object>> salesData = adminService.getSalesList(params);
            List<Map<String, Object>> paymentList = adminService.getCafePaymentList(studycafe_idx);

			ModelAndView mav = new ModelAndView();
			mav.setViewName("admin/adminCafe/adminCafeSales");
			mav.addObject("salesData", salesData);
            mav.addObject("paymentList", paymentList);
            mav.addObject("studycafe_idx", studycafe_idx);

			return mav;
		}
		// 스터디 카페 좌석현황
		@GetMapping("/adminCafeSeat.do")
		public ModelAndView adminCafeSeat(@RequestParam("studycafe_idx") int studycafe_idx) {
		    List<Map<String, Object>> layoutList = adminService.getLayoutList(studycafe_idx);

		    ModelAndView mav = new ModelAndView();
		    mav.setViewName("admin/adminCafe/adminCafeSeat");
		    
		    mav.addObject("layoutList", layoutList);
		    mav.addObject("studycafe_idx", studycafe_idx);

		    return mav;
		}
		// 스터디 카페 문의사항
		@GetMapping("/adminCafeInquiryList.do")
		public String adminCafeInquiryList() {
			return "admin/adminCafe/adminCafeInquiryList";
		}

		// 스터디 카페 요금제 리스트
		@GetMapping("/adminCafePrice.do")
		public ModelAndView adminCafePrice(@RequestParam("studycafe_idx") int idx) {
			ModelAndView mav = new ModelAndView();

			List<TicketCategoryDTO> categoryList = adminService.getTicketCategoryList();
			List<TicketJoinTicketCategoryDTO> ticketList = adminService.getTicketList(idx);

			mav.addObject("categoryList", categoryList);
			mav.addObject("ticketList", ticketList);
			mav.setViewName("admin/adminCafe/adminCafePrice");
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
		
		@GetMapping("/deleteTicketAction.do")
		@ResponseBody
		public Map<String, Object> deleteTicket(@RequestParam("ticket_idx") int ticket_idx) {
		    int result = adminService.removeTicket(ticket_idx);

		    Map<String, Object> response = new HashMap<>();
		    if(result > 0) {
		        response.put("status", "success");
		    } else {
		        response.put("status", "fail");
		        response.put("message", "삭제에 실패했습니다.");
		    }
		    return response;
		}
		// 스터디 카페 좌석 등록 에디터
		@GetMapping("/studycafeEditor.do")
		public ModelAndView studycafeEditor(@RequestParam("studycafe_idx") int studycafe_idx) {
			List<Map<String, Object>> layoutList = adminService.getLayoutList(studycafe_idx);

			ModelAndView mav = new ModelAndView();
			mav.setViewName("admin/adminCafe/studycafeEditor");
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
		
		@GetMapping("/adminCafeReg.do")
	    public String adminCafeRegForm() {
	        return "admin/adminCafe/adminCafeReg";
	    }

	    // 등록 실행
	    @RequestMapping("/adminCafeRegOk.do")
	    public ModelAndView adminCafeReg(StudycafeDTO dto) {
	        int result = adminService.insertStudyCafe(dto);
	        ModelAndView mav = new ModelAndView();
	        
	        if(result > 0) {
	            mav.addObject("msg", "스터디카페가 성공적으로 등록되었습니다.");
	            mav.addObject("url", "adminCafeList.do");
	        } else {
	            mav.addObject("msg", "등록 실패");
	            mav.addObject("url", "adminCafeReg.do");
	        }
	        mav.setViewName("admin/adminMsg");
	        return mav;
	    }

}
