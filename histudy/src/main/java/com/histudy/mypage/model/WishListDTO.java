package com.histudy.mypage.model;

import java.sql.Date;

public class WishListDTO {
	public int wish_idx;
	public String w_target_type;
	public Date w_date;
	public int w_target_idx;
	public int user_idx;
	public int getWish_idx() {
		return wish_idx;
	}
	public WishListDTO() {
		// TODO Auto-generated constructor stub
	}
	public void setWish_idx(int wish_idx) {
		this.wish_idx = wish_idx;
	}
	public String getW_target_type() {
		return w_target_type;
	}
	public void setW_target_type(String w_target_type) {
		this.w_target_type = w_target_type;
	}
	public Date getW_date() {
		return w_date;
	}
	public void setW_date(Date w_date) {
		this.w_date = w_date;
	}
	public int getW_target_idx() {
		return w_target_idx;
	}
	public void setW_target_idx(int w_target_idx) {
		this.w_target_idx = w_target_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public WishListDTO(int wish_idx, String w_target_type, Date w_date, int w_target_idx, int user_idx) {
		super();
		this.wish_idx = wish_idx;
		this.w_target_type = w_target_type;
		this.w_date = w_date;
		this.w_target_idx = w_target_idx;
		this.user_idx = user_idx;
	}
	
	
}
