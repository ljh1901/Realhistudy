package com.histudy.studycafe.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface StudycafeReplyService {
	public void copyFile(MultipartFile reviewFiles);
	public  Map<String, Object> writeStudycafeReply(MultipartFile[] reviewFiles, String studycafe_reply, 
			double studycafe_rating, int user_idx, int studycafe_idx) throws Exception;
}
