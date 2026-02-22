package com.histudy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import java.util.*;

import com.histudy.admin.model.FaqDTO;
import com.histudy.admin.model.NoticeDTO;
import com.histudy.usersupport.service.*;

@Controller
public class UserSupportController {

	@Autowired
	private UserSupportService supportService;

    @RequestMapping("/faqList.do")
    public ModelAndView faqList(@RequestParam(value = "menu_category_idx", required = false, defaultValue = "0") int menu_category_idx) {
        
        List<Map<String, Object>> categoryList = supportService.getFaqCategoryList();
        
        Map<String, Object> map = new HashMap<>();
        map.put("menu_category_idx", menu_category_idx);
        List<FaqDTO> faqList = supportService.getFaqList(map);
        
        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryList", categoryList);
        mav.addObject("faqList", faqList);
        mav.setViewName("support/faqList");
        return mav;
    }

    @RequestMapping("/noticeList.do")
    public ModelAndView noticeList(@RequestParam(value = "notice_category_idx", required = false, defaultValue = "0") int notice_category_idx) {

        List<Map<String, Object>> noticeCategoryList = supportService.getNoticeCategoryList();
        
        Map<String, Object> map = new HashMap<>();
        map.put("notice_category_idx", notice_category_idx);
        List<NoticeDTO> noticeList = supportService.selectNoticeList(map);
        
        ModelAndView mav = new ModelAndView();
        mav.addObject("noticeCategoryList", noticeCategoryList);
        mav.addObject("noticeList", noticeList);
        mav.setViewName("support/noticeList");
        return mav;
    }

    @RequestMapping("/noticeDetail.do")
    public ModelAndView noticeDetail(@RequestParam("notice_idx") int notice_idx) {
        NoticeDTO dto = supportService.getNoticeOne(notice_idx);
        
        ModelAndView mav = new ModelAndView();
        mav.addObject("notice", dto);
        mav.setViewName("support/noticeDetail");
        return mav;
    }
}