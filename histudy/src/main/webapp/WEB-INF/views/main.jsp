<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="/histudy/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css"
	href="/histudy/css/user/loginModal.css">
<script>
if(${!empty msg}){
	alert(${requestScope.msg});
}
</script>
</head>
<body>
	<%@include file="header.jsp"%>
	<main>
		<!--Home -->
		<section class="home">
			<div class="home__text">
				<p class="description">함께 성장하는</p>
				<h1 class="home__title">Study & Mentoring</h1>
				<p class="description">목표에 맞는 스터디 그룹과 멘토링으로 학습을 이어가세요.</p>
			</div>
			<div class="home__btns">
				<input type="button" value="스터디 시작하기" class="home__btn"> <input
					type="button" value="멘토링 신청" class="home__btn"
					id="applyMentoringBtn">
			</div>
		</section>

		<!-- serviceSection -->
		<section id="serviceSection" class="section">
			<div class="serviceController max-container">
				<div class="service__text">
					<p>우리의 서비스</p>
					<h2>당신의 학습 여정을</h2>
					<h2>
						<i>완벽하게 지원합니다</i>
					</h2>
				</div>
				<div class="service__grid">
					<div class="service__grid__items">
						<div class="service__grid__imgBox">
							<img src="/histudy/main-img/groupStudy.png">
						</div>
						<div class="service__grid__textBox">
							<h3>그룹 스터디</h3>
							<p>함께 목표 달성</p>
						</div>
					</div>
					<div class="service__grid__items">
						<div class="service__grid__imgBox">
							<img src="/histudy/main-img/mentoring.png">
						</div>
						<div class="service__grid__textBox">
							<h3>1:1 멘토링</h3>
							<p>전문가의 맞춤 조언</p>
						</div>
					</div>
					<div class="service__grid__items">
						<div class="service__grid__imgBox">
							<img src="/histudy/main-img/studyCafe.png">
						</div>
						<div class="service__grid__textBox">
							<h3>스터디 카페</h3>
							<p>집중 학습 공간</p>
						</div>
					</div>
					<div class="service__grid__items">
						<div class="service__grid__imgBox">
							<img src="/histudy/main-img/lectuer.png">
						</div>
						<div class="service__grid__textBox">
							<h3>온라인 강의</h3>
							<p>프리미엄 회원 혜택</p>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- MembershipSection -->
		<section id="MembershipSection" class="section">
			<div class="membershipContainer max-container">
				<div class="membershipBG">
					<div class="membershipTEXT">
						<p class="membership-sub">프리미엄 멤버십</p>
						<h2 class="membership-title">더 많은 혜택을</h2>
						<p class="membership-desc">경험하세요</p>
						<a href="membership.do"><button class="membership-btn">멤버십 알아보기</button></a>
					</div>
				</div>
			</div>
		</section>

		<!-- ReviewSection -->
		<section id="ReviewSection" class="section">
			<div class="reviewContainer max-container">
				<div class="reviewText">
					<p>사용자 후기</p>
					<h2>실제 이용자들의</h2>
					<h2>
						<i>생생한 경험담</i>
					</h2>
				</div>
				<div class="reviewGrid">
					<div class="reviewCard">
						<div class="reviewHeader">
							<img src="/histudy/main-img/beom.jpg" class="reviewAvatar">
							<div class="reviewUser">
								<p class="reviewName">서준범</p>
								<p class="reviewId">seoni65</p>
							</div>
						</div>
						<p class="reviewContent">"전문 멘토님의 조언 덕분에 진로를 명확하게 설정할 수 있었습니다.
							정말 감사드려요. 앞으로도 계속 이용할 예정입니다!"</p>
					</div>
					<div class="reviewCard">
						<div class="reviewHeader">
							<img src="/histudy/main-img/sung.jpg" class="reviewAvatar">
							<div class="reviewUser">
								<p class="reviewName">김성지</p>
								<p class="reviewId">tjdwl12</p>
							</div>
						</div>
						<p class="reviewContent">"멘토링 덕분에 목표했던 자격증을 단기간에 취득할 수 있었어요.
							1:1 맞춤 학습이 정말 효과적이었습니다!"</p>
					</div>
					<div class="reviewCard">
						<div class="reviewHeader">
							<img src="/histudy/main-img/sang.jpg" class="reviewAvatar">
							<div class="reviewUser">
								<p class="reviewName">양상연</p>
								<p class="reviewId">sang__chi</p>
							</div>
						</div>
						<p class="reviewContent">"스터디 카페 좌석현황을 한 눈에 볼 수 있고, 예약까지..?
							저한테 진짜 필요했었는데 매우 유용하게 이용하고 있습니다!"</p>
					</div>
					<div class="reviewCard">
						<div class="reviewHeader">
							<img src="/histudy/main-img/min.jpg" class="reviewAvatar">
							<div class="reviewUser">
								<p class="reviewName">김민영</p>
								<p class="reviewId">alsdud12</p>
							</div>
						</div>
						<p class="reviewContent">"그룹 스터디에서 만난 동료들과 함께 성장하는 느낌이 정말
							좋아요."</p>
					</div>
					<div class="reviewCard">
						<div class="reviewHeader">
							<img src="/histudy/main-img/yoo.jpg" class="reviewAvatar">
							<div class="reviewUser">
								<p class="reviewName">유준상</p>
								<p class="reviewId">wnstkd12</p>
							</div>
						</div>
						<p class="reviewContent">"온라인 강의 퀄리티가 정말 높아요. 프리미엄 회원이라면 언제
							어디서나 학습할 수 있어서 직장인인 저에게 딱 맞습니다!"</p>
					</div>
					<div class="reviewCard">
						<div class="reviewHeader">
							<img src="/histudy/main-img/ju.jpg" class="reviewAvatar">
							<div class="reviewUser">
								<p class="reviewName">이주호</p>
								<p class="reviewId">wngh12</p>
							</div>
						</div>
						<p class="reviewContent">"스터디 그룹 분위기가 정말 좋아요. 서로 응원하고 격려하면서 함께
							성장하는 느낌!"</p>
					</div>
				</div>
			</div>
		</section>

		<!-- aboutSection -->
		<section id="AboutSection" class="section">
			<div class="aboutContainer max-container">
				<div class="aboutLeft">
					<p>ABOUT US</p>
					<img src="/histudy/main-img/aboutImg.png">
				</div>
				<div class="aboutRight">
					<h2>학습의 새로운 패러다임</h2>
					<h2>
						<i>Hi, Study와 함께</i>
					</h2>
					<h2>시작하세요</h2>
					<p>StudyMate는 단순한 학습 플랫폼을 넘어, 여러분의 성장을 함께하는 파트너입니다. 전문 멘토와의 1:1
						맞춤 학습부터 그룹 스터디, 온라인 강의까지 다양한 학습 방법을 제공합니다.</p>
					<p>집중력을 높이는 스터디 카페 공간과 프리미엄 멤버십 혜택으로 여러분의 학습 목표 달성을 완벽하게 지원합니다.
					</p>
				</div>
			</div>
		</section>
	</main>
	<%@include file="footer.jsp"%>
	<div id="modalOverlay">
		<div id="modalContent" class="login-modal-box"></div>
	</div>
</body>
<script src="js/user/user.js"></script>
<script>
   // == 서준범 JavaScript 코드 == 
   //== 페이지 스크롤 시 Header 커스텀 ==
   const header = document.querySelector('.header');
   const headerHeight = header.getBoundingClientRect().height;
   
   document.addEventListener('scroll', function () {
     if (window.scrollY > headerHeight) {
       header.classList.add('header--white');
     } else {
       header.classList.remove('header--white');
     }
   });
    //== 검색창 커스텀 ==
   //1. 데이터 수집
   const selectBox = document.querySelector('.custom-select');
   const selected = document.querySelector('.selected');
   const options = document.querySelectorAll('.options li');

   //2. 셀렉트 열기
   selectBox.addEventListener('click', function(e) {
      e.stopPropagation();
      this.classList.toggle('open');
   });

   //3. 셀렉트 변경 후 닫기
   for (var i = 0; i < options.length; i++) {
      options[i].addEventListener('click', function(e) {
         e.stopPropagation();
         selected.innerHTML = this.innerHTML;
         selectBox.classList.remove('open');
      });
   }

   //4. 셀렉트 닫기
   document.addEventListener('click', function() {
      selectBox.classList.remove('open');
   });
</script>
</html>