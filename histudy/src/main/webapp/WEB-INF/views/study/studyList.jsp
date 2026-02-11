<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/studyDesign/studyList.css">
</head>
<body id="studyPage">
<%@ include file="../header.jsp" %>
   <main>
      <section class="studyList">
         <div class="studyList__container">
            <div class="studyList__container__top">
               <p>홈 &nbsp; > &nbsp;스터디 목록</p>
            </div>
            <h2 class="studyList__title">스터디 찾기</h2>   
            <p class="studyList__sub">함께 성장할 스터디를 찾아보세요</p>
            <div class="studyList__Find">
               <img src="/histudy/main-img/search.png">
               <input type="text" name="studyFind" placeholder="스터디 제목이나 강사명으로 검색하세요">
            </div>
         </div>
      </section>
      <section class="studyCategory">
         <div class="studyCategory__container max-container">
            <div class="studyCategory__left">
               <p>카테고리</p>
               <div class="studyCategory__left__list">
					<a href="studyList.do?cp=1&sc_idx=0" class="cate ${param.sc_idx=='0'?'active':''}">전체</a>
					<a href="studyList.do?cp=1&sc_idx=1" class="cate ${param.sc_idx=='1'?'active':''}">코딩</a>
					<a href="studyList.do?cp=1&sc_idx=2" class="cate ${param.sc_idx=='2'?'active':''}">언어</a>
					<a href="studyList.do?cp=1&sc_idx=3" class="cate ${param.sc_idx=='3'?'active':''}">학업</a>
					<a href="studyList.do?cp=1&sc_idx=4" class="cate ${param.sc_idx=='4'?'active':''}">자격증</a>
					<a href="studyList.do?cp=1&sc_idx=5" class="cate ${param.sc_idx=='5'?'active':''}">취업</a>
               </div>
               <p>총 <span>${studyListCount}</span>개의 스터디</p>
            </div>
         </div>
      </section>
      <section class="studyGrid">
         <c:if test="${!empty requestScope.studyList}">
            <c:forEach var="dto" items="${requestScope.studyList}">
            	<a href="studyContent.do?study_idx=${dto.study_idx}">
	                <article class="studyCard">
	                   <div class="studyCard__thumb">
	                     <img src="/histudy/study-img/${!empty dto.study_upload_img ? dto.study_upload_img : 'groupStudy.png'}" alt="스터디 이미지">
	                   </div>
	                   <div class="studyCard__content">
	                     <div class="studyCard__tags">
	                        <span class="tag">${dto.sc_name}</span>
	                     </div>
	                        <h3 class="studyCard__title">${dto.study_title}</h3>
	                     <div class="studyCard__rating">
	                       <div class="stars">
	                         ★★★★☆ <span style="color:black; font-weight:bold">4.9 (24)</span>
	                       </div>
	                    </div>
	                        <ul class="studyCard__meta">
	                          <li><img src="/histudy/main-img/user.png">${dto.user_name}</li>
	                             <li><img src="/histudy/main-img/personnel.png">${dto.study_current_members }/${dto.study_max_members}명</li>
	                          <li><img src="/histudy/main-img/clock.png">마감일 - ${dto.study_end_date.substring(0, 10)}</li>
	                          <li><img src="/histudy/main-img/location.png">${empty dto.study_addr?'장소가 지정되지 않았어요':dto.study_addr }</li>
	                       </ul>
	                   </div>
	                </article>
                </a>
            </c:forEach>
         </c:if>
         <c:if test="${empty requestScope.studyList}">
            <div id="notStudy">
               <h2>개설된 스터디가 없습니다.</h2>
            </div>
         </c:if>
      </section>
      <div class="paging">
         ${pageStr}
      </div>
         <section class="studyCreate">
            <form name="studyCreateForm" action="studyCreateForm.do">
               <div class="studyCreateContainer">
                  <h1>원하는 스터디를 찾지 못하셨나요?</h1>
                  <p>직접 스터디를 개설하고 함께할 멤버를 모집해보세요</p>
                  <input type="submit" value="스터디 개설하기">
               </div>
            </form>
         </section>
   </main>
   <%@include file="../footer.jsp" %>
</body>
</html>
