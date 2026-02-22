package com.histudy.usersupport.service;

import java.util.*;

import com.histudy.admin.model.FaqDTO;
import com.histudy.admin.model.NoticeDTO;

public interface UserSupportService {

	
	public List<Map<String, Object>> getFaqCategoryList();
	public List<FaqDTO> getFaqList(Map<String, Object> map);

	public List<Map<String, Object>> getNoticeCategoryList();
	public List<NoticeDTO> selectNoticeList(Map<String, Object> map);
	public NoticeDTO getNoticeOne(int notice_idx);
}
