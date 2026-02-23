package com.histudy.admin.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;

public class FaqDAOImple implements FaqDAO {
	
    private SqlSession session;

    public FaqDAOImple(SqlSession session) {
		this.session = session;
	}

	@Override
    public List<MenuCategoryDTO> getCategoryList() {
        return session.selectList("getFaqCategoryList");
    }

    @Override
    public List<FaqDTO> getFaqList(Map<String, Object> map) {
        return session.selectList("getFaqList", map);
    }
    
    @Override
    public FaqDTO getFaqOne(int faq_idx) {
    	return session.selectOne("getFaqOne", faq_idx);
    }
    @Override
    public int updateFaq(FaqDTO dto) {
    	return session.update("updateFaq", dto);
    }
    @Override
    public int insertFaq(FaqDTO dto) {
    	return session.insert("insertFaq", dto);
    }
    @Override
    public int deleteFaq(int faq_idx) {
        return session.delete("deleteFaq", faq_idx);
    }
}