package com.histudy.studycafe.model;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface StudycafeReplyDAO {
	public int writeStudycafeReply(Map<String,Object> map);
	public List<StudycafeReplyJoinStudycafeReplyFileDTO> replyList(int studycafe_idx);
	public double studycafeAvgRating(int studycafe_idx);
	public int studycafeReviewDelete(Map<String, Integer> map);
}
