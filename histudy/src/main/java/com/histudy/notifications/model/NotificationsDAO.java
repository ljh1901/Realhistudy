package com.histudy.notifications.model;

import java.util.List;

public interface NotificationsDAO {

	public int sendNotice(NotificationsDTO dto); // 스터디 리더가 멤버에게 보내는 알림
	public List<NotificationsDTO> selectNotice(int user_idx);
	public int updateNotice();
	public int deleteNotice();
	
}
