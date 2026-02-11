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
        return session.selectList("com.histudy.admin.getFaqCategoryList");
    }

    @Override
    public List<FaqDTO> getFaqList(Map<String, Object> map) {
        return session.selectList("com.histudy.admin.getFaqList", map);
    }
    
    @Override
    public FaqDTO getFaqOne(int faq_idx) {
    	return session.selectOne("com.histudy.admin.getFaqOne", faq_idx);
    }
    @Override
    public int updateFaq(FaqDTO dto) {
    	return session.update("com.histudy.admin.updateFaq", dto);
    }
    @Override
    public int insertFaq(FaqDTO dto) {
    	return session.insert("com.histudy.admin.insertFaq", dto);
    }
    @Override
    public int deleteFaq(int faq_idx) {
        return session.delete("com.histudy.admin.deleteFaq", faq_idx);
    }
}