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
<link rel="stylesheet" href="css/root.css" type="text/css">
<link rel="stylesheet" href="css/header.css" type="text/css">
<link rel="stylesheet" href="css/footer.css" type="text/css">
<link rel="stylesheet" href="css/studycafe/studycafe.css"
	type="text/css">
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>
window.onload=function(){
	document.querySelector('.studycafeCurrent').style.display="none";
}
</script>
<style>
/* ================= 기본 리셋 ================= */
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

:root {
    --primary: #4f46e5;
    --primary-light: #6366f1;
    --bg-light: #f9fafb;
    --border-light: #e5e7eb;
    --text-main: #111827;
    --reserved: #dc2626;
}

main {
    margin-top: 120px;
    background: var(--bg-light);
    min-height: 100vh;
}

/* ================= 카드 레이아웃 ================= */

section {
    width: 95%;
    max-width: 1200px;
    margin: 40px auto;
    padding: 40px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.06);
}

/* ================= 상단 탭 ================= */

section h1 {
    display: flex;
    gap: 30px;
    font-size: 20px;
    margin-bottom: 25px;
}

section h1 a {
    text-decoration: none;
    color: var(--text-main);
    font-weight: 600;
    padding-bottom: 8px;
    border-bottom: 2px solid transparent;
    transition: 0.2s;
}

section h1 a:hover {
    color: var(--primary);
    border-color: var(--primary);
}

/* ================= 카페 목록 ================= */

#studycafeList {
    list-style: none;
    margin-bottom: 30px;
}

#studycafeList li a {
    display: block;
    padding: 16px 20px;
    font-size: 18px;
    font-weight: 600;
    background: #f3f4f6;
    border-radius: 12px;
    text-decoration: none;
    color: var(--text-main);
    transition: 0.2s;
}

#studycafeList li a:hover {
    background: var(--primary);
    color: #fff;
}

/* ================= 지도 ================= */

#map {
    width: 100% !important;
    height: 350px;
    border-radius: 16px;
    margin-top: 20px;
}

/* ================= SVG 좌석 ================= */

#studycafeSeat {
    background: #f8fafc;
    border-radius: 20px;
    margin-top: 20px;
}

/* 좌석 기본 */
.seat-a {
    fill: #ffe4e6;
    stroke: #fca5a5;
    stroke-width: 1;
    transition: 0.2s;
}

/* hover */
.seat-a:hover {
    fill: #c7d2fe;
    stroke: var(--primary);
    cursor: pointer;
}

/* 예약 좌석 */
.seat-a[data-seat-status="RESERVED"] {
    fill: var(--reserved);
    stroke: var(--reserved);
}

.seat-a[data-seat-status="RESERVED"]:hover {
    cursor: not-allowed;
    opacity: 0.8;
}

/* ================= 구조물 (클래스 기반) ================= */

rect[data-layout-type="WALL"] {
    fill: #cda56d;
}

rect[data-layout-type="DOOR"] {
    fill: #93c5fd;
}

rect[data-layout-type="HALL"] {
    fill: #f1f5f9;
}

rect[data-layout-type="ZONE_A"],
rect[data-layout-type="ZONE_B"] {
    fill: #ffffff;
    stroke: #e5e7eb;
    stroke-width: 2;
}

rect[data-layout-type="ROOM_SMALL"] {
    fill: #eef2ff;
    stroke: #c7d2fe;
    stroke-width: 2;
}

/* ================= 모달 ================= */

.payseat {
    position: fixed;
    inset: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 2000;
}

.modal-overlay {
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.5);
}

.modal-box {
    position: relative;
    width: 420px;
    background: #fff;
    border-radius: 20px;
    padding: 30px;
}

.modal-header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.modal-close {
    margin-left: auto;
    border: none;
    background: none;
    font-size: 22px;
    cursor: pointer;
}

/* 버튼 */

#reserveBtn,
.ticketGrid button {
    width: 100%;
    padding: 12px;
    border-radius: 12px;
    border: none;
    background: var(--primary);
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    transition: 0.2s;
}

#reserveBtn:hover,
.ticketGrid button:hover {
    background: var(--primary-light);
}

.ticketGrid {
    display: grid;
    gap: 12px;
    margin-top: 15px;
}

