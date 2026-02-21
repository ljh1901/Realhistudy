package com.histudy.admin.service;

import com.histudy.admin.model.AdminCafeDAO;
import com.histudy.admin.model.TicketCategoryDTO;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

import java.util.*;

import org.springframework.transaction.annotation.Transactional;

public class AdminCafeServiceImple implements AdminCafeService {

    private final AdminCafeDAO adminDAO;

    public AdminCafeServiceImple(AdminCafeDAO adminDAO) {
        this.adminDAO = adminDAO;
    }

    @Override
    public List<StudycafeDTO> getCafeList() {
        return adminDAO.selectAllCafes();
    }
    @Override
    public List<Map<String, Object>> getSalesList(Map<String, Object> params) {
        return adminDAO.selectSalesList(params);
    }
    
    @Override
    public List<Map<String, Object>> getCafePaymentList(int studycafe_idx) {
        return adminDAO.selectCafePaymentList(studycafe_idx);
    }
    
    @Override
    public List<TicketCategoryDTO> getTicketCategoryList() {
        return adminDAO.getTicketCategoryList();
    }

    @Override
    public List<TicketJoinTicketCategoryDTO> getTicketList(int studycafe_idx) {
        return adminDAO.getTicketList(studycafe_idx);
    }

    @Override
    public int registerTicket(Map<String, Object> data) {
        return adminDAO.insertTicket(data);
    }

    @Override
    public int removeTicket(int ticket_idx) {
        return adminDAO.deleteTicket(ticket_idx);
    }
    
    @Override
    @Transactional
    public void updateCafeLayout(int studycafe_idx, List<Map<String, Object>> layoutData) {
    	adminDAO.deleteLayoutByCafeIdx(studycafe_idx);
    	adminDAO.deleteSeatByCafeIdx(studycafe_idx);

        for (Map<String, Object> item : layoutData) {
            item.put("studycafe_idx", studycafe_idx);
            
            adminDAO.insertLayout(item);
            
            if (!item.get("type").toString().equals("WALL")) { 
            	adminDAO.insertSeat(item);
            }
        }
    }
    @Override
    public List<Map<String, Object>> getLayoutList(int studycafe_idx) {
        return adminDAO.getLayoutList(studycafe_idx);
    }
    @Override
    public int insertStudyCafe(StudycafeDTO dto) {
        return adminDAO.insertStudyCafe(dto);
    }
    
}