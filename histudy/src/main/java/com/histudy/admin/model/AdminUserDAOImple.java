package com.histudy.admin.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.histudy.user.model.*;

public class AdminUserDAOImple implements AdminUserDAO {

    @Autowired
    private SqlSessionTemplate session;
   
    public AdminUserDAOImple(SqlSessionTemplate session) {
		super();
		this.session = session;
	}

	@Override
    public List<UserDTO> selectAllUserList() {
        return session.selectList("selectAllUserList");
    }

    @Override
    public int getUserCount() {
        return session.selectOne("getUserCount");
    }

    @Override
    public int deleteUser(int user_idx) {
        return session.delete("deleteUser", user_idx);
    }
}
