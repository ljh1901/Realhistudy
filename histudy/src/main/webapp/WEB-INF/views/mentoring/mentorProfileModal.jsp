<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>

<style>
/* ===== 공통 모달 배경 ===== */
.modal-backdrop{
  display:none;
  position:fixed;
  left:0; top:0;
  width:100%; height:100%;
  background: rgba(0,0,0,0.45);
  z-index:9999;
}

/* ===== 모달 박스 ===== */
.modal-box{
  width: 520px;
  max-width: calc(100% - 24px);
  background:#fff;
  border-radius:14px;
  margin: 90px auto 0;
  overflow:hidden;
  box-shadow: 0 20px 60px rgba(0,0,0,0.25);
}

.modal-header{
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding:14px 16px;
  background:#1E293B;
  color:#fff;
}
.modal-header h3{ margin:0; font-size:16px; }
.modal-close{
  border:none;
  background:transparent;
  color:#fff;
  font-size:24px;
  cursor:pointer;
  line-height:1;
}

.modal-body{ padding:16px; }

/* 안내 모달 텍스트 */
.guide-text{
  font-size:14px;
  line-height:1.6;
  color:#111827;
  background:#f8fafc;
  border:1px solid #e5e7eb;
  padding:14px;
  border-radius:12px;
}

/* 버튼들 */
.modal-actions{
  margin-top:14px;
  display:flex;
  gap:10px;
  justify-content:flex-end;
}
.btn-dark{
  border:none;
  padding:10px 14px;
  border-radius:10px;
  background:#1E293B;
  color:#fff;
  cursor:pointer;
  font-weight:700;
}
.btn-gray{
  border:none;
  padding:10px 14px;
  border-radius:10px;
  background:#e5e7eb;
  color:#111827;
  cursor:pointer;
  font-weight:700;
}

/* 등록 폼 */
.form-row{ margin-bottom:12px; text-align:left; }
.form-row label{
  display:block;
  font-size:13px;
  color:#111827;
  font-weight:700;
  margin-bottom:6px;
}
.form-row input, .form-row textarea{
  width:100%;
  box-sizing:border-box;
  border:1px solid #e5e7eb;
  border-radius:10px;
  padding:10px 12px;
  font-size:14px;
}
.form-row textarea{ min-height:90px; resize:vertical; }

.category-grid{
  display:flex;
  flex-wrap:wrap;
  gap:8px;
}
.cat-btn{
  border:1px solid #e5e7eb;
  background:#fff;
  padding:8px 12px;
  border-radius:10px;
  cursor:pointer;
  font-size:13px;
}
.cat-btn.active{
  background:#1E293B;
  color:#fff;
  border-color:#1E293B;
}
</style>


<!-- (모달1) 안내사항 모달 -->
<div id="mentorGuideModal" class="modal-backdrop" onclick="closeByBackdrop(event,'mentorGuideModal')">
  <div class="modal-box" onclick="event.stopPropagation();">
    <div class="modal-header">
      <h3>멘토 프로필 등록 안내</h3>
      <button type="button" class="modal-close" onclick="closeMentorGuideModal()">&times;</button>
    </div>

    <div class="modal-body">
      <div class="guide-text">
        <b>사용자님! 안녕하세요.</b><br/>
        멘토링 지식 공유에 동참해 주셔서 감사합니다!<br/>
        하이스터디의 이야기를 들려주세요!<br/><br/>

        1) 하이스터디는 성장기회의 평등을 추구합니다.<br/>
        2) 멘토링은 지식공유자가 자유롭게 운영할 수 있습니다.<br/><br/>

        아래 버튼을 눌러 멘토 프로필 등록을 진행해 주세요.
      </div>

      <div class="modal-actions">
        <button type="button" class="btn-gray" onclick="closeMentorGuideModal()">닫기</button>
        <button type="button" class="btn-dark" onclick="openMentorFormModal()">멘토 프로필 등록</button>
      </div>
    </div>
  </div>
