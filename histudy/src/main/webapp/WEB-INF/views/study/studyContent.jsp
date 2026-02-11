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
<style>
	#studyContentPage header{
		background-color: white;
		box-shadow: 0 2px 8px rgba(0,0,0,0.06);
	}
	.studyContent{
	  margin-top: 80px;
      background-color: #FFF4EE;
	}
	.studyContentContainer{
		padding: 3rem 5rem;
		display: flex;
		justify-content: space-between;
	}
	.studyContent__top{
		margin-bottom: 20px;
	}
	.studyContent__top p{
		color: #888;
		padding-bottom: 10px;
		font-size: 0.8rem;
	}
	.studyContent__title{
		font-size: 3.5rem;
		font-weight: 600;
	}
	.studyContent__sub{
		margin-top:10px;
		font-size:1.3rem;
		color: #4B5563;
	}
	.studyContent-tag{
		 display: inline-block;
	     padding: 6px 14px;
	     font-size: 1rem;
	     font-weight: 500;
	     border-radius: 999px; 
	     background-color: #F3E8FF;
	     color: #7C3AED;  
	}
	.studyContent__left__box__cate{
		display: flex;
		align-items: center;
		padding-top:30px;
	}
	.studyContent__left__box__cate img{
		width:18px;
      	margin-right: 8px;
	}
	.st_cate{
		display: flex;
		align-items: center;
		margin-right: 15px;
		background-color: white;
		box-shadow: 0 0 1px rgb(0,0,0,0.2);
		border-radius: 30px;
		padding:0.7rem;
	}
	.st_cate span{
		font-size: 0.8rem;
	}
	.studyContent__left{
		max-width: 750px;
	}
	.studyContent__left__box__reader{
		padding: 1rem;
		display: flex;
		align-items: center;
		margin-top:30px;
		background-color: white;
		border-radius: 20px;
		box-shadow: 0 0 1px rgb(0,0,0,0.2);
	}
	.studyContent__left__box__reader img{
		width: 85px;
		height: 85px;
		border-radius: 100%;
		margin-right:20px;
		margin-left: 10px;
	}
	.studyContent__left__box__reader__text{
		line-height: 1.8rem;
	}
	.studyContent__left__box__reader__text p{
		color: #4B5563;
		font-size:1rem;
	}
	.studyContent__left__box__reader__text h3{
		font-size:1.5rem;
		font-weight: 500;
	}
	.studyContent__right{
		min-width:500px;
		background-color: white;
		padding:2rem;
		border-radius: 20px;
		box-shadow: 0 3px 10px rgb(0,0,0,0.2);
		margin-left:30px;
		margin-top: 50px;
	}
	.studyContent__right__top img{
		width:20px;
		margin-right:10px;
	}
	.studyContent__right__top__tag{
		display: flex;
		max-width:130px;
	    padding: 6px 14px;
	    font-size: 1rem;
	    font-weight: 500;
	    border-radius: 999px; 
	    background-color: #CCFBF1;
	    color: #0F766E;
	}
	.studyContent__right__top__title{
		font-size: 1.2rem;
		color: #666;
		margin-top: 20px;
	}
	.studyContent__right__middle{
		margin-top:30px;
	}
	.studyContent__right__middle__box{
		display: flex;
		align-items: center;
		justify-content: space-between;
		border-bottom: 1px solid #ccc;
		margin-bottom: 25px;
	}
	.studyContent__right__middle__box p{
		font-size:0.9rem;
		color: #565F6C;
		margin-bottom:10px;
	}
	.studyContent__right__btns{
		display: flex;
		justify-content: center;
		flex-direction: column;
		gap:0.5rem;
		padding-bottom: 30px;
		border-bottom: 1px solid #999;
		margin-top: 50px;
	}
	.studyContent__right__btns input{
		padding:1rem;
		border: none;
		border-radius: 20px;
		font-size: 1rem;
	}
	.studyContent__right__btns input[type="submit"]{
		background-color: #111827;
		color: white;
	}
	.studyContent__right__btns input[type="submit"]:hover{
		cursor: pointer;
		background-color: var(--color-navy);
	}
	.studyContent__right__btns input[type="button"]{
		background-color: white;
		color: black;
		border:1px solid #111827;
	}
	.studyContent__right__btns input[type="button"]:hover{
		cursor: pointer;
		background-color: var(--color-navy);
		color: white;
	}
	.trtr{
		margin-top: 30px;
		text-align: center;
		font-size:0.7rem;
	}
	.ajaxBtns{
		display: flex;
		padding: 1rem 6rem;
		gap: 2.5rem;
		font-size: 1.3rem;
		border-bottom: 1px solid #ccc;
	}
	.ajaxBtns p{
		cursor: pointer;
		border-bottom: 1px solid white;
	}
	.ajaxBtns p:hover{
		border-bottom: 1px solid #ccc;
	}
	.studyContent__dt{
		padding:3rem;
	}
	.studyContent__dt__container{
		max-width:1000px;
		margin: 0 auto;
	}
	.studyContent__dt__container textarea{
		margin-top: 30px;
		border-radius: 10px;
        padding:1rem;
        width:100%;
        resize: none;
	}
	.studyContent__dt__btns{
		display: flex;
		margin-top:30px;
	}
	.studyContent__dt__btn_l{
		flex: 1;
		padding: 2rem;
		background-color: #F6EEFF;
		border-radius: 10px;
		margin:10px;
	}
	.studyContent__dt__btn_l img{
		width: 70px;
		border: 1px solid #ccc;
		border-radius: 100%;
		padding:0.3rem;
		background-color: #E9D5FF;
	}
	.studyContent__dt__btn_l h2{
		font-size: 3rem;
		color: #7E22CE;
	}
	.studyContent__dt__btn_r{
		flex: 1;
		padding: 2rem;
		background-color: #D5FBF3;
		border-radius: 10px;
		margin: 10px;
	}
	.studyContent__dt__btn_r img{
		width: 70px;
		border: 1px solid #ccc;
		border-radius: 100%;
		padding:0.3rem;
		background-color: #99F6E4;
	}
	.studyContent__dt__btn_r h2{
		color: #0F766E;
		font-size: 3rem;
	}
	.ch_study{
		background-color: #FAFAFA;
		padding: 2rem 6rem;
	}
	.ch_study__top h1{
		font-size:3rem;
		font-weight: 550;
	}
	.studyLocation{
		margin-top:30px;
		margin-bottom:30px;
	}
	.studyLocation h1{
		margin-bottom:30px;
	}
	.studyLocationAddr{
		display: flex;
		justify-content: center;
	}
	.studyLocation input[type="text"]{
		padding:1rem;
		font-size:1rem;
		border: 1px solid #ccc;
		border-radius: 10px;
		width:100%;
	}
	#map{
		border: 1px solid black;
		border-radius: 10px;
		margin-bottom: 10px;
		z-index:0;
	}
	.studyReview__card{
		border: 1px solid black;
		border-radius: 15px;
		margin-bottom:25px;
		padding: 1rem;
	}
	.studyReview__top{
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 30px;
	}
	.studyReview__card__top{
		display: flex;
		justify-content: space-between;
		margin-bottom:10px;
	}
	.studyReview__card__top__left{
		display: flex;
		align-items: center;
	}
	.studyReview__card__top__left img{
		width:50px;
		height:50px;
		border-radius: 100%;
	}
	.studyReview__card__top__left__text{
		margin-left: 15px;
	}
