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
<link rel="stylesheet" href="css/mypageDesign/myDashboard.css" type="text/css">
</head>
<body id="myDashboardPage">
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
						<li><a href="myRefund.do"><img src="mypage-img/refund.png" width="30">정기권 환불</a>
						<li><a href="myHeart.do"><img src="mypage-img/heart.png" width="30">찜 목록</a>
						</li>
				</ul>
			</nav>
		</aside>
		<div class="dashboard-content">
		    <section class="membership-card">
		    
		        <div>👑 프리미엄 회원 잔여일</div>
		        <c:choose>
		            <c:when test="${sessionScope.membership=='premium'}">
		                <p>이용 가능 기간이 ${restDays}일 남았습니다.</p>
		            </c:when>
		            <c:otherwise>
		                <p>일반 회원입니다.</p>
		            </c:otherwise>
		        </c:choose>
		    </section>
		
		    <section class="note-summary-section">
		        <div class="section-header">
		            <h3>📝 최근 작성한 학습 노트</h3>
		        </div>
		        <div class="study-grid">
		            <c:choose>
		                <c:when test="${not empty note}">
		                    <div class="study-card" style="border-top: 5px solid #f1c40f;">
		                        <div style="font-size: 11px; color: #999; margin-bottom: 5px; font-weight: 600;">
		                            📚 ${note.lecture_name}
		                        </div>
		                        <h4 class="study-title">${not empty note.note_title ? note.note_title : '제목 없음'}</h4>
		                        <p style="font-size: 13px; color: #666; height: 36px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; margin-bottom: 15px;">
		                            ${note.note_content}
		                        </p>
		                        <div class="study-footer" style="display: flex; justify-content: flex-end;">
		                            <button type="button" class="btn-enter" onclick="location.href='lectureContent.do?lecture_idx=${note.lecture_idx}'" style="background: #f1c40f; color: white; border: none; padding: 5px 15px; border-radius: 5px; cursor: pointer;">입장</button>
		                        </div>
		                    </div>
		                </c:when>
		                <c:otherwise>
		                    <div class="empty-study" style="padding: 20px; text-align: center; color: #ccc;">작성된 노트가 없습니다.</div>
		                </c:otherwise>
		            </c:choose>
		        </div>
		    </section>
		
		    <section class="my-study-section">
		        <div class="section-header">
		            <h3>✍️ 참여중인 스터디</h3>
		        </div>
		        <div class="study-grid">
		            <c:forEach var="study" items="${study}">
		                <div class="study-card">
		                    <div class="study-badge">${study.sc_name}</div>
		                    <h4 class="study-title">${study.study_title}</h4>
		                    <div class="study-footer">
		                        <span class="d-day ${study.dday <= 3 ? 'urgent' : ''}">D-${study.dday}</span>
		                        <button type="button" onclick="location.href='studyContent.do?study_idx=${study.study_idx}'">입장</button>
		                    </div>
		                </div>
		            </c:forEach>
		            <c:if test="${empty study}">
		                <div class="empty-study">참여 중인 스터디가 없습니다.</div>
		            </c:if>
		        </div>
		    </section>
		
		    <section class="mentoring-section">
		        <div class="section-header">
		            <h3>⏲ 참여 중인 멘토링</h3>
		        </div>
		        <div class="study-grid">
		            <c:choose>
		                <c:when test="${not empty mentoring}">
		                    <div class="study-card">
		                        <div class="study-badge" style="background: rgba(168, 85, 247, 0.1); color: #7c3aed;">${mentoring.job_group}</div>
		                        <h4 class="study-title">${mentoring.mentoring_title}</h4>
		                        <div class="study-info">
		                            <img src="mypage-img/${not empty mentoring.mentor_profile_img ? mentoring.mentor_profile_img : 'user.png'}" width="22" height="22" style="border-radius: 50%;">
		                            <span style="margin-left: 8px;"><strong>${mentoring.mentor_name}</strong> 멘토</span>
		                        </div>
		                        <div class="study-footer" style="display: flex; justify-content: flex-end;">
		                            <button type="button" class="btn-enter" onclick="location.href='mentorProfile.do?mentor_idx=${mentoring.mentor_idx}'">입장</button>
		                        </div>
		                    </div>
		                </c:when>
		                <c:otherwise>
		                    <div class="empty-study">참여 중인 멘토링이 없습니다.</div>
		                </c:otherwise>
		            </c:choose>
		        </div>
		    </section>
		</div>
	</div>
</main>
<%@ include file="../footer.jsp"%>
</body>
</html>