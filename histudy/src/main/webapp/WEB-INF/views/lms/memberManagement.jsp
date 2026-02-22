<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/lmsDesign/memberManagement.css">
<script src="https://kit.fontawesome.com/3f5acacf0e.js" crossorigin="anonymous"></script>
</head>
<body id="memberManagementBody">
<%@include file="../header.jsp" %>
<main>
	<form name="memberManagement">
		<section class="memberTopSection">
			<div class="memberTopContainer">
				<a class="memberTopContainer__sub" href="lms.do">
					<i class="fa-solid fa-arrow-left"></i><span>LMS로 돌아가기</span>
				</a>
				<div class="memberTopContainer__top">
					<div class="memberTopContainer__top__left">
						<div class="MTL__subBox">
							<span class="category">${studyDto.sc_name}</span>
							<span class="date">${studyDto.study_begin_date.substring(0, 10)} ~ ${study_finish_date}</span>
							<c:if test="${studyDto.study_begin_date.substring(0, 10) > studyDto.sysdate.substring(0, 10)}">
								<span class="studyBeginDate">스터디 시작 전입니다 · ${studyDto.study_begin_date.substring(0,10)}부터 진행됩니다</span>
							</c:if>
						</div>
						<h1 class="memberTopContainer__title">${studyDto.study_title}</h1>
						<div class="memberTopContainer__textBox">
							<div class="MTC__box">
								<i class="fa-regular fa-user"></i>
								<p>${memberCount}/${studyDto.study_max_members}명</p>
							</div>
							<div class="MTC__box right">
								<i class="fa-brands fa-old-republic"></i>
								<p>리더: ${studyDto.user_name}</p>
							</div>
						</div>
					</div>
					<div class="memberTopContainer__top__right">
						<i class="fa-solid fa-share-nodes"></i>
						<input type="button" value="초대 링크 복사" onclick="linkcopy(${studyIdx})">
					</div>
				</div>
				<div class="memberTopContainer__cards">
					<div class="memberTopContainer__card">
						<div class="memberTopContainer__card__imgBox">
							<img src="/histudy/lms-img/fulmember.png">
						</div>
						<div class="memberTopContainer__card__text">
							<p class="memberTopContainer__card__text__num">${memberCount}</p>
							<p class="memberTopContainer__card__text__sub">전체 멤버</p>
						</div>
					</div>
					<div class="memberTopContainer__card">
						<div class="memberTopContainer__card__imgBox">
							<img src="/histudy/lms-img/lms-taskOk.png">
						</div>
						<div class="memberTopContainer__card__text">
							<p class="memberTopContainer__card__text__num">${!empty memberLists ? memberLists[0].activeCount : 0}</p>
							<p class="memberTopContainer__card__text__sub">활동 중</p>
						</div>
					</div>
					<div class="memberTopContainer__card">
						<div class="memberTopContainer__card__imgBox">
							<img src="/histudy/lms-img/clockwait.png">
						</div>
						<div class="memberTopContainer__card__text">
							<p class="memberTopContainer__card__text__num">${pendingCount}</p>
							<p class="memberTopContainer__card__text__sub">가입 대기 중</p>
						</div>
					</div>
					<div class="memberTopContainer__card">
						<div class="memberTopContainer__card__imgBox">
							<img src="/histudy/lms-img/memberOk.png">
						</div>
						<div class="memberTopContainer__card__text">
							<p class="memberTopContainer__card__text__num">${studyDto.study_max_members-memberCount}</p>
							<p class="memberTopContainer__card__text__sub">모집 가능</p>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="memberCenterSection">
			<div class="memberCenterContainer">
				<div class="memberToggleBtns">
					<input type="button" value="멤버 관리" class="togglebtn toggle" onclick="javascript:location.href='memberManagement.do?study_idx=${studyIdx}'">
					<input type="button" value="가입 신청" class="togglebtn" onclick="studyApplySelect(${studyIdx})">
				</div>
				<div id="memberArea">
				<div class="leaderCard">
					<div class="leaderCard__Container">
						<div class="leaderCard__Container__data">
							<div class="leaderCard__Container__data__imgBox">
								<img src="/histudy/main-img/${creatorData.profile_img}" alt="개설자 이미지">
							</div>
							<div class="leaderCard__Container__data__textBox">
								<div class="leaderCard__Container__data__textBox__name">
									<h3>${creatorData.user_name}</h3>
									<span>스터디 리더</span>
								</div>
								<p>${creatorData.user_email}</p>
								<p class="startDate">개설일: ${creatorData.study_start_date.substring(0,10)}</p>
							</div>
						</div>
					</div>
				</div>
					<c:if test="${!empty memberLists}">
					<c:forEach var="m_list" items="${memberLists}">
						<div class="memberCard">
							<div class="memberCard__Container">
								<div class="memberCard__Container__data">
									<div class="memberCard__Container__data__imgBox">
										<img src="/histudy/main-img/${m_list.profile_img}" alt="참여자 이미지">
									</div>
									<div class="memberCard__Container__data__textBox">
										<div class="memberCard__Container__data__textBox__name">
											<h3>${m_list.user_name}</h3>
											<p>${m_list.user_email}</p>
										</div>
										<div class="memberCard__Container__data__studyData">
											<div class="memberCard__divBox">
												<p>진도율</p>
												<div>
													<meter value="${m_list.progress}" min="0" max="100"></meter>
													<span>${m_list.progress}%</span>
												</div>
											</div>
											<div class="memberCard__divBox">
												<p>과제 제출</p>
												<p>${m_list.taskSubmitCount}/${taskTotalCnt}</p>
											</div>
											<div class="memberCard__divBox">
												<p>가입일</p>
												<p>${m_list.join_date.substring(0,10)}</p>
											</div>
											<div class="memberCard__divBox">
												<p>최근 활동</p>
												<p>${m_list.activeStatus}</p>
											</div>
										</div>
									</div>
								</div>
								<div class="memberCard__Container__right">
									<div class="msgIconBtn" onclick="notice(${m_list.user_idx},${studyIdx},'${m_list.user_name}','${studyDto.study_title}')">
										<i class="fa-regular fa-comment-dots"></i>
									</div>
									<div class="deleteUserIconBtn" onclick="deleteUser(${m_list.user_idx},${studyIdx},'${m_list.user_name}')">
										<i class="fa-solid fa-user-xmark"></i>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					</c:if>
				</div>
			</div>
		</section>
	</form>
