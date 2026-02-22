<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토링 신청 | Hi, Study</title>

<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" href="css/header.css" type="text/css">
<link rel="stylesheet" href="css/footer.css" type="text/css">
<link rel="stylesheet" href="css/mentoringDesign/mentoringApply.css" type="text/css">
</head>

<body id="mentoring_apply">
<%@ include file="../header.jsp"%>

<section class="apply-ground">
  <div class="apply-wrap">

    <div class="apply-top">
      <!-- ===== 멘토링 정보 ===== -->
      <div class="card">
        <h2 class="title">
          <c:out value="${mentorSummary.mentoring_title}" default="멘토링 제목"/>
        </h2>

        <div class="mline">분야: <b><c:out value="${mentorSummary.job_group}" default="-"/></b></div>
        <div class="mline">직무: <b><c:out value="${mentorSummary.job_role}" default="-"/></b></div>
        <div class="mline">경력: <b><c:out value="${mentorSummary.career_years}" default="-"/></b></div>

        <hr class="hr"/>

        <div class="mline">
          <div style="font-weight:900;">설명</div>
          <div style="margin-top:6px;color:#0f172a;">
            <c:out value="${mentoring.description}" default="(설명 없음)"/>
          </div>
        </div>

        <div class="mline" style="margin-top:12px;">
          <div style="font-weight:900;">사전 공지</div>
          <div style="margin-top:6px;color:#0f172a;">
            <c:out value="${mentoring.pre_notice}" default="(공지 없음)"/>
          </div>
        </div>
      </div>

      <div class="card">
        <h3 class="title" style="font-size:18px;">멘토 정보</h3>

        <div class="mentor-card">
          <div class="mentor-avatar">
            <c:choose>
              <c:when test="${not empty mentorSummary.mentor_profile_img}">
                <img src="<c:out value='${mentorSummary.mentor_profile_img}'/>" alt="mentor">
              </c:when>
              <c:otherwise>
                <span>멘토</span>
              </c:otherwise>
            </c:choose>
          </div>

          <div style="flex:1;">
            <div class="mline" style="margin:0;">
              이름: <b><c:out value="${mentorSummary.mentor_name}" default="멘토"/></b>
            </div>

            <div class="mentor-meta">
              <div>분야: <b><c:out value="${mentorSummary.job_group}" default="-"/></b></div>
              <div>경력: <b><c:out value="${mentorSummary.career_years}" default="-"/></b></div>

              <!-- 평균 평점/리뷰수(있으면 표시) -->
              <c:if test="${not empty mentorSummary.avg_rating}">
                <div style="margin-top:8px;">
                  <span class="stars" style="--rating:${mentorSummary.avg_rating};"></span>
                  <span class="rating-num"><c:out value="${mentorSummary.avg_rating}"/></span>
                </div>
              </c:if>

              <c:if test="${not empty mentorSummary.review_count}">
                <div class="review-count">리뷰 수: <b><c:out value="${mentorSummary.review_count}"/></b></div>
              </c:if>
            </div>
          </div>
        </div>

        <div class="notice">
          신청 후 멘토가 승인하면 상태가 “승인됨”으로 바뀌고, 멘토링 시간이 끝난 이후 리뷰 작성이 가능해집니다.
        </div>
      </div>
    </div>

    <!-- ===== 신청 폼 ===== -->
<div class="card" style="margin-top:16px;">
  <h3 class="title" style="font-size:18px;">신청 사유</h3>

  <div class="guide-box">
    아래 내용을 간단히 적어주면 멘토가 승인하기 쉬워요 🙂
    <ul class="guide-list">
      <li>현재 상황(레벨/경험)</li>
      <li>목표(취업/프로젝트/과제 등)</li>
      <li>궁금한 점 2~3개</li>
    </ul>
  </div>

  <form method="post" action="mentoringApplySubmit.do"
        onsubmit="return confirm('이 멘토링을 신청하시겠습니까?');">
    <input type="hidden" name="mentoring_idx" value="${param.mentoring_idx}"/>

    <label class="field-label" for="applyContent">내용</label>

    <div class="textarea-wrap">
      <textarea id="applyContent" class="area area-pretty" name="apply_content" required
                maxlength="800"
                placeholder="예) Spring 백엔드 취업 준비 중인데, JWT 인증 흐름이 헷갈립니다. 현재 프로젝트에서 로그인/권한 처리 방향을 잡고 싶어요."></textarea>
      <div class="counter"><span id="cc">0</span>/800</div>
    </div>

    <div class="btns">
      <button type="button" class="btn btn-gray" onclick="history.back()">뒤로</button>
      <button type="submit" class="btn btn-dark">신청하기</button>
    </div>
  </form>
</div>

<script>
  (function(){
    const ta = document.getElementById('applyContent');
    const cc = document.getElementById('cc');
    if(!ta || !cc) return;
    const update = () => cc.textContent = (ta.value || '').length;
    ta.addEventListener('input', update);
    update();
  })();
</script>

</section>

<%@ include file="../footer.jsp"%>
</body>
</html>
