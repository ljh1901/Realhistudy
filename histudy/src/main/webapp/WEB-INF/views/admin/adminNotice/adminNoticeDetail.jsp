<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세조회</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp" %>
</head>

<body id="adminNoticeDetail">
    <h1>공지사항 상세조회</h1>

    <table class="notice__detail-form">
        <tr>
            <th>카테고리</th>
            <td>${notice.notice_category_name}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td><strong>${notice.notice_title}</strong></td>
        </tr>
        <tr>
            <th>작성일</th>
            <td><fmt:formatDate value="${notice.notice_writedate}" pattern="yyyy-MM-dd HH:mm"/></td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td>
                <c:choose>
                    <c:when test="${not empty notice.notice_file}">
                        <a href="#=${notice.notice_file}" style="color: var(--color-navy); font-weight: bold;">
                            ${notice.notice_file}
                        </a>
                    </c:when>
                    <c:otherwise>첨부파일 없음</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>공지 내용</th>
            <td>
               <div class="notice__content__text" style="min-height: 300px; padding: 10px;">${notice.notice_content}</div>
            </td>
        </tr>
    </table>

    <div class="notice__btn__area" style="margin-top: 20px; text-align: center; display: flex; justify-content: center; gap: 10px;">
        <button type="button" class="notice__admin__btn" 
                onclick="location.href='adminNoticeEdit.do?notice_idx=${notice.notice_idx}'">수정하기</button>
        
        <button type="button" class="notice__admin__btn notice__btn__del" style="font-weight: bold;"
                onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='adminNoticeDelete.do?notice_idx=${notice.notice_idx}'">삭제하기</button>
        
        <button type="button" class="notice__admin__btn notice__cancel__btn" 
                onclick="location.href='adminNotice.do'">목록으로</button>
    </div>
</body>
</html>