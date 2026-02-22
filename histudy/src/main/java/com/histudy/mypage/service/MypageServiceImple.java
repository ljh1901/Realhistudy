package com.histudy.mypage.service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.histudy.mentoring.model.MentoProfileDTO;
import com.histudy.mypage.model.MypageDAO;
import com.histudy.mypage.model.ScheduleDTO;
import com.histudy.mypage.model.WishListDTO;
import com.histudy.study.model.StudyDTO;

public class MypageServiceImple implements MypageService {
	@Autowired
	private MypageDAO mypageDao;	
	@Override
	public Map<String, String> getMonthSchedule(Integer user_idx, String year, String month) {
		Map<String, Object> param = new HashMap<>();
		param.put("user_idx", user_idx);
		param.put("year", year);
		param.put("month", month);

		List<ScheduleDTO> list = mypageDao.getMonthSchedule(param);
		Map<String, String> resultMap = new HashMap<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (ScheduleDTO dto : list) {
			if (dto.getS_start_date() != null) {
				String dateKey = sdf.format(dto.getS_start_date());
				resultMap.put(dateKey, dto.getS_title());
			}
		}
		return resultMap;
	}

	@Override
	public int saveSchedule(Map<String, Object> param) {
		int count = mypageDao.checkSchedule(param);
		
		if (count > 0) {
			return mypageDao.updateSchedule(param);
		} else {
			return mypageDao.insertSchedule(param);
		}
	}
	@Override
	public int deleteSchedule(Map<String, Object> param) {
		return mypageDao.deleteSchedule(param);
	}
	@Override
	public List<Map<String, Object>> selectMonthly(int user_idx) {
		// TODO Auto-generated method stub
		return mypageDao.selectMonthly(user_idx);
	}
	@Override
	public int insertWish(WishListDTO dto) {
		// TODO Auto-generated method stub
		return mypageDao.insertWish(dto);
	}
	@Override
	public int deleteWish(WishListDTO dto) {
		// TODO Auto-generated method stub
		return mypageDao.deleteWish(dto);
	}
	@Override
	public List<Map<String, Object>> selectWishMentorList(int user_idx) {
		// TODO Auto-generated method stub
		return mypageDao.selectWishMentorList(user_idx);
	}
	@Override
	public List<StudyDTO> selectWishStudyList(int user_idx) {
		// TODO Auto-generated method stub
		return mypageDao.selectWishStudyList(user_idx);
	}
}
