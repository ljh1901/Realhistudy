package com.histudy.membership.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.membership.model.MembershipDAO;
import com.histudy.membership.model.MembershipDTO;
import com.histudy.membership.model.MembershipPaymentDTO;
import com.histudy.membership.service.MembershipService;
import com.histudy.mentoring.service.MentoringService;
import com.histudy.user.model.UserDTO;
import com.histudy.user.service.UserService;

@Controller
public class MembershipController {

    @Autowired
    private MembershipService membershipService;
    @Autowired
    private UserService userService;
    
    @GetMapping("membership.do")
    public ModelAndView membershipPayment(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        String user_id = (String) session.getAttribute("user_id");
        Integer user_idx = (Integer) session.getAttribute("user_idx");
        if (user_id == null) {
            mav.addObject("msg", "로그인 후 이용 가능합니다.");
            mav.setViewName("membership/membershipPayment"); 
            return mav;
        }
        if ("프리미엄".equals(membershipService.membershipGrade(user_idx))) {
            mav.addObject("msg", "이미 프리미엄 회원입니다!");
            mav.setViewName("membership/membershipPayment"); 
            return mav;
        }
        UserDTO udto = userService.userInfo(user_id);
        mav.addObject("uname", udto.getUser_name());
        mav.addObject("uemail", udto.getUser_email());
        mav.addObject("utel", udto.getUser_tel());
        mav.addObject("uid", udto.getUser_id());
        mav.addObject("uidx", udto.getUser_idx());
        mav.setViewName("membership/membershipPayment");
        
        Map<String, Object> map = new HashMap<>();
        map.put("user_idx", user_idx);
        map.put("start", 1); 
        map.put("end", 10);
        List<Map<String, Object>> list=membershipService.getPayment(map);
        mav.addObject("list",list);
        
        return mav;
    }
	@PostMapping("/cookieMake.do") 
	@ResponseBody 
	public Map<String, Object> cookieMake(HttpSession session,
			HttpServletResponse resp, 
			@RequestBody MembershipPaymentDTO dto) {
	    
	    membershipService.insertPrimium(dto);
	    session.setAttribute("membership", "premium");
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("result", "success");
	    
	    return map; 
	}
}
