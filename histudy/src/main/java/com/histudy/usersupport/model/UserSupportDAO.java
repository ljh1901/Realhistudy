package com.histudy.usersupport.model;

import java.util.List;
import java.util.Map;

import com.histudy.admin.model.FaqDTO;
import com.histudy.admin.model.NoticeDTO;

public interface UserSupportDAO {
    // FAQ 관련
    public List<Map<String, Object>> getFaqCategoryList();
    public List<FaqDTO> getFaqList(Map<String, Object> map);

    // 공지사항 관련
    public List<Map<String, Object>> getNoticeCategoryList();
    public List<NoticeDTO> selectNoticeList(Map<String, Object> map);
    public NoticeDTO getNoticeOne(int notice_idx);
}
