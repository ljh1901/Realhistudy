<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" href="css/lectureDesign/lectureContent.css" type="text/css">
</head>
<body>
<%@ include file="../header.jsp"%>
<main>
<div class="mypage-wrapper">
	<div class="mypage-container">
		<aside class="mypage-sidebar">
			<nav class="sidebar-nav">
				<ul>
					<li><a href="myPage.do"><img src="mypage-img/user.png" width="30">프로필</a>
					<li><a href="myDashboard.do"><img src="mypage-img/report.png" width="30">대시보드</a>
					<li><a href="mySchedule.do"><img src="mypage-img/calendar.png" width="30">일정관리</a>
					<li><a href="myPurchase.do"><img src="mypage-img/shopping-cart.png" width="30">구매 / 혜택</a>
					<li><a href="myHeart.do"><img src="mypage-img/heart.png" width="30">찜 목록</a>
					<li><a href="myAlarm.do"><img src="mypage-img/bell.png" width="30">알림 설정</a>
					</li>
				</ul>
			</nav>
		</aside>
		<c:choose>
			<c:when test="${sessionScope.membership=='primeum' }">
				<section>
				<div>프리미엄 회원 잔여일</div>
				</section>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</main>
<%@ include file="../footer.jsp"%>
</body>
</html>