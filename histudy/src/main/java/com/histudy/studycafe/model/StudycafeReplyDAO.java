package com.histudy.studycafe.model;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface StudycafeReplyDAO {
	public int writeStudycafeReply(Map<String,Object> map);
}
