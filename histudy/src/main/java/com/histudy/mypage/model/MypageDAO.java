package com.histudy.mypage.model;

import java.util.List;
import java.util.Map;

public interface MypageDAO {
	public List<ScheduleDTO> getMonthSchedule(Map<String, Object> param);
	public int checkSchedule(Map<String, Object> param);
	public int insertSchedule(Map<String, Object> param);
	public int updateSchedule(Map<String, Object> param);
	public int deleteSchedule(Map<String, Object> param);
}
