package com.histudy.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.lecture.model.LectureNoteDTO;
import com.histudy.lecture.service.LectureService;
import com.histudy.membership.model.MembershipPaymentDTO;
import com.histudy.membership.service.MembershipService;
import com.histudy.mentoring.model.MentoProfileDTO;
import com.histudy.mentoring.model.MentorSummaryDTO;
import com.histudy.mentoring.model.MentoringDetailDTO;
import com.histudy.mentoring.model.MentoringScheduleDTO;
import com.histudy.mentoring.service.MentoringService;
import com.histudy.mypage.model.WishListDTO;
import com.histudy.mypage.service.MypageService;
import com.histudy.mypage.service.MypageServiceImple;
import com.histudy.study.model.StudyDTO;
import com.histudy.study.service.StudyService;
	
@Controller
public class MypageController {
	@Autowired
	private MembershipService membershipService;
	@Autowired
	private MypageService mypageService;
	@Autowired
	private StudyService studyService;
	@Autowired
	private MentoringService mentoringService;
	@Autowired
	private LectureService lectureService;

	@GetMapping("myDashboard.do")
	public ModelAndView myDashboard(HttpSession session){
	    ModelAndView mav=new ModelAndView();
	    Integer user_idx=(Integer)session.getAttribute("user_idx");
	    mav.addObject("restDays",0);
	    Map<String, Integer> params = new HashMap<>();
	    params.put("start_num", 1);
	    params.put("end_num", 3);
	    
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("user_idx", user_idx); 
	    paramMap.put("start_num", 1);       
	    paramMap.put("end_num", 3);
	    List<StudyDTO> study = mypageService.selectMyStudyList(paramMap);
	    mav.addObject("study",study);
	    Integer mentor_idx = mypageService.getMentorIdxByMentee(user_idx);
	    if(mentor_idx != null) {
            MentoringDetailDTO mdto = mentoringService.selectMentoringDetailByMentor(mentor_idx);
            mav.addObject("mentoring", mdto);
        } 
	    
	    List<LectureNoteDTO> recentNotes = lectureService.selectRecentNotes(user_idx);
	    mav.addObject("recentNotes", recentNotes);
	    if (recentNotes != null && !recentNotes.isEmpty()) {
	        mav.addObject("note", recentNotes.get(0));
	    }
	    
	    if(user_idx!=null){
	        Map<String,Object> map=new HashMap<>();
	        map.put("user_idx",user_idx);
	        map.put("start",1);
	        map.put("end",1);
	        List<Map<String,Object>> list=membershipService.getPayment(map);
	        if(list!=null&&!list.isEmpty()){
	            Map<String,Object> latest=list.get(0);
	            Object endDateObj=latest.get("END_DATE");
	            if(endDateObj!=null){
	                try{
	                    String dateStr=String.valueOf(endDateObj);
	                    java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy년 MM월 dd일");
	                    java.util.Date endDate=sdf.parse(dateStr);
	                    java.util.Date today=new java.util.Date();
	                    long diff=endDate.getTime()-today.getTime();
	                    double days=diff/(1000.0*60*60*24);
	                    long restDays=(long)Math.ceil(days);
	                    mav.addObject("restDays",restDays>0?restDays:0);
	                }catch(Exception e){}
	            }
	        }
	    }
	    
	    
	    mav.setViewName("mypage/myDashboard");
	    return mav;
	}
	@GetMapping("/getMyMonthlyUsage.do")
	@ResponseBody
	public List<Map<String,Object>> getMyMonthlyUsage(HttpSession session){
	    Integer user_idx=(Integer)session.getAttribute("user_idx");
	    if(user_idx==null)return new java.util.ArrayList<>();
	    return mypageService.selectMonthly(user_idx);
	}
	@GetMapping("mySchedule.do")
	public ModelAndView mySchedule() {
		ModelAndView mav=new ModelAndView();

		
		mav.setViewName("mypage/mySchedule");
		return mav;
	}
	@GetMapping("myPurchase.do")
	public ModelAndView myPurchase(HttpSession session,
		@RequestParam(value="cp", defaultValue="1") int cp,
		@RequestParam(value="ls", defaultValue="8") int ls) {
		ModelAndView mav=new ModelAndView();
		Integer user_idx = (Integer)session.getAttribute("user_idx");
		
		int totalCnt=membershipService.getPaymentTotalCnt(user_idx);
		int listSize=8;
		int pageSize=5;
		String pageStr=com.histudy.lecture.page.PageModule.makePage("myPurchase.do",totalCnt,listSize,pageSize,cp);
		int start = (cp - 1) * listSize + 1;
	    int end = cp * listSize;
		Map<String, Object> map = new HashMap<>();
	    map.put("user_idx", user_idx);
	    map.put("start", start);
	    map.put("end", end);
		List<Map<String, Object>> list=membershipService.getPayment(map);
		mav.addObject("list",list);
		mav.addObject("pageStr",pageStr);
		
		String grade = membershipService.membershipGrade(user_idx); 

		if (grade != null && "프리미엄".equals(grade)) {
		    //세션에 쿠폰 부여
		        session.setAttribute("hasCoupon", true);
		} else {
		    //멤버십 만료
		    session.setAttribute("hasCoupon", false);
		}
		
		mav.setViewName("mypage/myPurchase");
		return mav;
	}
	@GetMapping("myHeart.do")
	public ModelAndView myHeart(HttpSession session) {
		ModelAndView mav=new ModelAndView();
		Integer user_idx = (Integer)session.getAttribute("user_idx");
		
		List<Map<String, Object>> mlist=mypageService.selectWishMentorList(user_idx);
		List<StudyDTO> slist=mypageService.selectWishStudyList(user_idx);
		
		mav.addObject("mlist",mlist);
		mav.addObject("slist",slist);
		mav.setViewName("mypage/myHeart");
		return mav;
	}
	
	@GetMapping("/getScheduleList.do")
    @ResponseBody
    public Map<String, Object> getScheduleList(
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
	public String saveSchedule(@RequestBody Map<String,Object> param,HttpSession session){
	    Integer user_idx=(Integer)session.getAttribute("user_idx");
	    if(user_idx==null)
	    	return "fail";
	    param.put("user_idx",user_idx);
	    if(param.get("s_title")==null)
	    	param.put("s_title","");
	    if(param.get("s_content")==null)
	    	param.put("s_content","");
	    int result=mypageService.saveSchedule(param);
	    return result>0?"success":"fail";
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
    //찜하기~~~~~
    @ResponseBody
    @PostMapping("/insertWish.do")
    public Map<String, String> insertWish(@RequestBody WishListDTO dto) {
        Map<String, String> response=new HashMap<>();
        int result=mypageService.insertWish(dto); 
        
        if(result>0) {
            response.put("result","success");
        }else{
            response.put("result","fail");
        }
        return response;
    }
    @ResponseBody
    @PostMapping("/deleteWish.do")
    public Map<String, String> deleteWish(@RequestBody WishListDTO dto) {
        Map<String, String> response=new HashMap<>();
        int result=mypageService.deleteWish(dto); 
        
        if(result>0) {
            response.put("result","success");
        }else{
            response.put("result","fail");
        }
        return response;
    }
    //정기권환불
    @GetMapping("myRefund.do")
	public ModelAndView myRefund() {
		ModelAndView mav=new ModelAndView();

		
		mav.setViewName("mypage/myRefund");
		return mav;
	}
}
