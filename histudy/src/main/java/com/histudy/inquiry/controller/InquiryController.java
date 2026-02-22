package com.histudy.inquiry.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.inquiry.model.InquiryDTO;
import com.histudy.inquiry.model.InquiryCategoryDTO;
import com.histudy.inquiry.service.InquiryService;

@Controller
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    //사용자 문의 작성 폼
    @GetMapping("/userInquiryWrite.do")
    public ModelAndView userInquiryWriteForm(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        List<InquiryCategoryDTO> catList = inquiryService.getCategoryList();
        
        mav.addObject("categoryList", catList);
        mav.setViewName("inquiry/userInquiryWrite");
        return mav;
    }
    
    //사용자 문의 ok
    @PostMapping("/userInquiryWriteOk.do")
    public ModelAndView userInquiryWriteOk(InquiryDTO dto, HttpSession session) {
    	
        Integer userIdx = (Integer) session.getAttribute("user_idx");
        
        ModelAndView mav = new ModelAndView("admin/adminMsg");
        
        if (userIdx == null) {
            mav.addObject("msg", "로그인이 필요한 서비스입니다.");
            mav.addObject("url", "userSignIn.do");
            return mav;
        }
        
        dto.setUser_idx(userIdx);
        int result = inquiryService.insertInquiry(dto);
        
        if (result > 0) {
            mav.addObject("msg", "문의사항이 접수되었습니다.");
            mav.addObject("url", "userInquiryList.do");
        } else {
            mav.addObject("msg", "등록 실패!");
            mav.addObject("url", "history.back()");
        }
        return mav;
    }

    //해당 사용자 문의사항 리스트
    @RequestMapping("/userInquiryList.do")
    public ModelAndView userInquiryList(HttpSession session) {
    	
        Integer userIdx = (Integer) session.getAttribute("user_idx");
        
        ModelAndView mav = new ModelAndView();

        if (userIdx == null) {
            mav.addObject("msg", "로그인이 필요한 서비스입니다.");
            mav.addObject("url", "userSignIn.do");
            mav.setViewName("admin/adminMsg");
            return mav;
        }

        List<InquiryDTO> list = inquiryService.getUserInquiryList(userIdx);
        
        mav.addObject("userInquiryList", list);
        mav.setViewName("inquiry/userInquiryList");
        return mav;
    }
    
    @RequestMapping("/userInquiryDetail.do")
    public ModelAndView userInquiryDetail(@RequestParam("inquiry_idx") int inquiry_idx, HttpSession session) {
        
        Integer userIdx = (Integer) session.getAttribute("user_idx");
        ModelAndView mav = new ModelAndView();

        if (userIdx == null) {
            mav.addObject("msg", "로그인이 필요한 서비스입니다.");
            mav.addObject("url", "userSignIn.do");
            mav.setViewName("admin/adminMsg");
            return mav;
        }

        InquiryDTO dto = inquiryService.getInquiryDetail(inquiry_idx);
        
        if (dto == null || dto.getUser_idx() != userIdx) {
            mav.addObject("msg", "해당 글이 존재하지 않거나 접근 권한이 없습니다.");
            mav.addObject("url", "userInquiryList.do");
            mav.setViewName("admin/adminMsg");
            return mav;
        }
        
        mav.addObject("dto", dto);
        mav.setViewName("inquiry/userInquiryDetail");
        return mav;
    }
}
