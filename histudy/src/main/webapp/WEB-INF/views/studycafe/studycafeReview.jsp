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
<link rel="shortcut icon" href="/histudy/main-img/logo1.png"
	type="image/x-icon" />

<!-- OG (Open Graph Data)-->
<meta property="og:title" content="Hi, Study" />
<meta property="og:type" content="website" />
<meta property="og:url" content="배포후 생성된 URL" />
<meta property="og:image" content="배포후에 생성된 이미지 URL" />

<!-- GoogleFont -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<!-- CSS -->
<link rel="stylesheet" href="css/root.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<style>
body {
	background-color: #f3f4f6;
	font-family: 'Noto Sans KR', sans-serif;
}

#studycafeReviewBody header {
	background-color: white;
}
/* 평균 평점 */
main>span {
	font-size: 1.2rem;
	font-weight: 600;
	display: block;
	margin-bottom: 20px;
}

#reply__area {
	width: 50%;
	padding-top: 80px;
	margin: auto;
}
/* 리뷰 카드 디자인 업그레이드 */
.reply-content {
	background: #fff;
	border-radius: 14px;
	padding: 18px 20px;
	margin-bottom: 20px;
	box-shadow: 0 3px 12px rgba(0, 0, 0, 0.06);
	border: none;
	transition: 0.2s ease;
}

.reply-content:hover {
	transform: translateY(-3px);
}

/* 상단 영역 정렬 */
.reply-content>span {
	font-size: 0.85rem;
	color: #777;
	margin-right: 10px;
}

/* 별점 강조 */
.reply-content span:last-of-type {
	font-weight: bold;
	color: #FFCA1A;
}

/* 사진 영역 */
.reply-photo {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 8px;
	margin: 10px 0;
}

.photo-area img {
	width: 100%;
	height: 110px;
	object-fit: cover;
	border-radius: 10px;
	padding-left: 0;
	transition: 0.2s;
}

.photo-area img:hover {
	transform: scale(1.05);
}

/* 리뷰 텍스트 */
.reply-text {
	background: #f9fafb;
	border: 1px solid #e5e7eb;
	border-radius: 10px;
	padding: 12px;
	width: 100%;
	margin: 10px 0 0 0;
	font-size: 0.95rem;
	line-height: 1.6;
	color: #333;
}

/* 수정/삭제/신고 링크 */
.reply-content a {
	text-decoration: none;
	color: #aaa;
	font-size: 0.8rem;
	transition: 0.2s;
}

.reply-content a:hover {
	color: #4f46e5;
}

/* 리뷰 작성 버튼 업그레이드 */
#studycafeReplyBtn {
	background: #4f46e5;
	color: #fff;
	padding: 12px 25px;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	font-weight: 600;
	transition: 0.2s;
}

#studycafeReplyBtn:hover {
	background: #3730a3;
}

/* 작성 폼 카드화 */
#reply_layout {
	background: #fff;
	border-radius: 16px;
	padding: 25px;
	margin-top: 30px;
	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05);
}

#ratingRegister .star {
	font-weight: 800;
	font-size: 2rem;
	color: #FFCA1A;
	margin: 0 3px;
	user-select: none;
} /* 평점 텍스트 */
.rating_value {
	font-size: 1rem;
	color: #333;
	margin-right: 10px;
}

.star_wrap {
	display: flex;
}

.star {
	position: relative;
	font-size: 2rem;
	cursor: pointer;
	width: 32px;
	height: 32px;
} /* 기본 빈 별 */
.star::before {
	content: "☆";
	position: absolute;
	left: 0;
	color: #ccc;
} /* 채워진 별 */
.star.full::before {
	content: "★";
	color: #FFCA1A;
} /* 반쪽 별 */
.star.half::before {
	content: "★";
	color: #FFCA1A;
	width: 50%;
	overflow: hidden;
}

#reviewFileInputBtn {
	background: #4f46e5;
	color: #fff;
	padding: 12px 25px;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	font-weight: 600;
	transition: 0.2s;
}

/* ===============================
   전체 컨테이너 정리
================================ */
main {
	max-width: 800px;
	margin: 0 auto;
	padding: 60px 20px 100px;
}

#reply__area {
	width: 100%;
	padding-top: 40px;
}

