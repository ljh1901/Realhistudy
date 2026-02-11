package com.histudy.admin.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

import java.util.*;

public class AdminDAOImple implements AdminDAO {

    private SqlSessionTemplate session;

    public AdminDAOImple(SqlSessionTemplate session) {
        this.session = session;
    }
    @Override
    public List<StudycafeDTO> selectAllCafes() {
        return session.selectList("selectAllCafes");
    }
    @Override
    public List<Map<String, Object>> selectSalesList(Map<String, Object> params) {     
        return session.selectList("selectSalesList", params);
    }
    
    @Override
    public void deleteLayoutByCafeIdx(int studycafe_idx) {
        session.delete("deleteLayoutByCafeIdx", studycafe_idx);
    }

    @Override
    public void insertLayout(Map<String, Object> item) {
        session.insert("insertLayout", item);
    }

    @Override
    public List<Map<String, Object>> getLayoutList(int studycafe_idx) {
        return session.selectList("selectLayoutList", studycafe_idx);
    }
    
    @Override
    public List<TicketCategoryDTO> getTicketCategoryList() {
        return session.selectList("getTicketCategoryList");
    }
    
    @Override
    public List<TicketJoinTicketCategoryDTO> getTicketList(int studycafe_idx) {
        return session.selectList("getTicketList", studycafe_idx);
    }

    @Override
    public int insertTicket(Map<String, Object> data) {
        session.insert("insertTicket", data);
        return Integer.parseInt(data.get("newIdx").toString());
    }

    @Override
    public int deleteTicket(int ticket_idx) {
        return session.delete("deleteTicket", ticket_idx);
    }
}