package com.histudy.mypage.service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.histudy.mypage.model.MypageDAO;
import com.histudy.mypage.model.ScheduleDTO;

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
				resultMap.put(dateKey, dto.getS_content());
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
}
