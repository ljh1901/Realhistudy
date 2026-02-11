package com.histudy.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import java.util.*;

import com.histudy.admin.service.AdminUserServiceImple;
import com.histudy.user.model.*;

@Controller
public class AdminUserController {

    @Autowired
    private AdminUserServiceImple adminUserService;

    /** 회원 관리 목록 */
    @RequestMapping("/adminUserList.do")
    public ModelAndView adminUserList(@RequestParam(value="cp", defaultValue="1") int cp) {
        List<UserDTO> list = adminUserService.getUserList();
        int totalCount = adminUserService.getUserCount();

        ModelAndView mav = new ModelAndView();
        mav.addObject("userList", list);
        mav.addObject("userListCount", totalCount);
        mav.setViewName("admin/adminUserList");
        return mav;
    }

    @RequestMapping("/adminUserDelete.do")
    public String adminUserDelete(@RequestParam("user_idx") int user_idx) {
        int result = adminUserService.deleteUser(user_idx);
        return "redirect:adminUserList.do";
    }
}
