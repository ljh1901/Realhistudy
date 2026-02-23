<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<link rel="stylesheet" href="css/root.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>

<style>
section>h1, section>p {
	margin-left: 5%;
}

section>p {
	color: gray;
}

#studycafeBody header {
	background: white;
	box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.korea__region {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin: 20px 0;
	flex-wrap: wrap;
}

.korea__region button {
	padding: 6px 14px;
	background: white;
	border: 1px solid #ddd;
	border-radius: 20px;
	cursor: pointer;
	transition: 0.2s;
}

.korea__region button:hover {
	background: #6366f1;
	color: white;
	border-color: #6366f1;
}

.studycafeList {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
	margin: 2% 5% 5%;
}

.studycafeIdx {
	background: #fff;
	border-radius: 14px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
	overflow: hidden;
	transition: 0.2s;
	display: flex;
	flex-direction: column;
}

.studycafeIdx:hover {
	transform: translateY(-6px);
}

.studycafeList__header img {
	width: 100%;
	height: 220px;
	object-fit: cover;
}

.studycafeInfo {
	display: flex;
	justify-content: space-between;
	padding: 15px;
	font-weight: 700;
	font-size: 18px;
}

.studycafeList__body {
	padding: 0 15px 15px 15px;
	display: flex;
	justify-content: space-between;
	font-size: 14px;
	color: #555;
}

.studycafeList__footer {
	padding: 15px;
	margin-top: auto;
}

.studycafeUse {
	width: 100%;
	padding: 12px 0;
	border: none;
	border-radius: 8px;
	background: #6366f1;
	color: white;
	font-weight: 600;
	cursor: pointer;
	transition: 0.2s;
}

.studycafeUse:hover {
	background: #4f46e5;
}

/* 스와이퍼 css 준범 수정 */
.swiper {
	width: 100%;
	height: 300px;
	margin: 80px 0 5%;
}

.swiper-slide {
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 22px;
	font-weight: 700;
}

.slide1{
	background: linear-gradient(
	  135deg,
	  #FFF6F8 0%,
	  #FFF7F5 40%,
	  #FFF9F7 70%,
	  #FFFDFB 100%
	);
}
.slide-study-content{
	text-align: center;
	padding: 20px 30px;
}
.slide-study-content h1{
	font-weight: bold;
}
.slide-study-content p{
	font-size: 1rem;
	color: #222;
	margin-top: 20px;
}
.slide-study-btn{
	border: none;
	border-radius:15px;
	width:160px;
	padding:1rem;
	background-color: #111827;
	color: white;
	margin-top:20px;
	font-size:1rem;
	cursor: pointer;
	transition: transform 0.25s ease, box-shadow 0.25s ease;
}
.slide-study-btn:hover{
    transform: scale(1.05);
    box-shadow: 0 6px 15px rgba(0,0,0,0.2);
}
.slide2 {
	background: url("main-img/primiam.png") center/cover no-repeat;
	position: relative;
}

.slide2::before {
	content: "";
	position: absolute;
	inset: 0;
	background: rgba(0, 0, 0, 0.4);
}

.slide2-content {
	position: relative;
	z-index: 1;
	color: white;
	text-align: center;
	padding: 20px 30px;
}

.slide2-content h1{
	font-weight: bold;
}

.slide2-content p{
	font-size: 1rem;
	color: white;
	margin-top: 20px;
}

.slide3{
	background: #f4fff2;
}
.slide3-content{
	text-align: center;
	padding: 20px 30px;
}
.slide3-content h1{
	font-weight: bold;
}
.slide3-content p{
	font-size: 1rem;
	color: #222;
	margin-top: 20px;
}
.slide3-content button{
	border: none;
	border-radius:15px;
	width:160px;
	padding:1rem;
	background-color: #111827;
	color: white;
	margin-top:20px;
	font-size:1rem;
	cursor: pointer;
	transition: transform 0.25s ease, box-shadow 0.25s ease;
}
.slide3-content button:hover{
    transform: scale(1.05);
    box-shadow: 0 6px 15px rgba(0,0,0,0.2);
}
.slide-study-content h1,
.slide2-content h1,
.slide3-content h1 {
    text-shadow: 1.5px 1.5px 6px rgba(0,0,0,0.35);
}
.slide-study-content p,
.slide2-content p,
.slide3-content p {
    line-height: 1.6;
}
.fa-solid{
	margin-right: 10px;
}

