<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자주 묻는 질문 | Hi, Study</title>
    <link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
    <link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
    <link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
    <link rel="stylesheet" type="text/css" href="/histudy/css/inquiryDesign/inquiry.css">
    <style>
        /* FAQ 전용 스타일 추가 */
        .faq__answer { display: none; background-color: #f9f9f9; }
        .faq__question { cursor: pointer; transition: background 0.2s; }
        .faq__question:hover { background-color: #f1f5f9; }
        .faq__category__nav { margin-bottom: 25px; }
        .faq__category__list { display: flex; gap: 10px; list-style: none; padding: 0; overflow-x: auto; }
        .faq__category__item { padding: 8px 16px; background: #eee; border-radius: 20px; cursor: pointer; font-size: 14px; white-space: nowrap; }
        .faq__category__item.active { background: #2563eb; color: #fff; font-weight: bold; }
        .faq__icon { color: #2563eb; font-weight: bold; margin-right: 10px; }
    </style>
</head>
<body id="userFaqList">

<%@include file="../header.jsp" %>

    <main class="inquiry__container">
        <div class="inquiry__header">
            <h1 class="inquiry__title">자주 묻는 질문 (FAQ)</h1>
        </div>

        <nav class="faq__category__nav">
            <ul class="faq__category__list">
                <li class="faq__category__item ${empty param.menu_category_idx ? 'active' : ''}" 
                    onclick="location.href='faqList.do'">전체</li>
                <c:forEach var="cat" items="${categoryList}">
                    <li class="faq__category__item ${param.menu_category_idx == cat.menu_category_idx ? 'active' : ''}" 
                        onclick="location.href='faqList.do?menu_category_idx=${cat.menu_category_idx}'">
                        ${cat.menu_category_name}
                    </li>
                </c:forEach>
            </ul>
        </nav>

        <table class="inquiry__list__table">
            <thead>
                <tr>
                    <th width="10%">번호</th>
                    <th width="15%">카테고리</th>
                    <th width="75%">질문</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="faq" items="${faqList}">
                    <tr class="faq__question" onclick="toggleFaq('${faq.faq_idx}')">
                        <td align="center">${faq.faq_idx}</td>
                        <td align="center">
                            <span class="badge inquiry__cat__item">${faq.menu_category_name}</span>
                        </td>
                        <td style="text-align: left;">
                            <span class="faq__icon">Q.</span> ${faq.faq_title}
                        </td>
                    </tr>
                    <tr id="content_${faq.faq_idx}" class="faq__answer">
                        <td colspan="3" style="padding: 25px 40px; border-bottom: 1px solid #eee;">
                            <div style="display: flex;">
                                <span class="faq__icon" style="color: #ef4444;">A.</span>
                                <div class="faq__content__text" style="line-height: 1.6; color: #555;">
                                    ${faq.faq_content}
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty faqList}">
                    <tr>
                        <td colspan="3" align="center" class="inquiry__empty">등록된 질문이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </main>

<%@include file="../footer.jsp" %>

<script>
function toggleFaq(idx) {
    const contentRow = document.getElementById('content_' + idx);
    const allAnswers = document.querySelectorAll('.faq__answer');
    
    // 선택한 것 외에 다른 답변은 닫고 싶을 때 (옵션)
    /*
    allAnswers.forEach(row => {
        if(row.id !== 'content_' + idx) row.style.display = 'none';
    });
    */

    if (contentRow.style.display === 'none' || contentRow.style.display === '') {
        contentRow.style.display = 'table-row';
    } else {
        contentRow.style.display = 'none';
    }
}
</script>
</body>
</html>