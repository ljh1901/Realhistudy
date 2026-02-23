<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" href="css/mypageDesign/myHeart.css" type="text/css">
</head>
<body class="myHeartPage">
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
						</li>
				</ul>
			</nav>
		</aside>
		<section class="mypage-content" style="flex:1;">
	    <div class="heart-header">
	        <div class="heart-tabs">
	            <button type="button" class="tab-btn active" onclick="showTab('study')">스터디</button>
	            <button type="button" class="tab-btn" onclick="showTab('mentor')">멘토링</button>
	        </div>
	    </div>
		
		<div id="study-section" class="wish-section active">
	        <c:choose>
	            <c:when test="${not empty slist}">
	                <div class="wish-grid">
	                    <c:forEach var="s" items="${slist}">
	                        <div class="wish-card" onclick="location.href='studyContent.do?study_idx=${s.study_idx}'">
	                            <div class="wish-thumb">
	                                <img src="/histudy/study-img/${not empty s.study_upload_img ? s.study_upload_img : 'groupStudy.png'}">
	                            </div>
	                            <div class="wish-info">
	                                <span class="wish-tag">${s.sc_name}</span>
	                                <h3 class="wish-title">${s.study_title}</h3>
	                                <div class="wish-meta">
	                                <span>👤 ${not empty s.user_name ? s.user_name : '스터디원'}</span>
									</div>
	                            </div>
	                        </div>
	                    </c:forEach>
	                </div>
	            </c:when>
	            <c:otherwise>
	                <div class="empty-msg">
	                    <img src="mypage-img/heart.png" width="50">
	                    <p>찜한 스터디가 없습니다.</p>
	                    <a href="studyList.do" class="go-link">스터디 구경하러 가기</a>
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>
	
	    <div id="mentor-section" class="wish-section">
	        <c:choose>
	            <c:when test="${not empty mlist}">
	                <div class="wish-grid">
	                   <c:forEach var="m" items="${mlist}">
						    <div class="wish-card" onclick="location.href='mentorProfile.do?mentor_idx=${m.MENTOR_IDX}'">
						        <div class="wish-thumb mentor">
						            <c:choose>
						                <c:when test="${not empty m.PROFILE_IMG}">
						                    <img src="/histudy/mypage-img/pimg/${m.PROFILE_IMG}" style="width:100%; height:100%; object-fit:cover;">
						                </c:when>
						                <c:otherwise>
						                    <span style="font-size: 50px;">👤</span>
						                </c:otherwise>
						            </c:choose>
						        </div>
						        <div class="wish-info">
						            <h3 class="wish-title">${m.USER_NAME}</h3>
						            <p class="wish-desc">${m.MENTOR_INTRO}</p>
						        </div>
						    </div>
						</c:forEach>
	                </div>
	            </c:when>
	            <c:otherwise>
	                <div class="empty-msg">
	                    <img src="mypage-img/heart.png" width="50">
	                    <p>찜한 멘토가 없습니다.</p>
	                    <a href="mentorList.do" class="go-link">멘토 찾으러 가기</a>
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</div>
</div>
</main>
<%@ include file="../footer.jsp"%>
</body>
<script>
function showTab(type){
    const sections=document.querySelectorAll('.wish-section');
    const btns=document.querySelectorAll('.tab-btn');
    
    sections.forEach(s=>s.classList.remove('active'));
    btns.forEach(b=>b.classList.remove('active'));
    
    document.getElementById(type+'-section').classList.add('active');
    event.currentTarget.classList.add('active');
}
</script>
</html>