package com.histudy.user.model;

import java.util.List;
import java.util.Map;

import com.histudy.study.model.StudyDTO;

public interface UserDAO {

	public int userSignUp(UserDTO dto);
	public String userSignIn(String user_id);
	public int userCheckId(String user_id);
	public UserDTO userInfo(String user_id);
	public int userCheckEmail(String user_email);
	public int updateProfile(UserDTO dto);
	public String userFindId(UserDTO dto);
	public int userCheckPw(UserDTO dto); //정보 확인용
	public int userUpdatePw(UserDTO dto); //비밀번호 수정
	public void insertDefaultMypage(int user_idx);
	public int userUpdateInfo(UserDTO dto);
	public int userUpdateMypage(UserDTO dto);
	public int insertDefaultMypage(String user_id );
}
