<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>StudyCafe Editor - ${param.studycafe_name}</title>
<link rel="stylesheet" href="css/admin_layout.css" type="text/css">
<style>
    html, body { height: 100%; margin: 0; padding: 0; overflow: hidden; }
    body { background: #F1F5F9; font-family: 'Pretendard', Arial, sans-serif; display: flex; flex-direction: column; }

    .editor-wrap { 
        width: 98%; max-width: 1400px; margin: 0 auto; height: 100vh;
        display: flex; flex-direction: column; padding: 10px 0; box-sizing: border-box;
    }
    .toolbar { 
        background: white; padding: 8px 16px; border-radius: 8px; margin-bottom: 8px; 
        box-shadow: 0 2px 5px rgba(0,0,0,0.05); display: flex; 
        justify-content: space-between; align-items: center; flex-shrink: 0;
    }

    .tool-group button {
        padding: 6px 12px; margin-right: 4px; border: none;
        background: #2563EB; color: white; border-radius: 6px; cursor: pointer; font-size: 13px;
    }

    .save-btn {
        padding: 6px 18px; border: none; background: #10B981;
        color: white; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 13px;
    }

    svg { 
        background: white; width: 100%; flex-grow: 1; min-height: 0; 
        box-shadow: 0 4px 12px rgba(0,0,0,0.08); border-radius: 8px; 
        border: 1px solid #E2E8F0; display: block;
        /* 배경 격자를 더 촘촘하게(15px) 변경하여 정렬 보조 */
        background-image: 
            linear-gradient(to right, #f8fafc 1px, transparent 1px),
            linear-gradient(to bottom, #f8fafc 1px, transparent 1px);
        background-size: 15px 15px;
    }

    .selected rect { stroke: #2563EB; stroke-width: 3; }
    .handle { fill: white; stroke: #2563EB; stroke-width: 2; cursor: nwse-resize; }
    text { font-size: 11px; font-weight: bold; pointer-events: none; user-select: none; fill: #1E293B; }
</style>
</head>
<body>

<div class="editor-wrap">
    <fieldset>
        <legend><strong>관리 중인 카페 : ${param.studycafe_name}</strong></legend>
        <div class="adminCafe">
            <ul class="adminCafe__menu">
                <li class="adminCafe__menu__item"><a href="adminCafeSales.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">총 매출확인</a></li>
                <li class="adminCafe__menu__item"><a href="adminCafeSeat.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">스터디카페 현황 보기</a></li>
                <li class="adminCafe__menu__item"><a href="adminCafeInquiryList.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">스터디카페 문의</a></li>
                <li class="adminCafe__menu__item"><a href="studycafeEditor.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">좌석등록</a></li>
                <li class="adminCafe__menu__item"><a href="adminCafePrice.do?studycafe_idx=${param.studycafe_idx}&studycafe_name=${param.studycafe_name}">요금제 등록</a></li>
            </ul>
        </div>
    </fieldset>

    <div class="toolbar">
        <div class="tool-group">
            <button onclick="tool='seat'">좌석 추가</button>
            <button onclick="tool='room'">스터디룸 추가</button>
        </div>
        <div>
            <span style="margin-right:20px; font-size:14px; color:#64748b;">카페: <strong>${param.studycafe_name}</strong></span>
            <button class="save-btn" onclick="saveLayout()">배치 저장하기</button>
        </div>
    </div>

    <svg id="editor" viewBox="0 0 1200 700">
        <image id="bgImage" href="<c:url value='/img/histudy.jpg'/>" x="0" y="0" width="1200" height="700" preserveAspectRatio="none" style="opacity: 0.6; pointer-events: none;" />
    </svg>
</div>

<script>
const NS = "http://www.w3.org/2000/svg";
const svg = document.getElementById("editor");
const gridSize = 15; // 촘촘한 정렬을 위해 그리드 단위를 15로 조정

let tool = "seat";
let action = null; 
let target = null;
let offsetX = 0, offsetY = 0;

function getNextNumber(type) {
    const items = Array.from(svg.querySelectorAll(type === "seat" ? ".item-seat text" : ".item-room text"));
    const usedNums = items
        .map(t => parseInt(t.textContent))
        .filter(n => !isNaN(n))
        .sort((a, b) => a - b);

    let next = 1;
    for (let num of usedNums) {
        if (num === next) next++;
        else if (num > next) break;
    }
    return next;
}

function cursor(evt) {
    const pt = svg.createSVGPoint();
    pt.x = evt.clientX; pt.y = evt.clientY;
    return pt.matrixTransform(svg.getScreenCTM().inverse());
}

function createBox(x, y, w, h, color, label, isRoom=false) {
    const sx = Math.round(x / gridSize) * gridSize;
    const sy = Math.round(y / gridSize) * gridSize;

    const g = document.createElementNS(NS, "g");
    g.setAttribute("class", isRoom ? "item-room" : "item-seat");
    const rect = document.createElementNS(NS, "rect");
    rect.setAttribute("x", sx - w / 2);
    rect.setAttribute("y", sy - h / 2);
    rect.setAttribute("width", w);
    rect.setAttribute("height", h);
    rect.setAttribute("fill", color);
    rect.setAttribute("rx", 4); // 둥근 모서리 살짝 줄임
    if (isRoom) { rect.setAttribute("stroke", "#6366F1"); rect.setAttribute("stroke-width", "2"); }
    g.appendChild(rect);
    
    if (label) {
        const text = document.createElementNS(NS, "text");
        text.textContent = label;
        text.setAttribute("text-anchor", "middle");
        text.setAttribute("dominant-baseline", "middle");
        text.setAttribute("x", sx);
        text.setAttribute("y", sy);
        g.appendChild(text);
    }
    const handle = document.createElementNS(NS, "circle");
    handle.setAttribute("r", 5);
    handle.setAttribute("class", "handle");
    g.appendChild(handle);
    updateHandle(g);
    enableElement(g);
    svg.appendChild(g);
}

function updateHandle(g) {
    const rect = g.querySelector("rect");
    const handle = g.querySelector("circle");
    const x = Number(rect.getAttribute("x")), y = Number(rect.getAttribute("y"));
    const w = Number(rect.getAttribute("width")), h = Number(rect.getAttribute("height"));
    handle.setAttribute("cx", x + w); handle.setAttribute("cy", y + h);
}

function enableElement(g) {
    g.addEventListener("mousedown", (e) => {
        e.stopPropagation();
        document.querySelectorAll(".selected").forEach(el => el.classList.remove("selected"));
        g.classList.add("selected");
        target = g;
        const c = cursor(e);
        if (e.target.classList.contains("handle")) action = "resize";
        else {
            action = "drag";
            offsetX = c.x - g.querySelector("rect").getAttribute("x");
            offsetY = c.y - g.querySelector("rect").getAttribute("y");
        }
    });
}

svg.addEventListener("mousedown", (e) => {
    if (e.target !== svg && e.target.id !== "bgImage") return;
    const c = cursor(e);
    
    if (tool === "seat") {
        const nextNum = getNextNumber("seat");
        // 가로 55, 세로 40 직사각형
        createBox(c.x, c.y, 55, 35, "#60A5FA", nextNum.toString(), false);
    } else {
        const nextNum = getNextNumber("room");
        // 룸은 조금 더 크게
        createBox(c.x, c.y, 180, 130, "#EEF2FF", nextNum + "번 룸", true);
    }
});

svg.addEventListener("mousemove", (e) => {
    if (!action) return;
    const rect = target.querySelector("rect"), text = target.querySelector("text"), c = cursor(e);
    const x = Number(rect.getAttribute("x")), y = Number(rect.getAttribute("y"));
    
    if (action === "drag") {
        let nx = Math.round((c.x - offsetX) / gridSize) * gridSize;
        let ny = Math.round((c.y - offsetY) / gridSize) * gridSize;
        rect.setAttribute("x", nx); rect.setAttribute("y", ny);
        if (text) {
            text.setAttribute("x", nx + Number(rect.getAttribute("width")) / 2);
            text.setAttribute("y", ny + Number(rect.getAttribute("height")) / 2);
        }
    } else if (action === "resize") {
        let nw = Math.max(gridSize, Math.round((c.x - x) / gridSize) * gridSize);
        let nh = Math.max(gridSize, Math.round((c.y - y) / gridSize) * gridSize);
        rect.setAttribute("width", nw); rect.setAttribute("height", nh);
        if (text) { text.setAttribute("x", x + nw / 2); text.setAttribute("y", y + nh / 2); }
    }
    updateHandle(target);
});

window.addEventListener("mouseup", () => { action = null; target = null; });
window.addEventListener("keydown", (e) => {
    if ((e.key === "Delete" || e.key === "Backspace") && document.querySelector(".selected")) {
        if (confirm("삭제하시겠습니까?")) document.querySelector(".selected").remove();
    }
});

function saveLayout() {
    const items = [];
    svg.querySelectorAll("g").forEach(g => {
        const rect = g.querySelector("rect");
        const text = g.querySelector("text");
        items.push({
            label: text.textContent,
            x: parseFloat(rect.getAttribute("x")),
            y: parseFloat(rect.getAttribute("y")),
            width: parseFloat(rect.getAttribute("width")),
            height: parseFloat(rect.getAttribute("height")),
            type: g.classList.contains("item-room") ? "ROOM" : "SEAT"
        });
    });
    fetch("saveCafeLayoutAction.do", {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ studycafe_idx: "${param.studycafe_idx}", layout: items })
    }).then(res => res.json()).then(data => {
        if(data.status === "success") alert("저장되었습니다!"); else alert("실패");
    }).catch(err => console.error("Error:", err));
}

window.onload = function() {
    const savedLayout = [];
    <c:forEach var="item" items="${layoutList}">
        savedLayout.push({
            type: "${item.TYPE != null ? item.TYPE : item.type}",
            label: "${item.LABEL != null ? item.LABEL : item.label}",
            x: Number("${item.X != null ? item.X : item.x}"),
            y: Number("${item.Y != null ? item.Y : item.y}"),
            width: Number("${item.WIDTH != null ? item.WIDTH : item.width}"),
            height: Number("${item.HEIGHT != null ? item.HEIGHT : item.height}")
        });
    </c:forEach>
    savedLayout.forEach(item => {
        if (item.label) {
            createBox(item.x + (item.width / 2), item.y + (item.height / 2), item.width, item.height,
                item.type === 'SEAT' ? "#60A5FA" : "#EEF2FF", item.label, item.type === 'ROOM');
        }
    });
};
</script>
</body>
</html>