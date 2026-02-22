<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/studyDesign/studyContent.css">
</head>
<body id="studyContentPage">
<%@include file="../header.jsp" %>
<main>
	<form name="studyContent">
		<section class="studyContent">
			<div class="studyContentContainer">
				<div class="studyContent__left">
					<div class="studyContent__top">
						<p>홈 &nbsp; > &nbsp; 스터디 &nbsp; > &nbsp; ${dto.study_title}</p>
					</div>
					<div class="studyContent__left__box">
						<span class="studyContent-tag">${dto.sc_name}</span>
						<h1 class="studyContent__title">${dto.study_title}</h1>
						<p class="studyContent__sub">
							${dto.study_content.substring(0, 69)}...
						</p>
						<div class="studyContent__left__box__cate">
							<div class="st_cate">
								<img src="/histudy/main-img/personnel.png">
								<span>${dto.study_current_members}/${dto.study_max_members}명</span>
							</div>
							<div class="st_cate">
								<img src="/histudy/main-img/clock.png">
								<span>${dto.study_total_weeks}주</span>
							</div>
							<div class="st_cate">
								<img src="/histudy/main-img/clock.png">
								<span>마감일 - ${dto.study_end_date.substring(0, 10)}</span>
							</div>
							<div class="st_cate">
								<img src="/histudy/main-img/location.png">
								<span>${empty dto.study_addr?'장소가 지정되지 않았어요':dto.study_addr}</span>
							</div>
						</div>
						<div class="studyContent__left__box__reader">
							<img src="/histudy/main-img/junbeom.png">
							<div class="studyContent__left__box__reader__text">
								<p>스터디 리더</p>
								<h3>${dto.user_name}</h3>
								<p>환영합니다 !</p>
							</div>
						</div>
					</div>
				</div>
				<div class="studyContent__right">
					<div class="studyContent__right__top">
						<div class="studyContent__right__top__tag">
							<img src="/histudy/main-img/gift.png">
							<p>무료 참여</p>
						</div>
						<p class="studyContent__right__top__title">Hi, Study 회원이라면 누구나 무료로 참여 가능!</p>
					</div>
					<div class="studyContent__right__middle">
						<div class="studyContent__right__middle__box">
							<p>모집 인원</p>
							<p>${dto.study_current_members}/${dto.study_max_members}명</p>
						</div>
						<div class="studyContent__right__middle__box">
							<p>모집 기간</p>
							<p>${dto.study_start_date} ~ ${dto.study_end_date.substring(0, 10)}</p>
						</div>
						<div class="studyContent__right__middle__box">
							<p>스터디 시작일</p>
							<p>${dto.study_begin_date.substring(0,10)}</p>
						</div>
						<div class="studyContent__right__middle__box">
							<p>스터디 일정</p>
							<p>${dto.study_total_weeks}주</p>
						</div>
					</div>
					<div class="studyContent__right__btns">
						<input type="button" value="참여 신청하기" class="btn1" onclick="studyApplyModal()">
						<input type="button" value="문의하기" class="btn2" onclick="userInquiry()">
					</div>
					<p class="trtr">신청 후 알림함을 통해 승인 여부가 전송됩니다.</p>
				</div>
			</div>
		</section>
		<section class="studyContent__dt" id="scd">
			<div class="studyContent__dt__container">
				<h1>스터디 소개</h1>
				<textarea name="studyContent__dt__content" rows="20" cols="40" readonly>${dto.study_content}</textarea>
				<div class="studyContent__dt__btns">
				
					<!-- 모집 진행률 -->
					<div class="studyCard progressCard">
						<img src="/histudy/main-img/team.png">
				
						<h1>모집 진행률</h1>
				
						<div class="progressBar">
							<div class="progressFill"
								style="width:${(dto.study_current_members*100)/dto.study_max_members}%">
							</div>
						</div>
				
						<h2>${dto.study_current_members}/${dto.study_max_members}명</h2>
						<p>현재 참여중인 스터디원</p>
					</div>
				
					<!-- 일정 요약 -->
					<div class="studyCard infoCard">
						<img src="/histudy/main-img/clock.png">
				
						<h1>스터디 일정</h1>
				
						<h2>${dto.study_total_weeks}주</h2>
				
						<p>시작일 · ${dto.study_begin_date.substring(0,10)}</p>
					</div>
				
				</div>
				<div class="studyLocation">
					<!-- 지도 안내 문구 -->
					<h1 class="map-instruction">스터디 장소</h1>
		
					<div id="map"
						${empty dto.study_addr?'style="border:none;"':'style="width:100%;
				            												height:350px;
				            												border: 1px solid black;
				            												border-radius: 10px;
																			margin-bottom: 10px;"'}></div>
		
					<div id="clickLatlng"></div>
					<div class="studyLocationAddr">
						<input type="text" id="study_address" name="study_addr"
							placeholder="선택한 주소가 여기에 표시됩니다."
							value="${empty dto.study_addr?'장소가 지정되지 않았어요!':dto.study_addr}"
							readonly>
					</div>
					<input type="hidden" name="study_location_lat"
						value="${empty dto.study_location_lat?'':dto.study_location_lat}">
					<input type="hidden" name="study_location_lng"
						value="${empty dto.study_location_lng?'':dto.study_location_lng}">
				</div>
			</div>
		</section>
	</form>
</main>
<!-- 참여 신청 모달 -->
<div id="applyModal" class="modalBg" style="display:none;">
	<div class="modalBox">
		
		<h2>스터디 참여 신청</h2>
		
		<textarea id="applyContent" name="sa_intro" placeholder="간단한 자기소개를 입력해주세요 (최대 30자)" rows="6"></textarea>
		
		<div class="modalBtns">
			<button onclick="closeModal()">취소하기</button>
			<button onclick="submitApply()">신청하기</button>
		</div>
		
	</div>
</div>
<%@include file="../footer.jsp" %>
</body>
<script type="text/javascript" 
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bfd1692e45797ef0c18f5709f6bffce4&libraries=services&autoload=false"></script>

<script>
kakao.maps.load(function() {
	var dblat = document.studyContent.study_location_lat.value;
	var dblng = document.studyContent.study_location_lng.value;
	if(dblat == null || dblng == null){
		return;
	}else{
	    var mapContainer = document.getElementById('map'),
        mapOption = { 
            center: new kakao.maps.LatLng(dblat, dblng), 
            level: 3 
        };

	    var map = new kakao.maps.Map(mapContainer, mapOption);
	    var marker = new kakao.maps.Marker({ position: map.getCenter() });
	    marker.setMap(map);
	
	    var geocoder = new kakao.maps.services.Geocoder();
	}
});

function studyApplyModal(){
	document.getElementById('applyModal').style.display='flex';
}
function closeModal(){
	document.getElementById('applyModal').style.display='none';
}
function submitApply(){
	
	var intro = document.getElementById('applyContent').value;
	
	if(intro.trim()==''){
		alert('자기소개를 입력하세요');
		return;
	}
	
	location.href='studyApply.do?study_idx='+${dto.study_idx}+'&sa_intro='+encodeURIComponent(intro);
}

function userInquiry(){
	location.href='userInquiryList.do';
}
</script>
</html>