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
		return session.selectList("getNoticeCategoryList");
	}

	@Override
	public List<NoticeDTO> getNoticeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.selectList("selectNoticeList",map);
	}

	@Override
	public NoticeDTO getNoticeOne(int notice_idx) {
		return session.selectOne("getNoticeOne", notice_idx);
	}
	@Override
	public int insertNotice(NoticeDTO dto) {
		return session.insert("insertNotice",dto);
	}
	
	@Override
	public int updateNotice(NoticeDTO dto) {
		return session.update("updateNotice",dto);
	}
	@Override
	public int deleteNotice(int notice_idx) {
		return session.delete("deleteNotice",notice_idx);
	}
}
