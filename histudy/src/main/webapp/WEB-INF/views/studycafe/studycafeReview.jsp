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
/* 전체 배경과 폰트 */
body {
	background-color: #f9f9f9;
	font-family: Arial, sans-serif;
	margin: 0;
	padding-top: 80px;
}
#reply_layout{
	user-select: none;
}
/* 리뷰 폼 컨테이너만 가운데 */
#studycafeReview {
	width: 600px;
	margin: 40px auto; /* 상하 40px, 가로 중앙 */
	background-color: #fff;
	border-radius: 12px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
	padding: 20px 30px;
	box-sizing: border-box;
}

/* 사진/영상 업로드 박스 */
.review-photo {
	border: 2px dashed #ccc;
	border-radius: 12px;
	padding: 20px;
	text-align: center;
	margin-bottom: 20px;
	background-color: #fafafa;
}

/* 파일 추가 버튼 */
.review-upload-btn {
	display: inline-block;
	padding: 10px 20px;
	margin-top: 10px;
	background: #4f46e5;
	color: white;
	border-radius: 8px;
	cursor: pointer;
	transition: 0.2s;
}

.review-upload-btn:hover {
	background: #3730a3;
}

/* 사진/영상 미리보기 */
#reviewPreviewContainer {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	margin-top: 15px;
	justify-content: center; /* 중앙 정렬 */
}

.preview-item {
	position: relative;
}

.preview-item img, .preview-item video {
	width: 110px;
	height: 110px;
	object-fit: cover;
	border-radius: 10px;
}

/* 미리보기 제거 버튼 */
.remove-file-btn {
	top: 2px;
	right: 2px;
	position: absolute;
	background: red;
	color: white;
	border: none;
	border-radius: 50%;
	cursor: pointer;
}

/* textarea */
.writeReview>textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
	resize: none;
	margin-top: 10px;
	box-sizing: border-box;
}

/* 글자수 라벨 */
#countWriteReview {
	font-size: 0.9rem;
	color: #666;
	float: right;
	margin-top: 5px;
}

/* 별점 */
#ratingRegister {
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 10px;
}

#ratingRegister .star {
	font-weight: 800;
	font-size: 2rem;
	color: #FFCA1A;
	margin: 0 3px;
	user-select: none;
}

/* 평점 텍스트 */
.rating_value {
	font-size: 1rem;
	color: #333;
	margin-right: 10px;
}
.star_wrap {
    display: inline-block;
    cursor: pointer;
}

.star {
    font-size: 2rem;
    color: #FFCA1A;
    margin: 0 3px;
    user-select: none;
}
</style>
</head>
<body>
	<%@include file="../header.jsp"%>
	<form id="studycafeReview" method="post" enctype="multipart/form-data">
		<main>
			<section id="reply__area">
				<div class="reply-content"></div>
			</section>
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
						<div class="star_wrap">
							<span class="star">☆</span> <span class="star">☆</span> 
							<span class="star">☆</span> 
							<span class="star">☆</span> 
							<span class="star">☆</span>
						</div>
					</div>
					<input type="hidden" name="rating" id="ratingValue" value="0">
					<textarea id="writeReview" name="studycafe_reply"></textarea>
					<div>
						<label for="writeReview" id="countWriteReview">0/400</label>
					</div>
					<button type="submit" id="reviewWrite">리뷰 작성하기</button>
				</div>
			</section>
		</main>
	</form>
	<%@include file="../footer.jsp"%>
</body>
<script src="js/studycafe/studycafereview/reviewWrite.js" type="text/javascript"></script>
<script src="js/studycafe/studycafereview/ratingStarCal.js" type="text/javascript"></script>

<script>
var xhr = null;
document.getElementById('studycafeReview').addEventListener('submit', function(e){
	e.preventDefault();
	fileReview();
})
function fileReview(){
	xhr = new XMLHttpRequest();
	var formData = new FormData();
	if(document.getElementById('writeReview').value == '' && ratingInput.value == 0 && selectedReviewFiles == ''){
		alert('리뷰를 작성해주세요!');
		return false;
	}else if(ratingInput.value == 0){
		alert('평점을 선택해주세요');
		return false;
	}
	xhr.open("POST", "studycafeReviewFile.do", true);
	xhr.onreadystatechange=fileReviewResult;
	formData.append("studycafe_reply", document.getElementById('writeReview').value);
	formData.append("studycafe_rating",ratingInput.value);
	if( selectedReviewFiles !=null){
	selectedReviewFiles.forEach(function(reviewFiles){
		formData.append("reviewFiles",reviewFiles);
	})
	}
	console.log(formData);
	xhr.send(formData);
	
}
function fileReviewResult(){
	if(xhr.readyState==4){
		if(xhr.status==200){
			var str = '';
			var fileData=JSON.parse(xhr.responseText);
			if(fileData.replyFileList != null){
			fileData.replyFileList.forEach(function(fileList){
				console.log(fileList);
				str +=fileList;
			})
				document.querySelector('.reply-content').innerHTML += str;
			}
			if(fileData.studycafe_reply !=null){
			document.querySelector('.reply-content').innerHTML=fileData.studycafe_reply;
			}
		}
	}
}
</script>
</html>