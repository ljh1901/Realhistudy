package com.histudy.mypage.service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.histudy.membership.model.MembershipPaymentDTO;
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
		List<StudyDTO> studyList = mypageDao.getMyStudyDates(user_idx);
		Map<String, String> resultMap = new HashMap<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (ScheduleDTO dto : list) {
			if (dto.getS_start_date() != null) {
				resultMap.put(sdf.format(dto.getS_start_date()), dto.getS_title());
			}
		}
		// 스터디 일정 합치기
		for (StudyDTO sdto : studyList) {
		    if (sdto != null && sdto.getStudy_start_date() != null) {
		        String startKey = sdto.getStudy_start_date(); 
		        if(startKey.length() > 10) startKey = startKey.substring(0, 10);
		        String sVal = resultMap.getOrDefault(startKey, "");
		        resultMap.put(startKey, sVal + (sVal.isEmpty() ? "" : " | ") + "[시작] " + sdto.getStudy_title()+"스터디");
		    }
		    if (sdto != null && sdto.getStudy_end_date() != null) {
		        String endKey = sdto.getStudy_end_date();
		        if(endKey.length() > 10) endKey = endKey.substring(0, 10);
		        String eVal = resultMap.getOrDefault(endKey, "");
		        resultMap.put(endKey, eVal + (eVal.isEmpty() ? "" : " | ") + "[종료] " + sdto.getStudy_title()+"스터디");
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
	@Override
	public int selectHalfPrice(Map<String,Object> map) {
		int user_idx = (Integer) map.get("user_idx");
		//(1)멤버십 날짜가 지나지 않았는지 체크
		//최근 멤버십 결제일 가져옴
		MembershipPaymentDTO membership=mypageDao.getLastMembership(user_idx);
		long now=System.currentTimeMillis();
		if (membership == null || membership.getEnd_date().getTime() < now) {
			return 0;
		}
		int usedCount = mypageDao.selectHalfPrice(map);
		return (usedCount == 0) ? 1 : 0;
	}
	@Override
	public MembershipPaymentDTO getLastMembership(int user_idx) {
		// TODO Auto-generated method stub
		return mypageDao.getLastMembership(user_idx);
	}
	
	@Override
	public List<StudyDTO> getMyStudyDates(int user_idx) {
		// TODO Auto-generated method stub
		return mypageDao.getMyStudyDates(user_idx);
	}
	@Override
	public Integer getMentorIdxByMentee(int user_idx) {
		return mypageDao.getMentorIdxByMentee(user_idx);
	}
}
