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
<%@include file="../header.jsp" %>
<main>
	<section class="taskInsertTopSection">
		<div class="TIContainer">
			<div class="TIContainer__top">
				<p>LMS &nbsp; > &nbsp; 과제 등록</p>
			</div>
			<h1 class="TIContainer__title">과제 등록</h1>
			<p class="TIContainer__sub">스터디 멤버들에게 새로운 과제를 등록하세요</p>
		</div>
	</section>
	<section class="taskInsertForm">
		<div class="TIFContainer">
			<form name="taskInsertForm" action="taskInsert.do" method="POST" enctype="multipart/form-data">
				<div class="TIF_BOX">
					<div class="TIF_card">
						<label>스터디 선택 <span>*</span></label>
						<select name="study_idx" required>
							<c:forEach var="s" items="${studyList}">
								<option value="${s.study_idx}">${s.study_title}</option>
							</c:forEach>
						</select>
						<p>리더로 참여 중인 스터디만 표시됩니다.</p>
					</div>
					<div class="TIF_card">
						<label>과제 제목 <span>*</span><span id="maxTitle"></span></label>
						<input type="text" name="a_title" oninput="titleCheck(this)" maxlength="21" placeholder="과제 제목을 입력해주세요." required>
					</div>
					<div class="TIF_card">
						<label>주차 <span>*</span></label>
						<select name="a_weeks" required>
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
                     		maxlength="600"required></textarea>
                     	<div class="TIF_card_keynum">
							<p id="keynum">0</p>
                     		<p>/600자</p>
                     	</div>
					</div>
					<div class="TIF_card">
						<div class="TIF_card_date">
							<div>
								<label>마감 날짜 <span>*</span></label>
								<input type="date" name="a_end_date" onchange="dateCheck()" required>
							</div>
							<div>
								<label>마감 시간 <span>*</span></label>
								<div class="TIF__selectbox">
									<select name="a_end_time" required>
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
									<select name="a_end_time_m" required>
										<c:forEach var="i" begin="0" end="59" step="1">
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
						<label>첨부 파일</label>
						<div class="TIF_card_file">
							<div class="TIF_card_file_imgbox">
								<img src="/histudy/lms-img/fileimg.png">
							</div>
							<p class="file-title">파일을 클릭하여 업로드</p>
							<p class="file-desc">PDF, ZIP, 이미지 파일 등 (최대 50MB)</p>
							<span class="file-name">선택된 파일 없음</span>
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
									<li>- 과제를 등록하여 스터디를 운영해보세요.</li>
									<li>- 등록된 과제는 수정 및 삭제가 가능합니다.</li>
									<li>- 멤버들의 제출 현황은 LMS 페이지의 멤버 관리를 클릭하여 확인할 수 있습니다.</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="TIF_btns">
						<input type="reset" value="취소">
						<input type="submit" value="과제 등록하기">
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
    const fileName = input.files.length > 0
        ? input.files[0].name
        : '선택된 파일 없음';

    document.querySelector('.file-name').textContent = fileName;
}

// 제목 글자수 제한 유효성 검사
function titleCheck(el){
	const MAX = 21;
	const titleCount = el.value.length;
	const data = document.getElementById('maxTitle');
	
	if(titleCount>=MAX){
		data.innerHTML = '제목은 21자 이내로 작성해주세요!';
	}else{
		data.innerHTML = '';
	}
	
}
// 스터디 내용 글자수 제한 유효성 검사 
function studyContentCheck(el){
   const MAX = 600;
   const count = el.value.length;
   const keynum = document.getElementById('keynum');
   
   keynum.textContent = count;
   
    if (count >= MAX) {
        keynum.style.color = 'red';
    } else {
        keynum.style.color = 'black';
    } 
}
// 이전 날짜 제한 유효성 검사
function dateCheck(){
   var selectDate = document.taskInsertForm.a_end_date.value;
   
   var endDate = new Date(selectDate);
   var today = new Date();
   
   if(endDate < today){
	   alert('오늘 날짜 이후로 선택하셔야 합니다.');
	   document.taskInsertForm.a_end_date.value='';
   }
}
</script>
</html>