/* 평균 평점 */
#reply__area>span {
	display: block;
	font-size: 1.4rem;
	font-weight: 700;
	margin-bottom: 30px;
}

/* ===============================
   리뷰 카드 정리 (레이아웃만 개선)
================================ */
.reply-content {
	padding: 20px;
	border: 1px solid #eee;
}

.reply-content>span {
	margin-right: 12px;
}

/* 작성자 이름 강조 */
.reply-content>span:first-child {
	font-weight: 600;
	color: #111;
}

/* 날짜 */
.reply-content>span:nth-of-type(2) a, .reply-content>span:nth-of-type(3) a
	{
	color: #9ca3af;
}

/* 별점 */
.reply-content span:last-of-type {
	font-size: 0.9rem;
}

/* ===============================
   이미지 영역 살짝 정리
================================ */
.reply-photo {
	margin-top: 12px;
}

.photo-area img {
	border: 1px solid #f1f1f1;
}

.photo-area img:hover {
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* ===============================
   리뷰 텍스트 가독성 개선
================================ */
.reply-text {
	margin-top: 15px;
	line-height: 1.7;
	white-space: pre-line;
}

/* ===============================
   작성 버튼 중앙 정렬
================================ */
#studycafeReplyBtn {
	display: block;
	margin: 40px auto 0;
}

/* ===============================
   작성 폼 정리
================================ */
#reply_layout {
	margin-top: 60px;
}

.review-photo h2 {
	font-size: 1.1rem;
	margin-bottom: 10px;
}

#writeReview {
	width: 100%;
	min-height: 120px;
	border: 1px solid #e5e7eb;
	border-radius: 8px;
	padding: 12px;
	resize: none;
}

#writeReview:focus {
	outline: none;
	border-color: #4f46e5;
}

/* 글자수 + 버튼 한 줄 정렬 */
#writeReview+div {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 12px;
}

#reviewWrite {
	background: #4f46e5;
	color: #fff;
	border: none;
	padding: 8px 18px;
	border-radius: 6px;
	cursor: pointer;
}

#reviewWrite:hover {
	background: #3730a3;
}

/* 내 리뷰 이동 */
.writeReview a {
	display: inline-block;
	margin-top: 15px;
	font-size: 0.85rem;
	color: #6b7280;
}

.writeReview a:hover {
	color: #4f46e5;
}
/* ===============================
   파일 미리보기 영역 꾸미기
================================ */
#reviewPreviewContainer {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(110px, 1fr));
	gap: 12px;
	margin-top: 15px;
}

/* 미리보기 카드 */
.preview-item {
	position: relative;
	width: 100%;
	height: 110px;
	border-radius: 12px;
	overflow: hidden;
	background: #f9fafb;
	border: 1px solid #e5e7eb;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	transition: 0.2s ease;
}

.preview-item:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.12);
}

/* 이미지 & 영상 공통 */
.preview-item img, .preview-item video {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* ===============================
   삭제 버튼 스타일
================================ */
.remove-file-btn {
	position: absolute;
	top: 6px;
	right: 6px;
	width: 24px;
	height: 24px;
	border-radius: 50%;
	border: none;
	background: rgba(0, 0, 0, 0.65);
	color: #fff;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: 0.2s ease;
}

.remove-file-btn:hover {
	background: #ef4444;
	transform: scale(1.1);
}

/* ===============================
   파일 추가 버튼 살짝 업그레이드
================================ */
#reviewFileInputBtn {
	margin-top: 10px;
}

#reviewFileInputBtn:hover {
	transform: translateY(-2px);
}

.avg-rating {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 25px;
}

.avg-score {
	font-size: 1.6rem;
	font-weight: 700;
	color: #111;
}

.avg-stars .star {
	font-size: 1.6rem;
	color: #ccc;
}

