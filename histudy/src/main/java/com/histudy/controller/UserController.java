   package com.histudy.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile; // [추가] 업로드 파일 처리를 위해 필요
import org.springframework.web.servlet.ModelAndView;

import com.histudy.membership.model.MembershipPaymentDTO;
import com.histudy.membership.service.MembershipService;
import com.histudy.user.model.UserDTO;
import com.histudy.user.service.UserService;
import com.histudy.study.service.StudyApplyService;

@Controller
public class UserController {
  @Autowired
   private UserService userService;
   @Autowired
   private MembershipService membershipService;
	@Autowired
	private StudyApplyService sa_Service;

   // 1. 회원가입 View 이동
   @GetMapping("/userSignUp.do")
   public ModelAndView signUpView() {
      ModelAndView mav = new ModelAndView();
      java.util.List<Integer> yearList = new java.util.ArrayList<>();
      for (int i = 2026; i >= 1950; i--) {
         yearList.add(i);
      }
      java.util.List<String> monthList = new java.util.ArrayList<>();
      for (int i = 1; i <= 12; i++) {
         monthList.add(String.format("%02d", i));
      }
      java.util.List<String> dayList = new java.util.ArrayList<>();
      for (int i = 1; i <= 31; i++) {
         dayList.add(String.format("%02d", i));
      }

      mav.addObject("yearList", yearList);
      mav.addObject("monthList", monthList);
      mav.addObject("dayList", dayList);
      mav.setViewName("user/userSignUp");
      return mav;
   }

   // 2. 회원가입 완료
   @PostMapping("/userSignUp.do")
   public String signup(UserDTO dto, HttpServletRequest request) {
	   if (dto.getProfile_img() == null || dto.getProfile_img().trim().isEmpty()) {
           dto.setProfile_img("user.png"); 
       }
      userService.userSignUp(dto);
      UserDTO user = userService.userInfo(dto.getUser_id());
      userService.insertDefaultMypage(user.getUser_idx());
      request.setAttribute("msg", "회원가입 완료");
      return "redirect:/index.do";
   }

   // 3. 로그인 View 및 처리
   @GetMapping("/userSignIn.do")
   public String userSignInView() {
      return "user/userSignIn";
   }

   @PostMapping("/userSignIn.do")
   @ResponseBody
   public String userSignIn(@RequestBody Map<String, String> params, HttpSession session,
         HttpServletResponse response) {
      String user_id = params.get("user_id");
      String user_pwd = params.get("user_pwd");
      String remember_id = params.get("remember_id");
      int result = userService.userSignIn(user_id, com.histudy.security.PwdModule.securityPwd(user_pwd));
      
      if (result == 1) {
         UserDTO loginUser = userService.userInfo(user_id);
         session.setAttribute("user_id", user_id);
         session.setAttribute("user_idx", loginUser.getUser_idx());
         session.setAttribute("role_idx", loginUser.getRole_idx());
         session.setAttribute("user_name", loginUser.getUser_name());

         sa_Service.userLoginTimeUpdate(loginUser.getUser_idx());
         
         // [중요] 세션에 DTO 객체를 저장해둬야 마이페이지 수정 시 편리합니다.
         session.setAttribute("user", loginUser);

         if (remember_id != null) {
            Cookie ck = new Cookie("id", user_id);
            ck.setMaxAge(24 * 60 * 60 * 30);
            response.addCookie(ck);
         } else {
            Cookie ck = new Cookie("id", user_id);
            ck.setMaxAge(0);
            response.addCookie(ck);
         }
         //멤버십처리------------------
         String grade = membershipService.membershipGrade(loginUser.getUser_idx());         
         if ("프리미엄".equals(grade)) {
            session.setAttribute("membership", "premium");
         }else {
            session.setAttribute("membership", "basic");
         }
         return "로그인 성공";
      } else {
         return "아이디 또는 비밀번호를 잘못입력하셨습니다.";
      }
   }

