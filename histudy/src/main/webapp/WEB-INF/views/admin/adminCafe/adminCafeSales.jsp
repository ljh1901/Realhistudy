<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 통계 - ${param.studycafe_name}</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%@ include file="../adminCheck.jsp" %>
</head>

<body id="adminCafeSales">
    <fieldset>
        <legend><strong>관리 중인 카페 : ${param.studycafe_name}</strong></legend>
        <div class="adminCafe">	
            <ul class="adminCafe__menu">
                <li class="adminCafe__menu__item"><a href="adminCafeSales.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">총 매출확인</a></li>
                <li class="adminCafe__menu__item"><a href="adminCafeSeat.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">스터디카페 현황 보기</a></li>
                <li class="adminCafe__menu__item"><a href="studycafeEditor.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">좌석등록</a></li>
                <li class="adminCafe__menu__item"><a href="adminCafePrice.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">요금제 등록</a></li>
            </ul>
        </div>
    </fieldset>

    <h3>총 매출 확인</h3>
    <fieldset>
        <div>
            <ul class="adminCafeSales__menu">
                <li><a href="adminCafeSales.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}&type=day">일별</a>|</li>
                <li><a href="adminCafeSales.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}&type=month">월별</a>|</li>
                <li><a href="adminCafeSales.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}&type=total">누적</a></li>
            </ul>
        </div>
        <legend>기간 조회</legend>
        <form action="adminCafeSales.do" method="get">
            <input type="hidden" name="studycafe_idx" value="${param.studycafe_idx}"> 
            <input type="hidden" name="studycafe_name" value="${param.studycafe_name}"> 
            <input type="hidden" name="type" value="${empty param.type ? 'day' : param.type}">

            <input type="date" name="startDate" value="${param.startDate}">
            ~ <input type="date" name="endDate" value="${param.endDate}">
            <button type="submit">조회</button>
        </form>
    </fieldset>

    <div class="chart__container">
        <canvas id="salesChart"></canvas>
    </div>

    <div class="adminCafe__container" style="margin-top: 50px;">
        <h3 class="admin__title">상세 결제 내역</h3>
        <table class="adminCafe__table">
            <thead>
                <tr>
                    <th width="100">결제번호</th>
                    <th width="180">구매자 (ID)</th>
                    <th>이용권 정보</th>
                    <th width="150">결제 금액</th>
                    <th width="200">결제 일시</th>
                    <th width="120">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pay" items="${paymentList}">
                    <tr>
                        <td>${pay.PAY_IDX}</td>
                        <td>
                            <strong>${pay.USER_NAME}</strong> 
                            <span style="color: #94a3b8; font-size: 0.85rem;">(${pay.USER_ID})</span>
                        </td>
                        <td>
                            <span class="adminCafe__badge" style="background: #eef2ff; color: #4f46e5;">
                                ${pay.TICKET_NAME}
                            </span>
                        </td>
                        <td style="text-align: right; padding-right: 25px;">
                            <span style="font-weight: bold; color: #1e293b;">
                                <fmt:formatNumber value="${pay.TOTALAMOUNT}" pattern="#,###"/>원
                            </span>
                        </td>
                        <td style="color: #64748b;">${pay.PAY_DATE}</td>
                        <td>
                            <span class="adminCafe__badge adminCafe__status--ok">결제완료</span>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty paymentList}">
                    <tr>
                        <td colspan="6" style="padding: 80px 0; color: #94a3b8; text-align: center;">
                            해당 지점의 결제 내역이 존재하지 않습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <script>
    let labelName = '일별 매출액 (원)';
    <c:if test="${param.type == 'month'}">labelName = '월별 매출액 (원)';</c:if>
    <c:if test="${param.type == 'total'}">labelName = '누적 총 매출액 (원)';</c:if>

    const ctx = document.getElementById('salesChart').getContext('2d');
    const labels = [
        <c:forEach var="item" items="${salesData}">
            '${item.SALES_DATE}',
        </c:forEach>
    ];
    
    const data = [
        <c:forEach var="item" items="${salesData}">
            ${item.TOTAL_AMOUNT},
        </c:forEach>
    ];

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: labelName,
                data: data,
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: { 
                y: { 
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    }
                } 
            }
        }
    });
</script>
</body>
</html>