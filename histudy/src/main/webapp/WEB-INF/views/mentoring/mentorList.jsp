<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 목록 | Hi, Study</title>
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" href="css/header.css" type="text/css">
<link rel="stylesheet" href="css/mainLayout.css" type="text/css">
<link rel="stylesheet" href="css/footer.css" type="text/css">
<link rel="stylesheet" href="css/mentoringDesign/mentoringList.css" type="text/css">
</head>

<body id="mentoringPage">
<%@ include file="../header.jsp"%>

<!-- ===== 상단 ===== -->
<section class="mentoring-hero">
  <div class="hero-inner">
    <div class="hero-sub">1:1 맞춤 멘토링</div>
    <div class="hero-title">나에게 딱 맞는 멘토를<br/>찾아보세요</div>
    <div class="hero-desc">다양한 분야의 전문가들이 여러분의 성장을 도와드립니다</div>
     </div>
</section>

<section class="mentoring-search">
    <form class="hero-search" method="get" action="mentorList.do" >
      <span style="color:#94a3b8;">🔎</span>
      <input type="text" name="kw" value="${param.kw}" placeholder="멘토 이름, 키워드로 검색!" />
    </form>

   

    <!-- ===== 카테고리 필터 ===== -->
    <div class="mentor-filter">
      <a class="${activeCategory == 0 ? 'active' : ''}" href="mentorList.do">전체</a>
      <a class="${activeCategory == 1 ? 'active' : ''}" href="mentorList.do?sc_idx=1&kw=${param.kw}">코딩</a>
      <a class="${activeCategory == 2 ? 'active' : ''}" href="mentorList.do?sc_idx=2&kw=${param.kw}">언어</a>
      <a class="${activeCategory == 3 ? 'active' : ''}" href="mentorList.do?sc_idx=3&kw=${param.kw}">학업</a>
      <a class="${activeCategory == 4 ? 'active' : ''}" href="mentorList.do?sc_idx=4&kw=${param.kw}">자격증</a>
      <a class="${activeCategory == 5 ? 'active' : ''}" href="mentorList.do?sc_idx=5&kw=${param.kw}">취업</a>
    </div>
 
</section>

<!-- ===== 리스트 ===== -->
<section class="mentoring-list">
<div class="mentor-list-wrap">
  <div class="mentor-grid">
  
    <c:choose>
      <c:when test="${empty mentorList}">
        <p style="grid-column:1/-1; color:#6b7280;">등록된 멘토가 없습니다.</p>
      </c:when>

      <c:otherwise>
        <c:forEach var="m" items="${mentorList}">
          <div class="mentor-card" onclick="openMentorProfile(${m.mentor_idx})" style="position: relative;">
          
          <!-- 하트 아이콘 추가 -->
          <div class="wish-icon-wrap" onclick="event.stopPropagation(); toggleWish(this, ${m.mentor_idx}, '${sessionScope.user_idx}')" style="position: absolute; top: 20px; right: 20px; z-index: 10;">
			    <img src="mypage-img/heart (1).png" class="wish-heart" style="width: 24px; height: 24px; cursor: pointer;" data-status="off">
			</div>
			
			<div class="wish-icon-wrap" data-idx="${m.mentor_idx}" onclick="event.stopPropagation(); toggleWish(this, ${m.mentor_idx}, '${sessionScope.user_idx}')" style="position: absolute; top: 20px; right: 20px; z-index: 10;">
			    <img src="mypage-img/heart (1).png" class="wish-heart" style="width: 24px; height: 24px; cursor: pointer;" data-status="off">
			</div>
          
            <div class="card-top">
              <div class="avatar">
  <c:choose>
    <c:when test="${not empty m.profile_img}">
        <img src="${pageContext.request.contextPath}/mypage-img/pimg/${m.profile_img}" 
             style="width: 100%; height: 100%; border-radius: 12px; object-fit: cover;"
             onerror="this.src='${pageContext.request.contextPath}/main-img/defaultUser.png';">
    </c:when>
    <c:otherwise>
        <div style="width: 100%; height: 100%; border-radius: 12px; background: #f1f5f9; 
                    display: flex; align-items: center; justify-content: center; font-size: 20px;">
            👤
        </div>
    </c:otherwise>
  </c:choose>
</div>
              <div>
                <div class="m-name"><c:out value="${m.user_name}"/></div>
                <div class="m-meta">
                  <c:choose>
                    <c:when test="${m.sc_idx == 1}">코딩</c:when>
                    <c:when test="${m.sc_idx == 2}">언어</c:when>
                    <c:when test="${m.sc_idx == 3}">학업</c:when>
                    <c:when test="${m.sc_idx == 4}">자격증</c:when>
                    <c:when test="${m.sc_idx == 5}">취업</c:when>
                    <c:otherwise>기타</c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>

            <div class="chips">
              <span class="chip">멘토</span>
              <span class="chip">
                <c:choose>
                  <c:when test="${m.sc_idx == 1}">IT/개발</c:when>
                  <c:when test="${m.sc_idx == 2}">언어</c:when>
                  <c:when test="${m.sc_idx == 3}">학업</c:when>
                  <c:when test="${m.sc_idx == 4}">자격증</c:when>
                  <c:when test="${m.sc_idx == 5}">취업</c:when>
                  <c:otherwise>기타</c:otherwise>
                </c:choose>
              </span>
            </div>

            <div class="desc"><c:out value="${m.mentor_intro}"/></div>

            <div class="card-bottom">
              <span class="small">프로필 보기</span>
              <button type="button" class="btn-detail"
                      onclick="event.stopPropagation(); openMentorProfile(${m.mentor_idx});">상세</button>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
  <c:if test="${not empty pageStr}">
  <div class="paging">
    ${pageStr}
  </div>
