<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/lmsDesign/taskInsert.css">
</head>
<body class="taskInsertBody">
<main>
<%@include file="../header.jsp" %>
	<section class="taskInsertTopSection">
		<div class="TIContainer">
			<div class="TIContainer__top">
				<p>LMS &nbsp; > &nbsp; 과제 수정</p>
			</div>
			<h1 class="TIContainer__title">과제 수정</h1>
			<p class="TIContainer__sub">업로드한 과제를 수정할 수 있어요</p>
		</div>
	</section>
	<section class="taskInsertForm">
		<div class="TIFContainer">
			<form name="taskInsertUpdateForm" action="taskInsertUpdateSubmit.do" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="a_idx" value="${dto.a_idx}">
				<div class="TIF_BOX">
					<div class="TIF_card">
						<label>스터디<span>*</span></label>
						<input type="text" name="study_title" value="${study_title}" readonly>
						<p>선택하신 스터디 입니다.</p>
					</div>
					<div class="TIF_card">
						<label>과제 제목 <span>*</span><span id="maxTitle"></span></label>
						<input type="text" name="a_title" value="${dto.a_title}" oninput="titleCheck(this)" placeholder="과제 제목을 입력해주세요." required>
					</div>
					<div class="TIF_card">
						<label>주차 <span>*</span></label>
						<select name="a_weeks">
							<option value="${dto.a_weeks}" selected>${dto.a_weeks}주차</option>
							<option value="1">1주차</option>
							<option value="2">2주차</option>
							<option value="3">3주차</option>
							<option value="4">4주차</option>
							<option value="5">5주차</option>
							<option value="6">6주차</option>
							<option value="7">7주차</option>
							<option value="8">8주차</option>
							<option value="9">9주차</option>
							<option value="10">10주차</option>
						</select>
					</div>
					<div class="TIF_card">
						<label>과제 설명 <span>*</span></label>
						<textarea 
							name="a_content"
							rows="10" cols="40"
							oninput="studyContentCheck(this)"
                     		maxlength="300"
                     		required>${dto.a_content}</textarea>
					</div>
					<div class="TIF_card">
						<div class="TIF_card_date">
							<div class="TIF__card__date__top">
								<label>마감 날짜 <span>*</span><span class="endDate">${dto.a_end_date.substring(0,11)}</span></label>
								<input type="date" name="a_end_date" onchange="dateCheck()" value="${dto.a_end_date}" required>
							</div>
							<div class="TIF__card__date__top">
								<label>마감 시간 <span>*</span><span class="endDate">${dto.a_end_date.substring(11)}</span></label>
								<div class="TIF__selectbox">
									<select name="a_end_time">
										<c:forEach var="i" begin="0" end="23" step="1">
											<c:choose>
												<c:when test="${i<=9}">
													<option value="${i}">0${i} 시</option>
												</c:when>
												<c:when test="${i>9}">
													<option value="${i}">${i} 시</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</select>
									<select name="a_end_time_m">
										<c:forEach var="i" begin="1" end="59" step="1">
											<c:choose>
												<c:when test="${i<=9}">
													<option value="${i}">0${i} 분</option>
												</c:when>
												<c:when test="${i>9}">
													<option value="${i}">${i} 분</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="TIF_card">
						<div class="files">
							<label>첨부 파일</label>
							<span class="current-file">
					            ${empty dto.a_fname ? '첨부된 파일 없음' : dto.a_fname}
					        </span>
						</div>
						<div class="TIF_card_file">
							<div class="TIF_card_file_imgbox">
								<img src="/histudy/lms-img/fileimg.png">
							</div>
							<p class="file-title">파일을 클릭하여 업로드</p>
							<p class="file-desc">PDF, ZIP, 이미지 파일 등 (최대 50MB)</p>
							<!-- 변경될 파일명 -->
        					<span class="file-name">변경할 파일 없음</span>
							<input type="file" name="prve_a_fname" onchange="fileName(this)">
						</div>
					</div>
					<div class="TIF_card">
						<div class="task_guide">
							<div class="TIF_card_imgBox">
								<img src="/histudy/lms-img/guide.png">
							</div>
							<div class="TIF_card_text">
								<h3>과제 등록 안내</h3>
								<ul>
									<li>- 과제 등록 후 스터디 멤버들에게 알림이 전송됩니다</li>
									<li>- 등록된 과제는 수정 및 삭제가 가능합니다.</li>
									<li>- 멤버들의 제출 현황은 LMS 페이지의 멤버 관리를 클릭하여 확인할 수 있습니다.</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="TIF_btns">
						<input type="reset" value="취소">
						<input type="submit" value="과제 수정하기">
					</div>
				</div>
			</form>
		</div>
	</section>
</main>
<%@include file="../footer.jsp" %>
</body>
<script>
function fileName(input){
    const name = input.files.length > 0
        ? input.files[0].name
        : '변경할 파일 없음';

    const card = input.closest('.TIF_card');
    card.querySelector('.file-name').textContent = name;

    // 기존 파일 흐리게 (선택)
    const current = card.querySelector('.current-file');
    if(current){
        current.style.opacity = '0.5';
    }
}
</script>
</html>