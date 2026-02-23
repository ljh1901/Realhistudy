<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/lmsDesign/taskSubmit.css">
</head>
<body class="taskSubmitBody">
<%@include file="../header.jsp" %>
<main>
	<form name="taskSubmit" action="taskSubmitOk.do" method="post" enctype="multipart/form-data">
	<section class="taskSubmitTopSection">
		<div class="TSContainer">
			<div class="TSContainer__top">
				<p>LMS &nbsp; > &nbsp; 과제 제출</p>
			</div>
			<h1 class="TSContainer__title">과제 제출</h1>
			<p class="TSContainer__sub">과제를 완료하고 제출하세요</p>
		</div>
	</section>
	<section class="taskSubmitForm">
		<div class="TSFContainer">
			<div class="taskData">
				<div class="lmsCenterContainer__rightBox__card">
					<div class="lmsCenterContainer__rightBox__card__top">
						<span class="tag-title">${study_title}</span>
						<span class="tag-weeks">${taskData.a_weeks}주차</span>
					</div>
					<div class="lmsCenterContainer__rightBox__card__middle">
						<h3>${taskData.a_title}</h3>
						<p>${taskData.a_content }</p>
						<div class="lmsCenterContainer__rightBox__middle__file">
							<p>첨부 파일</p>
							<div class="files__file">
								<img src="/histudy/lms-img/clip.png">
								<span class="files__file-name">
								    <c:choose>
								        <c:when test="${not empty taskData.a_fname}">
								            <a href="taskFileDownload.do?fileName=${taskData.a_fname}"
								               class="file-download-link">
								                ${taskData.a_fname}
								            </a>
								        </c:when>
								        <c:otherwise>
								            첨부된 파일이 없습니다.
								        </c:otherwise>
								    </c:choose>
								</span>
							</div>
						</div>
					</div>
					<div class="lmsCenterContainer__rightBox__card__row">
						<div class="row__left">
							<img src="/histudy/lms-img/calendar.png">
							<p>마감일: &nbsp;</p>
							<p>${taskData.a_end_date}</p>
							<p class="endDateText">마감</p>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" name="a_idx" value="${taskData.a_idx}">
			<div class="taskData2">
				<h3 class="taskData2__title">과제 제출하기</h3>
				<div class="TIF_card">
					<label>제출 내용 <span>*</span></label>
					<textarea name="as_content" rows="20" cols="40" required></textarea>
				</div>
				<div class="TIF_card">
					<label>파일 첨부</label>
					<div class="TIF_card_file">
						<div class="TIF_card_file_imgbox">
							<img src="/histudy/lms-img/fileimg.png">
						</div>
						<p class="file-title">파일을 드래그하거나 클릭하여 업로드</p>
						<p class="file-desc">PDF, ZIP, 이미지 파일 등 (최대 50MB)</p>
						<span class="file-name">선택된 파일 없음</span>
						<input type="file" name="prve_as_fname" onchange="fileName(this)">
					</div>
				</div>
				<div class="TIF_card">
					<div class="task_guide">
						<div class="TIF_card_imgBox">
							<img src="/histudy/lms-img/guide2.png">
						</div>
						<div class="TIF_card_text">
							<h3>제출 전 확인 사항</h3>
							<ul>
								<li>- 과제 요구사항을 모두 충족했는지 확인해주세요</li>
								<li>- 제출 후에도 마감 전까지 수정이 가능합니다</li>
								<li>- 마감일 이후에는 제출 및 수정이 불가능합니다</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="TIF_btns">
					<input type="reset" value="취소">
					<input type="submit" value="제출하기">
				</div>
			</div>
		</div>
	</section>
	</form>
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
</script>
</html>