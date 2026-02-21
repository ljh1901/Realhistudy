package com.histudy.notifications.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.notifications.model.NotificationsDTO;
import com.histudy.notifications.service.NotificationsService;

@Controller
public class NotificationsController {
	@Autowired
	private NotificationsService notificationsService;
	
	@GetMapping("notifications")
	public ModelAndView list(HttpSession session) {
		ModelAndView mav=new ModelAndView();
	    Integer user_idx = (Integer) session.getAttribute("user_idx");
		List<NotificationsDTO> list = notificationsService.selectNotice(user_idx);
		mav.addObject("list", list);
		return mav;
	}
}
