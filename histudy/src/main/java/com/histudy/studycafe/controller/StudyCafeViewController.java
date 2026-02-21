package com.histudy.studycafe.controller;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.histudy.studycafe.model.PayDTO;
import com.histudy.studycafe.model.SeatDTO;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.StudycafeJoinReservationDTO;
import com.histudy.studycafe.model.StudycafeLayoutDTO;
import com.histudy.studycafe.model.StudycafeReservationDTO;
import com.histudy.studycafe.service.StudycafeSerivce;
import com.histudy.studycafe.service.StudycafeServiceImple;
import com.histudy.user.model.UserDTO;
import com.histudy.user.service.UserService;

@Controller
public class StudyCafeViewController {
	@Autowired
	private StudycafeSerivce studycafeService;
	
	@Autowired
	private UserService userService;
	// 1. 스터디 카페 목록
	@GetMapping("/studycafeList.do")
	public ModelAndView studycafeListView(@RequestParam(defaultValue="전체", required=false) String region, @RequestParam(defaultValue="1") int currentPage) {
		ModelAndView mav = new ModelAndView();
		int pageSize = 5; // 한번에 보여줄 페이지 개수
		int listSize = 3; // 한번에 보여줄 스터디 카페 개수
		int totalCount = studycafeService.studycafeListCount(region); // 카테고리별 전체 개수
		// int currentPage, int listSize, int pageSize, String url
		String paging=com.histudy.studycafe.page.StudycafePageModule.studycafePageAlgorithm(totalCount, currentPage, listSize, pageSize, "studycafeList.do", region);
		List<StudycafeDTO> studycafeList = studycafeService.studycafeList(currentPage, region, listSize);
		mav.addObject("studycafeList", studycafeList);
		mav.addObject("region", region);
		mav.addObject("paging", paging);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("studycafe/studycafeList");
		return mav;
	}
	
	@PostMapping("studycafePageList.do")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> studycafeResponseList(@RequestBody Map<String, Object> map){
		Map<String, Object> respMap = new HashMap<String, Object>();
		String region = (String)map.get("region");
		int totalCount = studycafeService.studycafeListCount(region); // 지역별 전체 개수
		System.out.println(totalCount);
		if(totalCount !=0) {
			int currentPage = (Integer)map.get("currentPage");
			int pageSize = 5; // 한번에 보여줄 페이지 개수
			int listSize = 3; // 한번에 보여줄 스터디 카페 개수
			String paging=com.histudy.studycafe.page.StudycafePageModule.studycafePageAlgorithm(totalCount, currentPage, listSize, pageSize, "studycafeList.do", region);
			List<StudycafeDTO> studycafeList = studycafeService.studycafeList(currentPage, region, 3);
			respMap.put("studycafeList", studycafeList);
			respMap.put("paging", paging);
			respMap.put("currentPage", currentPage);
		}
		ResponseEntity<Map<String,Object>>  respEntity = new ResponseEntity<Map<String,Object>>(respMap,HttpStatus.OK);
		return respEntity;
	}
	// 2. 스터디 카페 좌석 배치
	@GetMapping("/studycafe.do")
	public String studycafeView(Model model, HttpSession session, @RequestParam(required = true ,defaultValue="1") Integer studycafe_idx) {
		// 좌석 상태 변경하기
		int seatStatusUpdate = studycafeService.seatStatusUpdate();
		
		// 스터디 카페 불러오기
		StudycafeDTO studycafeOne = studycafeService.studycafe(studycafe_idx);
		
		// 스터디 카페 레이아웃 불러오기
		List<StudycafeLayoutDTO> layoutDTO = studycafeService.studycafeLayout(studycafe_idx);
		
		// 스터디 카페 좌석 레이아웃 불러오기 
		List<SeatDTO> seatList = studycafeService.seatInfo(studycafe_idx);
		
		// 로그인 아이디 불러오기
		if(session.getAttribute("user_id")!=null) {
			UserDTO udto = userService.userInfo((String)session.getAttribute("user_id"));
			model.addAttribute("udto", udto);
		}
		model.addAttribute("studycafeOne", studycafeOne);
		model.addAttribute("seatList", seatList);
		model.addAttribute("layoutDTO", layoutDTO);
		return "studycafe/studycafeView";
	}
	
	// 스터디 카페 좌석 정보
	@GetMapping("/seatInfo.do")
	@ResponseBody
	public ResponseEntity<List<SeatDTO>> seatInfo(@RequestParam(value="studycafe_idx", required = true, defaultValue = "1") int studycafe_idx){
		System.out.println(studycafe_idx);
		List<SeatDTO> seatList = studycafeService.seatInfo(studycafe_idx);
		ResponseEntity<List<SeatDTO>> seatDTO = new ResponseEntity<List<SeatDTO>>(seatList, HttpStatus.OK);	
		return seatDTO;
	}

	// 스터디 카페 영수증 뷰
	@GetMapping("/receipt.do")
	public ModelAndView receiptView(@RequestParam String paymentId,
	                                @RequestParam(required=false) Integer viewTotalAmount,
	                                HttpSession session) {
	    ModelAndView mav = new ModelAndView();
	    try {
	        PayDTO receipt = studycafeService.processPaymentAndReservation(paymentId, viewTotalAmount, session);
	        mav.setViewName("studycafe/receipt");
	        mav.addObject("receipt", receipt);
	    } catch(Exception e) {
	        e.printStackTrace();
	        mav.setViewName("studycafe/receipt");
	        mav.addObject("msg", "결제를 취소하셨습니다.");
	    }
	    return mav;
	}
	
	@GetMapping("studycafeReview.do")
	public ModelAndView studycafeReply(@RequestParam(required = true, value="studycafe_idx") int studycafe_idx) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("studycafe/studycafeReview");
		return mav;
	}



}
