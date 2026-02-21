package com.histudy.mypage.service;

import java.util.Map;

public interface MypageService {
	public Map<String,String> getMonthSchedule(Integer user_idx,String year,String month);
	public int saveSchedule(Map<String, Object> param);
	public int deleteSchedule(Map<String, Object> param);
}
