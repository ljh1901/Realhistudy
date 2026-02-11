<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 - Admin</title>
<link rel="stylesheet" href="css/admin_layout.css" type="text/css">
<style>
.admin__user__container {
	padding: 30px;
	max-width: 1200px;
	margin: 0 auto;
}

/* 테이블 스타일 커스텀 */
.user__table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

.user__table th {
	background-color: var(- -color-navy);
	color: var(- -color-white);
	padding: 15px;
	font-size: 14px;
}

.user__table td {
	padding: 15px;
	border-bottom: 1px solid #e2e8f0;
	text-align: center;
	font-size: 14px;
	color: #334155;
}

.user__table tr:hover {
	background-color: #f8fafc;
}

/* 등급 배지 */
.role--admin {
	color: #ef4444;
	font-weight: bold;
}

.role--user {
	color: #2563eb;
}

.btn__user__del {
	background-color: #fee2e2;
	color: #ef4444;
	border: none;
	padding: 6px 12px;
	border-radius: 4px;
	cursor: pointer;
	font-weight: 600;
}

.btn__user__del:hover {
	background-color: #ef4444;
	color: #fff;
}
</style>
</head>
<body>
	<div class="admin__user__container">
		<div class="admin__header">
			<h1 class="admin__title">회원 관리</h1>
			<p>
				총 가입 회원: <strong>${userListCount}</strong>명
			</p>
		</div>

		<table class="user__table">
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="u" items="${userList}">
					<tr>
						<td>${u.user_idx}</td>
						<td><strong>${u.user_id}</strong></td>
						<td>${u.user_name}</td>
						<td>${u.user_tel}</td>
						<td>${u.user_email}</td>
						<td>
							<button class="btn__user__del"
								onclick="deleteUser(${u.user_idx}, '${u.user_name}')">탈퇴처리</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="paging" style="margin-top: 20px; text-align: center;">
			${pageStr}</div>
	</div>

	<script>
        function deleteUser(idx, name) {
            if(confirm(name + " 회원을 정말로 강제 탈퇴시키겠습니까?")) {
                location.href = "adminUserDelete.do?user_idx=" + idx;
            }
        }
    </script>
</body>
</html>