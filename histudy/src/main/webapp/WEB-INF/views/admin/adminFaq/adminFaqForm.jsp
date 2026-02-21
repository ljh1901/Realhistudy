<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp" %>
</head>

<body id="adminFaqForm">
	<h1>자주 묻는 질문 관리</h1>

	<fieldset class="faq__category">
		<ul class="faq__category__list">
			<li
				class="faq__category__item ${empty param.menu_category_idx ? 'active' : ''}"
				onclick="location.href='adminFaqForm.do'">전체</li>
			<c:forEach var="cat" items="${categoryList}">
				<li
					class="faq__category__item ${param.menu_category_idx == cat.menu_category_idx ? 'active' : ''}"
					onclick="location.href='adminFaqForm.do?menu_category_idx=${cat.menu_category_idx}'">
					${cat.menu_category_name}</li>
			</c:forEach>
		</ul>
	</fieldset>

	<div
		style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
		<p>
			총 <strong>${faqList.size()}</strong>개의 질문이 있습니다.
		</p>
		<button type="button" class="faq__admin__btn"
			onclick="location.href='adminFaqWrite.do'">새 질문 등록</button>
	</div>

	<table class="faq__list">
		<thead>
			<tr>
				<th width="10%" style="text-align: center;">번호</th>
				<th width="15%" style="text-align: center;">카테고리</th>
				<th width="50%" style="text-align: center;">질문 내용</th>
				<th width="25%" style="text-align: center;">관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="faq" items="${faqList}">
				<tr class="faq__row" onclick="toggleFaq('${faq.faq_idx}')"
					style="cursor: pointer;">
					<td style="text-align: center;">${faq.faq_idx}</td>
					<td style="text-align: center;">${faq.menu_category_name}</td>
					<td style="text-align: left;">${faq.faq_title}</td>
					<td style="text-align: center;">
						<button class="faq__btn__edit"
							onclick="event.stopPropagation(); location.href='adminFaqEdit.do?faq_idx=${faq.faq_idx}'">수정</button>
						<button class="faq__btn__del"
							onclick="event.stopPropagation(); if(confirm('삭제하시겠습니까?')) location.href='adminFaqDelete.do?faq_idx=${faq.faq_idx}'">삭제</button>
					</td>
				</tr>

				<tr id="content_${faq.faq_idx}" class="faq__content__row"
					style="display: none; background-color: #fcfcfc;">
					<td colspan="4"
						style="text-align: left; padding: 20px; border-bottom: 1px solid #ddd;">
						<div style="font-weight: bold; margin-bottom: 10px; color: #555;">[답변]</div>
						<div class="faq__content__text">${faq.faq_content}</div>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty faqList}">
				<tr>
					<td colspan="4" style="text-align: center; padding: 30px;">등록된
						질문이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
<script>
function toggleFaq(idx) {
    const contentRow = document.getElementById('content_' + idx);
    
    if (contentRow.style.display === 'none') {
        contentRow.style.display = 'table-row';
    } else {
        contentRow.style.display = 'none';
    }
}
</script>
</html>