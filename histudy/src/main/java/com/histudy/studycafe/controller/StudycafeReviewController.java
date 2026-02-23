package com.histudy.studycafe.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.histudy.studycafe.model.StudycafeReplyFileDTO;
import com.histudy.studycafe.service.StudycafeReplyService;

@Controller
public class StudycafeReviewController {
	
	@Autowired
	private StudycafeReplyService studycafeReplyService;
	
	@GetMapping("studycafeReview.do")
	public ModelAndView studycafeReply(@RequestParam(required = true, value = "studycafe_idx") int studycafe_idx) {
		ModelAndView mav = new ModelAndView();
		studycafeReplyService.replyList(studycafe_idx);
		double avgRating=studycafeReplyService.studycafeAvgRating(studycafe_idx);
		DecimalFormat df = new DecimalFormat("0.##");
		avgRating= Double.parseDouble(df.format(avgRating));
		mav.addObject("studycafe_idx", studycafe_idx);
		mav.addObject("avgRating", avgRating);
		mav.setViewName("studycafe/studycafeReview");
		return mav;
	}

	@PostMapping(value = "studycafeReviewFile.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> fileList(@RequestBody(required = false) MultipartFile[] reviewFiles, 
			String studycafe_reply, double studycafe_rating, HttpSession session, int studycafe_idx) {
		try {
		Map<String, Object> map = studycafeReplyService.writeStudycafeReply(reviewFiles, studycafe_reply, studycafe_rating, (Integer)session.getAttribute("user_idx"), studycafe_idx); // JSON 객체
		ResponseEntity<Map<String, Object>> respReplyFile = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		return respReplyFile;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
