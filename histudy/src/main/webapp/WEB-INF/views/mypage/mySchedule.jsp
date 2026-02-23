<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- SEO -->
<title>Hi, Study</title>
<meta name="description" content="스터디&멘토링" />
<meta name="author" content="파이널 프로젝트" />
<link rel="shortcut icon" href="/histudy/main-img/logo1.png" type="image/x-icon" />

<!-- OG (Open Graph Data)-->
<meta property="og:title" content="Hi, Study" />
<meta property="og:type" content="website" />
<meta property="og:url" content="배포후 생성된 URL" />
<meta property="og:image" content="배포후에 생성된 이미지 URL" />

<!-- GoogleFont -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<!-- CSS -->
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" href="/histudy/css/mypageDesign/mySchedule.css" type="text/css">
</head>
<body>
<%@ include file="../header.jsp"%>
<main>
<div class="mySchdulePage">
<div class="mypage-wrapper">
    <div class="mypage-container">
        <aside class="mypage-sidebar">
            <nav class="sidebar-nav">
                <ul>
						<li><a href="myPage.do"><img src="mypage-img/user.png" width="30">프로필</a>
						<li><a href="myDashboard.do"><img src="mypage-img/report.png" width="30">대시보드</a>
						<li><a href="mySchedule.do"><img src="mypage-img/calendar.png" width="30">일정관리</a>
						<li><a href="myPurchase.do"><img src="mypage-img/shopping-cart.png" width="30">구매 / 혜택</a>
						<li><a href="myHeart.do"><img src="mypage-img/heart.png" width="30">찜 목록</a>
						</li>
                </ul>
            </nav>
        </aside>

        <div class="calendar-section">
            <div id="calendar-header">
                <button type="button" id="btn-prev">&lt;</button>
                <span id="label-month"></span>
                <button type="button" id="btn-next">&gt;</button>
            </div>
            <table class="calendar-table">
                <thead><tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr></thead>
                <tbody id="calendar-body"></tbody>
            </table>
        </div>

        <div class="memo-section">
            <div class="memo-card memo-header-card">
                <div id="view-big-date" class="big-date">--</div>
                <div class="date-info">
                    <div id="view-full-date" class="full-date">날짜를 선택하세요</div>
                    <div id="view-day-name" class="day-name"></div>
                </div>
            </div>
            <div class="memo-card">
                <div id="empty-view" class="empty-state">
                    <img src="mypage-img/calendar.png">
                    <p>새 일정을 추가해보세요</p>
                    <button type="button" onclick="showForm()" style="border:1px solid #00c1a1;color:#00c1a1;background:none;padding:8px 15px;border-radius:8px;margin-top:10px;cursor:pointer;">일정 추가</button>
                </div>
                <div id="memo-form-view" class="memo-form">
                    <label>제목</label>
                    <input type="text" id="memo-title">
                    <label>내용</label>
                    <textarea id="memo-text"></textarea>
                    <div class="memo-buttons">
                        <button type="button" id="btn-save">등록하기</button>
                        <button type="button" id="btn-delete" style="background:none;border:1px solid black;padding:12px;border-radius:10px;cursor:pointer;">삭제하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</main>
<%@ include file="../footer.jsp"%>
</body>
<script>
var today = new Date();
var viewYear = today.getFullYear();
var viewMonth = today.getMonth();
var currentMonthData = {};
var selectedDateKey = null;

function showForm() {
    document.getElementById("empty-view").style.display = "none";
    document.getElementById("memo-form-view").style.display = "flex";
}

function fetchMonthData(year, month) {
    fetch('getScheduleList.do?year=' + year + '&month=' + (month + 1))
    .then(res => res.json())
    .then(data => {
        currentMonthData = data;
        renderCalendarHTML(year, month);
    });
}

