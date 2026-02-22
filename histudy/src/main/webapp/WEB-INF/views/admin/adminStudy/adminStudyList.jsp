<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디 모임 관리</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp"%>

</head>
<body>
	<div class="admin__study__container">
		<div class="admin__header">
			<h1>스터디 모임 관리</h1>
			<div class="admin__study__cat">
				<select id="cateFilter" class="admin__select"
					onchange="filterCategory(this.value)">
					<option value="0" ${param.sc_idx == '0' ? 'selected' : ''}>전체</option>
					<option value="1" ${param.sc_idx == '1' ? 'selected' : ''}>코딩</option>
					<option value="2" ${param.sc_idx == '2' ? 'selected' : ''}>언어</option>
					<option value="3" ${param.sc_idx == '3' ? 'selected' : ''}>학업</option>
					<option value="4" ${param.sc_idx == '4' ? 'selected' : ''}>자격증</option>
					<option value="5" ${param.sc_idx == '5' ? 'selected' : ''}>취업</option>
				</select>
			</div>
		</div>

		<div class="admin__study__list">
			<c:forEach var="s" items="${studyList}">
				<div class="admin__study__item">
					<div class="study__info__left">
						<div class="study__meta">
							<span class="study__cate">${s.sc_name}</span> <a
								href="adminStudyDetail.do?study_idx=${s.study_idx}"
								class="study__title__link"> <span class="study__title_text">${s.study_title}</span>
							</a>
						</div>
						<div class="study__details">
							<span><img src="/histudy/main-img/user.png" width="14">
								${s.user_name}</span> <span><img
								src="/histudy/main-img/personnel.png" width="14">
								${s.study_current_members} / ${s.study_max_members}명</span> <span><img
								src="/histudy/main-img/clock.png" width="14"> 기간:
								${s.study_start_date.substring(0,10)} ~
								${s.study_end_date.substring(0,10)}</span>
						</div>
					</div>

					<div class="admin__actions">
						<c:choose>
							<c:when test="${s.study_status == 2}">
								<span class="study__status study__status__closed">완료됨</span>
							</c:when>
							<c:when test="${s.study_status == 1}">
								<span class="study__status study__status__ongoing">진행중</span>
							</c:when>
							<c:otherwise>
								<span class="study__status study__status__recruiting">모집중</span>
							</c:otherwise>
						</c:choose>

						<button class="admin__btn__del_small"
							onclick="deleteStudy(${s.study_idx})">삭제</button>
					</div>
				</div>
			</c:forEach>

			<c:if test="${empty studyList}">
				<div style="text-align: center; padding: 100px 0; color: #94a3b8;">
					<p style="font-size: 1.2rem;">관리할 스터디 모임이 없습니다.</p>
				</div>
			</c:if>
		</div>

		<div class="paging" style="margin-top: 30px; text-align: center;">
			${pageStr}</div>
	</div>

	<script>
        function deleteStudy(idx) {
            if(confirm("정말 이 스터디를 삭제하시겠습니까?")) {
                location.href = "adminStudyDelete.do?study_idx=" + idx;
            }
        }

        function filterCategory(val) {
            location.href = "adminStudyList.do?sc_idx=" + val;
        }
    </script>
</body>
</html>