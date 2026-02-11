package com.histudy.admin.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

public class NoticeDAOImple implements NoticeDAO {

	private SqlSession session;

	public NoticeDAOImple(SqlSession session) {
		super();
		this.session = session;
	}

	@Override
	public List<NoticeCategoryDTO> getNoticeCategoryList() {
		return session.selectList("com.histudy.admin.getNoticeCategoryList");
	}

	@Override
	public List<NoticeDTO> getNoticeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("com.histudy.admin.selectNoticeList",map);
	}

	@Override
	public NoticeDTO getNoticeOne(int notice_idx) {
		return session.selectOne("com.histudy.admin.getNoticeOne", notice_idx);
	}
	@Override
	public int insertNotice(NoticeDTO dto) {
		return session.insert("com.histudy.admin.insertNotice",dto);
	}
	
	@Override
	public int updateNotice(NoticeDTO dto) {
		return session.update("com.histudy.admin.updateNotice",dto);
	}
	@Override
	public int deleteNotice(int notice_idx) {
		return session.delete("com.histudy.admin.deleteNotice",notice_idx);
	}
}
