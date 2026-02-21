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
#reply_layout{
	padding-top: 80px;
	width: 50%;
}
.review-photo{
    border: 2px dashed #ccc;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
}

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

#reviewPreviewContainer {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 15px;
    width: 70%;
    padding: 10px;
    
}

.preview-item {
    position: relative;
}

.preview-item img,
.preview-item video {
    width: 110px;
    height: 110px;
    object-fit: cover;
    border-radius: 10px;
}

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
.writeReview > textarea{
	width: 100%;


}
</style>
</head>
<body>
	<%@include file="../header.jsp"%>
	<form id="studycafeReview" method="post" enctype="multipart/form-data">
		<main>
			<section id="reply_layout">
				<div class="review-photo">
					<h2>사진 / 영상 추가</h2>
					<input id="reviewFileInput" name="reviewFiles" type="file" accept="image/*, video/*" multiple hidden="true"> 
					<label for="reviewFileInput" class="review-upload-btn"> + 파일 추가 </label>
					<div id="reviewPreviewContainer"></div>
				</div>
				<div class="writeReview">
					<textarea>
					</textarea>
					<button type="button">리뷰 작성하기</button>
				</div>
			</section>
		</main>
	</form>
	<%@include file="../footer.jsp"%>
</body>
<script>
const reviewFileInput = document.getElementById("reviewFileInput");
const previewContainer = document.getElementById("reviewPreviewContainer");
var selectedReviewFiles = [];

reviewFileInput.addEventListener("change", function () {
	for (let i = 0; i < reviewFileInput.files.length; i++) {
	    selectedReviewFiles.push(reviewFileInput.files[i]);
	}
    renderPreviewItems();
});

function renderPreviewItems() {

    previewContainer.innerHTML = "";
    selectedReviewFiles.forEach(function (file, index){
        const fileReader = new FileReader();
        fileReader.onload = function (event) {

            const previewWrapper = document.createElement("div");
            previewWrapper.setAttribute("class", "preview-item");
            let mediaElement;
            if (file.type.startsWith("image/")) {
                mediaElement = document.createElement("img");
            } 
            else if (file.type.startsWith("video/")) {
                mediaElement = document.createElement("video");
                mediaElement.controls = true;
            }

            mediaElement.src = event.target.result;
            const removeButton = document.createElement("button");
            removeButton.setAttribute("class", "remove-file-btn");
            removeButton.innerText = "×";

            removeButton.onclick = function () {
                selectedReviewFiles.splice(index, 1);
                renderPreviewItems();
            };

            previewWrapper.appendChild(mediaElement);
            previewWrapper.appendChild(removeButton);
            previewContainer.appendChild(previewWrapper);
        };

        fileReader.readAsDataURL(file);
    });
}
</script>
</html>