.swiper-button-prev,
.swiper-button-next {
    width: 40px;
    height: 40px;
    padding:0.5rem;
    background-color: #111827;
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white; 
    font-size: 1.5rem;
    font-weight: bold;
}
.paging__area{
      padding-bottom: 30px;
      display: flex;
      justify-content: center;
      font-size: 1.2rem;
      font-weight: bold;
      gap:1rem;
}
.paging img{
      width: 30px;
}
</style>
<script src="https://kit.fontawesome.com/3f5acacf0e.js" crossorigin="anonymous"></script>
</head>
<body id="studycafeBody">
	<%@include file="../header.jsp"%>
	<main>
		<div class="swiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide slide1">
				    <div class="slide-study-content">
				        <h1>Hi, Study 스터디 참여하기</h1>
				        <p>다양한 스터디와 함께 성장할 수 있는 기회를 제공합니다.</p>
				        <button class="slide-study-btn" type="button" onclick="javascript:location.href='studyList.do'">스터디 시작하기</button>
				    </div>
				</div>
				<div class="swiper-slide slide2">
					<div class="slide2-content">
						<h1>쾌적한 환경의 스터디 카페</h1>
						<p>집중을 위한 최적의 공간을 제공합니다</p>
					</div>
				</div>
				<div class="swiper-slide slide3">
					<div class="slide3-content">
						<h1 class="text-4xl font-bold text-white mb-4">함께 성장하는 멘토링 플랫폼</h1>
						<p class="text-lg text-teal-100 mb-8">전문 멘토와 1:1 상담으로 목표 달성을 지원합니다.</p>
						<button class="mentoring" onclick="javascript:location.href='mentorList.do'">멘토링 시작하기</button>
					</div>
				</div>
			</div>
			<div class="swiper-pagination"></div>
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
		<section>
			<h1>스터디 카페</h1>
			<p>집중할 수 있는 공간을 예약해보세요.</p>
			<div class="korea__region"></div>
			<div class="studycafeList">
				<c:forEach var="studycafe" items="${requestScope.studycafeList}">
					<div class="studycafeIdx">
						<div class="studycafeList__header">
							<img src="img/histudyNum1.png" alt="histudy">
							<div class="studycafeInfo">
								<div>${studycafe.studycafe_name}</div>
								<div>
									<a href="studycafeReview.do?studycafe_idx=${studycafe.studycafe_idx}">이용 후기</a>
								</div>
							</div>
						</div>
						<div class="studycafeList__body">
							<div><i class="fa-solid fa-couch"></i>${studycafe.avaliable}/${studycafe.all}석</div>
							<div>${studycafe.studycafe_addr}</div>
						</div>
						<div class="studycafeList__footer">
							<button class="studycafeUse" value="${studycafe.studycafe_idx}">이용하기</button>
						</div>
					</div>
				</c:forEach>
			</div>
				<div class="paging__area">${paging}</div>
		</section>
	</main>
	<%@include file="../footer.jsp"%>
</body>
	<script>
	var region = '${region}';
	var currentPage = ${currentPage};
	document.querySelector('.studycafeList').addEventListener('click', function(e) {
		var btn = e.target.closest('.studycafeUse');
		location.href = 'studycafe.do?studycafe_idx=' + btn.value;
	});
	</script>
	<script src="js/studycafe/studycafeList/swiper.js" type="text/javascript"></script>
<script src="js/studycafe/studycafeList/regionSelect.js" type="text/javascript"></script>
</html>
