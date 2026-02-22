package com.histudy.mypage.service;

import java.util.List;
import java.util.Map;

import com.histudy.mentoring.model.MentoProfileDTO;
import com.histudy.mypage.model.WishListDTO;
import com.histudy.study.model.StudyDTO;

public interface MypageService {
	public Map<String,String> getMonthSchedule(Integer user_idx,String year,String month);
	public int saveSchedule(Map<String, Object> param);
	public int deleteSchedule(Map<String, Object> param);
	public List<Map<String,Object>> selectMonthly(int user_idx);
	public int insertWish(WishListDTO dto);
	public int deleteWish(WishListDTO dto);
	public List<StudyDTO> selectWishStudyList(int user_idx);
	public List<Map<String, Object>> selectWishMentorList(int user_idx);

}
