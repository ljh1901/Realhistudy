package com.histudy.studycafe.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.histudy.studycafe.model.StudycafeReplyJoinStudycafeReplyFileDTO;

public interface StudycafeReplyService {
	public void copyFile(MultipartFile reviewFiles);
	public  Map<String, Object> writeStudycafeReply(MultipartFile[] reviewFiles, String studycafe_reply, 
			double studycafe_rating, int user_idx, int studycafe_idx) throws Exception;
	public List<StudycafeReplyJoinStudycafeReplyFileDTO> replyList(int studycafe_idx);
	public double studycafeAvgRating(int studycafe_idx);
}
