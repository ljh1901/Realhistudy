package com.histudy.notifications.service;

import java.util.List;

import com.histudy.notifications.model.NotificationsDAOImple;
import com.histudy.notifications.model.NotificationsDTO;

public class NotificationsServiceImple implements NotificationsService {

	
	private NotificationsDAOImple ndao;
	
	public NotificationsServiceImple(NotificationsDAOImple ndao) {
		super();
		this.ndao = ndao;
	}

	@Override
	public int sendNotice(NotificationsDTO dto) {
		int result = ndao.sendNotice(dto);
		return result;
	}
	@Override
	public List<NotificationsDTO> selectNotice(int user_idx) {
		// TODO Auto-generated method stub
		return ndao.selectNotice(user_idx);
	}
	@Override
	public int deleteNotice() {
		// TODO Auto-generated method stub
		return ndao.deleteNotice();
	}
	@Override
	public int updateNotice() {
		// TODO Auto-generated method stub
		return ndao.updateNotice();
	}
}
