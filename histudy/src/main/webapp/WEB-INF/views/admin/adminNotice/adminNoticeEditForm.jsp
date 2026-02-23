<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp" %>
</head>

<body id="adminNoticeEditForm">
    <h1>공지사항 수정</h1>
    
    <form action="adminNoticeEditOk.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="notice_idx" value="${notice.notice_idx}">

        <table class="notice__edit-form">
            <tr>
                <th>카테고리</th>
                <td>
                    <select name="notice_category_idx" class="notice__input">
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.notice_category_idx}" 
                                ${notice.notice_category_idx == cat.notice_category_idx ? 'selected' : ''}>
                                ${cat.notice_category_name}
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>	
            <tr>
                <th>공지 제목</th>
                <td>
                    <input type="text" name="notice_title" class="notice__input" value="${notice.notice_title}" required>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    <c:if test="${!empty notice.notice_file}">
                        <div style="margin-bottom: 5px; font-size: 0.9rem; color: #666;">
                            기존 파일: <strong>${notice.notice_file}</strong>
                            <input type="hidden" name="old_file" value="${notice.notice_file}">
                        </div>
                    </c:if>
                    <input type="file" name="uploadFile" class="notice__input">
                    <p style="font-size: 0.8rem; color: #999; margin: 5px 0 0 0;">* 새 파일을 선택하면 기존 파일이 교체됩니다.</p>
                </td>
            </tr>
            <tr>
                <th>공지 내용</th>
                <td>
                    <textarea name="notice_content" class="notice__textarea" required>${notice.notice_content}</textarea>
                </td>
            </tr>
        </table>

        <div class="notice__btn__area" style="margin-top: 20px; text-align: center; display: flex; justify-content: center; gap: 10px;">
            <button type="submit" class="notice__admin__btn">수정 완료</button>
            <button type="button" class="notice__admin__btn notice__cancel__btn" onclick="history.back()">취소</button>
        </div>
    </form>
</body>
</html>