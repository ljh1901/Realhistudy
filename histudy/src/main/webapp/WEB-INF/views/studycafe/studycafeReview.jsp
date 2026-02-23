<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/root.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<style>
body {
	background-color: #f3f4f6;
	font-family: 'Noto Sans KR', sans-serif;
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
</style>
</head>
<body>
	<%@include file="../header.jsp"%>
	<form id="studycafeReview" method="post" enctype="multipart/form-data">
		<main>
			<section id="reply__area">
						평점: ★${avgRating}
				<c:forEach var="reply" items="${reply}">
					<div class="reply-content">
						<span>${sessionScope.user_name}</span> <span><a href="#">수정</a></span>
						<span><a href="#">삭제</a></span> <span><a href="#">${reply.created_at}</a></span>
						<span><a href="#"></a></span> <span><a href="#">신고</a></span> <span>별점:
							${reply.studycafe_rating}</span>
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
				<button type="button" id="studycafeReplyBtn">이용후기 남기기</button>
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
					</div>
					<button type="submit" id="reviewWrite">리뷰 작성하기</button>
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
if(document.querySelector('.reply-text').textContent == ''){
	document.querySelector('.reply-text').style.display='none';
}
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
				var str = '';
				var fileData = JSON.parse(xhr.responseText);
				if (fileData.replyFileList != null) {
					fileData.replyFileList.forEach(function(fileList) {
						console.log(fileList);
						str += fileList;
					})
					document.querySelector('.photo-area').innerHTML += str;
				}
				if (fileData.studycafe_reply != null) {
					document.querySelector('.reply-text').innerHTML += fileData.studycafe_reply;
					document.querySelector('.reply-text').innerHTML += fileData.studycafe_rating;
					document.querySelector('.reply-text').style.display='';
				}
			}
		}
	}
</script>
</html>