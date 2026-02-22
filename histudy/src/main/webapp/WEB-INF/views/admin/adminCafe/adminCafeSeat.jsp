<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 좌석 현황</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp" %>
<style>
    /* 배경 및 레이아웃 */
    .viewer-wrap { position: relative; background: #eee; padding: 20px; border-radius: 10px; }
    svg { background: white; border: 1px solid #ccc; display: block; margin: 0 auto; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
    
    /* 좌석 상태별 스타일 */
    .item-seat rect { stroke-width: 1; stroke: #3b82f6; }
    .item-seat.available rect { fill: #60A5FA; }
    .item-seat.occupied rect { fill: #CBD5E1; stroke: #94A3B8; }
    
    .item-room rect { stroke-width: 2; stroke: #6366F1; }
    .item-room.available rect { fill: #EEF2FF; }
    .item-room.occupied rect { fill: #F1F5F9; stroke: #94A3B8; }

    /* 텍스트 스타일 */
    text { font-size: 12px; font-weight: bold; fill: #1e293b; pointer-events: none; }
    .occupied text { fill: #64748b; }

    .status-legend { margin-bottom: 10px; text-align: right; }
    .badge { padding: 4px 8px; border-radius: 4px; font-size: 13px; margin-left: 10px; color: white; }
    .badge.available { background: #60A5FA; }
    .badge.occupied { background: #CBD5E1; color: #64748b; }
</style>
</head>
<body id="adminCafeSeat">
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

<div class="viewer-wrap">
    <h2>${param.studycafe_name} 실시간 좌석 점유 현황</h2>
    <div class="status-legend">
        <span class="badge available">이용가능</span>
        <span class="badge occupied">사용중</span>
    </div>

    <svg id="seatViewer" viewBox="0 0 1200 700">
        <image id="bgImage" href="<c:url value='/img/histudy.jpg'/>" x="0" y="0" width="1200" height="700" style="opacity: 0.4;" />
    </svg>
</div>

<script>
function drawLayout(item) {
    const svgNS = "http://www.w3.org/2000/svg";
    const g = document.createElementNS(svgNS, "g");
    
    const isOccupied = item.isOccupied === true || item.isOccupied === "true";
    const statusClass = isOccupied ? "occupied" : "available";
    g.setAttribute("class", (item.type === 'ROOM' ? "item-room " : "item-seat ") + statusClass);
    
    const rect = document.createElementNS(svgNS, "rect");
    const ix = parseFloat(item.x);
    const iy = parseFloat(item.y);
    const iw = parseFloat(item.width);
    const ih = parseFloat(item.height);

    rect.setAttribute("x", ix); 
    rect.setAttribute("y", iy);
    rect.setAttribute("width", iw); 
    rect.setAttribute("height", ih);
    rect.setAttribute("rx", 4);
    
    const text = document.createElementNS(svgNS, "text");
    text.textContent = item.label;
    text.setAttribute("x", ix + iw / 2);
    text.setAttribute("y", iy + ih / 2);
    text.setAttribute("text-anchor", "middle");
    text.setAttribute("dominant-baseline", "middle");

    g.appendChild(rect);
    g.appendChild(text);

    // 관리자용 툴팁 (마우스 올리면 상태 표시 - 선택사항)
    const title = document.createElementNS(svgNS, "title");
    title.textContent = item.label + (isOccupied ? " (사용 중)" : " (비어 있음)");
    g.appendChild(title);

    document.getElementById("seatViewer").appendChild(g);
}

window.onload = function() {
    <c:forEach var="item" items="${layoutList}">
        drawLayout({
            type: "${item.TYPE != null ? item.TYPE : (item.type != null ? item.type : 'SEAT')}",
            label: "${item.LABEL != null ? item.LABEL : item.label}",
            x: ${item.X != null ? item.X : item.x},
            y: ${item.Y != null ? item.Y : item.y},
            width: ${item.WIDTH != null ? item.WIDTH : item.width},
            height: ${item.HEIGHT != null ? item.HEIGHT : item.height},
            isOccupied: ${ (item.isOccupied == 'Y' || item.ISOCCUPIED == 'Y') ? true : false }
        });
    </c:forEach>
};
</script>
</body>
</html>