</main>
<%@include file="../footer.jsp" %>
</body>
<script>
// 오른쪽 토글 버튼 클릭 시
var togglebtns = document.querySelectorAll('.togglebtn');
for(let i=0; i<togglebtns.length; i++){
	togglebtns[i].addEventListener('click', function(){
		
		for(let j=0; j<togglebtns.length; j++){
			togglebtns[j].classList.remove('toggle');
		}
		
		togglebtns[i].classList.add('toggle');
	});	
}
var xhr;
function getXHR(){
	if(window.ActiveXObject){
		return new ActiveXObject('Msxml2.XMLHTTP');
	}else if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}else{
		return null;
	}
}

function studyApplySelect(study_idx){
	xhr = getXHR();
	xhr.open('GET', 'lmsRest/memberManagement.do?study_idx='+study_idx, true);
	xhr.onreadystatechange=studyApplySelectResult;
	xhr.send(null);
}
function studyApplySelectResult(){
	if(xhr.readyState==4){
		if(xhr.status==200){
			var list = xhr.responseText;
			var jsonData = JSON.parse(list);
			
			var memberArea = document.getElementById('memberArea');
			memberArea.innerHTML = '';
			
			if(jsonData == null || jsonData.length==0){
				memberArea.innerHTML = 
				  '<div class="studyApplyCard">' +
				  	'<h3>가입 신청자가 없습니다. 초대 링크를 복사하여 스터디를 공유해보세요!</h3>' +
				  '</div>';
			}
			
			for(let i=0; i<jsonData.length; i++){
				console.log(jsonData[i]);
				
				memberArea.innerHTML += 
	
			'<div class="studyApplyCard">' +
				'<div class="studyApplyCard__left">' +
					'<img src="/histudy/main-img/defaultUser.png" alt="참여자 이미지">' +
				'</div>' +
				'<div class="studyApplyCard__center">' +
					'<div class="studyApplyCard__center__top">' +
						'<div class="studyApplyCard__center__top__userData">' +
							'<h3>'+jsonData[i].user_name+'</h3>' +
							'<p>'+jsonData[i].user_email+'</p>' +
						'</div>' +
					'</div>' +
					'<div class="studyApplyCard__center__intro">' +
						'<p>'+jsonData[i].sa_intro+'</p>' +
					'</div>' +
					'<div class="studyApplyCard__center__btns">' +
					'<input type="button" value="승인" class="ok" onclick="location.href=\'studyApplyJoin.do?study_idx='+jsonData[i].study_idx+'&user_idx='+jsonData[i].user_idx+'\'">' +
					'<input type="button" value="거절" class="no" onclick="Rejected('+jsonData[i].study_idx+','+jsonData[i].user_idx+',\''+jsonData[i].user_name+'\')">' +
					'</div>' +
				'</div>' +
			'</div>';
			}
		}
	}
}

