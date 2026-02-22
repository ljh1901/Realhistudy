package com.histudy.studycafe.model;

import java.util.List;
import java.util.Map;

public interface StudycafeDAO {
	public List<StudycafeDTO> studycafeList(Map<String,Object> map); // 스터디 카페 목록
	public int studycafeListCount(String region); // 스터디 카페 개수
	public StudycafeDTO studycafe(int studycafe_idx);
	public StudycafeJoinReservationDTO seatReservation(int seat_idx);
	public List<TicketJoinTicketCategoryDTO> ticketInfo(Map<String, Integer> map);
	public List<SeatDTO> seatInfo(int studycafe_idx);
	public int orderPay(PayDTO payOrder);
	public int paySeat(PayDTO paydto);
	public PayDTO receipt(String paymentId); // 영수증
	public int registerReservation(StudycafeReservationDTO srdto);
	public int ticketTotalAmount(int ticket_idx);
	public int ticketTime(int ticket_idx);
	public int reservationComplete(int seat_idx);
	public int payCancel(String paymentId);
	public int seatStatusUpdate();
	public List<StudycafeLayoutDTO> studycafeLayout(int studycafe_idx); // 스터디 카페 레이아웃
}
