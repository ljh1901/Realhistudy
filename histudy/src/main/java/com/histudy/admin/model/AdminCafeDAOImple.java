package com.histudy.admin.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

import java.util.*;

public class AdminCafeDAOImple implements AdminCafeDAO {

    private SqlSessionTemplate session;

    public AdminCafeDAOImple(SqlSessionTemplate session) {
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
    public List<Map<String, Object>> selectCafePaymentList(int studycafe_idx) {
        return session.selectList("selectCafePaymentList", studycafe_idx);
    }
    @Override
    public void deleteLayoutByCafeIdx(int studycafe_idx) {
        session.delete("deleteLayoutByCafeIdx", studycafe_idx);
    }

    @Override
    public int deleteSeatByCafeIdx(int studycafe_idx) {
        return session.delete("deleteSeatByCafeIdx", studycafe_idx);
    }
    @Override
    public int insertSeat(Map<String, Object> seatData) {
        return session.insert("insertSeat", seatData);
    }
    
    @Override
    public int insertLayout(Map<String, Object> layoutData) {
        return session.insert("insertLayout", layoutData);
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
    
    @Override
    public int insertStudyCafe(StudycafeDTO dto) {
        return session.insert("insertStudyCafe", dto);
    }
}