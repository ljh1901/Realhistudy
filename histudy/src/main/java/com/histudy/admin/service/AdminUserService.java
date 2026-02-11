package com.histudy.admin.service;

import java.util.*;
import com.histudy.user.model.*;

public interface AdminUserService {
    List<UserDTO> getUserList();
    int getUserCount();
    int deleteUser(int user_idx);
}