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
<link rel="stylesheet" href="css/root.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/user/userSignUp.css">

<style>
/* JSP 내부에 추가로 정의된 스타일 */
.signup-form {
	width: 300px;
	margin: 50px auto;
}

.signup-form button {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
}
</style>
</head>

<body class="signupBody">
	<div class="signup-container">
		<h2>회원 가입</h2>
		<br>
		<form name="signUpForm" action="userSignUp.do" method="post"
			id="signupForm" onsubmit="return validateSignUp()">
			<div class="input-group">
				<input type="text" name="user_id" id="user_id" class="icon-id"
					placeholder="아이디" required>
				<button type="button" class="check-btn" onclick="checkId()">중복확인</button>
			</div>

			<div class="input-group">
				<input type="password" name="user_pw" id="user_pw" class="icon-pw"
					placeholder="비밀번호 (7자리 이상)" required>
			</div>

			<div class="input-group" style="position: relative;">
				<img src="/histudy/user-img/pw2-icon.png" id="pw_icon"
					class="pw-icon-style"> <input type="password"
					id="user_pw_confirm" class="icon-pw2" placeholder="비밀번호 확인"
					required style="background-image: none !important;">
			</div>
			<span id="pw_msg"
				style="font-size: 12px; margin-left: 10px; display: block; margin-bottom: 10px;"></span>

			<div class="input-group">
				<input type="text" name="user_name" class="icon-name"
					placeholder="성명" required>
			</div>

			<div class="input-group">
				<input type="tel" name="user_tel" class="icon-tel"
					placeholder="전화번호" required>
			</div>

			<div class="input-group">
				<input type="email" name="user_email" id="user_email"
					class="icon-email" placeholder="이메일 주소" required>
				<button type="button" class="check-btn" onclick="emailCheck()">중복확인</button>
			</div>

			<div class="birth-group">
				<select name="birth_year" id="birth_year" class="birth-select">
					<option value="">연도</option>
					<c:forEach var="year" items="${yearList}">
						<option value="${year}">${year}</option>
					</c:forEach>
				</select> <select name="birth_month" id="birth_month" class="birth-select">
					<option value="">월</option>
					<c:forEach var="month" items="${monthList}">
						<option value="${month}">${month}</option>
					</c:forEach>
				</select> <select name="birth_day" id="birth_day" class="birth-select">
					<option value="">일</option>
					<c:forEach var="day" items="${dayList}">
						<option value="${day}">${day}</option>
					</c:forEach>
				</select>
			</div>

			<input type="hidden" name="user_birthdate" id="user_birthdate">
			<button type="submit" class="signup-btn">가입하기</button>
		</form>
	</div>
	<script src="js/user/user.js"></script>
</body>
</html>
