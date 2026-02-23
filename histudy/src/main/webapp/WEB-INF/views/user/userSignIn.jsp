<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- SEO -->
<title>Hi, Study</title>
<meta name="description" content="스터디&멘토링" />
<meta name="author" content="파이널 프로젝트" />
<link rel="shortcut icon" href="/histudy/main-img/logo1.png" type="image/x-icon" />

<!-- OG (Open Graph Data)-->
<meta property="og:title" content="Hi, Study" />
<meta property="og:type" content="website" />
<meta property="og:url" content="배포후 생성된 URL" />
<meta property="og:image" content="배포후에 생성된 이미지 URL" />

<!-- GoogleFont -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<!-- CSS -->
<link rel="stylesheet" href="css/userSignIn.css">
<script>
window.onload=function(){
	if(${!empty cookie.id}){
	document.login.user_id.value = '${cookie.id}';
    document.login.rememberId.checked = true;
	}
}
</script>
</head>
<body>
	<div id="signInFragment">
		<h2 class="login-title"
			style="text-align: center; margin-bottom: 25px;">Hi, Study</h2>

		<div id="login-section">
			<form name="login">
				<div class="input-group">
					<input type="text" name="user_id" class="icon-id" id="login_id"
						placeholder="아이디">
				</div>
				<div class="input-group">
					<input type="password" name="user_pwd" id="login_pw"
						class="icon-pw" placeholder="비밀번호">
				</div>

				<div class="login-options" style="margin: 10px 0;">
					<input type="checkbox" id="rememberId" name="rememberId"> <label
						for="rememberId">아이디 기억하기</label>
				</div>

				<button type="button" class="login-submit-btn"
					onclick="loginCheck()">로그인</button>
			</form>

			<div class="login-footer-links"
				style="display: flex; justify-content: center; gap: 15px; margin-top: 20px; font-size: 13px;">
				<span onclick="showSection('find-id')" style="cursor: pointer;">아이디 찾기</span>
				<span style="color: #ccc">|</span>
				<span onclick="showSection('find-pw')" style="cursor: pointer;">비밀번호 찾기</span>
				<span style="color: #ccc">|</span>
				<a href="userSignUp.do" style="text-decoration: none; color: inherit;">회원가입</a>
			</div>
		</div>

		<div id="find-id-section" style="display: none;">
			<div class="find-form">
				<h3 style="text-align: center; margin-bottom: 20px;">아이디 찾기</h3>
				<div class="input-group">
					<input type="text" id="find_name" class="icon-name"
						placeholder="이름 입력">
				</div>
				<div class="input-group">
					<input type="text" id="find_tel" class="icon-tel"
						placeholder="전화번호 입력">
				</div>
				<button type="button" onclick="findUserId()"
					class="login-submit-btn">아이디 찾기</button>
				<p onclick="showSection('login')"
					style="text-align: center; margin-top: 15px; font-size: 12px; cursor: pointer; color: #888;">로그인으로
					돌아가기</p>
			</div>
		</div>

		<div id="find-pw-section" style="display: none;">
			<div class="find-form">
				<h3 style="text-align: center; margin-bottom: 20px;">비밀번호 찾기</h3>
				<div class="input-group">
					<input type="text" id="find_pw_id" class="icon-id"
						placeholder="아이디 입력">
				</div>
				<div class="input-group">
					<input type="text" id="find_pw_name" class="icon-name"
						placeholder="이름 입력">
				</div>
				<div class="input-group">
					<input type="text" id="find_pw_tel" class="icon-tel"
						placeholder="전화번호 입력">
				</div>
				<button type="button" onclick="findUserPw()"
					class="login-submit-btn">임시 비번 발급</button>
				<p onclick="showSection('login')"
					style="text-align: center; margin-top: 15px; font-size: 12px; cursor: pointer; color: #888;">로그인으로
					돌아가기</p>
			</div>
			<div id="find-id-result"
				style="margin-top: 15px; text-align: center; color: #4A90E2; font-weight: bold;"></div>

			<div id="find-pw-result"
				style="margin-top: 15px; text-align: center; color: #4A90E2; font-weight: bold;"></div>
		</div>
	</div>
</body>
</html>
