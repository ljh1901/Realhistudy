<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp" %>
</head>
<body id="adminNoticeForm">
    <h1>공지사항 관리</h1>

    <fieldset class="notice__category">
        <ul class="notice__category__list">
            <li class="notice__category__item ${empty selectedCategory or selectedCategory == 0 ? 'active' : ''}" 
                onclick="location.href='adminNotice.do'">전체</li>
            <c:forEach var="cat" items="${categoryList}">
                <li class="notice__category__item ${selectedCategory == cat.notice_category_idx ? 'active' : ''}"
                    onclick="location.href='adminNotice.do?notice_category_idx=${cat.notice_category_idx}'">
                    ${cat.notice_category_name}
                </li>
            </c:forEach>
        </ul>
    </fieldset>

    <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
        <p>총 <strong>${noticeList.size()}</strong>개의 공지사항이 있습니다.</p>
        <button type="button" class="notice__admin__btn" onclick="location.href='adminNoticeWrite.do'">새 공지 등록</button>
    </div>

    <table class="notice__list">
        <thead>
            <tr>
                <th width="10%" style="text-align: center;">번호</th>
                <th width="15%" style="text-align: center;">카테고리</th>
                <th width="50%" style="text-align: center;">제목</th>
                <th width="25%" style="text-align: center;">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dto" items="${noticeList}">
                <tr class="notice__row">
                    <td style="text-align: center;">${dto.notice_idx}</td>
                    <td style="text-align: center;">${dto.notice_category_name}</td>
                    <td>
                        <a href="adminNoticeDetail.do?notice_idx=${dto.notice_idx}" style="text-decoration: none; color: inherit;">
                            ${dto.notice_title}
                        </a>
                    </td>
                    <td style="text-align: center;">
                        <fmt:formatDate value="${dto.notice_writedate}" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty noticeList}">
                <tr>
                    <td colspan="4" style="text-align: center; padding: 30px;">등록된 공지사항이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>