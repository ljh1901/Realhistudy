package com.histudy.mypage.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.histudy.membership.model.MembershipPaymentDTO;
import com.histudy.mentoring.model.MentoProfileDTO;
import com.histudy.study.model.StudyDTO;

public class MypageDAOImple implements MypageDAO {
	private SqlSessionTemplate sqlSession;
	public MypageDAOImple(SqlSessionTemplate sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	@Override
	public int checkSchedule(Map<String, Object> param) {
		Integer result = sqlSession.selectOne("mypage.checkSchedule", param);
		return result == null ? 0 : result;	}
	@Override
	public int deleteSchedule(Map<String, Object> param) {
		return sqlSession.delete("mypage.deleteSchedule", param);
	}
	@Override
	public List<ScheduleDTO> getMonthSchedule(Integer user_idx, String year, String month){
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("user_idx", user_idx);
	    paramMap.put("year", year);
	    paramMap.put("month", month);
		return sqlSession.selectList("mypage.getMonthSchedule", paramMap);
	}
	@Override
	public int insertSchedule(Map<String, Object> param) {
		return sqlSession.insert("mypage.insertSchedule", param);
	}
	@Override
	public int updateSchedule(Map<String, Object> param) {
		return sqlSession.update("mypage.updateSchedule", param);
	}
	@Override
	public List<Map<String,Object>> selectMonthly(int user_idx){
	    return sqlSession.selectList("mypage.selectMonthly",user_idx);
	}
	@Override
	public int insertWish(WishListDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mypage.insertWish",dto);
	}
	@Override
	public int deleteWish(WishListDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mypage.deleteWish",dto);
	}
	@Override
	public List<Map<String, Object>> selectWishMentorList(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectWishMentorList",user_idx);
	}
	@Override
	public List<StudyDTO> selectWishStudyList(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectWishStudyList", user_idx);
	}
	@Override
	public int selectHalfPrice(Map<String,Object> map){
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectHalfPrice",map);
	}
	@Override
	public MembershipPaymentDTO getLastMembership(int user_idx) {
	// TODO Auto-generated method stub
		return sqlSession.selectOne("getLastMembership",user_idx);
	}
	@Override
	public List<StudyDTO> getMyStudyDates(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getMyStudyDates",user_idx);
	}
	@Override
	public Integer getMentorIdxByMentee(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getMentorIdxByMentee",user_idx);
	}
}
