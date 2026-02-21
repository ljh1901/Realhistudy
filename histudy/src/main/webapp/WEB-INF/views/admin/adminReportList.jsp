<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 관리</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="adminCheck.jsp" %>
</head>
<body id="adminReportList">

    <div class="repory__container"> <div class="admin__header">
            <h1 class="admin__title">신고 관리</h1>
        </div>

        <div class="inquiry__category">
            <ul class="inquiry__category__list">
                <li class="inquiry__category__item ${empty param.status ? 'active' : ''}" 
                    onclick="location.href='adminReportList.do'">전체</li>
                <li class="inquiry__category__item ${param.status == '대기' ? 'active' : ''}" 
                    onclick="location.href='adminReportList.do?status=대기'">처리대기</li>
                <li class="inquiry__category__item ${param.status == '완료' ? 'active' : ''}" 
                    onclick="location.href='adminReportList.do?status=완료'">처리완료</li>
            </ul>
        </div>

        <form action="adminReportList.do" method="get" class="inquiry__cat">
            <input type="hidden" name="status" value="${param.status}">
        </form>

        <table class="inquiry__list__table">
            <thead>
                <tr>
                    <th width="80">번호</th>
                    <th width="120">신고 유형</th>
                    <th width="180">신고 대상(ID/제목)</th>
                    <th>신고 사유</th>
                    <th width="120">신고자</th>
                    <th width="100">상태</th>
                    <th width="120">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${reportList}">
                    <tr>
                        <td align="center">${r.report_idx}</td>
                        <td align="center">
                            <span class="badge inquiry__cat__item">${r.report_type}</span>
                        </td>
                        <td align="center"><strong>${r.target_name}</strong></td>
                        <td style="text-align: left; padding-left: 15px;">
                            <div style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${r.report_content}">
                                ${r.report_content}
                            </div>
                        </td>
                        <td align="center">${r.reporter_name}</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${r.report_status == '대기'}">
                                    <span class="badge inquiry__status__ok__wait">처리대기</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge inquiry__status__ok">처리완료</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="center">
                            <c:if test="${r.report_status == '대기'}">
                                <button class="inquiry__btn__search" style="padding: 5px 10px; font-size: 12px;"
                                    onclick="resolveReport(${r.report_idx})">처리완료</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty reportList}">
                    <tr>
                        <td colspan="7" align="center" style="padding: 80px 0; color: #64748b;">
                            신고 내역이 없습니다.
                        </td>
                    </tr>
                </c:if>
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