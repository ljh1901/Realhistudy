package com.histudy.membership.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MembershipController {
	@GetMapping("membership.do")
	public ModelAndView membershipPayment() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("membership/membershipPayment");
		return mav;
	}
}
