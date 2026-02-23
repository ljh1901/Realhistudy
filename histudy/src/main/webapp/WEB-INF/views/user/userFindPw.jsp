<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/userSignIn.css">
<script src="${pageContext.request.contextPath}/js/user/user.js"></script>
</head>
<body>
    <div id="signInFragment">
        <h2 class="login-title">비밀번호 찾기</h2>
        <form id="findPwForm">
            <div class="input-group">
                <input type="text" id="find_pw_id" placeholder="아이디" required>
            </div>
            <div class="input-group">
                <input type="text" id="find_pw_name" placeholder="이름" required>
            </div>
            <div class="input-group">
                <input type="tel" id="find_pw_tel" placeholder="전화번호" required>
            </div>
            
            <button type="button" class="login-submit-btn" onclick="findUserPw()">임시 비밀번호 발급</button>
            <div style="text-align: center; margin-top: 15px;">
                <a href="userSignIn.do" style="font-size: 13px; color: #666;">로그인으로 돌아가기</a>
            </div>
        </form>
    </div>
</body>
</html>