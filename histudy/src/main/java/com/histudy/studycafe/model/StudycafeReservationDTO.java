package com.histudy.studycafe.model;

import java.io.File;
import java.sql.Timestamp;

public class StudycafeReservationDTO {
	private int reservation_idx;
	private int user_idx;
	private int seat_idx;
	private Timestamp reservation_starttime;
	private Timestamp reservation_endtime;
	private String reservation_status;
	private int ticket_idx;
	private String paymentId;
	public StudycafeReservationDTO() {
		super();
	}
	
	
	public StudycafeReservationDTO(int reservation_idx, int user_idx, int seat_idx, Timestamp reservation_starttime,
			Timestamp reservation_endtime, String reservation_status, int ticket_idx, String paymentId) {
		super();
		this.reservation_idx = reservation_idx;
		this.user_idx = user_idx;
		this.seat_idx = seat_idx;
		this.reservation_starttime = reservation_starttime;
		this.reservation_endtime = reservation_endtime;
		this.reservation_status = reservation_status;
		this.ticket_idx = ticket_idx;
		this.paymentId = paymentId;
	}


	public int getReservation_idx() {
		return reservation_idx;
	}
	public void setReservation_idx(int reservation_idx) {
		this.reservation_idx = reservation_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getSeat_idx() {
		return seat_idx;
	}
	public void setSeat_idx(int seat_idx) {
		this.seat_idx = seat_idx;
	}
	public Timestamp getReservation_starttime() {
		return reservation_starttime;
	}
	public void setReservation_starttime(Timestamp reservation_starttime) {
		this.reservation_starttime = reservation_starttime;
	}
	public Timestamp getReservation_endtime() {
		return reservation_endtime;
	}
	public void setReservation_endtime(Timestamp reservation_endtime) {
		this.reservation_endtime = reservation_endtime;
	}
	public String getReservation_status() {
		return reservation_status;
	}
	public void setReservation_status(String reservation_status) {
		this.reservation_status = reservation_status;
	}
	public int getTicket_idx() {
		return ticket_idx;
	}
	public void setTicket_idx(int ticket_idx) {
		this.ticket_idx = ticket_idx;
	}
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	
	
}
