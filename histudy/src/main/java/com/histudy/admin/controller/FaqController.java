package com.histudy.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.admin.model.FaqDTO;
import com.histudy.admin.model.MenuCategoryDTO;
import com.histudy.admin.service.FaqService;

@Controller
public class FaqController {
	
	@Autowired
	private FaqService faqService;
	
	@GetMapping("/adminFaqForm.do")
	public ModelAndView adminFaqForm(
			@RequestParam(value = "menu_category_idx", required = false) Integer menuCategoryIdx) {
		ModelAndView mav = new ModelAndView("admin/adminFaqForm");

		List<MenuCategoryDTO> categoryList = faqService.getCategoryList();
		List<FaqDTO> faqList = faqService.getFaqList(menuCategoryIdx);

		mav.addObject("categoryList", categoryList);
		mav.addObject("faqList", faqList);
		return mav;
	} 
	// 자주 묻는 질문 등록 폼
	@GetMapping("/adminFaqWrite.do")
	public ModelAndView adminFaqWrite() {
		ModelAndView mav = new ModelAndView("admin/adminFaqWrite");
		mav.addObject("categoryList", faqService.getCategoryList());
		return mav;
	}

	//자주 묻는 질문 등록 ok
	@PostMapping("/adminFaqWriteOk.do")
	public ModelAndView adminFaqWriteOk(FaqDTO dto) {
	    int result = faqService.insertFaq(dto);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("admin/adminMsg");
	    
	    if (result > 0) {
	        mav.addObject("msg", "새 질문이 성공적으로 등록되었습니다.");
	        mav.addObject("url", "adminFaqForm.do");
	    } else {
	        mav.addObject("msg", "등록에 실패했습니다. 다시 시도해주세요.");
	        mav.addObject("url", "adminFaqWrite.do");
	    }	    
	    return mav;
	}
	//자주 묻는 질문 수정 폼
	@RequestMapping("/adminFaqEdit.do")
	public ModelAndView adminFaqEdit(@RequestParam("faq_idx") int faq_idx) {
		
	    List<MenuCategoryDTO> categoryList = faqService.getCategoryList();
	    FaqDTO faqOne = faqService.getFaqOne(faq_idx);
	    
	    ModelAndView mav = new ModelAndView();

	    mav.addObject("faq", faqOne);
	    mav.addObject("categoryList", categoryList);
	    mav.setViewName("admin/adminFaqEditForm");

	    return mav;
	}

	//자주 묻는 질문 수정 ok
	@RequestMapping("/adminFaqEditOk.do")
	public ModelAndView adminFaqEditOk(FaqDTO dto) {
		int result = faqService.updateFaq(dto);
		
		ModelAndView mav = new ModelAndView();
	    mav.setViewName("admin/adminMsg");
	    
		if (result > 0) {
			  mav.addObject("msg", "수정 성공");
		        mav.addObject("url", "adminFaqForm.do");
		} else {
			mav.addObject("msg", "수정 실패, 다시 시도해주세요");
	        mav.addObject("url", "adminFaqEditForm.do");
		}
		return mav;
	}
	
	//자주 묻는 질문 삭제
	@RequestMapping("/adminFaqDelete.do")
	public ModelAndView adminFaqDelete(@RequestParam("faq_idx") int faq_idx) {
	    int result = faqService.deleteFaq(faq_idx);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("admin/adminMsg");
	    
	    if (result > 0) {
	        mav.addObject("msg", "질문이 삭제되었습니다.");
	        mav.addObject("url", "adminFaqForm.do");
	    } else {
	        mav.addObject("msg", "삭제에 실패했습니다.");
	        mav.addObject("url", "adminFaqForm.do");
	    }
	    
	    return mav;
	}
}
