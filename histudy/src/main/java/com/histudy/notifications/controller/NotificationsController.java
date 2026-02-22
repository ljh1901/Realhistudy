package com.histudy.notifications.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.notifications.model.NotificationsDTO;
import com.histudy.notifications.service.NotificationsService;

@Controller
public class NotificationsController {
	@Autowired
	private NotificationsService notificationsService;
	
	@GetMapping("notification.do")
	public ModelAndView list(HttpSession session) {
		ModelAndView mav=new ModelAndView();
	    Integer user_idx = (Integer) session.getAttribute("user_idx");
	    
	    notificationsService.updateNotice(user_idx);
	    
		List<NotificationsDTO> list = notificationsService.selectNotice(user_idx);
		mav.addObject("list", list);
    	mav.setViewName("mypage/myNotification");

		return mav;
	}
	@GetMapping("deleteNoti.do")
	@ResponseBody
	public String delete(@RequestParam("n_idx") int n_idx) { 
	    int result=notificationsService.deleteNotice(n_idx);
	    return (result>0)?"success":"fail";
	}
}
