<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/lmsDesign/lms.css">
</head>
<body id="lmsBody">
<%@include file="../header.jsp" %>
<main>
	<form name="lmsForm">
	<section class="lmsSection">
		<div class="lmsTopContainer">
			<h1 class="lmsTopContainer__title">학습 관리</h1>
			<p class="lmsTopContainer__sub">스터디 과제를 관리하고 학습 진도를 확인하세요</p>
			<div class="lmsTopContainer__cards">
				<div class="lmsTopContainer__card">
					<div class="lmsTopContainer__card__imgBox">
						<img src="/histudy/lms-img/lms-studying.png">
					</div>
					<div class="lmsTopContainer__card__text">
						<p class="lmsTopContainer__card__text__num">${studyCount}</p>
						<p class="lmsTopContainer__card__text__sub">내 스터디</p>
					</div>
				</div>
				<div class="lmsTopContainer__card">
					<div class="lmsTopContainer__card__imgBox">
						<img src="/histudy/lms-img/lms-waitTask.png">
					</div>
					<div class="lmsTopContainer__card__text">
						<p class="lmsTopContainer__card__text__num">${waitTaskCount}</p>
						<p class="lmsTopContainer__card__text__sub">제출해야 할 과제</p>
					</div>
				</div>
				<div class="lmsTopContainer__card">
					<div class="lmsTopContainer__card__imgBox">
						<img src="/histudy/lms-img/lms-studyOk.png">
					</div>
					<div class="lmsTopContainer__card__text">
						<p class="lmsTopContainer__card__text__num">${taskSubmitOkCount}</p>
						<p class="lmsTopContainer__card__text__sub">제출 완료</p>
					</div>
				</div>
				<div class="lmsTopContainer__card">
					<div class="lmsTopContainer__card__imgBox">
						<img src="/histudy/lms-img/lms-taskOk.png">
					</div>
					<div class="lmsTopContainer__card__text">
						<p class="lmsTopContainer__card__text__num">${finishStudyCount}</p>
						<p class="lmsTopContainer__card__text__sub">완료한 스터디</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="lmsTaskSection">
		<div class="lmsCenterContainer">
			<div class="lmsCenterContainer__leftBox">
				<div class="lmsCenterContainer__leftBox__stduyIng">
					<div class="lmsCenterContainer__leftBox__stduyIng__top">
						<h2>내 스터디</h2>
						<p><a href="lms.do">전체보기</a></p>
					</div>
					<c:if test="${!empty s_list}">
						<c:forEach var="s_list" items="${s_list}">
							<div class="lmsCenterContainer__leftBox__stduyIng__card" onclick="memberCheck('leader', ${s_list.study_idx})">
								<div class="studyIng__card__title">
									<h3>${s_list.study_title }</h3>
									<div class="leader">
										<span>리더</span>
										<span><a href="memberManagement.do?study_idx=${s_list.study_idx}">멤버</a></span>
									</div>
								</div>
								<div class="studyIng__card__members">
									<span>${s_list.study_current_weeks}/${s_list.study_total_weeks}주차</span>
									<span class="maxMembers">${s_list.study_current_members}명</span>
								</div>
								<div class="studyIng__card__graph">
									<meter value="${s_list.studyProgress}" min="0" max="100"></meter>
								</div>
								<div class="studyIng__card__graphText">
									<span>진행률 ${s_list.studyProgress}%</span>
									<span class="taskCount">과제 ${s_list.taskCount}개</span>
								</div>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${!empty approved_List}">
						<c:forEach var="a_list" items="${approved_List }">
							<div class="lmsCenterContainer__leftBox__stduyIng__card" onclick="memberCheck('member', ${a_list.study_idx})">
								<div class="studyIng__card__title">
									<h3>${a_list.study_title}</h3>
								</div>
								<div class="studyIng__card__members">
									<span>${a_list.study_current_weeks}/${a_list.study_total_weeks}주차</span>
									<span class="maxMembers">${a_list.study_current_members}명</span>
								</div>
								<div class="studyIng__card__graph">
									<meter value="${a_list.studyProgress}" min="0" max="100"></meter>
								</div>
								<div class="studyIng__card__graphText">
									<span>진행률 ${a_list.studyProgress}%</span>
									<span class="taskCount">과제 ${a_list.taskCount2}개</span>
								</div>
							</div>
						</c:forEach>
					</c:if>
				<div class="lmsCenterContainer__leftBox__studyOk">
					<h3>완료한 스터디</h3>
					<c:if test="${!empty finishStudyList}">
						<c:forEach var="f_list" items="${finishStudyList}">
							<div class="lmsCenterContainer__leftBox__studyOk__card">
								<p>${f_list.study_title }</p>
								<span>리더 - ${f_list.user_name}</span>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty finishStudyList}">
							<div class="lmsCenterContainer__leftBox__studyOk__card">
								<p>완료한 스터디가 아직 없습니다.</p>
							</div>
					</c:if>
				</div>
				</div>
			</div>
			<div class="lmsCenterContainer__rightBox">
				<div class="lmsCenterContainer__rightBox__top">
					<div class="lmsCenterContainer__rightBox__title">
						<h2>과제 관리</h2>
						<c:if test="${!empty s_list}">
							<a href="taskInsertForm.do">과제 등록</a>
						</c:if>
					</div>
					<div class="lmsCenterContainer__rightBox__toggleBtns">
						<input type="button" value="진행중" class="togglebtn toggle" onclick="taskCheck('진행중')">
						<input type="button" value="제출 완료" class="togglebtn" onclick="taskCheck('제출 완료')">
					</div>
				</div>
				<div id="taskArea">
					<c:if test="${!empty C_task_list}">
						<c:forEach var="c_task_list" items="${C_task_list}">
							<div class="lmsCenterContainer__rightBox__card">
								<div class="lmsCenterContainer__rightBox__card__top">
									<span class="tag-title">${c_task_list.study_title}</span>
									<span class="tag-weeks">${c_task_list.a_weeks}주차 과제</span>
								</div>
								<div class="lmsCenterContainer__rightBox__card__middle">
									<h3>${c_task_list.a_title}</h3>
									<p>${c_task_list.a_content }</p>
									<div class="lmsCenterContainer__rightBox__middle__file">
										<div class="files__file">
											<img src="/histudy/lms-img/clip.png">
											<span>${empty c_task_list.a_fname?'첨부된 파일이 없습니다.':c_task_list.a_fname}</span>
										</div>
									</div>
								</div>
								<div class="lmsCenterContainer__rightBox__card__row">
									<div class="row__left">
										<img src="/histudy/lms-img/calendar.png">
										<p>${c_task_list.a_end_date}</p>
										<p class="endDateText">마감</p>
									</div>
									<div class="row__right__myTask">
										<input type="button" value="내가 등록한 과제">
										<input type="button" value="수정하기"
										 id="row__right__myTask__updateBtn"
										 onclick="taskUpdate(${c_task_list.a_idx}, '${c_task_list.study_title}')">
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${!empty A_task_list}">
						<c:forEach var="A_task_list" items="${A_task_list}">
							<div class="lmsCenterContainer__rightBox__card">
								<div class="lmsCenterContainer__rightBox__card__top">
									<span class="tag-title">${A_task_list.study_title}</span>
									<span class="tag-weeks">${A_task_list.a_weeks}주차</span>
								</div>
								<div class="lmsCenterContainer__rightBox__card__middle">
									<h3>${A_task_list.a_title}</h3>
									<p>${A_task_list.a_content }</p>
									<div class="lmsCenterContainer__rightBox__middle__file">
										<div class="files__file">
											<img src="/histudy/lms-img/clip.png">
											<span>${empty A_task_list.a_fname?'첨부된 파일이 없습니다.':A_task_list.a_fname}</span>
										</div>
									</div>
								</div>
								<div class="lmsCenterContainer__rightBox__card__row">
									<div class="row__left">
										<img src="/histudy/lms-img/calendar.png">
										<p>${A_task_list.a_end_date}</p>
										<p class="endDateText">마감</p>
									</div>
									<div class="row__right">
										<c:if test="${empty OK_task_list}">
											<div class="row__right__abtn">
												<a href="taskSubmit.do?a_idx=${A_task_list.a_idx}&study_title=${A_task_list.study_title}">제출하기</a>
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${(empty A_task_list && empty C_task_list)}">
						<div class="lmsCenterContainer__rightBox__card">
							<div class="emptyTask">
								<img src="/histudy/lms-img/emptyTask.png">
								<p>과제가 없습니다.</p>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	</form>
