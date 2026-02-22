<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 상세 내역 | Hi, Study</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/inquiryDesign/inquiry.css">
</head>
<body id="userInquiryDetail">

<%@include file="../header.jsp" %>

    <main class="inquiry__container">
        <div class="inquiry__header">
            <h1 class="inquiry__title">문의 상세 내역</h1>
            <div class="inquiry__status__badge">
                <c:choose>
                    <c:when test="${dto.inquiry_status eq '대기'}">
                        <span class="badge inquiry__status__wait">답변대기</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge inquiry__status__ok">답변완료</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <table class="inquiry__write__table">
            <tbody>
                <tr>
                    <th>카테고리</th>
                    <td>${dto.inquiry_category_name}</td>
                    <th>등록일</th>
                    <td>${dto.inquiry_date}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td colspan="3" class="inquiry__detail__title">${dto.inquiry_title}</td>
                </tr>
                <tr>
                    <th>문의 내용</th>
                    <td colspan="3">
                        <div class="inquiry__detail__content">${dto.inquiry_content}</div>
                    </td>
                </tr>
            </tbody>
        </table>

        <c:if test="${not empty dto.inquiry_reply}">
            <div class="inquiry__reply__section">
                <div class="inquiry__reply__header">
                    <img src="${pageContext.request.contextPath}/main-img/logo1.png" width="24" alt="logo">
                    <h3>Hi, Study 답변</h3>
                </div>
                <div class="inquiry__reply__content">
                    ${dto.inquiry_reply}
                </div>
            </div>
        </c:if>

        <div class="inquiry__footer__btn">
            <button type="button" class="inquiry__btn__cancel" onclick="location.href='userInquiryList.do'">목록으로</button>
            
            <c:if test="${empty dto.inquiry_reply}">
                <button type="button" class="inquiry__btn__delete" 
                        onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='userInquiryDelete.do?inquiry_idx=${dto.inquiry_idx}'">
                    삭제하기
                </button>
            </c:if>
        </div>
    </main>

<%@include file="../footer.jsp" %>

</body>
</html>