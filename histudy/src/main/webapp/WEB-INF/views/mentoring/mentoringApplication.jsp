<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>멘토링 신청현황 | Hi, Study</title>

  <link rel="stylesheet" href="css/root.css" type="text/css">
  <link rel="stylesheet" href="css/header.css" type="text/css">
  <link rel="stylesheet" href="css/footer.css" type="text/css">
  <link rel="stylesheet" href="css/mentoringDesign/mentoringApplication.css" type="text/css">
</head>

<body id="app-page">
<%@ include file="../header.jsp"%>

<section class="ma-page">
  <div class="ma-wrap">

    <h2 class="ma-title">멘토링 신청현황</h2>

    <!-- 상단 카드 영역 -->
    <div class="ma-top">
      <!-- 왼쪽: 멘토링 카드 -->
      <div class="ma-card ma-mentoring">
        <div class="ma-card-title">멘토링</div>

        <!-- mentoring_title -->
        <div class="ma-mentoring-quote">
          <c:out value="${mentorSummary.mentoring_title}" default="(멘토링 제목이 여기에 표시됩니다)"/>
        </div>

        <div class="ma-tags">
          <c:forEach var="t" items="${mentorSummary.tags}">
            <span class="ma-tag"><c:out value="${t}"/></span>
          </c:forEach>
        </div>
      </div>

      <!-- 오른쪽: 멘토 프로필 카드 -->
      <div class="ma-card ma-mentor">
  <div class="ma-mentor-row">
    <div class="ma-mentor-img">
      <c:choose>
        <c:when test="${not empty mentorSummary.mentor_profile_img}">
          <img src="${pageContext.request.contextPath}/mypage-img/pimg/${mentorSummary.mentor_profile_img}" alt="멘토 프로필"
          onerror="this.src='${pageContext.request.contextPath}/main-img/defaultUser.png';">
        </c:when>
        <c:otherwise>
          <div class="ma-mentor-img-fallback" style="background-color: #f1f5f9; font-size:30px; display: flex; align-items: center; justify-content: center;">
            👤
          </div>
        </c:otherwise>
      </c:choose>
    </div>

          <div class="ma-mentor-info">
            <div class="ma-mentor-name"><c:out value="${mentorSummary.mentor_name}" default="멘토명"/></div>
            <div class="ma-mentor-meta">
              <div>분야: <b><c:out value="${mentorSummary.job_group}" default="-"/></b></div>
              <div>직무: <b><c:out value="${mentorSummary.job_role}" default="-"/></b></div>
              <div>경력: <b><c:out value="${mentorSummary.career_years}" default="-"/></b></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 하단: 신청자 테이블 -->
    <div class="ma-card ma-table-card">
      <div class="ma-table-head">
        <div class="ma-card-title">멘토링 신청 인원 현황</div>

        <form class="ma-search" method="get" action="mentoringApplication.do">
          <input id="kw" name="kw" type="text" value="${param.kw}" placeholder="이름/이메일 검색">
          <button type="button" class="ma-btn ma-btn-dark">검색</button>
        </form>
      </div>

      <c:choose>
        <c:when test="${empty applications}">
          <div class="ma-empty">신청이 없습니다.</div>
        </c:when>
        <c:otherwise>
          <div class="ma-table-wrap">
            <table class="ma-table" id="appTable">
              <thead>
                <tr>
                  <th style="width:90px;">신청번호</th>
                  <th style="width:120px;">이름</th>
                  <th>이메일</th>
                  <th style="width:160px;">전화번호</th>
                  <th style="width:140px;">지원 날짜</th>
                  <th style="width:110px;">프로필</th>
                  <th style="width:170px;">상태</th>
                </tr>
              </thead>

              <tbody>
              <c:forEach var="a" items="${applications}">
                <tr>
                  <td><c:out value="${a.ma_id}"/></td>
                  <td class="ma-name"><c:out value="${a.mentee_name}"/></td>
                  <td class="ma-email"><c:out value="${a.mentee_email}"/></td>
                  <td><c:out value="${a.mentee_phone}"/></td>
                  <td>
                    <fmt:formatDate value="${a.created_at}" pattern="yyyy-MM-dd"/>
                  </td>

                  <!-- 프로필 클릭: 모달 -->
                  <td>
                    <button type="button"
                            class="ma-btn ma-btn-ghost"
                            onclick="openReasonModal(
                              '${a.ma_id}',
                              '${fn:escapeXml(a.mentee_name)}',
                              '${fn:escapeXml(a.apply_content)}',
                              '${fn:escapeXml(a.mentee_profile_img)}'
                            )">
                      보기
                    </button>
                  </td>

                  <!-- 상태 + 승인/거절 -->
                  <td>
  <div class="ma-actions">

    <c:choose>
      <c:when test="${a.status eq '승인대기중'}">
        <!-- 승인대기중일 때만 버튼 2개 -->
        <form method="post" action="mentoringApprove.do" class="ma-inline"
              onsubmit="return confirm('이 신청을 승인하시겠습니까?');">
          <input type="hidden" name="ma_id" value="${a.ma_id}">
          <button type="submit" class="ma-btn ma-btn-dark">승인</button>
        </form>

        <form method="post" action="mentoringDelete.do" class="ma-inline"
              onsubmit="return confirm('이 신청을 정말 거절(삭제)하시겠습니까?');">
          <input type="hidden" name="ma_id" value="${a.ma_id}">
          <button type="submit" class="ma-btn ma-btn-gray">거절</button>
        </form>
      </c:when>

      <c:otherwise>
        <!-- 승인된 경우 -->
        <span class="ma-badge ok">승인됨</span>
      </c:otherwise>
    </c:choose>
    <button type="button" class="ma-btn ma-btn-ghost" 
            style="color: #e11d48; border-color: #fecdd3;"
            onclick="openMenteeReportModal('${a.mentee_user_idx}', '${fn:escapeXml(a.mentee_name)}')">
        신고
    </button>

  </div>
