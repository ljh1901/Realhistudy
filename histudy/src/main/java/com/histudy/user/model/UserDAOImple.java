package com.histudy.user.model;

import org.mybatis.spring.SqlSessionTemplate;

public class UserDAOImple implements UserDAO {

	private SqlSessionTemplate sqlSession;

	// 생성자 주입
	public UserDAOImple(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int userSignUp(UserDTO dto) {
		return sqlSession.insert("userSignUpSQL", dto);
	}

	@Override
	public String userSignIn(String user_id) {
		return sqlSession.selectOne("userSignInSQL", user_id);
	}

	@Override
	public int userCheckId(String user_id) {
		return sqlSession.selectOne("userCheckIdSQL", user_id);
	}

	@Override
	public int userCheckEmail(String user_email) {
		return sqlSession.selectOne("userCheckEmailSQL", user_email);
	}

//마이페이지 관련
	@Override
	public UserDTO userInfo(String user_id) {

		return sqlSession.selectOne("mypage.userInfoSQL", user_id);
	}

	@Override
	public int updateProfile(UserDTO dto) {
		// 1. mypage 테이블 (자기소개, 사진) 수정
		return sqlSession.update("mypage.updateProfileSQL", dto);
	}

	// [추가] usertb 테이블 (이름, 이메일, 전화번호) 수정 메서드
	public int updateUserTb(UserDTO dto) {
		return sqlSession.update("mypage.updateUserTbSQL", dto);
	}

	@Override
	public String userFindId(UserDTO dto) {
		return sqlSession.selectOne("com.histudy.user.userFindIdSQL", dto);
	}

	@Override
	public int userCheckPw(UserDTO dto) {
		return sqlSession.selectOne("com.histudy.user.userCheckPwSQL", dto);
	}

	@Override
	public int userUpdatePw(UserDTO dto) {
		return sqlSession.update("com.histudy.user.userUpdatePwSQL", dto);
	}
	@Override
	public void insertDefaultMypage(int user_idx) {
		sqlSession.insert("insertDefaultMypage",user_idx);
	}
	@Override
	public int userUpdateInfo(UserDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.update("userUpdateInfoSQL", dto);
	}
	@Override
	public int userUpdateMypage(UserDTO dto) {
		return sqlSession.update("userUpdateMypageSQL", dto);
	}
	@Override
	public int insertDefaultMypage(String user_id) {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertDefaultMypage",user_id);
	}
}