</div>

<!-- (모달2) 멘토 프로필 등록 폼 모달 -->
<div id="mentorFormModal" class="modal-backdrop" onclick="closeByBackdrop(event,'mentorFormModal')">
  <div class="modal-box" onclick="event.stopPropagation();">
    <div class="modal-header">
      <h3>멘토 프로필 등록</h3>
      <button type="button" class="modal-close" onclick="closeMentorFormModal()">&times;</button>
    </div>

    <div class="modal-body">

      <form method="post" action="mentorProfileCreate.do">



        <div class="form-row">
          <label>연락 받을 이메일 *</label>

          <input type="text" name="user_email" placeholder="example@example.com"/>
        </div>

        <div class="form-row">
          <label>연락처(전화번호) *</label>
          <input type="text" name="mentor_tel" placeholder="010-0000-0000"/>
        </div>

        <div class="form-row">
          <label>희망분야(카테고리) *</label>

          <input type="hidden" name="sc_idx" id="sc_idx" value=""/>

          <div class="category-grid">
            <button type="button" class="cat-btn" onclick="pickCategory(this,1)">개발</button>
            <button type="button" class="cat-btn" onclick="pickCategory(this,2)">언어</button>
            <button type="button" class="cat-btn" onclick="pickCategory(this,3)">취업</button>
            <button type="button" class="cat-btn" onclick="pickCategory(this,4)">자격증</button>
            <button type="button" class="cat-btn" onclick="pickCategory(this,5)">학업</button>
          </div>
        </div>

        <div class="form-row">
          <label>나를 소개하는 글(한줄 소개) *</label>
          <textarea name="mentor_intro" placeholder="멘토로서 어떤 소개를 할지 작성해 주세요."></textarea>
        </div>

        <div class="form-row">
          <label>링크(선택)</label>
          <input type="text" name="mentor_link" placeholder="https:// ..."/>
        </div>

        <div class="modal-actions">
          <button type="button" class="btn-gray" onclick="closeMentorFormModal()">취소</button>
          <button type="submit" class="btn-dark" onclick="return validateMentorForm();">제출</button>
        </div>

      </form>
    </div>
  </div>
</div>

<script>
/* ===== 모달 열고/닫기 ===== */
function openMentorGuideModal(){
  document.getElementById("mentorGuideModal").style.display = "block";
  document.body.style.overflow = "hidden";
}
function closeMentorGuideModal(){
  document.getElementById("mentorGuideModal").style.display = "none";
  document.body.style.overflow = "";
}
function openMentorFormModal(){

  document.getElementById("mentorGuideModal").style.display = "none";
  document.getElementById("mentorFormModal").style.display = "block";
  document.body.style.overflow = "hidden";
}
function closeMentorFormModal(){
  document.getElementById("mentorFormModal").style.display = "none";
  document.body.style.overflow = "";
}
function closeByBackdrop(e, modalId){

  if(e.target.id === modalId){
    document.getElementById(modalId).style.display = "none";
    document.body.style.overflow = "";
  }
}

/* ===== 카테고리 선택 ===== */
function pickCategory(btn, val){
  var buttons = btn.parentNode.querySelectorAll(".cat-btn");
  for(var i=0; i<buttons.length; i++){
    buttons[i].classList.remove("active");
  }
  btn.classList.add("active");
  document.getElementById("sc_idx").value = val;
}

function validateMentorForm(){
  var tel = document.querySelector("input[name='mentor_tel']").value;
  var sc  = document.getElementById("sc_idx").value;
  var intro = document.querySelector("textarea[name='mentor_intro']").value;
  
  if(!tel){
    alert("연락처를 입력해 주세요.");
    return false;
  }
  if(!sc){
    alert("희망분야(카테고리)를 선택해 주세요.");
    return false;
  }
  if(!intro){
    alert("소개글을 입력해 주세요.");
    return false;
  }
  return true;
}
</script>
</body>
</html>
