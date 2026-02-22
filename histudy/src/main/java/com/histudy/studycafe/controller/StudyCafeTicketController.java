package com.histudy.studycafe.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.histudy.studycafe.model.StudycafeJoinReservationDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;
import com.histudy.studycafe.service.StudycafeSerivce;

@RestController
@RequestMapping("/seatTicket.do")
public class StudyCafeTicketController {
	
	@Autowired
	private StudycafeSerivce studycafeService;
	
	// 티켓 정보
	@GetMapping
	public ResponseEntity<List<TicketJoinTicketCategoryDTO>> ticketInfo(@RequestParam int ticket_category_idx, @RequestParam(value="studycafe_idx") int studycafe_idx) {
		List<TicketJoinTicketCategoryDTO> data = studycafeService.ticketInfo(ticket_category_idx, studycafe_idx);
		ResponseEntity<List<TicketJoinTicketCategoryDTO>> re = new ResponseEntity<List<TicketJoinTicketCategoryDTO>>(data,HttpStatus.OK);
		return re;
	}
	
}
