package com.histudy.mypage.service;

import java.util.List;
import java.util.Map;

import com.histudy.mypage.model.WishListDTO;

public interface MypageService {
	public Map<String,String> getMonthSchedule(Integer user_idx,String year,String month);
	public int saveSchedule(Map<String, Object> param);
	public int deleteSchedule(Map<String, Object> param);
	public List<Map<String,Object>> selectMonthly(int user_idx);
	public int insertWish(WishListDTO dto);
	public int deleteWish(WishListDTO dto);

}