</style>
</head>
<body>
	<%@include file="../header.jsp"%>
	<form name="studycafe">
		<main>
			<section>
				<h1>
					<a href="#" id="studycafeInfo">스터디 카페 정보</a> 
					<a href="#" id="studycafeCurrent">스터디 카페 좌석 현황</a>
				</h1>
				<div class="studycafeInfo">
					<ul id="studycafeList">
							<li><a href="#" class="studycafe-item" onclick="seatInfo(${studycafeOne.studycafe_idx})">${studycafeOne.studycafe_name}</a></li>
					</ul>
					<div id="map" style="width: 50%; height: 350px;"></div>
					<div id="clickLatlng"></div>
				</div>
				<div class="studycafeCurrent" style="display: none">
					<!-- (모달1) 안내사항 모달 -->
					<div class="payseat" style="display: none;">
						<div class="modal-overlay" onclick="close1()"></div>
						<div class="modal-box">
							<div class="modal-header">
								<h2 id="seat">좌석 현황</h2>
								<button type="button" class="modal-close" onclick="close1()">&times;</button>
							</div>
							<div class="modal-content"></div>
						</div>
					</div>
					<svg id="studycafeSeat" viewBox="0 0 1200 800" width="100%"
						height="100%">
<!-- 벽 -->
<g id="studycafe__structure">
<c:forEach var="layout" items="${requestScope.layoutDTO}">
<rect x="${layout.layout_x}" y="${layout.layout_y}" width="${layout.layout_w}" height="${layout.layout_h}" 
fill="#CDA56D" data-layout-type="${layout.layout_type}" />
<!-- 입구 문 -->
</c:forEach>
<text x="706" y="600" font-size="10" transform="rotate(90 706,600)">문</text>
<text x="720" y="425" font-size="10" transform="rotate(90 706,420)">문</text>
<text x="550" y="320" text-anchor="middle" font-size="20" fill="#94A3B8" font-weight="700"> MAIN HALL </text>
<text x="220" y="40" text-anchor="middle" font-size="20" font-weight="700">노트북 존</text>
<text x="220" y="340" text-anchor="middle" font-size="20" font-weight="700">일반존 A</text>
<text x="820" y="40" text-anchor="middle" font-size="20" font-weight="700">일반존 B</text>
<text x="870" y="710" text-anchor="middle" font-weight="700">스터디룸 B</text>
<text x="865" y="350" text-anchor="middle" font-size="18" font-weight="700">1인 독방</text>
</g>
<g id="seat__area">
<c:forEach var="seat" items="${seatList}">
<rect class="seat-a" x="${seat.seat_x}" y="${seat.seat_y}"
								width="${seat.seat_w}" height="${seat.seat_h}"
								value="${seat.seat_num}" data-seat-idx="${seat.seat_idx}"
								data-seat-type="${seat.seat_type}"
								data-seat-status="${seat.seat_status}"></rect>
<text x="${seat.seat_x+seat.seat_w/2}"
								y="${seat.seat_y + seat.seat_h / 2}" fill="black"
								text-anchor="middle" font-size="14">${seat.seat_num}</text>
</c:forEach>
</g>
</svg>
				</div>
			</section>
		</main>
	</form>
	<%@include file="../footer.jsp"%>
</body>
<script>
// 위도, 경도
var lat =0;
var lng =0;
var xhr = null;
const seat__area=document.getElementById('seat__area');
if(document.querySelector('.studycafe-item').text == 'histudy 1호점'){
	lat = ${studycafeOne.studycafe_lat};
	lng = ${studycafeOne.studycafe_lng};
}
function seatInfo(studycafe_idx){
	xhr = new XMLHttpRequest();
	xhr.open("GET", "seatInfo.do?studycafe_idx="+studycafe_idx, true);
	xhr.onreadystatechange=showResult;
	xhr.send();
}