</c:if>
</div>
</section>
<!-- ===== 하단 멘토 모집 ===== -->
<section class="cta">
  <div class="cta-inner">
    <div class="cta-badge">멘토 모집</div>
    <div class="cta-title">당신의 경험을 나눠주세요</div>
    <div class="cta-desc">전문 지식과 경험을 바탕으로 후배들의 성장을 도와주세요.</div>

    <c:choose>
  <c:when test="${isMentor}">
    <button type="button" class="cta-btn" onclick="location.href='mentoringCreate.do'">멘토링 개설하기</button>
  </c:when>

  <c:otherwise>
  <button type="button" class="cta-btn" onclick="openMentorGuideModal()">멘토 신청하기</button>
  </c:otherwise>
</c:choose>
   <button type="button" class="cta-btn" onclick="location.href='mentoringApplication.do'">멘토링 신청 현황</button>
  </div>
</section>

<%@ include file="mentorProfileModal.jsp" %>

<%@ include file="../footer.jsp" %>

<script>
function openMentorProfile(mentor_idx) {
   location.href = "mentorProfile.do?mentor_idx=" + mentor_idx;
}

function openMentorGuideModal(){
  document.getElementById("mentorGuideModal").style.display = "block";
}
function closeMentorGuideModal(){
  document.getElementById("mentorGuideModal").style.display = "none";
}
function openMentorFormModal(){
  closeMentorGuideModal();
  document.getElementById("mentorFormModal").style.display = "block";
}
function closeMentorFormModal(){
  document.getElementById("mentorFormModal").style.display = "none";
}
function closeByBackdrop(e, modalId){
  if(e.target && e.target.id === modalId){
    document.getElementById(modalId).style.display = "none";
  }
}


  var btns = document.querySelectorAll(".cat-btn");
  for(var i=0;i<btns.length;i++){
    btns[i].className = "cat-btn";
  }
  var target = document.getElementById("cat_"+sc_idx);
  if(target) target.className = "cat-btn active";

  
</script>

<c:if test="${not empty msg}">
  <script>
    alert("${msg}");
  </script>
</c:if>

<c:if test="${param.msg == 'created'}">
  <script>
    alert('멘토링 개설 완료!');
  </script>
</c:if>

<!-- ================찜하기================ -->
<script>
document.addEventListener("DOMContentLoaded",function(){
    const userIdx='${sessionScope.user_idx}';
    if(!userIdx) return;
    let savedWishes=JSON.parse(localStorage.getItem('wish_'+userIdx))||[];
    const wishWraps=document.querySelectorAll('.wish-icon-wrap');
    wishWraps.forEach(wrap=>{
        const mIdx=parseInt(wrap.getAttribute('data-idx'));
        if(savedWishes.includes(mIdx)){
            const img=wrap.querySelector('.wish-heart');
            img.src='mypage-img/heart.png';
            img.setAttribute('data-status','on');
        }
    });
});

function toggleWish(element,targetIdx,userIdx){
    if(!userIdx||userIdx===''){
        alert('로그인이 필요한 기능입니다.');
        return;
    }
    const imgElement=element.querySelector('.wish-heart');
    const currentStatus=imgElement.getAttribute('data-status');
    const requestData={
        w_target_type:'멘토링',
        w_target_idx:targetIdx,
        user_idx:userIdx
    };
    const url=(currentStatus==='off')?'insertWish.do':'deleteWish.do';
    fetch(url,{
        method:'POST',
        headers:{
            'Content-Type':'application/json'
        },
        body:JSON.stringify(requestData)
    })
    .then(response=>response.json())
    .then(data=>{
        if(data.result==='success'){
            let savedWishes=JSON.parse(localStorage.getItem('wish_'+userIdx))||[];
            if(currentStatus==='off'){
                imgElement.src='mypage-img/heart.png';
                imgElement.setAttribute('data-status','on');
                if(!savedWishes.includes(targetIdx)){
                    savedWishes.push(targetIdx);
                    localStorage.setItem('wish_'+userIdx,JSON.stringify(savedWishes));
                }
            }else{
                imgElement.src='mypage-img/heart (1).png';
                imgElement.setAttribute('data-status','off');
                savedWishes=savedWishes.filter(id=>id!==targetIdx);
                localStorage.setItem('wish_'+userIdx,JSON.stringify(savedWishes));
            }
        }else{
            alert('오류발생~');
        }
    })
    .catch(error=>{
        console.error('Error:',error);
    });
}
</script>
</body>
</html>
