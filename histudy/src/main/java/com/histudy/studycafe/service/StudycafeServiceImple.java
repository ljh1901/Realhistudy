package com.histudy.studycafe.service;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.management.RuntimeErrorException;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.histudy.studycafe.model.PayDTO;
import com.histudy.studycafe.model.SeatDTO;
import com.histudy.studycafe.model.StudycafeDAO;
import com.histudy.studycafe.model.StudycafeDTO;
import com.histudy.studycafe.model.StudycafeJoinReservationDTO;
import com.histudy.studycafe.model.StudycafeLayoutDTO;
import com.histudy.studycafe.model.StudycafeReservationDTO;
import com.histudy.studycafe.model.TicketJoinTicketCategoryDTO;

public class StudycafeServiceImple implements StudycafeSerivce {

	private StudycafeDAO studycafeDAO;
	public StudycafeServiceImple(StudycafeDAO studycafeDAO) {
		super();
		this.studycafeDAO = studycafeDAO;
	}
	
	@Override
	public List<StudycafeDTO> studycafeList(int currentPage, String region, int listSize) {
		System.out.println(region);
		Map<String,Object> map = new HashMap<String,Object>();
		int start = (currentPage-1)*listSize+1;
		int end = currentPage*listSize;
		map.put("start", start);
		map.put("end", end);
		map.put("region", region);
		List<StudycafeDTO> studycafeList = studycafeDAO.studycafeList(map);
		return studycafeList;
	}
	@Override
	public int studycafeListCount(String region) {
		int result = studycafeDAO.studycafeListCount(region);
		return result;
	}
	@Override
	public StudycafeDTO studycafe(int studycafe_idx) {
		StudycafeDTO studycafeOne = studycafeDAO.studycafe(studycafe_idx);
	return studycafeOne;
	}
	@Override
	public StudycafeJoinReservationDTO seatReservation(int seat_idx) {
		StudycafeJoinReservationDTO seatInfo = studycafeDAO.seatReservation(seat_idx);
		return seatInfo;
	}

