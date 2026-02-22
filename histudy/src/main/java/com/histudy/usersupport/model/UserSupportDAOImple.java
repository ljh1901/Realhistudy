package com.histudy.usersupport.model;

import org.mybatis.spring.SqlSessionTemplate;

import com.histudy.admin.model.FaqDTO;
import com.histudy.admin.model.NoticeDTO;

import java.util.*;

public class UserSupportDAOImple implements UserSupportDAO  {

    private SqlSessionTemplate session;
   
	public UserSupportDAOImple(SqlSessionTemplate session) {
		super();
		this.session = session;
	}

	// FAQ
    public List<Map<String, Object>> getFaqCategoryList() {
        return session.selectList("getFaqCategoryList");
    }

    public List<FaqDTO> getFaqList(Map<String, Object> map) {
        return session.selectList("getFaqList", map);
    }

    // 공지사항
    public List<Map<String, Object>> getNoticeCategoryList() {
        return session.selectList("getNoticeCategoryList");
    }

    public List<NoticeDTO> selectNoticeList(Map<String, Object> map) {
        return session.selectList("selectNoticeList", map);
    }

    public NoticeDTO getNoticeOne(int notice_idx) {
        return session.selectOne("getNoticeOne", notice_idx);
    }
}