</main>
<%@include file="../footer.jsp" %>
</body>
<script>
	var currentRole = '';
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
	
	function memberCheck(data, idx){
		currentRole = data; // 리더인지 참여자인지
		
		xhr = getXHR();
		xhr.open('GET', 'lmsRest/memberCheck.do?data='+data+'&study_idx='+idx, true);
		xhr.onreadystatechange=myStudyClickResult;
		xhr.send(null); 
	}
	
	function myStudyClickResult(){
		if(xhr.readyState==4){
			if(xhr.status==200){

				var lmsList = xhr.responseText;
				var jsonData = JSON.parse(lmsList);

				var emptyTask =
					'<div class="lmsCenterContainer__rightBox__card">' +
						'<div class="emptyTask">' +
							'<img src="/histudy/lms-img/emptyTask.png">' +
							'<p>과제가 없습니다.</p>' +
						'</div>' +
					'</div>';
				
				var rightLists = document.getElementById('taskArea');
				rightLists.innerHTML = '';
				
				if(lmsList==''||lmsList==null||jsonData==null||jsonData.length==0||jsonData==''){
					rightLists.innerHTML = emptyTask;
				}
				
				for(var i=0; i<jsonData.length; i++){

					var rightBtn = '';

					if(currentRole == 'leader'){
						rightBtn =
						'<div class="row__right__myTask">' +
							'<input type="button" value="내가 등록한 과제">' +
							'<input type="button" value="수정하기" id="row__right__myTask__updateBtn" onclick="taskUpdate(' + jsonData[i].a_idx + ', \'' + jsonData[i].study_title.replace(/'/g, "\\'") + '\')">' +
						'</div>';
					}else{
						rightBtn =
						'<div class="row__right__abtn">' +
							'<a href="taskSubmit.do?a_idx=' + jsonData[i].a_idx +
							'&study_title=' + jsonData[i].study_title + '">' +
							'제출하기</a>' +
						'</div>';
					}

					rightLists.innerHTML +=
					'<div class="lmsCenterContainer__rightBox__card">' +

						'<div class="lmsCenterContainer__rightBox__card__top">' +
							'<span class="tag-title">' + jsonData[i].study_title + '</span>' +
							'<span class="tag-weeks">' + jsonData[i].a_weeks + '주차</span>' +
						'</div>' +

						'<div class="lmsCenterContainer__rightBox__card__middle">' +
							'<h3>' + jsonData[i].a_title + '</h3>' +
							'<p>' + jsonData[i].a_content + '</p>' +

							'<div class="lmsCenterContainer__rightBox__middle__file">' +
								'<div class="files__file">' +
									'<img src="/histudy/lms-img/clip.png">' +
									'<span>' +
									(jsonData[i].a_fname == null ? '첨부된 파일이 없습니다.' : jsonData[i].a_fname) +
									'</span>' +
								'</div>' +
							'</div>' +
						'</div>' +

						'<div class="lmsCenterContainer__rightBox__card__row">' +
							'<div class="row__left">' +
								'<img src="/histudy/lms-img/calendar.png">' +
								'<p>' + jsonData[i].a_end_date + '</p>' +
								'<p class="endDateText">마감</p>' +
							'</div>' +

							'<div class="row__right">' +
								rightBtn +
							'</div>' +
						'</div>' +

					'</div>';
				}
			}
		}
	}
	
	function taskCheck(data){
		xhr = getXHR();
		xhr.open('GET', 'lmsRest/taskCheck.do?toggle='+data, true);
		xhr.onreadystatechange=taskCheckResult;
		xhr.send(null);
	}
	function taskCheckResult(){
		if(xhr.readyState==4){
			if(xhr.status==200){
				var taskSubmitOkList = xhr.responseText;
				var jsonData = JSON.parse(taskSubmitOkList);
				
				var rightLists = document.getElementById('taskArea');
				rightLists.innerHTML = '';
				
				var emptyTask =
					'<div class="lmsCenterContainer__rightBox__card">' +
						'<div class="emptyTask">' +
							'<img src="/histudy/lms-img/emptyTask.png">' +
							'<p>과제가 없습니다.</p>' +
						'</div>' +
					'</div>';
					
				if(jsonData==null || jsonData.length==0){
					rightLists.innerHTML = emptyTask;
				}	
					
				
				for(let i=0; i<jsonData.length; i++){
					
					var rightBtn = '';
					
					if(jsonData[i].memberStatus == '개설자'){
						rightBtn = 
						'<div class="row__right__myTask">' +
							'<input type="button" value="내가 등록한 과제">' +
							'<input type="button" value="수정하기" id="row__right__myTask__updateBtn" onclick="taskUpdate(' + jsonData[i].a_idx + ', \'' + jsonData[i].study_title.replace(/'/g, "\\'") + '\')">' +
						'</div>';
					}else if(jsonData[i].memberStatus == '참여자'){
						rightBtn = 
						'<div class="row__right__abtn">' +
							'<a href="taskSubmit.do?a_idx=' + jsonData[i].a_idx +
								'&study_title=' + jsonData[i].study_title + '">' +
							'제출하기</a>' +
						'</div>';
					}else if(jsonData[i].memberStatus == null || jsonData[i].memberStatus == ''){
						rightBtn = 
						'<div class="row__right__myTask">' +
							'<input type="button" value="제출 완료">' +
							'<input type="button" value="수정하기" id="row__right__myTask__taskSubmitUpdateBtn" onclick="taskSubmitUpdate(' + jsonData[i].a_idx + ', \'' + jsonData[i].study_title.replace(/'/g, "\\'") + '\')">' +
						'</div>';
					}
					
					rightLists.innerHTML += 
					'<div class="lmsCenterContainer__rightBox__card">' +

						'<div class="lmsCenterContainer__rightBox__card__top">' +
							'<span class="tag-title">' + jsonData[i].study_title + '</span>' +
							'<span class="tag-weeks">' + jsonData[i].a_weeks + '주차</span>' +
						'</div>' +

						'<div class="lmsCenterContainer__rightBox__card__middle">' +
							'<h3>' + jsonData[i].a_title + '</h3>' +
							'<p>' + jsonData[i].a_content + '</p>' +

							'<div class="lmsCenterContainer__rightBox__middle__file">' +
								'<div class="files__file">' +
									'<img src="/histudy/lms-img/clip.png">' +
									'<span>' +
									(jsonData[i].a_fname == null ? '첨부된 파일이 없습니다.' : jsonData[i].a_fname) +
									'</span>' +
								'</div>' +
							'</div>' +
						'</div>' +

						'<div class="lmsCenterContainer__rightBox__card__row">' +
							'<div class="row__left">' +
								'<img src="/histudy/lms-img/calendar.png">' +
								'<p>' + jsonData[i].a_end_date + '</p>' +
								'<p class="endDateText">마감</p>' +
							'</div>' +

							'<div class="row__right">' +
								rightBtn +
							'</div>' +
						'</div>' +

					'</div>';
				}
				
			}
		}
	}
	// 과제 등록 수정
	function taskUpdate(a_idx, study_title){
		location.href='taskInsertUpdate.do?a_idx='+a_idx+'&study_title='+study_title;
	}
	// 제출한 과제 수정
	function taskSubmitUpdate(a_idx, study_title){
		location.href='taskSubmitUpdate.do?a_idx='+a_idx+'&study_title='+study_title;
	}

	// 왼쪽 카드 클릭 시
	var cards = document.querySelectorAll('.lmsCenterContainer__leftBox__stduyIng__card');
	for(let i=0; i<cards.length; i++){
		cards[i].addEventListener('click', function(){
			
			for(let j=0; j<cards.length; j++){
				cards[j].classList.remove('active');
			}
			cards[i].classList.add('active');
			
		});	
	}
	
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
</script>
</html>