package com.histudy.study.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.histudy.study.model.StudyDTO;
import com.histudy.study.service.StudyService;
import com.histudy.user.model.UserDTO;

import java.util.*;

import javax.servlet.http.HttpSession;

@Controller
public class StudyController {

   @Autowired
   private StudyService ss;
   
   @GetMapping("/studyList.do")
   public ModelAndView studyList(
		   @RequestParam(value="cp", defaultValue="1")int cp,
		   @RequestParam(value="sc_idx", defaultValue="0")Integer sc_idx) {
      
	   // int로 받을 경우에 없다면? 0이 들어옴
	   // Integer로 받는다면 ? 래퍼클래스이기 때문에 null 비교 가능
	   
      int listSize = 9;
      int pageSize = 5;
      int totalCnt = 0;
      String pagename = "studyList.do";
    
      
      int start_num = (cp-1)*listSize+1;
      int end_num = cp*listSize;
      
      Map<String, Integer> map = new HashMap<String, Integer>();
      map.put("start_num", start_num);
      map.put("end_num", end_num);
      if(sc_idx == 0) {
    	  sc_idx = null;
    	  totalCnt = ss.studyTotalCnt(sc_idx);
      }else {
    	  totalCnt = ss.studyTotalCnt(sc_idx);
      }
      map.put("sc_idx", sc_idx);
      
      String pageStr = com.histudy.page.PagingModule.makePage(cp, listSize, pageSize, totalCnt, pagename, sc_idx);

      List<StudyDTO> lists = ss.getStudyList(map);
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("studyList", lists);
      mav.addObject("studyListCount", lists.size());
      mav.addObject("pageStr", pageStr);
      mav.setViewName("study/studyList");
      return mav;
   }
   
   @GetMapping("/studyCreateForm.do")
   public ModelAndView studyCreateForm(HttpSession session) {
	   
	   ModelAndView mav = new ModelAndView();
	   
	   String msg = null;
	   
	   Integer user_idx = (Integer)session.getAttribute("user_idx");

	   if(user_idx == null || user_idx == 0) {
		   msg = "Hi, Study에 로그인 완료된 사용자만 접근 가능합니다!";
		   mav.addObject("msg", msg);
		   mav.setViewName("study/studyMsg");
	   }else {
		   
		   UserDTO dto = ss.getStudyCreateUser(user_idx);
		      
		   mav.addObject("user_name", dto.getUser_name());
		   mav.addObject("user_tel", dto.getUser_tel());
		   mav.addObject("user_email", dto.getUser_email());
		   
		   mav.setViewName("study/studyCreate");
	   }
	   
      return mav;
   }
   
   @PostMapping("/studyCreate.do")
   public ModelAndView studyCreate(StudyDTO dto, MultipartFile rstudy_upload_img, HttpSession session) {
  
	  int user_idx = (Integer)session.getAttribute("user_idx");
	   
      int studyMaxCreateCount = ss.studyMaxCreate(user_idx);
      ModelAndView mav = new ModelAndView();
      
      String msg = null;
      if(studyMaxCreateCount>=3){
         msg = "스터디 개설은 최대 3개까지 가능합니다!";
         mav.addObject("msg", msg);
      }else {
         dto.setStudy_upload_img(rstudy_upload_img.getOriginalFilename());
         
         if(rstudy_upload_img != null) {
        	 fileCopy(rstudy_upload_img);
         }
         
         dto.setUser_idx(user_idx);
         
         int result = ss.createStudy(dto);
         msg = result>0?"스터디 개설 완료":"스터디 개설 실패";
         mav.addObject("msg", msg);
      }
      mav.setViewName("study/studyMsg");
      return mav;
   }
   
   @GetMapping("/studyContent.do")
   public ModelAndView studyContent(
		   @RequestParam(value="study_idx", defaultValue="0")int study_idx, HttpSession session) {
	   ModelAndView mav = new ModelAndView();
	   
	   
	   StudyDTO dto = ss.getStudyContent(study_idx);
	   
	   session.setAttribute("dto", dto);
	   
	   mav.addObject("dto", dto);
	   mav.setViewName("study/studyContent");
	   return mav;
   }
   
   public void fileCopy(MultipartFile upload) {
      try {
         byte bytes[] = upload.getBytes();
         
         File f = new File("C:/histudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/histudy/study-img/"+upload.getOriginalFilename());
         
         FileOutputStream fos = new FileOutputStream(f);
         
         fos.write(bytes);
         
         fos.close();
      }catch(IOException e) {
         e.printStackTrace();
      }
   }
   
}