function renderCalendarHTML(year, month) {
    document.getElementById("label-month").textContent = year + "년 " + (month + 1) + "월";
    var firstDay = new Date(year, month, 1).getDay();
    var lastDate = new Date(year, month + 1, 0).getDate();
    var calendarBody = document.getElementById("calendar-body");
    
    var html = ""; 
    var dateNum = 1;

    for (var i = 0; i < 6; i++) {
        var row = "<tr>";
        for (var j = 0; j < 7; j++) {
            if (i === 0 && j < firstDay || dateNum > lastDate) {
                row += "<td></td>";
            } else {
                var key = year + "-" + ((month + 1) < 10 ? "0" + (month + 1) : (month + 1)) + "-" + (dateNum < 10 ? "0" + dateNum : dateNum);
                var isSelected = key === selectedDateKey ? "selected" : "";
                
                row += "<td data-date='" + key + "' class='" + isSelected + "'><div class='date-num'>" + dateNum + "</div>";
                
                if (currentMonthData[key]) {
                    var data = currentMonthData[key];
                    var titleStr = typeof data === 'object' ? (data.s_title || "") : (data || "");
                    titleStr = String(titleStr);
                    
                    if (titleStr.trim() !== "") {
                        var displayTitle = titleStr.split(' | ').join('<br>● ');
                        row += "<div class='memo-preview'><span class='dot'>●</span>" + displayTitle + "</div>";                
                    }
                }
                row += "</td>";
                dateNum++;
            }
        }
        row += "</tr>";
        html += row;
    }
    calendarBody.innerHTML = html; 
    setCellEvents();
}

function setCellEvents() {
    document.querySelectorAll(".calendar-table td").forEach(td => {
        td.onclick = function() {
            var key = this.getAttribute("data-date");
            if (!key) return;

            selectedDateKey = key;
            document.querySelectorAll(".calendar-table td").forEach(el => el.classList.remove("selected"));
            this.classList.add("selected");

            var parts = key.split("-");
            var d = new Date(parts[0], parts[1] - 1, parts[2]);

            document.getElementById("view-big-date").textContent = parseInt(parts[2]);
            document.getElementById("view-full-date").textContent = parts[1] + "월 " + parts[2] + "일";
            
            var days = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
            document.getElementById("view-day-name").textContent = days[d.getDay()];

            if (currentMonthData[key]) {
                var data = currentMonthData[key];
                var titleStr = typeof data === 'object' ? (data.s_title || "") : (data || "");
                var contentStr = typeof data === 'object' ? (data.s_content || "") : ""; 
                
                document.getElementById("memo-title").value = titleStr;
                document.getElementById("memo-text").value = contentStr; 
                showForm();
            } else {
                document.getElementById("empty-view").style.display = "flex";
                document.getElementById("memo-form-view").style.display = "none";
                document.getElementById("memo-title").value = "";
                document.getElementById("memo-text").value = "";
            }
        };
    });
}

document.getElementById("btn-save").onclick = function() {
    var payload = {
        schedule_date: selectedDateKey,
        schedule_title: document.getElementById("memo-title").value,
        schedule_content: document.getElementById("memo-text").value
    };
    fetch('saveSchedule.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(res => res.text())
    .then(res => {
        if (res === "success") {
            alert("저장되었습니다");
            fetchMonthData(viewYear, viewMonth);
        }
    });
};

document.getElementById("btn-delete").onclick = function() {
    if (!selectedDateKey) return;
    if (!confirm("이 일정을 정말 삭제하시겠습니까?")) return;
    var payload = { schedule_date: selectedDateKey };
    
    fetch('deleteSchedule.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(res => res.text())
    .then(res => {
        if (res === "success") {
            alert("삭제되었습니다");
            document.getElementById("memo-title").value = "";
            document.getElementById("memo-text").value = "";
            document.getElementById("empty-view").style.display = "flex";
            document.getElementById("memo-form-view").style.display = "none";
            
            fetchMonthData(viewYear, viewMonth);
        } else {
            alert("삭제에 실패했습니다. (로그인 상태를 확인해주세요)");
        }
    });
};

document.getElementById("btn-prev").onclick = function() {
    viewMonth--;
    if (viewMonth < 0) {
        viewMonth = 11;
        viewYear--;
    }
    fetchMonthData(viewYear, viewMonth);
};

document.getElementById("btn-next").onclick = function() {
    viewMonth++;
    if (viewMonth > 11) {
        viewMonth = 0;
        viewYear++;
    }
    fetchMonthData(viewYear, viewMonth);
};

fetchMonthData(viewYear, viewMonth);
</script>
</html>