</td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
       <c:if test="${not empty pageStr}">
        <div class="paging">
          ${pageStr}
        </div>
      </c:if>
    </div>
  </div>
</section>

<!-- 신청사유 모달 -->
<div class="ma-modal" id="reasonModal" onclick="closeByBackdrop(event, 'reasonModal')">
  <div class="ma-modal-box">
    <div class="ma-modal-head">
      <div class="ma-modal-title" id="reasonTitle">신청 사유</div>
      <button class="ma-x" type="button" onclick="closeModal('reasonModal')">×</button>
    </div>

    <div class="ma-modal-body">
      <div class="ma-modal-profile">
        <div class="ma-modal-img" id="reasonImg"></div>
        <div>
          <div class="ma-modal-name" id="reasonName">-</div>
          <div class="ma-modal-sub" id="reasonId">-</div>
        </div>
      </div>

      <div class="ma-modal-text" id="reasonContent"></div>
    </div>

    <div class="ma-modal-foot">
      <button type="button" class="ma-btn ma-btn-gray" onclick="closeModal('reasonModal')">닫기</button>
    </div>
  </div>
</div>
<div id="menteeReportModal" class="report-modal">
    <div class="report-modal-content">
        <h3 id="reportTargetTitle">사용자 신고하기</h3>
        <p><span id="targetMenteeName"></span> 님을 신고하시겠습니까?</p>
        
        <form id="menteeReportForm" enctype="multipart/form-data">
            <input type="hidden" name="target_idx" id="target_user_idx">
            
            <div class="report-form-group">
                <label>신고 유형</label>
                <select name="report_type" required>
                    <option value="">-- 사유 선택 --</option>
                    <option value="노쇼">사전 연락 없는 노쇼</option>
                    <option value="비매너">비매너 대화 및 태도</option>
                    <option value="부적절한 요구">부적절한 요청</option>
                    <option value="기타">기타</option>
                </select>
            </div>
            
            <div class="report-form-group">
                <label>상세 내용</label>
                <textarea name="report_content" rows="4" required placeholder="내용을 입력해주세요."></textarea>
            </div>

            <div class="report-form-group">
                <label>증거 사진 <span class="optional-text">(선택)</span></label>
                <div class="file-input-wrapper">
                    <input type="file" name="report_photo_file" accept="image/*">
                </div>
            </div>
            
            <div class="report-btn-group">
                <button type="button" class="btn-report-cancel" onclick="closeMenteeReportModal()">취소</button>
                <button type="submit" class="btn-report-submit">신고 제출</button>
            </div>
        </form>
    </div>
