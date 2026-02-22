package com.histudy.admin.service;

import com.histudy.admin.model.TicketCategoryDTO;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

import java.util.*;

public interface AdminCafeService {
    public List<StudycafeDTO> getCafeList();
    public List<Map<String, Object>> getSalesList(Map<String, Object> params);
    List<Map<String, Object>> getCafePaymentList(int studycafe_idx);
    
    public List<TicketCategoryDTO> getTicketCategoryList();
    public List<TicketJoinTicketCategoryDTO> getTicketList(int studycafe_idx);
    public int registerTicket(Map<String, Object> data);
    public int removeTicket(int ticket_idx);
    
    public void updateCafeLayout(int studycafe_idx, List<Map<String, Object>> layoutData);
    public List<Map<String, Object>> getLayoutList(int studycafe_idx);
    public int insertStudyCafe(StudycafeDTO dto);
}