.avg-stars .star.full {
	color: #FFCA1A;
}
</style>
</head>
<body id="studycafeReviewBody">
	<%@include file="../header.jsp"%>
	<form id="studycafeReview" method="post" enctype="multipart/form-data">
		<main>
			<section id="reply__area">
				<div class="avg-rating">
					<div class="avg-rating">
						<span class="avg-score"> ⭐ ${avgRating} / 5 </span>
					</div>
				</div>
				<c:if test="${empty reply}">
					<p>리뷰가 존재하지 않습니다 리뷰를 남겨주세요</p>
				</c:if>
				<c:forEach var="reply" items="${reply}">
					<div class="reply-content">
						<span id="${sessionScope.user_idx}">${reply.user_name}</span>
						<c:if test="${sessionScope.user_idx == reply.user_idx}">
							<span><a
								href="studycafeReviewDelete.do?studycafe_idx=${studycafe_idx}&review_idx=${reply.review_idx}&user_idx=${reply.user_idx}">삭제</a></span>
						</c:if>
						<span><a href="#">${reply.created_at}</a></span> <span>별점:${reply.studycafe_rating}</span>
						<div class="reply-photo">
							<c:if test="${!empty reply.fileList}">
								<c:forEach var="file" items="${reply.fileList}">
									<div class="photo-area">
										<img src="${file.file_path}">
									</div>
								</c:forEach>
							</c:if>
						</div>
						<div class="reply-text">${reply.studycafe_reply}</div>
					</div>
				</c:forEach>
			</section>
			<div>
				<c:if
					test="${sessionScope.user_idx !=null && result > 0 && hasWritten ==0 }">
					<button type="button" id="studycafeReplyBtn">이용후기 남기기</button>
				</c:if>
			</div>
			<section id="reply_layout">
				<div class="review-photo">
					<h2>사진 / 영상 추가</h2>
					<input id="reviewFileInput" name="reviewFiles" type="file"
						accept="image/*, video/*" multiple hidden="true">
					<button type="button" id="reviewFileInputBtn"
						class="review-upload-btn">+ 파일 추가</button>
					<div id="reviewPreviewContainer"></div>
				</div>
				<div class="writeReview">
					<div id="ratingRegister">
						<div class="rating_value">평점:</div>
						<div id="ratingRegister">
							<span class="star" data-value="1">☆</span> <span class="star"
								data-value="2">☆</span> <span class="star" data-value="3">☆</span>

							<span class="star" data-value="4">☆</span> <span class="star"
								data-value="5">☆</span>
						</div>

						<input type="hidden" id="ratingValue" value="0">
					</div>
					<input type="hidden" name="rating" id="ratingValue" value="0">
					<textarea id="writeReview" name="studycafe_reply"></textarea>
					<div>
						<label for="writeReview" id="countWriteReview">0/200</label>
						<button type="submit" id="reviewWrite">리뷰 작성하기</button>
					</div>
					<a href="#${sessionScope.user_idx}">내 리뷰로 이동</a>
				</div>
			</section>
		</main>
	</form>
	<%@include file="../footer.jsp"%>
</body>
<script src="js/studycafe/studycafereview/reviewWrite.js"
	type="text/javascript"></script>
<script src="js/studycafe/studycafereview/ratingStarCal.js"
	type="text/javascript"></script>

<script>
document.getElementById('reply_layout').style.display='none';
document.getElementById('studycafeReplyBtn').addEventListener('click',function(){
	document.getElementById('reply_layout').style.display='';
})
	var xhr = null;
	document.getElementById('studycafeReview').addEventListener('submit',
			function(e) {
				e.preventDefault();
				fileReview();
			})
	function fileReview() {
		xhr = new XMLHttpRequest();
		var formData = new FormData();
		if (document.getElementById('writeReview').value == ''||document.getElementById('writeReview').value == null && ratingInput.value == 0 && selectedReviewFiles == '') {
			alert('리뷰를 작성해주세요!');
			return false;
		} else if (ratingInput.value == 0) {
			alert('평점을 선택해주세요');
			return false;
		}
		xhr.open("POST", "studycafeReviewFile.do", true);
		xhr.onreadystatechange = fileReviewResult;
		formData.append("studycafe_reply", document.getElementById('writeReview').value);
		formData.append("studycafe_rating", ratingInput.value);
		formData.append("studycafe_idx", ${studycafe_idx});
		if (selectedReviewFiles != null) {
			selectedReviewFiles.forEach(function(reviewFiles) {
				formData.append("reviewFiles", reviewFiles);
			})
		}
		console.log(formData);
		xhr.send(formData);

	}
	function fileReviewResult() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				xhr.onload=location.reload();
			}
		}
	}
	
</script>
</html>