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


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<style>
.logo {
	text-align: center;
	margin: 10% auto;
	box-shadow: black solid 1px;
	border: 1px black solid;
	width: 40%;
	padding:2rem;
}

img {
	width: 20%;
}

.receiptContent {
	padding:1rem;
	border: 1px solid #ccc;
	border-radius: 10px;
}
.receiptContent__top{
	border-bottom: 1px solid black;
	margin-bottom: 10px;
}
.receiptContent__middel{
	border-bottom: 1px solid black;
	margin-bottom: 10px;
}
.receiptContent__middel__card{
	display: flex;
	justify-content: space-between;
}
.receiptContent__middel__card label{
	font-size:1.2rem;
	font-weight: bold;
	font-family: serif;
}
#lastindex{
	margin-bottom: 10px;
}
</style>
<script>
if(${!empty msg}){
	alert('${msg}');
	location.href='studycafe.do'
}

</script>
</head>
<body>
	<main>
		<section>
			<div class="logo">
				<img src="main-img/logo1.png">
				<div>영수증</div>
				<div class="receiptContent">
					<div class="receiptContent__top">
						<p>*스터디 카페 정책 상 교환/환불은 불가하며, 자세한 사항은 스터디 카페 관리자에게 문의주셔야합니다.</p>
					</div>
					<div class="receiptContent__middel">
						<div class="receiptContent__middel__card">
							<label>결제번호 </label> <p>${receipt.paymentId}</p>
						</div>
						<div class="receiptContent__middel__card">
							<strong>좌석 : ${receipt.orderName}</strong>
						</div>
						<div class="receiptContent__middel__card">
							<strong>결제 수단: ${receipt.pay_method} </strong>
						</div>
						<div class="receiptContent__middel__card" id="lastindex">
							<strong>결제 PG 사: ${receipt.pgProvider} </strong>
						</div>
					</div>
					<div class="receiptContent__row">
						<div class="receiptContent__middel__card">
							<strong>과세매출 : ${receipt.vat}원</strong>
						</div>
						<div class="receiptContent__middel__card">
							<strong>부가세 : ${receipt.supply}원</strong>
						</div>
						<div class="receiptContent__middel__card">
							<strong>금액 : ${receipt.totalAmount}원</strong>
						</div>
						<div class="receiptContent__middel__card">
							<strong id="paidAt">${receipt.paidAt} </strong>
						</div>
					</div>
					<div class="d-grid gap-2 d-md-block">
						<button id="receiptCheckBtn" class="btn btn-primary" type="button">확인</button>
					</div>
				</div>
			</div>

		</section>
	</main>
</body>
<script>
var paidAt=new Date('${receipt.paidAt}');
paidAt=''+paidAt.getFullYear()+"-0"+(paidAt.getMonth()+1)+"-"+paidAt.getDate()+" "+paidAt.getHours()+":"+paidAt.getMinutes()+":"+paidAt.getSeconds();
document.getElementById('paidAt').textContent="결제시간 : "+paidAt;
document.getElementById('receiptCheckBtn').addEventListener('click', function(){
	location.href="index.do";
})

</script>
</html>