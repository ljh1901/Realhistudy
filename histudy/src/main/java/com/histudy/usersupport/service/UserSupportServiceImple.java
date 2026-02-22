package com.histudy.usersupport.service;

import java.util.*;

import com.histudy.admin.model.FaqDTO;
import com.histudy.admin.model.NoticeDTO;
import com.histudy.usersupport.model.UserSupportDAO;

public class UserSupportServiceImple implements UserSupportService {

    private UserSupportDAO supportDAO;
     
    public UserSupportServiceImple(UserSupportDAO supportDAO) {
		super();
		this.supportDAO = supportDAO;
	}

	@Override
    public List<Map<String, Object>> getFaqCategoryList() {
        return supportDAO.getFaqCategoryList();
    }

    @Override
    public List<FaqDTO> getFaqList(Map<String, Object> map) {
        return supportDAO.getFaqList(map);
    }

    @Override
    public List<Map<String, Object>> getNoticeCategoryList() {
        return supportDAO.getNoticeCategoryList();
    }

    @Override
    public List<NoticeDTO> selectNoticeList(Map<String, Object> map) {
        return supportDAO.selectNoticeList(map);
    }

    @Override
    public NoticeDTO getNoticeOne(int notice_idx) {
        return supportDAO.getNoticeOne(notice_idx);
    }
}
