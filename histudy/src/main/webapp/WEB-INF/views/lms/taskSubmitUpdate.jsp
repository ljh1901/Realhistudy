<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/lmsDesign/taskSubmit.css">
</head>
<body class="taskSubmitBody">
<%@include file="../header.jsp" %>
<main>
	<form name="taskSubmitUpdate" action="taskSubmitUpdateOk.do" method="post" enctype="multipart/form-data">
	<section class="taskSubmitTopSection">
		<div class="TSContainer">
			<div class="TSContainer__top">
				<p>LMS &nbsp; > &nbsp; 과제 제출 수정</p>
			</div>
			<h1 class="TSContainer__title">과제 제출 수정</h1>
			<p class="TSContainer__sub">제출하신 과제를 수정할 수 있어요.</p>
		</div>
	</section>
	<section class="taskSubmitForm">
		<div class="TSFContainer">
			<div class="taskData">
				<div class="lmsCenterContainer__rightBox__card">
					<div class="lmsCenterContainer__rightBox__card__top">
						<span class="tag-title">${study_title}</span>
						<span class="tag-weeks">${lmsDto.a_weeks}주차</span>
					</div>
					<div class="lmsCenterContainer__rightBox__card__middle">
						<h3>${lmsDto.a_title}</h3>
						<p>${lmsDto.a_content }</p>
						<div class="lmsCenterContainer__rightBox__middle__file">
							<p>첨부 파일</p>
							<div class="files__file">
								<img src="/histudy/lms-img/clip.png">
								<span>${empty lmsDto.a_fname?'첨부된 파일이 없습니다.':lmsDto.a_fname}</span>
							</div>
						</div>
					</div>
					<div class="lmsCenterContainer__rightBox__card__row">
						<div class="row__left">
							<img src="/histudy/lms-img/calendar.png">
							<p>마감일: &nbsp;</p>
							<p>${lmsDto.a_end_date}</p>
							<p class="endDateText">마감</p>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" name="a_idx" value="${lmsDto.a_idx}">
			<div class="taskData2">
				<h3 class="taskData2__title">과제 제출하기</h3>
				<div class="TIF_card">
					<label>제출 내용 <span>*</span></label>
					<textarea name="as_content" rows="20" cols="40" required>${lmsSubmitDto.as_content}</textarea>
				</div>
				<div class="TIF_card">
					<label>파일 첨부</label>
					<span class="current-file">
			            ${empty lmsSubmitDto.as_fname ? '첨부된 파일이 없습니다.' : lmsSubmitDto.as_fname}
			        </span>
					<div class="TIF_card_file">
						<div class="TIF_card_file_imgbox">
							<img src="/histudy/lms-img/fileimg.png">
						</div>
						<p>파일을 클릭하여 업로드</p>
						<p>PDF, ZIP, 이미지 파일 등 (최대 50MB)</p>
						<!-- 새로 선택된 파일 -->
       					<span class="file-name">변경할 파일 없음</span>
						<input type="file" name="prve_as_fname" onchange="submitFileName(this)">
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
					<input type="submit" value="수정하기">
				</div>
			</div>
		</div>
	</section>
	</form>
</main>
<%@include file="../footer.jsp" %>
</body>
<script>
function submitFileName(input){
    const name = input.files.length > 0
        ? input.files[0].name
        : '변경할 파일 없음';

    const card = input.closest('.TIF_card');
    card.querySelector('.file-name').textContent = name;

    // 기존 파일 흐리게
    const current = card.querySelector('.current-file');
    if(current){
        current.style.opacity = '0.5';
    }
}
</script>
</html>