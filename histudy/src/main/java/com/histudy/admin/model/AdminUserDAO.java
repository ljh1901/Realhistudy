package com.histudy.admin.model;

import java.util.*;
import com.histudy.user.model.*;

public interface AdminUserDAO {
    List<UserDTO> selectAllUserList();
    int getUserCount();
    int deleteUser(int user_idx);
}
