<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- SEO -->
<title>서비스 이용약관</title>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/root.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/user/loginModal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/privacy/terms.css">
</head>
<body>
	<%@ include file="../header.jsp"%>

	<main class="terms-wrapper">
		<div class="terms-container">
			<h1>Hi, Study 서비스 이용약관</h1>

			<section class="term-section">
				<h2>제 1 장 총칙</h2>
				<h3>제 1 조 (목적)</h3>
				<p>본 약관은 "Hi, Study"(이하 "사이트")가 제공하는 스터디 모집, 멘토링 신청, 스터디 카페 예약 및
					온라인 강의 수강 서비스(이하 "서비스")를 이용함에 있어 관리자와 이용자의 권리, 의무를 규정함을 목적으로 합니다.</p>

				<h3>제 2 조 (용어의 정의)</h3>
				<ol>
					<li>"회원"이란 사이트에 개인정보를 제공하여 회원가입을 한 자로서, 아이디(ID)를 부여받아 서비스를
						계속적으로 이용할 수 있는 자를 말합니다.</li>
					<li>"멘토"란 자신의 지식을 공유하기 위해 프로필을 등록하고 멘토링을 개설한 회원을 말합니다.</li>
					<li>"팀장"이란 스터디 그룹을 직접 개설하여 운영하는 회원을 말합니다.</li>
					<li>"프리미엄 회원"이란 별도의 멤버십 결제를 통해 온라인 강의 수강 혜택을 부여받은 회원을 의미합니다.</li>
				</ol>
			</section>

			<section class="term-section">
				<h2>제 2 장 회원가입 및 이용 계약</h2>
				<h3>제 3 조 (회원가입 조건)</h3>
				<ol>
					<li>이용자는 아이디, 비밀번호(7자리 이상의 영문/숫자 조합), 성명, 연락처 등을 입력하여 가입을
						신청합니다.</li>
					<li>만 14세 미만의 아동은 법정대리인(부모)의 동의를 얻어야 하며, 일부 서비스(19세 이상 관람가 관련
						등) 이용이 제한될 수 있습니다.</li>
					<li>아이디 중복 검사를 통과하지 못하거나 허위 정보를 입력한 경우 가입이 거절될 수 있습니다.</li>
				</ol>

				<h3>제 4 조 (회원 탈퇴 및 재가입 제한)</h3>
				<p>회원은 언제든지 마이페이지를 통해 탈퇴를 요청할 수 있으나, 부정 이용 방지를 위해 탈퇴 후 30일 이내에는
					재가입이 제한됩니다. 탈퇴 시 보유한 포인트 및 혜택은 소멸됩니다.</p>
			</section>

			<section class="term-section">
				<h2>제 3 장 서비스 이용 규정</h2>
				<h3>제 5 조 (스터디 및 멘토링 운영)</h3>
				<ol>
					<li>스터디 그룹의 모집 인원은 최대 6명으로 제한하며, 모집 기간 내 인원 미달 시 게시글이 자동 삭제될 수
						있습니다.</li>
					<li>사용자는 최대 3개의 스터디에 동시 신청할 수 있으며, 팀장의 승인을 통해 참여가 확정됩니다.</li>
					<li>멘토링 신청 시 멘토는 신청자의 프로필과 지원 동기를 확인하여 승인 또는 거절할 수 있습니다.</li>
				</ol>

				<h3>제 6 조 (스터디 카페 예약 및 결제)</h3>
				<p>스터디 카페 예약은 시간권, 종일권, 정기권으로 운영되며 결제 API를 통한 선결제 후 이용이 가능합니다.
					이중 결제 등 시스템 오류 발생 시 관리자 문의를 통해 환불 절차를 진행할 수 있습니다.</p>

				<h3>제 7 조 (온라인 강의 수강)</h3>
				<p>프리미엄 멤버십(월 29,000원/50,000원 등)을 결제한 회원에 한하여 제공되는 혜택으로, 일반 회원은
					강의 목록 열람은 가능하나 수강은 제한됩니다.</p>
			</section>

			<section class="term-section">
				<h2>제 4 장 계약 당사자의 의무 및 제재</h2>
				<h3>제 8 조 (부적절한 행위에 대한 제재)</h3>
				<ol>
					<li>타인의 정보를 도용하거나 불법 광고, 음란물을 게시하는 경우 관리자는 사전 통보 없이 게시물을 삭제하고
						해당 회원을 정지 또는 탈퇴 처리할 수 있습니다.</li>
					<li>누적 신고 건수가 일정 기준(예: 5건 이상)을 초과하는 회원은 관리자의 모니터링을 통해 서비스 이용이
						영구 제한될 수 있습니다.</li>
					<li>관리자에 의해 삭제된 스터디/멘토링의 참여 신청자들에게는 해당 사실이 알림함을 통해 통보됩니다.</li>
				</ol>
			</section>

			<div class="term-section"
				style="margin-top: 60px; text-align: right; color: #888;">
				<p>시행일자: 2026년 02월 01일</p>
				<p>Hi, Study 운영팀 드림</p>
			</div>
		</div>
	</main>

	<%@ include file="../footer.jsp"%>

	<div id="modalOverlay">
		<div id="modalContent" class="login-modal-box"></div>
	</div>
	<script src="${pageContext.request.contextPath}/js/user/user.js"></script>
</body>
</html>