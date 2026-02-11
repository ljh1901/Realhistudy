package com.histudy.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

import com.histudy.admin.model.AdminUserDAO;
import com.histudy.user.model.*;

@Service
public class AdminUserServiceImple implements AdminUserService {

    @Autowired
    private AdminUserDAO adminUserDao;

    public AdminUserServiceImple(AdminUserDAO adminUserDao) {
		super();
		this.adminUserDao = adminUserDao;
	}

	@Override
    public List<UserDTO> getUserList() {
        return adminUserDao.selectAllUserList();
    }

    @Override
    public int getUserCount() {
        return adminUserDao.getUserCount();
    }

    @Override
    public int deleteUser(int user_idx) {
        return adminUserDao.deleteUser(user_idx);
    }
}
