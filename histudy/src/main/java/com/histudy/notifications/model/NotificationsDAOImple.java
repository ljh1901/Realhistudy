package com.histudy.notifications.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

public class NotificationsDAOImple implements NotificationsDAO {


	private SqlSessionTemplate sqlSession;
	
	public NotificationsDAOImple(SqlSessionTemplate sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	@Override
	public int sendNotice(NotificationsDTO dto) {
		
		int count = sqlSession.insert("sendNotice", dto);
		return count;
	}
	@Override
	public List<NotificationsDTO> selectNotice(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectNotice",user_idx);
	}
	@Override
	public int deleteNotice(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.delete("com.histudy.notifications.deleteNotice",user_idx);
	}
	@Override
	public int updateNotice(int user_idx) {
		// TODO Auto-generated method stub
		return sqlSession.update("com.histudy.notifications.updateNotice",user_idx);
	}
}
