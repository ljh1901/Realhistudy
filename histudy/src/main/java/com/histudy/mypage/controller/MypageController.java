package com.histudy.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.membership.model.MembershipPaymentDTO;
import com.histudy.membership.service.MembershipService;
import com.histudy.mypage.service.MypageService;
import com.histudy.mypage.service.MypageServiceImple;
	
@Controller
public class MypageController {
	@Autowired
	private MembershipService membershipService;
	@Autowired
	private MypageService mypageService;

	@GetMapping("myDashboard.do")
	public ModelAndView myDashboard() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("mypage/myDashboard");
		return mav;
	}
	@GetMapping("mySchedule.do")
	public ModelAndView mySchedule() {
		ModelAndView mav=new ModelAndView();

		
		mav.setViewName("mypage/mySchedule");
		return mav;
	}
	@GetMapping("myPurchase.do")
	public ModelAndView myPurchase(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		Integer user_idx=(Integer)session.getAttribute("user_idx");
		List<Map<String, Object>> list=membershipService.getPayment(user_idx);
		mav.addObject("list",list);
		mav.setViewName("mypage/myPurchase");
		return mav;
	}
	@GetMapping("myHeart.do")
	public ModelAndView myHeart() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("mypage/myHeart");
		return mav;
	}
	@GetMapping("myAlarm.do")
	public ModelAndView myAlarm() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("mypage/myAlarm");
		return mav;
	}
	
	@GetMapping("/getScheduleList.do")
    @ResponseBody
    public Map<String, String> getScheduleList(
            @RequestParam("year") String year, 
            @RequestParam("month") String month, 
            HttpSession session) {
        
        Integer user_idx=(Integer)session.getAttribute("user_idx");
        
        if (user_idx==null) {
            return new HashMap<>();
        }

        return mypageService.getMonthSchedule(user_idx, year, month);
    }

    @PostMapping("/saveSchedule.do")
    @ResponseBody
    public String saveSchedule(@RequestBody Map<String, Object> param, HttpSession session) {
        Integer user_idx= (Integer) session.getAttribute("user_idx");
        
        if (user_idx== null) {
            return "fail";
        }
        
        param.put("user_idx", user_idx);
        
        int result= mypageService.saveSchedule(param);
        return result > 0 ? "success" : "fail";
    }

    @PostMapping("/deleteSchedule.do")
    @ResponseBody
    public String deleteSchedule(@RequestBody Map<String, Object> param, HttpSession session) {
        Integer user_idx= (Integer) session.getAttribute("user_idx");
        
        if (user_idx== null) {
            return "fail";
        }
        
        param.put("user_idx", user_idx);
        
        int result = mypageService.deleteSchedule(param);
        return result > 0 ? "success" : "fail";
    }
}
