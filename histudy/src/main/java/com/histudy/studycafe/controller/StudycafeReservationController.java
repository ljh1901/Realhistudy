package com.histudy.studycafe.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.histudy.studycafe.model.StudycafeJoinReservationDTO;
import com.histudy.studycafe.service.StudycafeSerivce;
@RestController
@RequestMapping("/seatReservation.do")
public class StudycafeReservationController {
	
	@Autowired
	private StudycafeSerivce studycafeService;
	
	@PostMapping
	public StudycafeJoinReservationDTO seatReservation(@RequestBody Map<String,Integer> map) {
		StudycafeJoinReservationDTO info = studycafeService.seatReservation(map.get("seat_idx"));
		return info;
	} 
}
