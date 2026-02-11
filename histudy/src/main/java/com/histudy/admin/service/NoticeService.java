package com.histudy.admin.service;

import java.util.List;

import com.histudy.admin.model.NoticeCategoryDTO;
import com.histudy.admin.model.NoticeDTO;

public interface NoticeService {
	List<NoticeCategoryDTO> getNoticeCategoryList();
	List<NoticeDTO> getNoticeList(Integer noticeCategory_idx);
	NoticeDTO getNoticeDetail(int notice_idx);
	int insertNotice(NoticeDTO dto);
	int updateNotice(NoticeDTO dto);
	int deleteNoitce(int notice_idx);
	
}
