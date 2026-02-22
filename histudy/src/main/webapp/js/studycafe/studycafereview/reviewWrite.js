document.getElementById('reviewFileInputBtn').addEventListener('click',function(){
	reviewFileInput.click();
})
var selectedReviewFiles = [];
var previewContainer = document.getElementById('reviewPreviewContainer');
reviewFileInput.addEventListener("change", function () {

    const fileCount = reviewFileInput.files.length;

    if (selectedReviewFiles.length + fileCount > 5) {
        alert('파일은 5개까지 업로드 가능합니다.');
        reviewFileInput.value = "";
        return;
    }

    for (let i = 0; i < fileCount; i++) {
        selectedReviewFiles.push(reviewFileInput.files[i]);
    }

    renderPreviewItems();
});

function renderPreviewItems() {

    previewContainer.innerHTML = "";
    selectedReviewFiles.forEach(function (file, index) {

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
            removeButton.setAttribute("class","remove-file-btn");
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

document.getElementById('writeReview').addEventListener('input', function(e){
	if(document.getElementById('writeReview').value.length>400){
		e.preventDefault();
		document.getElementById('writeReview').value=document.getElementById('writeReview').value.substring(0,400);
		alert('입력가능한 글자 수는 400자 입니다.')
	}
	document.getElementById('countWriteReview').innerText = document.getElementById('writeReview').value.length+"/"+400;
})