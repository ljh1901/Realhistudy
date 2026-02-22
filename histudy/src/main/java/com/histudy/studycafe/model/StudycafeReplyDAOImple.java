package com.histudy.studycafe.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.web.multipart.MultipartFile;

public class StudycafeReplyDAOImple implements StudycafeReplyDAO {
	private SqlSessionTemplate sqlSession;

	public StudycafeReplyDAOImple(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int writeStudycafeReply(Map<String, Object> map) {
		int result = sqlSession.insert("insertStudycafeReplySQL", map);
		List<StudycafeReplyFileDTO> list=(ArrayList<StudycafeReplyFileDTO>)map.get("replyFileList");
		int fileResult = 0;
		int review_idx = (Integer) map.get("review_idx");
		if(result>0) {
		for(int i=0; i<list.size(); i++) {
				list.get(i).setReview_idx(review_idx);
				fileResult +=sqlSession.insert("insertStudycafeReplyFileSQL",list.get(i));
			}
		}
		return fileResult; 
	}

}