function showResult(){
	if(xhr.readyState==4){
		if(xhr.status==200){
			var data = JSON.parse(xhr.responseText);
			seat__area.innerHTML = '';
			data.forEach(seat => {
			
			var rect = document.createElementNS("http://www.w3.org/2000/svg", "rect");
			rect.setAttribute('class', 'seat-a');
			rect.setAttribute('data-seat-idx', seat.seat_idx);
			rect.setAttribute('data-seat-type', seat.seat_type);
			rect.setAttribute('data-seat-status', seat.seat_status);
			rect.setAttribute('x',seat.seat_x);
			rect.setAttribute('y',seat.seat_y);
			rect.setAttribute('width',seat.seat_w);
			rect.setAttribute('height',seat.seat_h);
			rect.setAttribute('value',seat.seat_num);
			rect.setAttribute('fill','#FFE4E6' );
			rect.setAttribute('stroke','#FFE4E6' );
			
			var text = document.createElementNS("http://www.w3.org/2000/svg","text");
				text.setAttribute('x', Number(seat.seat_x) + seat.seat_w / 2);
				text.setAttribute('y', Number(seat.seat_y) + seat.seat_h / 2);
				text.setAttribute('text-anchor', 'middle'); 
				text.setAttribute('font-size', '14');
				text.setAttribute('fill', 'black');
				text.textContent=seat.seat_num;
			seat__area.appendChild(rect);
			seat__area.appendChild(text);
			
			});
			seatReservation();
		}
	}
}
seatReservation();
// 좌석 정보
var queryNum=-1;
var seat_idx = null;
var ticket_idx = null;
var ticketBtn = null;
var seat_type=null;
function seatReservation(){
for(let i = 0; i<document.querySelectorAll(".seat-a").length; i++){
	document.querySelectorAll(".seat-a")[i].addEventListener('click', function(){
		// 좌석 번호 가져오기
		seat_idx=document.querySelectorAll(".seat-a")[i].dataset.seatIdx;
		// 좌석, 스터디룸, 독방 타입 가져오기
		seat_type=document.querySelectorAll(".seat-a")[i].dataset.seatType;
		// 좌석 상태 가져오기
		seat_status=document.querySelectorAll(".seat-a")[i].dataset.seatStatus;
		
		seatCurrent(seat_idx);
		queryNum=i;
		document.querySelector('#seat').innerHTML = document.querySelectorAll(".seat-a")[i].getAttribute("value")+ '의 좌석현황';
		document.querySelector('.modal-content').innerHTML='<button id="reserveBtn">이용 하기</button>';
		// 이용하기
		document.getElementById('reserveBtn').addEventListener('click',function(e){
			if(${empty sessionScope.user_id}){
				alert('로그인 후 스터디 카페를 이용하실 수 있습니다');
				e.preventDefault();
				return;
			}
			if(seat_status==='RESERVED'){
				alert('이미 에약된 좌석입니다.')
				e.preventDefault();
				return;
			}
			document.querySelector('.modal-content').addEventListener('click',function(e){
				var ticket = e.target.closest('.ticket');
				if(seat_type == 'SINGLE_ROOM'||seat_type =='ROOM'){
					ticketBtn= '<button class="ticket" value="1">시간권</button><button class="ticket" value="2">종일권</button><button class="ticket" value="3">정기권</button>';
				}else{
					ticketBtn= '<button class="ticket" value="1">시간권</button><button class="ticket" value="2">종일권</button>';
				}
				document.querySelector('.modal-content').innerHTML = ticketBtn;
				if(ticket != null){
					seatTicketInfo(ticket.value, seat_idx);
				}
			});
		});
			document.querySelector('.payseat').style.display="";
		});
}
}
// 티켓 정보 가져오기
function seatTicketInfo(ticket_category_idx, seat_idx){
	return fetch("seatTicket.do?ticket_category_idx="+ticket_category_idx+"&seat_idx="+seat_idx+"&studycafe_idx="+${studycafeOne.studycafe_idx},{method: "GET"})
	.then(function(res){
		if(res.ok){
			return res.json();
		}
	})
	.then(function(res){
		document.querySelector('.modal-content').innerHTML += '<div class="ticketGrid"></div>';
			document.querySelector('.ticketGrid').innerHTML='';
		res.forEach(function(data){
			var ticketStr = '<button type="button" class="payBtn" value='+data.ticket_idx+'><div><h3 class="ticketName" value='+data.ticket_name+'>'+data.ticket_name+'</h3><span class="ticketAmount" value='+data.ticket_amount+'>'+data.ticket_amount+'원</span></div></button>';
			document.querySelector('.ticketGrid').innerHTML += ticketStr;
		})
		portOnePay(queryNum, ticket_category_idx);
	})
	.catch(error => console.log(error.message))
}

