package com.histudy.admin.model;

import java.util.*;

import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

public interface AdminCafeDAO {
	public List<StudycafeDTO> selectAllCafes();
	public List<Map<String, Object>> selectSalesList(Map<String, Object> params);
	public List<Map<String, Object>> selectCafePaymentList(int studycafe_idx);
	
	public void deleteLayoutByCafeIdx(int studycafe_idx);
	public int insertLayout(Map<String, Object> layoutData);
	public List<Map<String, Object>> getLayoutList(int studycafe_idx);
	public int deleteSeatByCafeIdx(int studycafe_idx);
	public int insertSeat(Map<String, Object> seatData);
    
	public List<TicketCategoryDTO> getTicketCategoryList();
	public List<TicketJoinTicketCategoryDTO> getTicketList(int studycafe_idx);
	public int insertTicket(Map<String, Object> data);
	public int deleteTicket(int ticket_idx);
	
	public int insertStudyCafe(StudycafeDTO dto);
}