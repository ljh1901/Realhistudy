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

		int fileResult = 0;
		int review_idx = (Integer) map.get("review_idx");
		if(result>0) {
			if(map.get("replyFileList") !=null) {
				List<StudycafeReplyFileDTO> list=(ArrayList<StudycafeReplyFileDTO>)map.get("replyFileList");
				for(int i=0; i<list.size(); i++) {
					list.get(i).setReview_idx(review_idx);
					fileResult +=sqlSession.insert("insertStudycafeReplyFileSQL",list.get(i));
				}
				return fileResult; 
			}
		}
		return result;
	}
	
	@Override
	public List<StudycafeReplyJoinStudycafeReplyFileDTO> replyList(int studycafe_idx) {
		List<StudycafeReplyJoinStudycafeReplyFileDTO> replyList = sqlSession.selectList("selectStudycafeReplySQL", studycafe_idx);
		return replyList;
	}
	
	@Override
	public double studycafeAvgRating(int studycafe_idx) {
		double avgRating = sqlSession.selectOne("selectStudycafeRatingAvgSQL", studycafe_idx);
		return avgRating;
	}
	@Override
	public int studycafeReviewDelete(Map<String, Integer> map) {
			int result = sqlSession.delete("deleteStudycafeReviewSQL", map);
		if(result > 0) {
			int delete=sqlSession.delete("deleteStudycafeReviewFileSQL", map);
		}
		return result;
	}
	
	@Override
	public int studycafeReplyValid(int user_idx) {
		int result = sqlSession.selectOne("selectStudycafePaySQL", user_idx);
		return result;
	}
	@Override
	public int studycafeReplyWritten(int user_idx) {
		int result = sqlSession.selectOne("selectWrittenSQL", user_idx);
		return result;
	}
}
