<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="css/userSignIn.css">
<script src="${pageContext.request.contextPath}/js/user/user.js"></script>
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
		<h2 class="login-title" style="margin-bottom: 30px;">Hi, Study</h2>
		<form name="login">
			<div class="input-group">
				<input type="text" name="user_id" class="icon-id" id="login_id" placeholder="아이디">
			</div>
			<div class="input-group">
				<input type="password" name="user_pwd" id="login_pw" class="icon-pw" placeholder="비밀번호">
			</div>

			<div class="login-options">
				<input type="checkbox" id="rememberId" name="rememberId"> 
				<label for="rememberId">아이디 기억하기</label>
			</div>
			<button type="button" class="login-submit-btn" onclick="loginCheck()">로그인</button>
			<div class="login-footer-links" style="display: flex; justify-content: space-between; margin-top: 20px; font-size: 13px;">
				<div class="login-footer-links">
					<a href="#">비밀번호 찾기</a> <a href="userSignUp.do">회원가입</a> 
					<a href="#">아이디 찾기</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
