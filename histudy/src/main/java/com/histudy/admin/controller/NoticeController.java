package com.histudy.admin.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.admin.model.NoticeCategoryDTO;
import com.histudy.admin.model.NoticeDTO;
import com.histudy.admin.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	//공지사항 리스트
	@GetMapping("/adminNotice.do")
    public ModelAndView adminNoticeForm(
            @RequestParam(value = "notice_category_idx", required = false) Integer noticeCategory_idx) {
        
        ModelAndView mav = new ModelAndView();

        List<NoticeDTO> noticeList = noticeService.getNoticeList(noticeCategory_idx); 

        mav.addObject("noticeList", noticeList);
        mav.addObject("categoryList", noticeService.getNoticeCategoryList());
        mav.addObject("selectedCategory", noticeCategory_idx);
        mav.setViewName("admin/adminNoticeForm");
        
        return mav;
    }
	//공지사항 등록 폼
	@GetMapping("/adminNoticeWrite.do")
    public ModelAndView adminNoticeWrite() {
        ModelAndView mav = new ModelAndView();
        mav.addObject("categoryList", noticeService.getNoticeCategoryList());
        mav.setViewName("admin/adminNoticeWrite");
        return mav;
    }
	//공지사항 등록ok
	@PostMapping("/adminNoticeWriteOk.do")
	public ModelAndView adminNoticeWriteOk(NoticeDTO dto, 
	                                     @RequestParam("uploadFile") MultipartFile file,
	                                     HttpServletRequest request) {
	    
	    if (!file.isEmpty()) {
	        String savePath = request.getSession().getServletContext().getRealPath("/resources/upload");

	        File folder = new File(savePath);
	        if(!folder.exists()) folder.mkdirs();

	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        
	        try {
	            file.transferTo(new File(savePath, fileName));
	            dto.setNotice_file(fileName); 
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    int result = noticeService.insertNotice(dto);
	    
	    ModelAndView mav = new ModelAndView("admin/adminMsg");
	    if(result > 0) {
	        mav.addObject("msg", "새 공지사항이 등록되었습니다.");
	        mav.addObject("url", "adminNotice.do");
	    } else {
	        mav.addObject("msg", "공지 등록에 실패했습니다.");
	        mav.addObject("url", "history.back()");
	    }
	    
	    return mav;
	}
	
	//공지사항 상세보기
	@GetMapping("/adminNoticeDetail.do")
	public ModelAndView adminNoticeDetail(@RequestParam("notice_idx") int idx) {
	    NoticeDTO dto = noticeService.getNoticeDetail(idx);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("admin/adminNoticeDetail");
	    mav.addObject("notice", dto);
	    
	    return mav;
	}
	
	//공지사항 수정 폼
	@GetMapping("/adminNoticeEdit.do")
	public ModelAndView adminNoticeEditForm(@RequestParam("notice_idx") int idx) {

	    NoticeDTO dto = noticeService.getNoticeDetail(idx);
	    List<NoticeCategoryDTO> categoryList = noticeService.getNoticeCategoryList();

	    ModelAndView mav = new ModelAndView();
	    mav.addObject("notice", dto); 
	    mav.addObject("categoryList", categoryList);
	    mav.setViewName("admin/adminNoticeEditForm");
	    
	    return mav;
	}
	
	//공지사항 수정 ok
	@PostMapping("/adminNoticeEditOk.do")
    public ModelAndView adminNoticeEditOk(NoticeDTO dto, 
                                         @RequestParam("uploadFile") MultipartFile file,
                                         @RequestParam(value="old_file", required=false) String oldFile,
                                         HttpServletRequest request) {
        
        if (!file.isEmpty()) {
        	String savePath = request.getSession().getServletContext().getRealPath("/resources/upload");

            File folder = new File(savePath);
            if(!folder.exists()) folder.mkdirs();

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            
            try {
                file.transferTo(new File(savePath, fileName));
                dto.setNotice_file(fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            dto.setNotice_file(oldFile);
        }

        int result = noticeService.updateNotice(dto);
        
        ModelAndView mav = new ModelAndView("admin/adminMsg");
        if(result > 0) {
            mav.addObject("msg", "공지사항이 수정되었습니다.");
            mav.addObject("url", "adminNoticeDetail.do?notice_idx=" + dto.getNotice_idx());
        } else {
            mav.addObject("msg", "수정에 실패했습니다.");
            mav.addObject("url", "history.back()");
        }
        
        return mav;
    }
	//공지사항 삭제
	@RequestMapping("/adminNoticeDelete.do")
	public ModelAndView adminNoticeDelete(@RequestParam("notice_idx")int notice_idx) {
		int result = noticeService.deleteNoitce(notice_idx);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/adminMsg");
		
		if(result>0) {
			mav.addObject("msg","삭제 완료");
			mav.addObject("url","adminNotice.do");
		}else {
			mav.addObject("msg","삭제실패");
			mav.addObject("url","adminNoticeDetail.do");
		}
		return mav;		
	}
}
