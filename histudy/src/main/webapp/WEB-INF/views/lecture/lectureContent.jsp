<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" href="css/header.css" type="text/css">
<link rel="stylesheet" href="css/footer.css" type="text/css">
<link rel="stylesheet" href="css/lectureDesign/lectureContent.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/histudy/css/user/loginModal.css">
<script>
function load(){
	var message="${msg}";
    if(message!="") {
		alert(message);
		location.href="index.do";
	}
    var reviewMsg = "${param.reviewMsg}"; 
    if(reviewMsg != "") {
        alert(reviewMsg);
    }
}
function show(lecture_idx) {
    var reviewDiv = document.getElementById('reviewWrite');
    var statusDiv = document.getElementById('reviewStatus');
    var url = "checkReview.do?lecture_idx=" + lecture_idx;
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var data = JSON.parse(xhr.responseText);
            if (data.count > 0) {
                statusDiv.innerText = "이미 리뷰를 등록하셨습니다.";
            } else {
                statusDiv.innerText = "";
                if (reviewDiv.style.display == 'none' || reviewDiv.style.display == '') {
                    reviewDiv.style.display = 'block';
                } else {
                    reviewDiv.style.display = 'none';
                }
            }
        }
    };
    xhr.send();
}
function reviewWrite(){
    alert('${param.reviewMsg}');
}
function saveMemo() {
    var lidx = document.getElementById('lecture_idx').value;
    var uidx = document.getElementById('user_idx').value;
    var title = document.getElementById('note_title').value;
    var content = document.getElementById('note_content').value;
    var statusDiv = document.getElementById('memoStatus');
    var url = "lectureMemo.do?lecture_idx=" + lidx + 
              "&user_idx=" + uidx + 
              "&note_title=" + encodeURIComponent(title) + 
              "&note_content=" + encodeURIComponent(content);

    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);

    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var data = JSON.parse(xhr.responseText);
            if(data.result > 0) {
                statusDiv.innerText = "메모가 저장되었습니다.";
                setTimeout(function() {
                    statusDiv.innerText = "";
                }, 3000);
            } else {
                statusDiv.innerText = "메모 저장 실패";
            }
        }
    };
 
    xhr.send();
}
function reviewUpdate(review_idx,title,content,score){
	var reviewDiv = document.getElementById('reviewWrite');
    var statusDiv = document.getElementById('reviewStatus');
    
    reviewDiv.style.display = 'block';
    document.writeFm.review_title.value = title;
    document.writeFm.review_content.value = content;
    document.writeFm.review_score.value = score;
    document.writeFm.action = "reviewUpdate.do"; 
    
    var idxInput = document.getElementById('review_idx_hidden');
    if(!idxInput) {
        idxInput = document.createElement("input");
        idxInput.type = "hidden";
        idxInput.name = "review_idx";
        idxInput.id = "review_idx_hidden";
        document.writeFm.appendChild(idxInput);
    }
    idxInput.value = review_idx;
    document.getElementById('reviewbt').value = "리뷰 수정";
}
function reviewDelete(review_idx,lecture_idx){
	var result=confirm("리뷰를 삭제하시겠습니까?");
	if(result){
		location.href="reviewDelete.do?review_idx="+review_idx+"&lecture_idx="+lecture_idx;
	}
}
function checkValid() {
    var f = document.writeFm;
    if (f.review_title.value.trim() == "") {
        alert("리뷰 제목을 입력해 주세요.");
        f.review_title.focus();
        return false; 
    }
    if (f.review_content.value.trim() == "") {
        alert("리뷰 내용을 입력해 주세요.");
        f.review_content.focus();
        return false; 
    }
    return true; 
}
function dolike(lecture_idx, user_idx) {
	document.getElementById('like_img').src = "/histudy/lecture-img/like (1).png";
	
}
function dohate(lecture_idx, user_idx) {
	var limg = document.getElementById('like_img');
	var himg = document.getElementById('hate_img');
	if (himg.src.includes('thumb-down (1).png')) {
        himg.src = "/histudy/lecture-img/thumb-down.png";
    } else {
        himg.src = "/histudy/lecture-img/thumb-down (1).png";
        limg.src = "/histudy/lecture-img/like.png";
    }
}
</script>
</head>
<body id="lectureContentPage" onload="load()">
<%@include file="../header.jsp"%>
<div class="header-spacer"></div>
<main>
<section class="LectureContentContainer">
<!-- 유효성 검사 -->
<c:choose>
	<c:when test="${empty sessionScope.user_id}">
	   <h1>로그인이 필요합니다.</h1>
	</c:when>
	<c:otherwise>
		<form name="lectureContent" action="lectureMemo.do">
    <div class="video-memo-container">
        
        <div class="video-area">
	   <video controls="controls" controlsList="nodownload">   
                <source src="${pageContext.request.contextPath}/video/${lectureContent.lecture_file}" type="video/mp4">    
            </video>
        </div>

        <div class="memo-area">
            <input type="hidden" id="lecture_idx" name="lecture_idx" value="${lectureContent.lecture_idx }">
            <input type="hidden" id="user_idx" name="user_idx" value="${sessionScope.user_idx}">
            
            <table class="memo-table">
                <tr>
                    <td><h3>메모 노트</h3></td>
                </tr>
                <tr>
                    <td><input id="note_title" type="text" name="note_title" value="${memo.note_title}" placeholder="제목" style="width:100%;"></td>
                </tr>
                <tr>
                    <td><textarea id="note_content" name="note_content" style="width:100%; height:300px; resize:none;">${memo.note_content}</textarea></td>
                </tr>
                <tr>
                    <td>
                        <input type="button" value="메모 저장" onclick="saveMemo()" style="width:100%; padding:10px; background:#333; color:white; border:none; cursor:pointer;">
                        <div id="memoStatus"></div>
                    </td>
                </tr>
            </table>
        </div>
        
    </div> </form>
	   <div class="lecture-header">
	    
	    <div class="lecture-title-group">
	        <h2>[${scIdx}] ${lectureContent.lecture_name}</h2>
	        <h3>강사: ${lectureContent.lecture_lecturer}</h3>
	    </div>
	
	    <div class="lecture-btn-group">
	        
	        <div class="btn-item">
	            <c:choose>
	                <c:when test="${isLike > 0}">
	                    <a href="reviewLike.do?lecture_idx=${lectureContent.lecture_idx}&user_idx=${sessionScope.user_idx}">
	                        <img id="like_img" src="/histudy/lecture-img/like (1).png" width="30" >
	                    </a>
	                </c:when>
	                <c:otherwise>
	                    <a href="reviewLike.do?lecture_idx=${lectureContent.lecture_idx}&user_idx=${sessionScope.user_idx}">
	                        <img id="like_img" src="/histudy/lecture-img/like.png" width="30"  >
	                    </a>
	                </c:otherwise>
	            </c:choose>
	            <span id="like">${lectureContent.lecture_like}</span>
	        </div>
	
	        <div class="btn-item">
	        	<c:choose>
	        		<c:when test="${isHate>0 }">
			            <a href="reviewHate.do?lecture_idx=${lectureContent.lecture_idx}&user_idx=${sessionScope.user_idx}">
			            	<img id="hate_img" src="/histudy/lecture-img/thumb-down (1).png" width="30">
			            </a>
	        		</c:when>
	        		<c:otherwise>
			            <a href="reviewHate.do?lecture_idx=${lectureContent.lecture_idx}&user_idx=${sessionScope.user_idx}">
			            	<img id="hate_img" src="/histudy/lecture-img/thumb-down.png" width="30">
			            </a>
	        		</c:otherwise>
	        	</c:choose>
	            <span id="hate">${lectureContent.lecture_hate}</span>
	        </div>
	
	    </div>
	</div>
	
	<div class="lecture-body" style="padding: 20px 0;">
	    ${lectureContent.lecture_content}
	</div>
	   	<div class="review-header-wrapper">
	    <span class="header-left">수강평</span>
	    <span class="header-right">
	        <span class="star-icon">★</span>${reviewAvg} 
	        <span class="count-text">(${reviewCount})</span>
	    </span>
	</div>
	
	<div class="review-list-container">
    <div style="text-align: right; margin-bottom: 15px;">
        <input type="button" value="리뷰 남기기" class="write-btn-small" onclick="show(${lectureContent.lecture_idx})">
        <div id="reviewStatus" style="text-align: center; color: red; margin: 10px 0;"></div>
    </div>
    <div id="reviewWrite" class="review-write-form" style="display:none">
	
	<form name="writeFm" action="reviewWrite.do" method="post" onsubmit="return checkValid()">	        <input type="hidden" name="lecture_idx" value="${lectureContent.lecture_idx}">
	        <input type="hidden" name="user_idx" value="${sessionScope.user_idx}">
	        
	        <div class="form-group">
	            <label>평점</label>
	            <select name="review_score">
	                <option value="5">★★★★★</option>
	                <option value="4">★★★★</option>
	                <option value="3">★★★</option>
	                <option value="2">★★</option>
	                <option value="1">★</option>
	            </select>
	        </div>
	        <div class="form-group">
	            <input type="text" name="review_title" placeholder="제목을 입력하세요">
	        </div>
	        <div class="form-group">
	            <textarea name="review_content" placeholder="수강평 내용을 입력하세요"></textarea>
	        </div>
	        <div class="form-actions">
	            <input type="submit" id="reviewbt" name="reviewbt" value="리뷰 작성">
				<input typmypage-img/pimg/="취소" onclick="show(${lectureContent.lecture_idx})" style="background:#ccc;">	        </div>
	    </form>
	</div>
	    <c:choose>
	        <c:when test="${empty reviewList}">
	            <div class="no-review">
	                <p>등록된 리뷰가 없습니다. 첫 리뷰를 작성해 보세요!</p><br>
	            </div>
	        </c:when>
	        <c:otherwise>
	            <div style="text-align: right; margin-bottom: 15px;">
	            </div>
	
	            <c:forEach var="dto" items="${reviewList}">
	                <div class="review-card">
	                    <div class="review-card-header">
	                        <div class="review-user-profile">
	                            <img src="mypage-img/pimg/${userPro}" class="review-user-img">
	                            <div>
	                                <div class="review-user-name">${dto.user_name}</div>
	                                <div class="review-stars">
	                                    <c:choose>
	                                        <c:when test="${dto.review_score == 5}">★★★★★</c:when>
	                                        <c:when test="${dto.review_score == 4}">★★★★</c:when>
	                                        <c:when test="${dto.review_score == 3}">★★★</c:when>
	                                        <c:when test="${dto.review_score == 2}">★★</c:when>
	                                        <c:when test="${dto.review_score == 1}">★</c:when>
	                                    </c:choose>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="review-date">${dto.review_date}</div>
	                    </div>
	
	                    <div class="review-body">
	                        <strong class="review-title">${dto.review_title}</strong>
	                        <p class="review-text">${dto.review_content}</p>
	                    </div>
	
	                    <c:if test="${dto.review_idx == myReview}">
	                        <div class="review-action-btns">
	                            <input type="button" value="수정" onclick="reviewUpdate('${dto.review_idx}', '${dto.review_title}', '${dto.review_content}', '${dto.review_score}')">
	                            <input type="button" value="삭제" onclick="reviewDelete('${dto.review_idx}', '${lectureContent.lecture_idx}')">
	                        </div>
	                    </c:if>
	                </div>
	            </c:forEach>
	        </c:otherwise>
	    </c:choose>
	</div>
	
	</c:otherwise>
</c:choose>
</section>
<div id="modalOverlay">
		<div id="modalContent" class="login-modal-box"></div>
</div>
</main>
<%@include file="../footer.jsp"%>
</body>
</html>