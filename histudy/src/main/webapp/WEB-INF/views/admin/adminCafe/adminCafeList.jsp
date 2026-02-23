
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디 카페 관리자</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp"%>
</head>

<body id="adminCafeListPage">
	<h1>입점 카페 목록</h1>

	<div class="adminCafe__container">
		<div class="adminCafe__header__tools">
			<a href="adminCafeReg.do">
				<button type="button" class="adminCafe__btn">＋ 새 카페 입점등록</button>
			</a>
		</div>

		<table class="adminCafe__table">
			<thead>
				<tr>
					<th style="width: 15%;">번호</th>
					<th>카페 명칭</th>
					<th style="width: 25%;">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cafe" items="${cafeList}">
					<tr>
						<td>${cafe.studycafe_idx}</td>
						<td style="text-align: left; padding-left: 30px;"><a
							href="adminCafeDetail.do?studycafe_idx=${cafe.studycafe_idx}&studycafe_name=${cafe.studycafe_name}"
							class="adminCafe__link"> 🏢 ${cafe.studycafe_name} </a></td>
						<td>
							<button type="button" class="faq__btn__del"
								onclick="deleteCafe('${cafe.studycafe_idx}', '${cafe.studycafe_name}')">카페
								삭제</button>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty cafeList}">
					<tr>
						<td colspan="3" style="padding: 50px; color: #999;">입점된 카페가
							없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<script>
		function deleteCafe(idx, name) {
			if (confirm(" [" + name
					+ "] 카페 폐점 처리 하겠습니까?")) {
				location.href = "adminCafeDelete.do?studycafe_idx=" + idx;
			}
		}
	</script>
</body>
</html>