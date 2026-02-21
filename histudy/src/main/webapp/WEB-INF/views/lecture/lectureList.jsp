<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" href="css/lectureDesign/lectureList.css" type="text/css">
</head>
<body id="lectureListPage" class="lectureList">
<%@include file="../header.jsp"%>
<main>
	<section class="lectureListContainer">
   <form name="lectureFm">
   <section class="top">
   <fieldset>
	   <p>Hi, Study 프리미엄 멤버십 29,000원 / <del>50,000원</del></p>
	   <p>분야별 전문 강사의 강의 제공 !! 스터디 카페 이용권 할인 혜택 !!</p>
   </fieldset>
   </section>
   <c:set var="count" value="0" />
   <table>
       <tr>
       <c:if test="${empty lectureLists }">
       <td>등록된 강의가 없습니다.</td>
       </c:if>
       <c:forEach var="dto" items="${lectureLists}">
		    <td>
		        <a href="lectureContent.do?lecture_idx=${dto.lecture_idx}" class="lecture-card">
		            <div class="video-box">
		            	<video preload="metadata">
		                    <source src="/histudy/video/${dto.lecture_file}" type="video/mp4">
		                </video>
		            </div>
		            <div class="info-box">
		                <p class="lecture-title">[${dto.sc_name}] ${dto.lecture_name}</p>
		                <p class="lecturer-name">${dto.lecture_lecturer}</p>
		                ★${dto.review_avg }(${dto.review_count })
		            </div>
		        </a>
		    </td>
		    
		    <c:set var="count" value="${count + 1}" />
		    <c:if test="${count % 4 == 0}">
		        </tr><tr>
		    </c:if>
		</c:forEach>
       </tr>
       <tfoot>
       		<tr>
       			<td colspan="4">
      	 		<div>${pageStr }</div>
      	 		</td>
      	 	</tr>
       </tfoot>
   </table>
   </form>
   </section>
   <form name="membershipFm" action="membership.do">
   <section class="membership">
   <br>
   <br>
   <div>지금 바로 학습을 시작하세요</div>
   <br>
   <p>${lectureCount }개의 강의와 ${userCount }명의 수강생들이 함께하고 있습니다</p>
   <br>
   <br>
   <c:if test="${sessionScope.membership!='premium'}">
   <input type="submit" name="membership_go" value="멤버십 가입하기">
   </c:if>
   <br>
   <br>
   </section>
   </form>
   
</main>
<%@include file="../footer.jsp"%>
</body>
</html>
