<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <title>결제하기</title>
  <!-- STEP 1. 부트페이 SDK 로드 -->
  <script src="https://js.bootpay.co.kr/bootpay-5.1.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="/histudy/css/header.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/root.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/footer.css">
<link rel="stylesheet" type="text/css" href="/histudy/css/membershipDesign/membershipPayment.css">
</head>
</head>
<body id="membershipPaymentPage">
<%@ include file="../header.jsp" %>
<main>
<section class="membershipPaymentContainer">
  <h1>결제하기</h1>
  <div class="order-summary">
    <p>상품명: 하이스터디 프리미엄 회원권 1개월</p>
    <p>결제금액: <span id="price">29,000원</span></p>
  </div>
  <button id="pay-btn" onclick="requestPayment()">결제하기</button>
 
  <script>
    // ------ STEP 2. 결제 요청 함수 ------
    async function requestPayment() {
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
            id: 'user_123',
            username: '홍길동'+Date.now(),
            phone: '01012345678',
            email: 'user@example.com'
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
            // 결제 완료 - 서버에서 검증 필요
            console.log('결제 완료:', response.receipt_id)
            verifyPaymentOnServer(response.receipt_id)
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
    function verifyPaymentOnServer(receiptId) {
      // 가맹점 서버로 receipt_id 전송
      // 서버에서 부트페이 API로 결제 조회 및 금액 대조
      fetch('/api/payment/verify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ receipt_id: receiptId })
      })
      .then(res => res.json())
      .then(result => {
        if (result.verified) {
          alert('결제가 완료되었습니다!')
          location.href = '/order/complete'
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