	@Override
	public List<TicketJoinTicketCategoryDTO> ticketInfo(int ticket_category_idx, int studycafe_idx) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("ticket_category_idx", ticket_category_idx);
		map.put("studycafe_idx", studycafe_idx);
		List<TicketJoinTicketCategoryDTO> ticketInfo = studycafeDAO.ticketInfo(map);
		return ticketInfo;
	}

	@Override
	public List<SeatDTO> seatInfo(int studycafe_idx) {
		List<SeatDTO> seatDTO = studycafeDAO.seatInfo(studycafe_idx);
		return seatDTO;
	}
	@Override
	public int orderPay(PayDTO payOrder) {
		int result = studycafeDAO.orderPay(payOrder);
		return result;
	}
	
	@Override
	public int paySeat(PayDTO paydto) {
		int result = studycafeDAO.paySeat(paydto);
		return result;
	}
	@Override
	public PayDTO processPaymentAndReservation(String paymentId, Integer viewTotalAmount, Integer user_idx) throws Exception {
	    // 1. PortOne 결제 확인
	    JsonNode root = StudycafePortOneApiService.getPaymentInfo(paymentId);
	    
	    ObjectMapper mapper = new ObjectMapper();
	  if(root.get("paidAt") !=null) {
		    Integer totalAmount = root.get("amount").get("total").asInt();
		    if(viewTotalAmount != null && !viewTotalAmount.equals(totalAmount)) {
		        throw new RuntimeException("금액 검증 실패");
		    }
	  
	    JsonNode customData = mapper.readTree(root.get("customData").asText());
	    int seat_idx = customData.get("seat_idx").asInt();
	    int ticket_idx = customData.get("ticket_idx").asInt();
	    int ticket_category_idx = customData.get("ticket_category_idx").asInt();
	    
	    // 2. 시간 값 변환
	    // 2-1. YYYY-MM-DDTHH24:MI:SS.FFZ
	    System.out.println("YYYY-MM-DDTHH24:MI:SS.FFZ: "+ root.get("paidAt").asText());
	    // 2-2. YYYY-MM-DDTHH24:MI:SS.FFZ
	    OffsetDateTime offSetPaidAt = OffsetDateTime.parse(root.get("paidAt").asText());
	    System.out.println("OffsetDateTime: " + offSetPaidAt);
	    // 2-3. YYYY-MM-DDTHH24:MI:SS 변환
	    LocalDateTime localDatePaidAt = offSetPaidAt.plusHours(9).toLocalDateTime();
	    System.out.println("localDateTime: "+ localDatePaidAt);
	    // 2-4. YYYY-MM-DD HH24:MI:SS 변환
	    Timestamp paidAt = Timestamp.valueOf(localDatePaidAt);
	    System.out.println(paidAt);
	    
	    OffsetDateTime offSetStatusChangedAt = OffsetDateTime.parse(root.get("statusChangedAt").asText());
	    LocalDateTime localDateStatusChangedAt = offSetStatusChangedAt.plusHours(9).toLocalDateTime();
	    Timestamp statusChangedAt = Timestamp.valueOf(localDateStatusChangedAt);

	    
	    PayDTO paydto = new PayDTO(
	        paymentId,
	        root.get("storeId").asText(),
	        "channel-key-da563d5f-f117-444f-aba5-ad9b66277c1b",
	        root.get("orderName").asText(),
	        root.get("amount").get("paid").asInt(),
	        user_idx,
	        root.get("method").get("provider").asText(),
	        root.get("status").asText(),
	        statusChangedAt,
	        paidAt,
	        totalAmount,
	        root.get("amount").get("vat").asInt(),
	        root.get("amount").get("supply").asInt(),
	        root.get("channel").get("pgProvider").asText()
	    );

	    // 3. 결제 DB 저장
	    int result = studycafeDAO.paySeat(paydto);
	    int registerReservation = 0;
	    if(result>0 && ticket_category_idx !=3) {
	    	Timestamp reservation_endtime = Timestamp.valueOf(localDatePaidAt.plusHours(studycafeDAO.ticketTime(ticket_idx)));
	    	StudycafeReservationDTO srdto = new StudycafeReservationDTO(0, user_idx, seat_idx, paidAt, reservation_endtime, "RESERVED", ticket_idx, paymentId);
	    	registerReservation = studycafeDAO.registerReservation(srdto);
	    }else if(result >0 && ticket_category_idx ==3) {
	    	Timestamp reservation_endtime = Timestamp.valueOf(localDatePaidAt.plusDays(studycafeDAO.ticketTime(ticket_idx)));
	    	StudycafeReservationDTO srdto = new StudycafeReservationDTO(0, user_idx, seat_idx, paidAt, reservation_endtime, "RESERVED", ticket_idx, paymentId);
	    	registerReservation = studycafeDAO.registerReservation(srdto);
	    }
	    	if(registerReservation >0) {
	    		// 좌석 상태 변경
	    		int reservationComplete=studycafeDAO.reservationComplete(seat_idx);
	    		System.out.println(reservationComplete >0);
	    		if(reservationComplete>0) {
	    			// 영수증 조회
	    			return studycafeDAO.receipt(paymentId);
	    		}else {
	    			throw new RuntimeException("좌석 예약 실패");
	    		}
	    	}
	    	else {
	    		throw new RuntimeException("예약 오류");
	    	}
	
	}else {
		int payCancel = studycafeDAO.payCancel(paymentId);
		throw new Exception("결제 취소");
	}
	}
	
	@Override
	public int ticketTotalAmount(int ticket_idx) {
		int ticketAmount = studycafeDAO.ticketTotalAmount(ticket_idx);
		return ticketAmount;
	}
	@Override
	public int seatStatusUpdate() {
		int seatStatusUpdate = studycafeDAO.seatStatusUpdate();
		return seatStatusUpdate;
	}
	@Override
	public List<StudycafeLayoutDTO> studycafeLayout(int studycafe_idx) {
		List<StudycafeLayoutDTO> layoutDTO = studycafeDAO.studycafeLayout(studycafe_idx);
		return layoutDTO;
	}
	@Override
	public int paySale(int user_idx) {
		int result = studycafeDAO.paySale(user_idx);
		return result;
	}
}
