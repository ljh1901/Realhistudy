<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" href="css/mypageDesign/myHeart.css" type="text/css">
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
						<li><a href="myRefund.do"><img src="mypage-img/refund.png" width="30">정기권 환불</a>
						<li><a href="myHeart.do"><img src="mypage-img/heart.png" width="30">찜 목록</a>
						</li>
                </ul>
            </nav>
        </aside>
        <section class="mypage-content" style="flex:1;">
            <div class="heart-header">
                <div class="heart-tabs">
                    <button type="button" class="tab-btn active" onclick="showTab('purchase')">구매 내역</button>
                    <button type="button" class="tab-btn" onclick="showTab('sale')">혜택 내역</button>
                </div>
            </div>
        
            <div id="purchase-section" class="wish-section active">
                <c:choose>
                    <c:when test="${not empty list}">
                        <div class="wish-grid">
                            <c:forEach var="pay" items="${list}">
                                <div class="wish-card">
                                    <div class="wish-info">
                                        <span class="wish-tag">${pay.PAY_DATE}</span>
                                        <h3 class="wish-title">${pay.PAY_TYPE} 이용권 구매</h3>
                                        <div class="wish-meta">
                                            <span style="font-weight:bold; color:#0f172a; font-size:16px;">${pay.PAY_AMOUNT}원</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div style="margin-top:30px; text-align:center;">
                            ${pageStr}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-msg">
                            <img src="mypage-img/shopping-cart.png" width="50">
                            <p>구매 내역이 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div id="sale-section" class="wish-section">
	            <c:choose>
			       <c:when test="${sessionScope.hasCoupon == true}">
				        <div class="coupon-box">
				            🎫 프리미엄 회원 전용 50% 할인 쿠폰!!!
				            <button type="button">쿠폰 적용하기</button>
				        </div>
				    </c:when>
			        <c:otherwise>
	                	<div class="empty-msg">
	                    <img src="mypage-img/promo-code.png" width="50">
	                    <p>받은 혜택 내역이 없습니다.</p>
	                    <a href="membership.do" class="go-link">멤버십 가입하러 가기</a>
		                </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
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