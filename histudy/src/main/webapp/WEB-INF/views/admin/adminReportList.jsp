<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 관리</title>
<link rel="stylesheet" href="css/admin_layout.css" type="text/css">
<style>
    .admin__report__container { padding: 30px; max-width: 1200px; margin: 0 auto; }
    .status--pending { color: #f59e0b; font-weight: bold; } /* 대기중 */
    .status--resolved { color: #10b981; } /* 처리완료 */
    .report__reason { text-align: left !important; max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
</style>
</head>
<body>
    <div class="admin__report__container">
        <div class="admin__header">
            <h1 class="admin__title">신고 관리</h1>
        </div>

        <table class="user__table"> <thead>
                <tr>
                    <th>번호</th>
                    <th>신고 유형</th>
                    <th>신고 대상(ID/제목)</th>
                    <th>신고 사유</th>
                    <th>신고자</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${reportList}">
                    <tr>
                        <td>${r.report_idx}</td>
                        <td>${r.report_type}</td> <td><strong>${r.target_name}</strong></td>
                        <td class="report__reason">${r.report_content}</td>
                        <td>${r.reporter_name}</td>
                        <td>
                            <span class="${r.report_status == '대기' ? 'status--pending' : 'status--resolved'}">
                                ${r.report_status}
                            </span>
                        </td>
                        <td>
                            <button class="btn__view" onclick="viewReport(${r.report_idx})">상세보기</button>
                            <c:if test="${r.report_status == '대기'}">
                                <button class="btn__user__del" onclick="resolveReport(${r.report_idx})">처리완료</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function resolveReport(idx) {
            if(confirm("해당 신고를 처리 완료로 변경하시겠습니까?")) {
                location.href = "adminReportResolve.do?report_idx=" + idx;
            }
        }
    </script>
</body>
</html>