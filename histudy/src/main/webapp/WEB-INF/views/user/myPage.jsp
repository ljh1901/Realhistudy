<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - Hi, Study</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/root.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/user/loginModal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
</head>
<body>
	<%@ include file="../header.jsp"%>
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

			<main class="mypage-main">
				<h2 class="content-title">내 프로필</h2>

				<form action="${pageContext.request.contextPath}/updateProfile.do"
					method="post" enctype="multipart/form-data">
					<input type="hidden" id="user_idx" value="${user.user_idx}">
					<div class="profile-card">
						<div class="profile-image-section">
							<div class="image-container">
								<img
									src="mypage-img/${user.profile_img}"
									id="profilePreview">
							</div>

							<input type="file" name="uploadFile" id="fileInput"
								style="display: none;" accept="image/*"
								onchange="readURL(this);">
							<button type="button" class="btn-img-change edit-mode" style="display: none;"
  							    onclick="document.getElementById('fileInput').click();">변경</button>
							<p class="img-guide">
								png, jpg, jpeg의 확장자<br>1MB 이하의 이미지
							</p>
						</div>

						<div class="profile-info-section">
							<table class="profile-table">
							<c:if test="${sessionScope.membership == 'premium'}">
							    <tr>
							        <th style="color: gold;">프리미엄 멤버</th>
							        <td>
							            <c:forEach var="pay" items="${list}">
							                <c:if test="${pay.PAY_TYPE == '멤버십'}">
							                    ${pay.PAY_DATE}&nbsp;~&nbsp;${pay.END_DATE}
							                </c:if>
							            </c:forEach>
							        </td>
							    </tr>
							</c:if>
								<tr>
									<th>이름</th>
									<td><span class="view-mode">${user.user_name}</span> <input
										type="text" id="name-input" class="edit-mode"
										value="${user.user_name}" style="display: none;"></td>
								</tr>
								<tr>
									<th>생년월일</th>
									<td><span class="view-mode">${user.user_age}세</span> <input
										type="date" id="birthdate-input" class="edit-mode"
										value="${user.user_birthdate}" style="display: none;"></td>
								</tr>
								<tr>
									<th>이메일</th>
									<td><span class="view-mode">${user.user_email}</span> <input
										type="email" id="email-input" class="edit-mode"
										value="${user.user_email}" style="display: none;"></td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td><span class="view-mode">${user.user_tel}</span> <input
										type="text" id="tel-input" class="edit-mode"
										value="${user.user_tel}" style="display: none;"></td>
								</tr>
								<tr>
									<th>자기소개</th>
									<td>
										<div id="intro-text" class="view-mode user-info-display"
											style="padding: 10px; line-height: 1.5;">
											${user.user_intro}</div> <textarea id="intro-input"
											class="edit-mode user-intro-edit" rows="5"
											style="display: none; width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: none;">${user.user_intro}</textarea>
									</td>
								</tr>
							</table>
							<div style="text-align: right; margin-top: 20px;">
								<div id="view-buttons">
									<button type="button" onclick="toggleEditMode(true)"
										style="background-color: #4A90E2; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold;">
										수정하기</button>
								</div>

								<div id="edit-buttons" style="display: none;">
									<button type="button" onclick="submitProfileUpdate()"
										style="background-color: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; margin-right: 5px;">
										저장</button>
									<button type="button" onclick="toggleEditMode(false)"
										style="background-color: #6c757d; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold;">
										취소</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</main>
		</div>
	</div>
	<script>
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('profilePreview').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
	<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
	<script src="${pageContext.request.contextPath}/js/user/user.js"></script>
	<%@ include file="../footer.jsp"%>
</body>
</html>