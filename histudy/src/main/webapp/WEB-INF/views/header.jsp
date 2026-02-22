<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css">
<header class="header">
	<div class="header__left">
		<img src="/histudy/main-img/logo1.png" class="header__logo">
		<h1 class="mainTitle">
			<a href="index.do">Hi, Study</a>
		</h1>
	</div>
	<nav class="header__nav">
		<ul class="header__nav__menu">
			<li class="header__nav__menu__item"><a href="index.do">Home</a></li>
			<li class="header__nav__menu__item"><a href="studyList.do">Study</a></li>
			<li class="header__nav__menu__item"><a href="mentorList.do">Mentoring</a></li>
			<li class="header__nav__menu__item"><a href="studycafeList.do">Study Cafe</a></li>
			<li class="header__nav__menu__item"><a href="lms.do">LMS</a></li>
			<li class="header__nav__menu__item"><a href="lecture.do">Lecture</a></li>
		</ul>
	</nav>
	<div class="header__right">
    <c:if test="${empty sessionScope.user_id}">
        <input type="button" value="Login" class="header__login" onclick="openSignInModal()">
    </c:if>

    <c:if test="${not empty sessionScope.user_id}">
        <div class="user-dropdown">

            <div class="user-greeting">
                ${sessionScope.user_name}님
            </div>

            <button type="button" class="header__login"
                onclick="toggleUserMenu(event)">
                My Page <span style="font-size: 10px; margin-left: 5px;"></span>
            </button>

            <ul class="user-menu" id="userMenu">
                <li><a href="${pageContext.request.contextPath}/myPage.do">프로필 관리</a></li>
				<li><a href="javascript:void(0);" onclick="openNotiModal();">알림함</a></li>              
                <li class="logout-item">
                    <a href="javascript:void(0);"
                       onclick="if(confirm('로그아웃 하시겠습니까?')) location.href='${pageContext.request.contextPath}/userLogout.do'"
                       class="logout-link">
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </c:if>
</div>
</header>
<script>
function openNotiModal() {
    fetch("notification.do")
        .then(function(response) {
            if (!response.ok) throw new Error("알림함 서버 응답 오류");
            return response.text();
        })
        .then(function(html) {
        	var parser = new DOMParser();
            var doc = parser.parseFromString(html, 'text/html');            
			var fragment = doc.querySelector('main'); 
            var modalContent = document.getElementById('modalContent');
            var overlay = document.getElementById('modalOverlay');
            if (modalContent && overlay) {
            	modalContent.innerHTML = fragment ? fragment.innerHTML : html;                overlay.style.display = 'flex';
                var closeBtn = document.createElement('div');
                closeBtn.className = 'close-btn';
                closeBtn.innerHTML = '&times;';
                closeBtn.onclick = function() { overlay.style.display = 'none'; };
                Object.assign(modalContent.style, {
                    width: '900px'
                });
                Object.assign(closeBtn.style, {
                    position: 'absolute', right: '25px', top: '20px',
                    cursor: 'pointer', fontSize: '20px'
                });
                modalContent.appendChild(closeBtn);
            }
        })
        .catch(function(error) { 
            console.error(error); 
            alert('알림함을 불러오는 데 실패했습니다.');
        });
}
</script>