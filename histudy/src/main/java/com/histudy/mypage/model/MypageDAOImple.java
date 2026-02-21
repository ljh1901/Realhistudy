package com.histudy.mypage.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

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
	public List<ScheduleDTO> getMonthSchedule(Map<String, Object> param) {
		return sqlSession.selectList("mypage.getMonthSchedule", param);
	}
	@Override
	public int insertSchedule(Map<String, Object> param) {
		return sqlSession.insert("mypage.insertSchedule", param);
	}
	@Override
	public int updateSchedule(Map<String, Object> param) {
		return sqlSession.update("mypage.updateSchedule", param);
	}
}