// 1. 결제 요청
function portOnePay(queryNum, ticket_category_idx){
	for(let i=0; i<document.querySelectorAll('.payBtn').length; i++){
	document.querySelectorAll('.payBtn')[i].addEventListener('click', async function(){
		var now = new Date();
		var str = ''+now.getFullYear()+(now.getMonth()+1)+now.getDate()+now.getHours()+now.getMinutes()+now.getSeconds();
			ticket_idx = document.querySelectorAll('.payBtn')[i].value;
		return fetch("studycafe/payment/payNotComplete.do?ticket_idx="+document.querySelectorAll('.payBtn')[i].value, {
			method:"POST",
			headers:{"Content-Type":"application/json"},
			body:JSON.stringify({
				storeId: "store-83eacdb9-6d28-4c80-b53b-26d96da03490",
				channelKey: "channel-key-da563d5f-f117-444f-aba5-ad9b66277c1b",
				paymentId: "payment-"+str,
				customer:{
				email: "${udto.user_email}",
			    fullName: "${udto.user_name}",
			  	phoneNumber: "${udto.user_tel}"
				},
				orderName: document.querySelectorAll('.seat-a')[queryNum].getAttribute('value')+"-좌석/"+document.querySelectorAll('.ticketName')[i].getAttribute("value"),
				totalAmount: document.querySelectorAll('.ticketAmount')[i].getAttribute("value"),
				currency: "CURRENCY_KRW",
				payMethod: "CARD"
			})
			})
			.then(res => res.json())
			.then(async function(res){
				resp = await PortOne.requestPayment({
				//Store ID 설정
				storeId: res.storeId,
				channelKey: res.channelKey,
				paymentId: res.paymentId,
				customer:{
				email: "${udto.user_email}",
			    fullName: "${udto.user_name}",
			  	phoneNumber: "${udto.user_tel}"
				},
				customData:{
					seat_idx: seat_idx,
					ticket_idx: ticket_idx,
					ticket_category_idx: ticket_category_idx
				},
				orderName: res.orderName,
				totalAmount: res.totalAmount,
				currency: "CURRENCY_KRW",
				payMethod: "CARD",
				redirectUrl: "http://localhost:9090/histudy/receipt.do?totalAmount="+res.totalAmount,
				forceRedirect: true
			})
			});
		
	});
	}
}


// 좌석 현황
function seatCurrent(seat_idx){
	return fetch("seatReservation.do", {
		method: "POST",
		headers:{
			"Content-Type":"application/json"
		},
		body:JSON.stringify({
			seat_idx: seat_idx
		})
	})
	.then(function(res){
		if(res.ok){
			return res.json();
		}else{
			var divTag=document.createElement('div');
			divTag.innerHTML = '<p>이용 가능한 좌석 입니다</p>';
		}
	})
	.then(function(res){
		var divTag=document.createElement('div');
		divTag.setAttribute('class', 'seatCurrent');
		document.getElementById('seat').appendChild(divTag);
		var reservation_starttime=new Date(res.reservation_starttime);
		var reservation_endtime = new Date(res.reservation_endtime);
		reservation_starttime = reservation_starttime.getFullYear()+"년"+(reservation_starttime.getMonth()+1)+"월"+reservation_starttime.getDate()+"일"+ reservation_starttime.getHours()+":"+reservation_starttime.getMinutes();
		reservation_endtime=reservation_endtime.getFullYear()+"년"+(reservation_endtime.getMonth()+1)+"월"+reservation_endtime.getDate()+"일"+reservation_endtime.getHours()+":"+reservation_endtime.getMinutes();
		var str="<div class='reservationTime'>이용중</div>"+"<div class='reservationTime'>"+reservation_starttime+"~"+reservation_endtime+"</div>";
		divTag.innerHTML = str;
	})
	.catch(error => console.log(error.message))
}

// 모달 창 닫기
function close1(){
	document.querySelector('.payseat').style.display = "none";
} 
// 카페 정보
document.getElementById('studycafeCurrent').addEventListener('click',function(){
	document.querySelector('.studycafeInfo').style.display="none";
	document.querySelector('.studycafeCurrent').style.display="";
});

// 카페 현황
document.getElementById('studycafeInfo').addEventListener('click',function(){
	document.querySelector('.studycafeInfo').style.display="";
	document.querySelector('.studycafeCurrent').style.display="none";
});
</script>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cc8dabaa3a75dab670d03c068fae3a5d&libraries=services&libraries=services"
	type="text/javascript"></script>
<script src="js/studycafe/map.js" type="text/javascript"></script>
</html>
