<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/root.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/loginModal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>
	<%@ include file="../header.jsp"%>

	<div class="mypage-wrapper">
		<div class="mypage-container">
			<aside class="mypage-sidebar">
				<nav class="sidebar-nav">
					<ul>
						<li><a href="myPage.do"><img
								src="mypage-img/profile-icon.png"> 프로필</a></li>
						<li><a href="#"><img src="mypage-img/dash-icon.png">
								대시보드</a></li>
						<li class="active"><a href="#"><img
								src="mypage-img/calendar-icon.png"> 일정관리</a></li>
						<li><a href="#"><img src="mypage-img/cart-icon.png">
								구매 / 혜택</a></li>
					</ul>
				</nav>
			</aside>

			<main class="mypage-main">
				<h2 class="content-title">일정 관리</h2>
				<div class="calendar-container">
					<div id="calendar"></div>
				</div>
			</main>

		</div>
	</div>

	<%@ include file="../footer.jsp"%>
	<script src="${pageContext.request.contextPath}/js/user/user.js"></script>
</body>
</html>