package com.histudy.studycafe.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
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

import com.histudy.studycafe.model.StudycafeReplyFile;

@Controller
public class StudycafeReviewController {
	@GetMapping("studycafeReview.do")
	public ModelAndView studycafeReply(@RequestParam(required = true, value = "studycafe_idx") int studycafe_idx) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("studycafe/studycafeReview");
		return mav;
	}

	@PostMapping(value = "studycafeReviewFile.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> fileList(@RequestBody(required = false) MultipartFile[] reviewFiles, String studycafe_reply, double studycafe_rating) {
		Map<String, Object> map = new HashMap<String, Object>(); // JSON 객체
		List<String> replyFileLists = new ArrayList<String>();
		// 리뷰 관리 폴더
		File f = new File("C:/Realhistudy/histudy/src/main/webapp/studycafe-reviewimg/");
		System.out.println("댓글 내용:" + studycafe_reply);
		System.out.println("업로드된 파일 길이:" + reviewFiles);
		System.out.println(studycafe_rating);
		if (reviewFiles !=null) {
		for (int i = 0; i < reviewFiles.length; i++) {
				copyFile(reviewFiles[i]); // 파일 복사
		}
		}
		if(studycafe_reply !=null && !(studycafe_reply.equals(""))) {
			map.put("studycafe_reply",studycafe_reply);
		}
		if (f.isDirectory()&&reviewFiles !=null) {
			File[] files = f.listFiles();
			for (File temp : files) {
				for (int i = 0; i < reviewFiles.length; i++) {
					if (!reviewFiles[i].isEmpty()) {
						if (temp.isFile()) {
							System.out.println("업로드 된 파일: " + reviewFiles[i].getOriginalFilename());

							if (reviewFiles[i].getOriginalFilename().equals(temp.getName())) {
								System.out.println("실제 디렉터리에 있는 파일: " + temp.getName());
								String image="<img src='"+temp.toString().substring(temp.toString().lastIndexOf("studycafe-reviewimg"))+"'alt='defaultImg'>";
								replyFileLists.add(image);
								map.put("replyFileList", replyFileLists);
							}
						}
					}
				}
			}
		}
		ResponseEntity<Map<String, Object>> respReplyFile = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		return respReplyFile;
	}

	public void copyFile(MultipartFile reviewFiles) {
		String directoryReview = "C:/Realhistudy/histudy/src/main/webapp/studycafe-reviewimg/";
		try {
			// 복사 용지 선택
			byte[] bytes = reviewFiles.getBytes();
			// 1. 빈 복사 용지 만들기
			File file = new File(directoryReview + reviewFiles.getOriginalFilename());
			// 2. 복사기 생성
			FileOutputStream fos = new FileOutputStream(file);

			// FileUtils.copyFile(file, fos);
			// reviewFiles.transferTo(file);

			// 3. 복사하기
			fos.write(bytes);

			// 4. 복사기 종료
			fos.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
