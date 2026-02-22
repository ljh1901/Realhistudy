<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>1:1 문의하기 | Hi, Study</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/inquiryDesign/inquiry.css">
</head>
<body id="userInquiryWrite">

<%@include file="../header.jsp" %>

    <main class="inquiry__container">
        <div class="inquiry__header">
            <h1 class="inquiry__title">1:1 문의 작성</h1>
        </div>

        <form action="userInquiryWriteOk.do" method="post" class="inquiry__form">
            <table class="inquiry__write__table">
                <tbody>
                    <tr>
                        <th>카테고리</th>
                        <td>
                            <select name="inquiry_category_idx" class="inquiry__select__field" required>
                                <option value="" disabled selected>선택해주세요</option>
                                <c:forEach var="cat" items="${categoryList}">
                                    <option value="${cat.inquiry_category_idx}">${cat.inquiry_category_name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <th>작성자</th>
                        <td>
                            <%-- 실제로 서버로 넘길때는 ID가 필요하므로 hidden input을 쓰거나 세션에서 처리하세요 --%>
                            <input type="text" value="${sessionScope.user_name} (${sessionScope.user_id})" class="inquiry__input__field readonly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td colspan="3">
                            <input type="text" name="inquiry_title" class="inquiry__input__field" placeholder="제목을 입력해 주세요." required>
                        </td>
                    </tr>
                    <tr>
                        <th>문의 내용</th>
                        <td colspan="3">
                            <textarea name="inquiry_content" class="inquiry__textarea" placeholder="문의 내용을 상세히 입력해 주세요. (문의하신 내용은 수정이 불가능하므로 신중히 작성해 주세요.)" required></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="inquiry__footer__btn">
                <button type="submit" class="inquiry__btn__submit">문의 등록</button>
                <button type="button" class="inquiry__btn__cancel" onclick="location.href='userInquiryList.do'">취소</button>
            </div>
        </form>
    </main>

<%@include file="../footer.jsp" %>

</body>
</html>