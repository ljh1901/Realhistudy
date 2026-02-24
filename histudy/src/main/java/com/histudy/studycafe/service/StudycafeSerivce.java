package com.histudy.studycafe.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.histudy.studycafe.model.PayDTO;
import com.histudy.studycafe.model.SeatDTO;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.StudycafeJoinReservationDTO;
import com.histudy.studycafe.model.StudycafeLayoutDTO;
import com.histudy.studycafe.model.StudycafeReservationDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

public interface StudycafeSerivce {
	public List<StudycafeDTO> studycafeList(int currentPage, String region, int listSize);
	public int studycafeListCount(String region);
	public StudycafeDTO studycafe(int studycafe_idx);
	public StudycafeJoinReservationDTO seatReservation(int seat_idx);
	public List<TicketJoinTicketCategoryDTO> ticketInfo(int ticket_category_idx, int studycafe_idx);
	public List<SeatDTO> seatInfo(int studycafe_idx);
	public int orderPay(PayDTO payOrder);
	public int paySeat(PayDTO paydto);
	public PayDTO processPaymentAndReservation(String paymentId, Integer viewTotalAmount, Integer user_idx) throws Exception;
	public int ticketTotalAmount(int ticket_idx);
	public int seatStatusUpdate();
	public List<StudycafeLayoutDTO> studycafeLayout(int studycafe_idx);
	public int paySale(int user_idx);
}