</style>
</head>
<body id="studyContentPage">
<%@include file="../header.jsp" %>
<main>
	<form name="studyContent" action="studyApply.do">
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
							<p>스터디 일정</p>
							<p>${dto.study_total_weeks}주</p>
						</div>
					</div>
					<div class="studyContent__right__btns">
						<input type="submit" value="참여 신청하기">
						<input type="button" value="문의하기">
					</div>
					<p class="trtr">신청 후 알림함을 통해 승인 여부가 전송됩니다.</p>
				</div>
			</div>
		</section>
		<div class="ajaxBtns">
			<p id="studyOverview">개요</p>
			<p>스터디 장소</p>
			<p id="studyReview">참여자 후기</p>
		</div>
		<section class="studyContent__dt" id="scd">
			<div class="studyContent__dt__container">
				<h1>스터디 소개</h1>
				<textarea name="studyContent__dt__content" rows="20" cols="40">${dto.study_content}</textarea>
				<div class="studyContent__dt__btns">
					<div class="studyContent__dt__btn_l">
						<img src="/histudy/main-img/team.png">
						<h1>목표 달성률</h1>
						<h2>95%</h2>
						<p>참여자의 95%가 목표 점수 달성</p>
					</div>
					<div class="studyContent__dt__btn_r">
						<img src="/histudy/main-img/star.png">
						<h1>만족도</h1>
						<h2>4.9/5.0</h2>
						<p>참여자 평균 만족도</p>
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
				<div class="studyReview">
					<div class="studyReview__top">
						<h1>참여자 후기</h1>
						<p>★★★★☆<span>4.9 (24)</span></p>
					</div>
					<div class="studyReview__middle">
						<div class="studyReview__card">
							<div class="studyReview__card__top">
								<div class="studyReview__card__top__left">
									<img src="/histudy/main-img/junbeom.png">
									<div class="studyReview__card__top__left__text">
										<h3>이다빈</h3>
										<p>2025.01.15</p>
									</div>
								</div>
								<div class="studyReview__card__top__right">
									<p>★★★★☆</p>
								</div>
							</div>
							<div class="studyReview__card__row">
								8주 만에 목표 점수 달성했어요! 체계적인 커리큘럼과 선생님의 세심한 피드백 덕분입니다.
							</div>
						</div>
						<div class="studyReview__card">
							<div class="studyReview__card__top">
								<div class="studyReview__card__top__left">
									<img src="/histudy/main-img/junbeom.png">
									<div class="studyReview__card__top__left__text">
										<h3>민채원</h3>
										<p>2025.01.15</p>
									</div>
								</div>
								<div class="studyReview__card__top__right">
									<p>★★★★☆</p>
								</div>
							</div>
							<div class="studyReview__card__row">
								8주 만에 목표 점수 달성했어요! 체계적인 커리큘럼과 선생님의 세심한 피드백 덕분입니다.
							</div>
						</div>
						<div class="studyReview__card">
							<div class="studyReview__card__top">
								<div class="studyReview__card__top__left">
									<img src="/histudy/main-img/junbeom.png">
									<div class="studyReview__card__top__left__text">
										<h3>박지현</h3>
										<p>2025.01.15</p>
									</div>
								</div>
								<div class="studyReview__card__top__right">
									<p>★★★★☆</p>
								</div>
							</div>
							<div class="studyReview__card__row">
								8주 만에 목표 점수 달성했어요! 체계적인 커리큘럼과 선생님의 세심한 피드백 덕분입니다.
							</div>
						</div>
						<div class="studyReview__card">
							<div class="studyReview__card__top">
								<div class="studyReview__card__top__left">
									<img src="/histudy/main-img/junbeom.png">
									<div class="studyReview__card__top__left__text">
										<h3>천은주</h3>
										<p>2025.01.15</p>
									</div>
								</div>
								<div class="studyReview__card__top__right">
									<p>★★★★☆</p>
								</div>
							</div>
							<div class="studyReview__card__row">
								8주 만에 목표 점수 달성했어요! 체계적인 커리큘럼과 선생님의 세심한 피드백 덕분입니다.
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</section>
	</form>
</main>
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
</script>
</html>