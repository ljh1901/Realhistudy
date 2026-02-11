package com.histudy.lecture.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.histudy.lecture.model.LectureDTO;
import com.histudy.lecture.model.LectureHateDTO;
import com.histudy.lecture.model.LectureLikeDTO;
import com.histudy.lecture.model.LectureNoteDTO;
import com.histudy.lecture.model.LectureReviewDTO;
import com.histudy.lecture.service.LectureService;


@Controller
public class LectureController {

   @Autowired
    private LectureService lectureService;
   
   @GetMapping("lecture.do")
   public ModelAndView lectureList(
		   @RequestParam(value="cp", defaultValue="1") int cp,
		   @RequestParam(value="ls", defaultValue="8") int ls) {
	  int totalCnt=lectureService.getTotalCnt();
	  int listSize=8;
	  int pageSize=5;
	  String pageStr=com.histudy.page.PagingModule.makePage(cp, listSize, pageSize, totalCnt, "lecture.do", ls);
	   
      ModelAndView mav= new ModelAndView();
      List<LectureDTO> lists;
	try {
		lists = lectureService.lectureList(cp,ls);
		mav.addObject("lectureLists",lists);
	} catch (Exception e) {
		e.printStackTrace();
	}
      mav.addObject("pageStr",pageStr);
      mav.setViewName("lecture/lectureList");
      
      return mav;
   }
   @GetMapping("lectureContent.do")
   public ModelAndView lectureContent(@RequestParam("lecture_idx") Integer lecture_idx,HttpSession session) {
      Integer user_idx = (Integer) session.getAttribute("user_idx");
      Map<String, Object> map = new HashMap<>();
      map.put("lecture_idx", lecture_idx);
      map.put("user_idx", user_idx);
      ModelAndView mav=new ModelAndView();
      if(user_idx!=null) {
    	  Integer review_idx=lectureService.myReview(user_idx);
    	  String userName=lectureService.selectName(user_idx);
    	  String scIdx=lectureService.scIdx(lecture_idx);
    	  mav.addObject("myReview",review_idx);
    	  List<LectureReviewDTO> lists=lectureService.reviewList(lecture_idx);
    	  mav.addObject("reviewList",lists);
    	  mav.addObject("userName",userName);
    	  mav.addObject("scIdx",scIdx);
      LectureNoteDTO memo = lectureService.lectureMemoList(map);
      if (memo == null) {
          LectureNoteDTO dto = new LectureNoteDTO();
          dto.setLecture_idx(lecture_idx);
          dto.setUser_idx(user_idx);
          dto.setNote_title("제목을 입력해주세요");
          dto.setNote_content("");
          lectureService.lectureNoteInsert(dto);
	  }
	  LectureDTO list=lectureService.lectureContent(lecture_idx);
      mav.addObject("lectureContent",list);
      mav.addObject("memo",memo);
      
      LectureLikeDTO ldto=new LectureLikeDTO();
      ldto.setLecture_idx(lecture_idx);
      ldto.setUser_idx(user_idx);
      
      Integer isLike=lectureService.lectureLike(ldto);
      mav.addObject("isLike",isLike);
      }else {
          String msg="로그인 후 이용 가능합니다.";
          mav.addObject("msg",msg);
      }
      mav.setViewName("lecture/lectureContent");
      return mav;
   }
   @ResponseBody
   @RequestMapping("lectureMemo.do")
   public Map<String,Object> lectureMemo(LectureNoteDTO dto) {
	  Map<String,Object> map=new HashMap<>();
      int result=lectureService.lectureNoteUpdate(dto);
      map.put("result", result);
      return map;
   }
   @ResponseBody
   @RequestMapping("checkReview.do")
   public Map<String, Object> checkReview(@RequestParam("lecture_idx") int lecture_idx, HttpSession session) {
       Integer user_idx = (Integer) session.getAttribute("user_idx");
       
       Map<String, Object> params = new HashMap<>();
       params.put("lecture_idx", lecture_idx);
       params.put("user_idx", user_idx);
       
       int count = lectureService.checkReviewCount(params); 
       
       Map<String, Object> map = new HashMap<>();
       map.put("count", count);
       return map;
   }
   @PostMapping("reviewWrite.do")
   public ModelAndView reviewWrite(LectureReviewDTO dto,RedirectAttributes rt) {
	   int result=lectureService.reviewInsert(dto);
	   ModelAndView mav=new ModelAndView();
	   String msg=result>0?"리뷰 작성 완료":"리뷰 작성 실패";
	   rt.addAttribute("reviewMsg", msg);
	   mav.setViewName("redirect:lectureContent.do?lecture_idx=" + dto.getLecture_idx());	   
	   return mav;
   }
   @PostMapping("reviewUpdate.do")
   public ModelAndView reviewUpdate(LectureReviewDTO dto,RedirectAttributes rt) {
       int result = lectureService.reviewUpdate(dto);
       
       ModelAndView mav = new ModelAndView();
       String msg = result > 0 ? "리뷰 수정 완료" : "리뷰 수정 실패";
       rt.addAttribute("reviewMsg",msg);
       mav.setViewName("redirect:lectureContent.do?lecture_idx=" + dto.getLecture_idx());
       return mav;
   }
   @RequestMapping("reviewDelete.do")
   public ModelAndView reviewDelete(@RequestParam("review_idx") int review_idx, 
                                   @RequestParam("lecture_idx") int lecture_idx) {
       lectureService.reviewDelete(review_idx);
       ModelAndView mav = new ModelAndView();
       mav.setViewName("redirect:lectureContent.do?lecture_idx=" + lecture_idx);
       
       return mav;
   }
   @RequestMapping("reviewLike.do")
   public ModelAndView reviewLike(int lecture_idx,int user_idx,LectureLikeDTO ldto,LectureHateDTO hdto) {
	   int result=lectureService.lectureLike(ldto);
	   if(result>0) {//좋아요가 존재할때
		   lectureService.lectureLikeDown(lecture_idx);
	   }else {
		   lectureService.lectureLikeUp(lecture_idx);
		   lectureService.lectureHateDown(lecture_idx);
		   lectureService.lectureHateDelete(hdto);
	   }
	   ModelAndView mav = new ModelAndView();
	   mav.setViewName("redirect:lectureContent.do?lecture_idx=" + lecture_idx);
	   return mav;
   }
}
