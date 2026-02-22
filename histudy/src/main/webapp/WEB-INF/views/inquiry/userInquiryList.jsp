<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 문의 내역 | Hi, Study</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/inquiryDesign/inquiry.css">
</head>
<body id="userInquiryList">

<%@include file="../header.jsp" %>

    <main class="inquiry__container">
        <div class="inquiry__header">
            <h1 class="inquiry__title">나의 1:1 문의 내역</h1>
            <div class="inquiry__actions">
                <button type="button" class="inquiry__btn__submit" 
                        onclick="location.href='userInquiryWrite.do'">새 문의 작성</button>
            </div>
        </div>

        <table class="inquiry__list__table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>등록일</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${userInquiryList}">
                    <tr>
                        <td align="center">${dto.inquiry_idx}</td>
                        <td align="center">
                            <span class="badge inquiry__cat__item">${dto.inquiry_category_name}</span>
                        </td>
                        <td style="text-align: left;">
                            <a href="userInquiryDetail.do?inquiry_idx=${dto.inquiry_idx}" class="inquiry__link">
                                ${dto.inquiry_title}
                            </a>
                        </td>
                        <td align="center">${dto.inquiry_date}</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${dto.inquiry_status eq '대기'}">	
                                    <span class="badge inquiry__status__wait">답변대기</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge inquiry__status__ok">답변완료</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty userInquiryList}">
                    <tr>
                        <td colspan="5" align="center" class="inquiry__empty">
                            작성하신 문의 내역이 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </main>

<%@include file="../footer.jsp" %>

</body>
</html>