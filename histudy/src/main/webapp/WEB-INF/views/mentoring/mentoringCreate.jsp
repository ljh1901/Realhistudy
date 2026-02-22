<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>

<%

    Calendar cal = Calendar.getInstance();
    cal.setFirstDayOfWeek(Calendar.MONDAY);
    int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    int delta = (dayOfWeek == Calendar.SUNDAY) ? -6 : (Calendar.MONDAY - dayOfWeek);
    cal.add(Calendar.DAY_OF_MONTH, delta);
    
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("MM/dd");
    SimpleDateFormat sdfFull = new SimpleDateFormat("yyyy-MM-dd");
    
    String[] displayDates = new String[7];
    String[] dbDates = new String[7];
    
    for (int i = 0; i < 7; i++) {
        displayDates[i] = sdfDisplay.format(cal.getTime());
        dbDates[i] = sdfFull.format(cal.getTime());
        cal.add(Calendar.DAY_OF_MONTH, 1);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토링 개설</title>
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" href="css/header.css" type="text/css">
<link rel="stylesheet" href="css/footer.css" type="text/css">
<link rel="stylesheet" href="css/mentoringDesign/mentoringCreate.css" type="text/css">

</head>

<body id="mentoringCreatePage">
<%@ include file="../header.jsp"%>

<section class="mentoringCreate">

  <form id="mentoringOpenForm" method="post" action="<c:url value='/mentoringCreate.do'/>">

    <input type="hidden" id="sc_idx" name="sc_idx" value="">
    <input type="hidden" id="skill_tags" name="skill_tags" value="">
    <input type="hidden" id="schedule_json" name="schedule_json" value="[]">

    <div class="card">
      <h3 class="section-title">기본 정보</h3>

      <div class="grid-2">
        <div>
          <label class="required">연락 가능한 번호</label>
          <input type="text" name="contact_phone_public" placeholder="010-1234-5678">
        </div>
        <div>
          <label class="required">연락 가능한 이메일</label>
          <input type="text" name="contact_email_public" placeholder="example@example.com">
        </div>
      </div>
    </div>

    <div class="card">
      <h3 class="section-title">카테고리</h3>

      <div class="cat-grid">
        <button type="button" class="cat-btn" data-val="1" onclick="pickCategory(this)">개발/프로그래밍</button>
        <button type="button" class="cat-btn" data-val="2" onclick="pickCategory(this)">언어</button>
        <button type="button" class="cat-btn" data-val="3" onclick="pickCategory(this)">취업</button>
        <button type="button" class="cat-btn" data-val="4" onclick="pickCategory(this)">자격증</button>
        <button type="button" class="cat-btn" data-val="5" onclick="pickCategory(this)">학업</button>
      </div>

      <div class="hint">카테고리 1개를 선택해 주세요.</div>
    </div>

    <div class="card">
      <h3 class="section-title">멘토링 정보</h3>

      <div style="margin-bottom:12px;">
        <label class="required">멘토링명 (한 줄 요약)</label>
        <input type="text" name="mentoring_title" placeholder="예) 개발자 취업 / 면접 / 자격증">
      </div>

      <div class="grid-2" style="margin-bottom:12px;">
        <div>
          <label class="required">멘토 직군</label>
          <input type="text" name="job_group" placeholder="예) 개발 / 디자인 / 기획">
        </div>
        <div>
          <label class="required">멘토 직무</label>
          <input type="text" name="job_role" placeholder="예) 백엔드 / 프론트 / 데이터">
        </div>
      </div>

      <div class="grid-2" style="margin-bottom:8px;">
        <div>
          <label class="required">멘토 경력(년차)</label>
          <input type="number" name="career_years" min="0" placeholder="예) 3">
          <div class="hint danger">* 멘토님의 직군/직무와 경력은 선택해 주세요.</div>
        </div>

        <div>
          <label>현재 소속 회사명</label>
          <input type="text" name="company_name" placeholder="예) 하이스터디">
        </div>
      </div>

      <div style="margin-top:14px;">
        <label>멘토링 스킬태그 (최대 5개)</label>
        <div class="tag-row">
          <input type="text" id="tagInput" placeholder="태그 입력 (예: java, html, css, javascript)">
          <button type="button" class="tag-add" onclick="addTag()">추가</button>
        </div>
        <div class="chips" id="tagChips"></div>
      </div>

      <div style="margin-top:14px;">
        <label class="required">1회 시간</label>
        <select name="session_minutes" id="session_minutes">
          <option value="">선택</option>
          <option value="60">1시간</option>
          <option value="120">2시간</option>
          <option value="180">3시간</option>
        </select>
        <div class="hint">시간 선택 후 스케줄을 클릭하면, 선택한 시간만큼 연속으로 자동 선택됩니다.</div>
      </div>

      <div style="margin-top:14px;">
        <label class="required">스케줄 선정 (멘토링 가능한 일정을 선택해주세요)</label>
        <div class="schedule-wrap">
          <table class="schedule" id="scheduleTable">
            <thead>
              <tr>
                <th class="time-col"></th>
                <th>월(<%= displayDates[0] %>)</th>
                <th>화(<%= displayDates[1] %>)</th>
                <th>수(<%= displayDates[2] %>)</th>
                <th>목(<%= displayDates[3] %>)</th>
                <th>금(<%= displayDates[4] %>)</th>
                <th>토(<%= displayDates[5] %>)</th>
                <th>일(<%= displayDates[6] %>)</th>
              </tr>
            </thead>
            <tbody>
              <% for(int h=14; h<=20; h++) { String t = h + ":00"; %>
              <tr>
                <td class="time-col"><%= t %></td>
                <td class="slot" data-day="MON" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
                <td class="slot" data-day="TUE" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
                <td class="slot" data-day="WED" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
                <td class="slot" data-day="THU" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
                <td class="slot" data-day="FRI" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
                <td class="slot" data-day="SAT" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
                <td class="slot" data-day="SUN" data-time="<%= t %>" onclick="onSlotClick(this)"></td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>
        <div class="hint">시작 시간을 클릭하면 선택한 “1회 시간”만큼 연속 선택/해제가 됩니다.</div>
      </div>

      <div style="margin-top:14px;">
        <label class="required">멘토링 상세 설명</label>
        <textarea name="description" placeholder="예) 어떤 내용을 어떻게 도와줄 수 있는지 자세히 작성해 주세요."></textarea>
      </div>

      <div style="margin-top:14px;">
        <label>멘토링 사전 안내</label>
        <textarea name="pre_notice" placeholder="예) 수업 전 준비사항, 필요한 자료/준비물, 환영 메시지 등"></textarea>
        <div class="hint danger">
          1. 수업을 신청해준 멘티에게 환영메시지를 작성해주세요.<br/>
          2. 수업 전 필수 준비사항, 준비물이 있는 경우 내용을 작성해주세요.
        </div>
      </div>

      <div class="bottom-actions">
        <button type="button" class="btn gray" onclick="history.back()">취소</button>
        <button type="button" class="btn dark" onclick="submitMentoringForm()">저장하기</button>
      </div>
    </div>

  </form>

<script>

  function pickCategory(btn){
    const val = btn.getAttribute("data-val");
    const sc = document.getElementById("sc_idx");
    if(sc) sc.value = val;
    document.querySelectorAll(".cat-btn").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");
  }

  const tags = []; 
  const tagInput = document.getElementById("tagInput");
  const tagChips = document.getElementById("tagChips");

  function addTag() {
      const rawValue = tagInput.value.trim();
      const tagValue = rawValue.replace(/\s+/g, ""); 

      if (!tagValue) return;
      if (tags.includes(tagValue)) { 
          alert("이미 추가된 태그입니다."); 
          return; 
      }
      if (tags.length >= 5) { 
          alert("스킬태그는 최대 5개까지 선택할 수 있어요."); 
          return; 
      }

      tags.push(tagValue); 
      tagInput.value = ""; 
      renderTags(); 
  }

  function removeTag(t) {
      const idx = tags.indexOf(t);
      if (idx >= 0) tags.splice(idx, 1); 
      renderTags();
  }

  function renderTags() {
    tagChips.innerHTML = ""; 
    
    tags.forEach(t => {
        const el = document.createElement("div");
        el.className = "chip"; 
        
        const tagText = document.createElement("span");
        tagText.textContent = "#" + t; 
        tagText.style.color = "#111827";
        
        const delBtn = document.createElement("button");
        delBtn.type = "button";
        delBtn.innerHTML = "&times;";
        delBtn.onclick = function() { removeTag(t); };
        
        el.appendChild(tagText);
        el.appendChild(delBtn);
        tagChips.appendChild(el);
    });
    
    const hiddenInput = document.getElementById("skill_tags");
    if (hiddenInput) hiddenInput.value = tags.join(",");
 }


  tagInput.addEventListener("keydown", function(e) {
      if (e.key === "Enter") {
          e.preventDefault();
          addTag();
      }
  });

  const selectedSlots = new Set();

  const dbDates = ["<%= dbDates[0] %>", "<%= dbDates[1] %>", "<%= dbDates[2] %>", "<%= dbDates[3] %>", "<%= dbDates[4] %>", "<%= dbDates[5] %>", "<%= dbDates[6] %>"];
  const dayMap = {"MON":0, "TUE":1, "WED":2, "THU":3, "FRI":4, "SAT":5, "SUN":6};

  function onSlotClick(td) {
    const day = td.dataset.day;
    const time = td.dataset.time;
    const actualDate = dbDates[dayMap[day]]; 

    const key = actualDate + "_" + time;

    if (selectedSlots.has(key)) {
      selectedSlots.delete(key);
      td.classList.remove("selected");
    } else {
      selectedSlots.add(key);
      td.classList.add("selected");
    }

    const arr = Array.from(selectedSlots).map(k => {
      const [d, t] = k.split("_");
      return { date: d, time: t };
    });
    document.getElementById("schedule_json").value = JSON.stringify(arr);
  }


 /* 4. 최종 제출  */
  function submitMentoringForm(){
    const f = document.getElementById("mentoringOpenForm");
    const sessionMin = parseInt(document.getElementById("session_minutes").value || "0", 10);
    const needSlots = sessionMin / 60; 


    if(!document.getElementById("sc_idx").value){ alert("카테고리를 선택해 주세요."); return; }
    if(!f.mentoring_title.value.trim()){ alert("멘토링명을 입력해 주세요."); return; }
    if(!f.job_group.value.trim() || !f.job_role.value.trim() || !f.career_years.value.trim()){ alert("직군/직무/경력을 입력해 주세요."); return; }
    if(sessionMin === 0){ alert("1회 시간을 선택해 주세요."); return; }
    
    if(selectedSlots.size !== needSlots){
      alert(`선택한 시간이 잘못되었습니다. 다시 시간에 맞게 선택해주세요!`);
      return;
    }

    if(!f.description.value.trim()){ alert("상세 설명을 입력해 주세요."); return; }

    f.submit();
  }
</script>

<c:if test="${not empty msg}">
  <script>alert("${msg}");</script>
</c:if>

</section>

<%@ include file="../footer.jsp"%>
</body>
</html>