// 멤버 거부
function Rejected(study_idx, user_idx, user_name){
	
	var modal = 
	'<div class="rejectModalBg">' +
		'<div class="rejectModal">' +
			'<h3>'+user_name+'님을 거절하시겠습니까?</h3>' +
			'<textarea id="rejectReason" placeholder="거절 사유를 입력하세요"></textarea>' +
			'<div class="rejectBtns">' +
				'<button onclick="submitReject('+study_idx+','+user_idx+')">확인</button>' +
				'<button onclick="closeReject()">취소</button>' +
			'</div>' +
		'</div>' +
	'</div>';
	
	document.body.insertAdjacentHTML('beforeend', modal);
}
function submitReject(study_idx, user_idx){
	
	const reason = document.getElementById('rejectReason').value;
	if(!reason){
		reason='';
	}
	
	location.href='studyApplyReject.do?study_idx='+study_idx+'&user_idx='+user_idx+'&sa_reason='+reason;
}
function closeReject(){
	document.querySelector('.rejectModalBg').remove();
}

// 멤버 삭제
function deleteUser(userIdx, studyIdx, userName){
	var modal = 
		'<div class="deleteModalBg">' +
			'<div class="deleteModal">' +
				'<div class="deleteImg">' +
					'<img src="/histudy/lms-img/memberDelete.png">' +
				'</div>' +
				'<h3>멤버 내보내기</h3>' +
				'<p class="titleSub"><strong>'+userName+'</strong>님을 스터디에서 내보내시겠습니까?</p>' +
				'<div class="deleteText">' +
					'<p>이 작업은 되돌릴 수 없습니다.<br> 멤버는 다시 가입 신청을 해야 합니다.</p>' +
				'</div>' +
				'<div class="deleteBtns">' +
					'<button onclick="closeDeleteUser()">취소</button>' +
					'<button onclick="deleteUserSubmit(' + userIdx + ',' + studyIdx + ')">내보내기</button>' +
				'</div>' +
			'</div>' +
		'</div>';
		
	document.body.insertAdjacentHTML('beforeend', modal);
}
function closeDeleteUser(){
	document.querySelector('.deleteModalBg').remove();
}
function deleteUserSubmit(user_idx, study_idx){
	location.href='studyMemberDelete.do?user_idx='+user_idx+'&study_idx='+study_idx;
}


function notice(userIdx, studyIdx, userName, study_title){
	var modal = 
		'<div class="noticeModalBg">' +
			'<div class="noticeModal">' +

				'<h3>알림 보내기</h3>' +
				'<p class="titleSub">작성한 내용은 <strong>'+userName+'</strong>님의 알림함으로 전송됩니다</p>' +

				'<textarea id="noticeMsg" placeholder="전달할 내용을 입력하세요"></textarea>' +

				'<div class="noticeBtns">' +
					'<button onclick="closeNotice()">취소</button>' +
					'<button onclick="sendNotice('+userIdx+','+studyIdx+',\''+study_title+'\')">알림 보내기</button>' +
				'</div>' +

			'</div>' +
		'</div>';

		document.body.insertAdjacentHTML('beforeend', modal);
}
function closeNotice(){
	document.querySelector('.noticeModalBg').remove();
}
function sendNotice(userIdx, studyIdx, studyTitle){
	
	var noticeContent = document.getElementById('noticeMsg').value;

	if(noticeContent == null || noticeContent == ''){
		return;
	}
	
	location.href='sendNotice.do?member_idx='+userIdx+
	'&study_idx='+studyIdx+
	'&noticeContent='+encodeURIComponent(noticeContent)+
	'&study_title='+encodeURIComponent(studyTitle);
}

// 초대 링크 복사 관련 -> css는 deleteUser css와 동일하게 ㄱㄱ
function linkcopy(studyIdx){
	var link = 'http://localhost:9090/histudy/studyContent.do?study_idx='+studyIdx;
	navigator.clipboard.writeText(link);
	var modal = 
		'<div class="deleteModalBg">' +
			'<div class="deleteModal">' +
				'<div class="deleteImg">' +
					'<img src="/histudy/lms-img/linkCopyOk.png">' +
				'</div>' +
				'<h3>초대 링크 복사 완료!</h3>' +
				'<p class="titleSub">링크를 공유하여 새로운 멤버를 초대하세요</p>' +
				'<div class="linkText">' +
					'<p>'+link+'</p>' +
				'</div>' +
				'<div class="linkBtns">' +
					'<button onclick="closeDeleteUser()">확인</button>' +
				'</div>' +
			'</div>' +
		'</div>';
		
	document.body.insertAdjacentHTML('beforeend', modal);
	
}
</script>
</html>