package com.histudy.studycafe.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;

public class StudycafeDAOImple implements StudycafeDAO{
	private SqlSessionTemplate sqlSession;

	public StudycafeDAOImple(SqlSessionTemplate sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<StudycafeDTO> studycafeList(Map<String,Object> map) {
		List<StudycafeDTO> list = sqlSession.selectList("studycafeListSQL", map);
		return list;
	}
	@Override
	public int studycafeListCount(@Param(value="region")String region) {
		int result = sqlSession.selectOne("studycafeListCountSQL", region);
		return result;
	}
	@Override
	public StudycafeDTO studycafe(int studycafe_idx) {
		StudycafeDTO studycafeOne = sqlSession.selectOne("selectStudycafeSQL", studycafe_idx);
		return studycafeOne;
	}
	@Override
	public StudycafeJoinReservationDTO seatReservation(int seat_idx) {
		StudycafeJoinReservationDTO seatInfo = sqlSession.selectOne("selectSeatInfoSQL", seat_idx);
		return seatInfo;
	}
	@Override
	public List<TicketJoinTicketCategoryDTO> ticketInfo(Map<String,Integer> map) {
		List<TicketJoinTicketCategoryDTO> ticketInfo = sqlSession.selectList("selectTicketInfoSQL", map);
		return ticketInfo;
	}
	@Override
	public List<SeatDTO> seatInfo(int studycafe_idx) {
		List<SeatDTO> seatDTO = sqlSession.selectList("selectSeatSQL", studycafe_idx);
		return seatDTO;
	}
	@Override
	public int orderPay(PayDTO payOrder) {
		int result = sqlSession.insert("insertOrderSQL", payOrder);
		return result;
	}
	@Override
	public int paySeat(PayDTO paydto) {
		int result = sqlSession.insert("updatePaySQL", paydto);
		return result;
	}
	@Override
	public PayDTO receipt(String paymentId) {
		PayDTO receipt = sqlSession.selectOne("selectReceiptSQL",paymentId);
		return receipt;
	}
	@Override
	public int registerReservation(StudycafeReservationDTO srdto) {
		int result = sqlSession.insert("insertRegisterReservationSQL",srdto);
		return result;
	}
	@Override
	public int ticketTotalAmount(int ticket_idx) {
		int ticketAmount = sqlSession.selectOne("selectTicketTotalAmountSQL", ticket_idx);
		return ticketAmount;
	}
	
	@Override
	public int ticketTime(int ticket_idx) {
		int ticket_time = sqlSession.selectOne("selectTicketTimeSQL", ticket_idx);
		return ticket_time;
	}
	@Override
	public int reservationComplete(int seat_idx) {
		int reservationComplete = sqlSession.update("updateSeatToReservedSQL", seat_idx);
		return reservationComplete;
	}
	@Override
	public int payCancel(String paymentId) {
		int payCancel = sqlSession.delete("payDeleteSQL", paymentId);
		return payCancel;
	}
	@Override
	public int seatStatusUpdate() {
		int seatStatusUpdate = sqlSession.update("updateSeatStatusSQL");
		return seatStatusUpdate;
	}
	@Override
	public List<StudycafeLayoutDTO> studycafeLayout(int studycafe_idx) {
		List<StudycafeLayoutDTO> layoutDTO = sqlSession.selectList("selectStudycafeLayoutSQL", studycafe_idx);
		return layoutDTO;
	}
}
