<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/membershipDesign/membershipPayment.css">

<!-- STEP 1. 부트페이 SDK 로드 -->
<script src="https://js.bootpay.co.kr/bootpay-5.1.4.min.js"></script>
<script>
function load(){
	var message="${msg}";
    if(message!="") {
		alert(message);
		location.href="index.do";
	}
}
</script>
</head>
<body id="membershipPaymentPage">
<%@ include file="../header.jsp" %>
<main>
<section class="membershipPaymentContainer">
<c:choose>
	<c:when test="${empty sessionScope.user_id}">
		로그인이 필요합니다.		
	</c:when>
	<c:when test="${sessionScope.membership == 'premium'}">
		이미 프리미엄 회원입니다.
	</c:when>
	<c:otherwise >
	<section class="why-learnhub">
    <div class="container">
        <h2 class="section-title">왜  Hi, Study를 선택해야 할까요?</h2>
        <p class="section-subtitle">최고의 학습 경험을 제공하는 이유</p>
        
        <div class="feature-grid">
            <div class="feature-card">
                <div class="icon-box green">👩‍🦲</div>
                <h3>전문 강사진</h3>
                <p>실무 경험이 풍부한 전문가들이 직접 제작한 고품질 강의를 만나보세요</p>
            </div>

            <div class="feature-card">
                <div class="icon-box green">☕</div>
                <h3>스터디 카페 할인권</h3>
                <p>프리미엄 회원 전용! 전국 제휴 스터디 카페 이용권을 증정합니다</p>
            </div>

            <div class="feature-card">
                <div class="icon-box green">📃‍</div>
                <h3>강의 메모 기능</h3>
                <p>강의별로 개인 메모를 작성하고 관리할 수 있습니다</p>
            </div>
        </div>
    </div>
</section>
<section class="payment-section">
    <div class="payment-container">
        <h1>결제하기</h1>
        <div class="order-summary">
            <div class="info-row">
                <span class="label">상품명</span>
                <span class="value">하이스터디 프리미엄 회원권 1개월</span>
            </div>
            <div class="info-row">
                <span class="label">결제금액</span>
                <span class="value price" id="price">29,000원</span>
            </div>
            
            <input type="hidden" id="user_id" value="${uid}"> 
            <input type="hidden" id="membership_idx" value="2"> 
            <input type="hidden" id="payment_amount" value="29000"> 
            <input type="hidden" id="payment_status" value="완료"> 
            <input type="hidden" id="payNum" value=""> 
            <input type="hidden" id="payment_method" value=""> 
            <input type="hidden" id="tax_free" value="0">
        </div>
        <button id="pay-btn" class="pay-button" onclick="requestPayment('${uname}','${uemail}','${uid}','${utel}','${uidx}')">
            결제하기
        </button>
    </div>
</section>
	</c:otherwise>
</c:choose>
  <script>
    // ------ STEP 2. 결제 요청 함수 ------
    async function requestPayment(name,email,id,tel,uidx) {
      try {
        // ------ STEP 3. 결제 요청 파라미터 설정 ------
        const response = await Bootpay.requestPayment({
          application_id: '697f4c338bbb6b2084c4ba03',
          price: 29000,
          order_name: '하이스터디 프리미엄 회원권 1개월',
          order_id: 'ORD-' + Date.now(),	//가맹점 고유 주문번호
          pg: '',         // PG사 선택
          method: '',        // 결제수단 선택
          tax_free: 0,
          user: {
            id: id,
            username: name,

            phone: tel,
            email: email
          },
          items: [
            {
              id: 'ITEM-001',
              name: '하이스터디 프리미엄 회원권 1개월',
              qty: 1,
              price: 29000
            }
          ],
          extra: {
            open_type: 'iframe',   // 결제창 타입
            card_quota: '0,2,3,4', // 할부 개월
            escrow: false
          }
        })
        
        // ------ STEP 4. 결제 결과 처리 ------
        switch (response.event) {
	        case 'done':
	            console.log('결제 완료 데이터:', response);
	            
	            const paymentData = response.data; 
	            const orderId = paymentData.order_id;
	            const method = paymentData.method;
	
	            document.getElementById("payNum").value = orderId;
	            document.getElementById("payment_method").value = method;
	
	            const paymentDto = {
	                payNum: orderId,  
	                payment_method: method, 
	                user_idx: parseInt(uidx), 
	                payment_amount: parseInt(document.getElementById("payment_amount").value), 
	                tax_free: parseInt(document.getElementById("tax_free").value),
	                payment_status: "완료", 
	                membership_idx: parseInt(document.getElementById("membership_idx").value)
	            };
	
	            console.log("서버로 보낼 DTO 객체:", paymentDto);
            
            fetch('${pageContext.request.contextPath}/cookieMake.do', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(paymentDto)
            })
            .then(res => res.json())
            .then(result => {
                if (result.result === 'success') {
                    alert('결제가 완료되었습니다! 프리미엄 멤버십에 오신걸 환영합니다!');
                    location.href = "${pageContext.request.contextPath}/lecture.do";
                } else {
                    alert('결제는 되었으나 DB 저장에 실패했습니다. 관리자에게 문의하세요.');
                }
            })
            .catch(err => {
                console.error('서버 통신 에러:', err);
                alert('서버와 통신 중 오류가 발생했습니다.');
            });
            break
          case 'issued':
            // 가상계좌 발급 완료
            console.log('가상계좌 발급:', response)
            break
          case 'confirm':
            // 분리승인 모드일 때 (extra.separately_confirmed = true)
            // 재고 확인 후 승인
            const confirmed = await Bootpay.confirm()
            if (confirmed.event === 'done') {
              verifyPaymentOnServer(confirmed.receipt_id)
            }
            break
        }
      } catch (e) {
        // 결제 오류 처리
        switch (e.event) {
          case 'cancel':
            console.log('사용자 취소:', e.message)
            break
          case 'error':
            console.log('결제 오류:', e.error_code, e.message)
            break
        }
      }
    }
 
 // ------ STEP 5. 서버에서 결제 검증 ------
    function verifyPaymentOnServer(receiptId,user_id) {
    	fetch('${pageContext.request.contextPath}/api/v1/bootpay/check', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ 
        	receipt_id: receiptId, 
        	})
      })
      .then(res => res.json())
      .then(result => {
        if (result.verified) {
          alert('결제가 완료되었습니다!')
          location.href = '${pageContext.request.contextPath}/lecture.do';
        } else {
          alert('결제 검증에 실패했습니다.')
        }
      })
    }
  </script>
</section>
</main>
<%@include file="../footer.jsp"%>
</body>
</html>