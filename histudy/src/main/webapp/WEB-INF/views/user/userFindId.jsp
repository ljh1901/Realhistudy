<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="${pageContext.request.contextPath}/js/user/user.js"></script>
</head>
<body>
	<div id="signInFragment">
		<h2 class="login-title">아이디 찾기</h2>
		<p
			style="text-align: center; font-size: 0.9em; color: #666; margin-bottom: 20px;">
			가입 시 등록한 이름과 전화번호를 입력해주세요.</p>

		<form id="findIdForm">
			<div class="input-group">
				<input type="text" id="find_name" class="icon-name" placeholder="성명"
					required>
			</div>
			<div class="input-group">
				<input type="tel" id="find_tel" class="icon-tel" placeholder="전화번호"
					required>
			</div>

			<button type="button" class="login-btn" onclick="findUserId()">아이디
				찾기</button>

			<div class="login-options"
				style="justify-content: center; margin-top: 15px;">
				<a href="userSignIn.do"
					style="text-decoration: none; color: #007bff;">로그인으로 돌아가기</a>
			</div>
		</form>
	</div>
</body>
</html>