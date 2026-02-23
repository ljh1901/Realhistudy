<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 상세 관리</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp"%>
</head>

<body id="adminInquiryDetail">

	<div class="adminInquiry">
		<h2 style="margin-bottom: 20px; color: #1a202c;">문의사항 상세 보기</h2>

		<table class="inquiry__table">
			<tr>
				<th>카테고리</th>
				<td>${dto.inquiry_category_name}</td>
				<th>작성일</th>
				<td>${dto.inquiry_date}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td colspan="3">${dto.user_name}(유저 아이디 : ${dto.user_id})</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${dto.inquiry_title}</td>
			</tr>
			<tr>
				<th>문의 내용</th>
				<td colspan="3" class="inquiry__content">${dto.inquiry_content}</td>
			</tr>
			<c:if test="${not empty dto.inquiry_reply_date}">
				<tr>
					<th>최종 답변일</th>
					<td colspan="3">${dto.inquiry_reply_date}</td>
				</tr>
			</c:if>
		</table>

		<div class="inquiry__reply">
			<h3>관리자 답변 작성</h3>
			<form action="adminInquiryReply.do" method="post">
				<input type="hidden" name="inquiry_idx" value="${dto.inquiry_idx}">

				<textarea class="inquiry__textarea" name="inquiry_reply"
					placeholder="사용자에게 전달할 답변 내용을 입력해 주세요.">${dto.inquiry_reply}</textarea>

				<div class="inquiry__btn">
					<button type="submit" class="inquiry__main__btn inquiry__btn__submit">답변
						등록/수정</button>
					<button type="button" class="inquiry__main__btn inquiry__btn__list"
						onclick="location.href='adminInquiryList.do'">목록으로</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>