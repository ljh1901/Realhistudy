<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" href="css/lectureDesign/lectureContent.css" type="text/css">
</head>
<body>
<%@ include file="../header.jsp"%>
<main>
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
					<li><a href="myAlarm.do"><img src="mypage-img/bell.png" width="30">알림 설정</a>
					</li>
				</ul>
			</nav>
		</aside>
		<div id="calendar-header">
				<button type="button" id="btn-prev">&lt;</button>
				<span id="label-month"></span>
				<button type="button" id="btn-next">&gt;</button>
			</div>

			<article>
				<table>
					<thead>
						<tr>
							<th>일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th>토</th>
						</tr>
					</thead>
					<tbody id="calendar-body">
					</tbody>
				</table>

				<!-- 메모(일정) 영역 -->
				<div id="memo-area">
					<div id="label-date">날짜를 선택하세요</div>
					<p>제목</p>
					<input type="text" name="s_title">
					<p>내용</p>
					<textarea id="memo-text" name="s_content"></textarea>
					<br>
					<div class="memo-buttons">
						<button type="button" id="btn-save">메모 저장</button>
						<button type="button" id="btn-delete">메모 삭제</button>
					</div>
				</div>
			</article>
	</div>
</div>
</main>
<%@ include file="../footer.jsp"%>
</body>
<script>
//===== 전역 변수 =====
var today = new Date();
var viewYear = today.getFullYear();
var viewMonth = today.getMonth(); 

var selectedDateKey = null; 
var currentMonthData = {};   

var calendarBody = document.getElementById("calendar-body");
var labelMonth = document.getElementById("label-month");
var labelDate = document.getElementById("label-date");
var memoText = document.getElementById("memo-text");

// ===== 유틸 함수 =====
function makeDateKey(dateObj) {
    var y = dateObj.getFullYear();
    var m = dateObj.getMonth() + 1;
    var d = dateObj.getDate();
    if (m < 10) m = "0" + m;
    if (d < 10) d = "0" + d;
    return y + "-" + m + "-" + d;
}

function makePreviewText(memo) {
    if (!memo) return "";
    memo = memo.replace(/\r/g, "");
    var idx = memo.indexOf("\n");
    if (idx !== -1) memo = memo.substring(0, idx);
    if (memo.length > 10) memo = memo.substring(0, 10) + "...";
    return memo;
}

function fetchMonthData(year, month) {
    var reqMonth = month + 1; 
    
    fetch('getScheduleList.do?year=' + year + '&month=' + reqMonth)
        .then(response => response.json())
        .then(data => {
            currentMonthData = data;  
            renderCalendarHTML(year, month);
        })
        .catch(error => console.error('Error:', error));
}

function renderCalendarHTML(year, month) {
    labelMonth.textContent = year + "년 " + (month + 1) + "월";
    var firstDayObj = new Date(year, month, 1);
    var lastDayObj = new Date(year, month + 1, 0);
    var firstWeekDay = firstDayObj.getDay(); 
    var lastDateNum = lastDayObj.getDate(); 

    calendarBody.innerHTML = "";
    var dateNum = 1;

    for (var week = 0; week < 6; week++) {
        var rowHtml = "<tr>";
        for (var day = 0; day < 7; day++) {
            var cellHtml = "";
            var attr = "";

            if (week === 0 && day < firstWeekDay) {
                cellHtml = "";
            } else if (dateNum > lastDateNum) {
                cellHtml = "";
            } else {
                var cellDateObj = new Date(year, month, dateNum);
                var key = makeDateKey(cellDateObj);
                
                var memo = currentMonthData[key] || ""; 
                var preview = makePreviewText(memo);

                attr = ' data-date="' + key + '"';
                cellHtml = "<div>" + dateNum + "</div>";
                if (preview !== "") {
                    cellHtml += '<div class="memo-preview">' + preview + "</div>";
                }
                dateNum++;
            }
            rowHtml += "<td" + attr + ">" + cellHtml + "</td>";
        }
        rowHtml += "</tr>";
        calendarBody.innerHTML += rowHtml;
    }
    setCellClickEvents();
    
    if(selectedDateKey) {
        var tds = calendarBody.getElementsByTagName("td");
        for (var i = 0; i < tds.length; i++) {
            if (tds[i].getAttribute("data-date") === selectedDateKey) {
                tds[i].classList.add("selected");
            }
        }
    } else {
        labelDate.textContent = "날짜를 선택하세요";
        memoText.value = "";
    }
}

function setCellClickEvents() {
    var tds = calendarBody.getElementsByTagName("td");
    for (var i = 0; i < tds.length; i++) {
        tds[i].onclick = function() {
            var key = this.getAttribute("data-date");
            if (!key) return;

            clearSelectedClass();
            this.classList.add("selected");
            selectedDateKey = key;
            labelDate.textContent = key + " 일정";
            memoText.value = currentMonthData[key] || "";
        };
    }
}

function clearSelectedClass() {
    var tds = calendarBody.getElementsByTagName("td");
    for (var i = 0; i < tds.length; i++) {
        tds[i].classList.remove("selected");
    }
}

document.getElementById("btn-prev").onclick = function() {
    selectedDateKey = null; 
    viewMonth--;
    if (viewMonth < 0) { viewMonth = 11; viewYear--; }
    fetchMonthData(viewYear, viewMonth);
};

document.getElementById("btn-next").onclick = function() {
    selectedDateKey = null;
    viewMonth++;
    if (viewMonth > 11) { viewMonth = 0; viewYear++; }
    fetchMonthData(viewYear, viewMonth);
};

document.getElementById("btn-save").onclick = function() {
    if (!selectedDateKey) {
        alert("먼저 날짜를 선택하세요.");
        return;
    }
    
    var memo = memoText.value;
    var payload = {
        schedule_date: selectedDateKey,
        schedule_content: memo
    };

    fetch('saveSchedule.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(response => response.text())
    .then(result => {
        if(result === "success") {
            alert("저장되었습니다.");
            currentMonthData[selectedDateKey] = memo;  
            renderCalendarHTML(viewYear, viewMonth);  
        } else {
            alert("저장에 실패했습니다.");
        }
    });
};

document.getElementById("btn-delete").onclick = function() {
    if(!selectedDateKey) {
        alert("먼저 날짜를 선택하세요.");
        return;
    }

    if(confirm("정말 이 날짜의 메모를 삭제하시겠습니까?")) {
        var payload = { schedule_date: selectedDateKey };

        fetch('deleteSchedule.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        })
        .then(response => response.text())
        .then(result => {
            if(result === "success") {
                alert("삭제되었습니다.");
                delete currentMonthData[selectedDateKey]; 
                memoText.value = "";
                renderCalendarHTML(viewYear, viewMonth);
            }
        });
    }
};

fetchMonthData(viewYear, viewMonth);
</script>
</html>