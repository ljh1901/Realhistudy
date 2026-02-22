<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<!-- 1.프리미엄회원 잔여일(비회원이면 안뜸) -->
		<section>
		<c:choose>
			<c:when test="${sessionScope.membership=='premium'}">
				<div>프리미엄 회원 잔여일</div>
				<p>이용 가능 기간이 ${restDays}일 남았습니다.</p>
			</c:when>
			<c:otherwise>
				일반 회원입니다.
			</c:otherwise>
		</c:choose>
		</section>
		<!-- 2.스카 이용률 그래프(한달, 이용안했으면 안뜸) -->
		<section>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<canvas id="usageChart" width="400" height="200"></canvas>
		<script>
		fetch('getMyMonthlyUsage.do')
		    .then(res=>res.json())
		    .then(data=>{
		        const labels=data.map(item=>item.date);
		        const usageData=data.map(item=>item.usage_count);
		        const ctx=document.getElementById('usageChart').getContext('2d');
		        new Chart(ctx,{
		            type:'line',
		            data:{
		                labels:labels,
		                datasets:[{
		                    label:'최근 30일 내 이용 건수',
		                    data:usageData,
		                    borderColor:'rgb(75, 192, 192)',
		                    tension:0.1
		                }]
		            }
		        });
		    });
		</script>
		</section>
	</div>
</div>
</main>
<%@ include file="../footer.jsp"%>
</body>
</html>