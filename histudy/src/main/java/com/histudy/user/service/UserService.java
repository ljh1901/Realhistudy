package com.histudy.user.service;
import com.histudy.mypage.model.WishListDTO;
import com.histudy.user.model.UserDTO;

public interface UserService {
    public int userSignIn(String user_id, String user_pwd);
    public int userSignUp(UserDTO dto);
	public int userCheckId(String user_id);
	public UserDTO userInfo(String user_id);
	public int userCheckEmail(String user_email);
	public int updateProfile(UserDTO dto);
	public String userFindId(String user_name,String user_tel);
	public String userFindPw(String user_id,String user_name,String user_tel);
	public int insertDefaultMypage(String user_id);
}