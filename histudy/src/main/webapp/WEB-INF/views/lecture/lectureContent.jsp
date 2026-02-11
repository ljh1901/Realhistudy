<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" href="css/header.css" type="text/css">
<link rel="stylesheet" href="css/footer.css" type="text/css">
<link rel="stylesheet" href="css/lectureDesign/lectureContent.css" type="text/css">
<script>
var limg = document.getElementById('like_img');
var himg = document.getElementById('hate_img');
function load(){
	var message="${msg}";
    if(message!="") {
		alert(message);
		location.href="index.do";
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
function dolike(lecture_idx, user_idx) {
	document.getElementById('like_img').src = "/histudy/lecture-img/like (1).png";
	
}
function dohate(lecture_idx, user_idx) {
	himg = document.getElementById('hate_img');
	if (himg.src.includes('thumb-down (1).png')) {
        himg.src = "/histudy/lecture-img/thumb-down.png";
    } else {
        himg.src = "/histudy/lecture-img/thumb-down (1).png";
        img.src = "/histudy/lecture-img/like.png";
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
	<c:when test="${empty sessionScope.user_idx}">
		
	   <h1>프리미엄 회원만 볼 수 있는 컨텐츠입니다.</h1>
	   <h1>프리미엄 회원만 볼 수 있는 컨텐츠입니다.</h1>
	   <h1>프리미엄 회원만 볼 수 있는 컨텐츠입니다.</h1>
		<h2><a href="membership.do">멤버십 가입하러가기</a></h2>
	</c:when>
	<c:otherwise>
		<form name="lectureContent" action="lectureMemo.do">
    <div class="video-memo-container">
        
        <div class="video-area">
	   <video width="70%" controls="controls" controlsList="nodownload">   
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
                    <td><input id="note_title" type="text" name="note_title" value="${memo.note_title}" placeholder="제목" style="width:95%;"></td>
                </tr>
                <tr>
                    <td><textarea id="note_content" name="note_content" style="width:95%; height:300px; resize:none;">${memo.note_content}</textarea></td>
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
	        <h2>${lectureContent.lecture_name}</h2>
	        <h3>강사: ${lectureContent.lecture_lecturer}</h3>
	    </div>
	
	    <div class="lecture-btn-group">
	        
	        <div class="btn-item">
	            <c:choose>
	                <c:when test="${isLike > 0}">
	                    <a href="reviewLike.do?lecture_idx=${lectureContent.lecture_idx}&user_idx=${sessionScope.user_idx}">
	                        <img id="like_img" src="/histudy/lecture-img/like (1).png" width="30" alt="좋아요 취소">
	                    </a>
	                </c:when>
	                <c:otherwise>
	                    <a href="reviewLike.do?lecture_idx=${lectureContent.lecture_idx}&user_idx=${sessionScope.user_idx}">
	                        <img id="like_img" src="/histudy/lecture-img/like.png" width="30" alt="좋아요 하기">
	                    </a>
	                </c:otherwise>
	            </c:choose>
	            <span id="like">${lectureContent.lecture_like}</span>
	        </div>
	
	        <div class="btn-item">
	            <img id="hate_img" src="/histudy/lecture-img/thumb-down.png" width="30" onclick="dohate()" style="cursor:pointer;">
	            <span id="hate">${lectureContent.lecture_hate}</span>
	        </div>
	
	    </div>
	</div>
	
	<div class="lecture-body" style="padding: 20px 0;">
	    ${lectureContent.lecture_content}
	</div>
	   	<table>
	   		<tr>	
	   			<th>수강평</th>
	   		</tr>
	   		<c:if test="${empty reviewList }">
	   		<tr>
	   			<td>등록된 리뷰가 없습니다. 리뷰를 작성해 보세요!</td>
	       </tr>
	       </c:if>
	       <c:forEach var="dto" items="${reviewList}">
	       <tr>
	       		<td><img src="${userPro}" width="20">${userName }</td>
	       </tr>
	       <tr>
	       		<td>
			    <c:choose>
			        <c:when test="${dto.review_score == 5}">★★★★★</c:when>
			        <c:when test="${dto.review_score == 4}">★★★★</c:when>
			        <c:when test="${dto.review_score == 3}">★★★</c:when>
			        <c:when test="${dto.review_score == 2}">★★</c:when>
			        <c:when test="${dto.review_score == 1}">★</c:when>
			    </c:choose>
			    ${dto.review_date}
			       	${dto.review_date }
			    </td>
	       </tr>
	       <tr>
			    <td>
			    	제목: ${scIdx }${dto.review_title }
			    </td>
			</tr>
			<tr>
			    <td>
			    	${dto.review_content }
			    </td>
			</tr>
			<tr>	 
				<td>
				<c:choose>
					<c:when test="${dto.review_idx == myReview }">
						<input type="button" value="수정" 
							onclick="reviewUpdate('${dto.review_idx}', '${dto.review_title}', '${dto.review_content}', '${dto.review_score}')"> 
						<input type="button" value="삭제"
							onclick="reviewDelete('${dto.review_idx }','${dto.lecture_idx }')"> 
					</c:when>
					<c:otherwise>
						<input type="button" value="답글">
					</c:otherwise>
				</c:choose>
				
				</td>
			</tr>
			</c:forEach>
	   </table>
	   
	   <input type="button" value="리뷰 남기기" onclick="show(${lectureContent.lecture_idx})">
	   <div id="reviewStatus"></div>
	   <div id="reviewWrite" style="display:none">
		<form name="writeFm" action="reviewWrite.do" method="post">
	   <table>
	   	<tr>
	   		<td>평점:<select name="review_score">
	   			<option value="5">★★★★★</option>
	   			<option value="4">★★★★</option>
	   			<option value="3">★★★</option>
	   			<option value="2">★★</option>
	   			<option value="1">★</option>
	   		</select></td>
	   	</tr>
	   	<input type="hidden" name="lecture_idx" value="${lectureContent.lecture_idx}">
        <input type="hidden" name="user_idx" value="${sessionScope.user_idx}">
	   	<tr>
	   		<td>제목:<input type="text" name="review_title"></td>
	   	</tr>
	   	<tr>
	   		<td><textarea rows="10" cols="90" name="review_content"></textarea>
	   	</tr>
	   	<tr>
	   		<td><input type="submit" name="reviewbt" value="리뷰 작성" onclick="reviewWrite()"></td>
	   	</tr>
	   </table>
		</form>
	   </div>
	</c:otherwise>
</c:choose>
</section>
</main>
<%@include file="../footer.jsp"%>
</body>
</html>