</div>

<script>
  function closeByBackdrop(e, id){
    if(e.target && e.target.id === id) closeModal(id);
  }
  function closeModal(id){
    document.getElementById(id).classList.remove("open");
  }
  function openModal(id){
    document.getElementById(id).classList.add("open");
  }

  function openReasonModal(maId, name, content, imgUrl){
    document.getElementById("reasonId").innerText = "신청번호: " + maId;
    document.getElementById("reasonName").innerText = name || "-";
    document.getElementById("reasonContent").innerText = content || "(내용 없음)";

    const box = document.getElementById("reasonImg");
    box.innerHTML = "";
    if(imgUrl && imgUrl !== "null"){
      const img = document.createElement("img");
      img.src = "${pageContext.request.contextPath}/mypage-img/pimg/" + imgUrl;
      img.alt = "프로필";
      box.appendChild(img);
      img.style.width = "100%";
      img.style.height = "100%";
      img.style.objectFit = "cover";
      img.style.borderRadius = "12px";
      box.appendChild(img);
      box.style.display = "block";
    } else {
    	box.innerHTML = "👤";
    	box.style.display = "flex";    
        box.style.alignItems = "center";  
        box.style.justifyContent = "center"; 
        box.style.fontSize = "30px";         
        box.style.backgroundColor = "#f1f5f9"; 
        box.style.borderRadius = "12px";
      box.classList.add("fallback");
    }
    openModal("reasonModal");
  }
  function openMenteeReportModal(userIdx, userName) {

	    const targetIdxInput = document.getElementById('target_user_idx');
	    const targetNameSpan = document.getElementById('targetMenteeName');
	    const modal = document.getElementById('menteeReportModal');

	    if (targetIdxInput && targetNameSpan && modal) {
	        targetIdxInput.value = userIdx;
	        targetNameSpan.innerText = userName;

	        modal.style.display = 'block';
	    }
	}

	function closeMenteeReportModal() {
	    const modal = document.getElementById('menteeReportModal');
	    const form = document.getElementById('menteeReportForm');
	    
	    if (modal) modal.style.display = 'none';
	    if (form) form.reset();
	}

	document.addEventListener('DOMContentLoaded', function() {
	    const reportForm = document.getElementById('menteeReportForm');
	    
	    if (reportForm) {
	        reportForm.addEventListener('submit', function(e) {
	            e.preventDefault();
	            
	            const formData = new FormData(this);
	            

	            fetch('reportSubmit.do', {
	                method: 'POST',
	                body: formData
	            })
	            .then(response => response.text())
	            .then(result => {

	                if (result.trim() === "success") {
	                    alert("신고가 정상적으로 접수되었습니다.");
	                    closeMenteeReportModal();
	                } else {
	                    alert("신고 접수에 실패했습니다. 다시 시도해주세요.");
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	                alert("서버 통신 중 오류가 발생했습니다.");
	            });
	        });
	    }
	});

	window.onclick = function(event) {
	    const modal = document.getElementById('menteeReportModal');
	    if (event.target == modal) {
	        closeMenteeReportModal();
	    }
	}

  function filterRows(){
    const kw = (document.getElementById("kw").value || "").toLowerCase();
    const rows = document.querySelectorAll("#appTable tbody tr");
    rows.forEach(r => {
      const name = (r.querySelector(".ma-name")?.innerText || "").toLowerCase();
      const email = (r.querySelector(".ma-email")?.innerText || "").toLowerCase();
      r.style.display = (name.includes(kw) || email.includes(kw)) ? "" : "none";
    });
  }
  
  
</script>

<%@ include file="../footer.jsp"%>
</body>
</html>