   // 4. 로그아웃 및 중복체크
   @RequestMapping(value = "/userLogout.do", method = RequestMethod.GET)
   public String logout(HttpSession session) {
      session.invalidate();

      Integer user_idx = (Integer) session.getAttribute("user_idx"); 
       sa_Service.userLogoutTimeUpdate(user_idx);
      return "redirect:/index.do";
   }

   @GetMapping("/userCheckId.do")
   @ResponseBody
   public String idCheck(String user_id) {
      return String.valueOf(userService.userCheckId(user_id));
   }

   @GetMapping("/userCheckEmail.do")
   @ResponseBody
   public String emailCheck(String user_email) {
      return String.valueOf(userService.userCheckEmail(user_email));
   }

   // 5. 마이페이지 조회
   @RequestMapping("/myPage.do")
   public ModelAndView myPage(HttpSession session) {
      String userId = (String) session.getAttribute("user_id");
      UserDTO dto = userService.userInfo(userId);
      Integer userIdx = (Integer) session.getAttribute("user_idx"); 
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("user", dto);
      mav.setViewName("user/myPage");
      
      Map<String, Object> map = new HashMap<>();
      map.put("user_idx", userIdx);
      map.put("start", 1); 
      map.put("end", 5);
      List<Map<String, Object>> list = membershipService.getPayment(map);
      mav.addObject("list", list); 
		
      return mav;
   }

   @RequestMapping("/updateProfile.do")
   @ResponseBody
   public String updateProfile(@RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
         UserDTO updatedData, HttpSession session) {
      UserDTO user = (UserDTO) session.getAttribute("user");
      if (user == null)
         return "fail";
      
      // 1. 텍스트 정보 업데이트
      user.setUser_name(updatedData.getUser_name());
      user.setUser_birthdate(updatedData.getUser_birthdate());
      user.setUser_email(updatedData.getUser_email());
      user.setUser_tel(updatedData.getUser_tel());
      user.setUser_intro(updatedData.getUser_intro());

      // 1. 이미지 파일이 있으면 저장 (기존 로직 활용)
      // UserController.java의 이미지 저장 부분 수정
      if (uploadFile != null && !uploadFile.isEmpty()) {
         String savePath = session.getServletContext().getRealPath("/mypage-img/pimg");
         String fileName = uploadFile.getOriginalFilename();

         // 경로와 파일명 사이에 File.separator 또는 "/" 추가 필요
         File saveFile = new File(savePath, fileName);

         try {
            uploadFile.transferTo(saveFile);
            user.setProfile_img(fileName);
         } catch (Exception e) {
            e.printStackTrace();
         }
      }
      int result = userService.updateProfile(user);
     
        if (result > 0) {
            // 성공 시 리턴
            UserDTO loginUser = (UserDTO) session.getAttribute("user");
            UserDTO updatedUser = userService.userInfo(loginUser.getUser_id()); 
            session.setAttribute("user", updatedUser); 
            return "success";
        } else {
            // 실패 시 리턴
            return "fail";
        }
   }

   @PostMapping("userFindId.do")
   @ResponseBody
   public String userFindId(@RequestBody Map<String, String> params) {
      String user_name = params.get("user_name");
      String user_tel = params.get("user_tel");
      String foundId = userService.userFindId(user_name, user_tel);
      return (foundId != null) ? foundId : "fail";
   }

   @GetMapping("/userFindId.do")
   public String userFindIdView() {
      return "user/userFindId";
   }
   
   @PostMapping("/userFindPw.do")
   @ResponseBody
   public String userFindPw(@RequestBody Map<String, String> params) {
      String id = params.get("user_id");
      String name = params.get("user_name");
      String tel = params.get("user_tel");
   
      String result = userService.userFindPw(id, name, tel);
      return (result != null) ? result : "fail";
   }
   
   @GetMapping("/userFindPw.do")
   public String userFindPwView() {
      return "user/userFindPw";
   }
}