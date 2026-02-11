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
<link rel="stylesheet" type="text/css" href="/histudy/css/studyDesign/studyCreate.css">
</head>
<body id="studyCreatePage">
<%@include file="../header.jsp" %>
<main>
   <form name="studyCreateForm" onsubmit="return locationCheck()" action="studyCreate.do" method="post" enctype="multipart/form-data">
      <section class="studyCreate section">
         <div class="studyCreateContainer">
            <div class="studyCreate__title">
               <h1>스터디 개설하기</h1>
               <p>새로운 스터디를 개설하고 함께 공부할 멤버를 모집하세요</p>
            </div>
            <div class="studyCreate__Data">
               <div class="studyCreate__Data__Top">
                  <h2>기본 정보</h2>
               </div>
               <div class="studyData">
               	  <div class="studyData__title">
               	  	    <label>스터디 제목</label>
               	  		<span id="maxTitle"></span>
               	  </div>
                  <input type="text" name="study_title" maxlength="25" oninput="titleCheck(this)" placeholder="ex) 정보처리기사 실기 스터디" required>
               </div>
               <div class="studyData">
                  <label>카테고리</label>
                  <select name="sc_idx" required>
                     <option>선택해주세요</option>
                     <option value="1">코딩</option>
                     <option value="2">언어</option>
                     <option value="3">학업</option>
                     <option value="4">자격증</option>
                     <option value="5">취업</option>
                  </select>
               </div>
               <div class="studyData">
                  <label>모집 인원</label>
                  <select name="study_max_members" required>
                     <option value="3">3명</option>
                     <option value="4">4명</option>
                     <option value="5">5명</option>
                     <option value="6">6명</option>
                     <option value="7">7명</option>
                     <option value="8">8명</option>
                  </select>
               </div>
               <div class="studyData">
                  <label>마감일</label>
                  <input type="date" name="study_end_date" onchange="dateCheck()" required>
               </div>
               <div class="studyData">
               	  <label>스터디 진행 일정</label>
               	  <select name="study_total_weeks" onchange="studyWeeksCheck()" required>
               	  	 <option value="5">5주</option>
               	  	 <option value="6">6주</option>
               	  	 <option value="7">7주</option>
               	  	 <option value="8">8주</option>
               	  	 <option value="9">9주</option>
               	  	 <option value="10">10주</option>
               	  </select>
               </div>
               <div class="studyData">
                  <label>배경 이미지</label>
                  <p class="studyData__sub">스터디 그룹의 배경 이미지를 넣어보세요 (.png 또는 .jpg)</p>
                  <input type="file" name="rstudy_upload_img" onchange="fileCheck()">
               </div>
            </div>
            <div class="studyCreate__Data">
               <div class="studyCreate__Data__Top">
                  <h2>개설자 정보</h2>
               </div>
               <div class="studyData">
                  <label>이름</label>
                  <input type="text" name="user_name" value="${user_name}" readonly>
               </div>
               <div class="studyData">
                  <label>이메일</label>
                  <input type="text" name="user_email" value="${user_email}" readonly>
               </div>
               <div class="studyData">
                  <label>연락처</label>
                  <input type="text" name="user_tel" value="${user_tel}" readonly>
               </div>
            </div>
            <div class="studyCreate__Data">
               <div class="studyCreate__Data__Top">
                  <h2>상세 정보</h2>
               </div>
               <div class="studyData">
                  <label>스터디 소개</label>
                  <textarea name="study_content" rows="20" cols="40"
                     placeholder="스터디 목표와 진행 방식을 자세히 설명해주세요 / 진행방식 / 커리큘럼 / 준비물 (최대 300자)"
                     oninput="studyContentCheck(this)"
                     maxlength="300"
                     required></textarea>
                  <div class="study_content_footer">
                     <p id="keynum">0</p>
                     <p>/300자</p>
                  </div>
               </div>
            </div>
            <div class="studyCreate__Data">
               <div class="studyCreate__Data__Top">
                  <h2>장소</h2>
               </div>
               
                <!-- 지도 안내 문구 -->
                   <p class="map-instruction">스터디 장소를 정해보세요!</p>
                   
               <div id="map" style="width:100%;height:350px;"></div>
                  <p class="map-subtext">마커를 클릭하면 선택한 위치의 주소가 표시됩니다.</p>
               <div id="clickLatlng"></div>
               <input type="text" id="study_address" name="study_addr" placeholder="선택한 주소가 여기에 표시됩니다." readonly>
               <input type="hidden" name="study_location_lat" id="study_lat">
               <input type="hidden" name="study_location_lng" id="study_lng">
   
            </div>
            <div class="studyCreate__btns">
               <input type="submit" value="스터디 개설하기">
            </div>
         </div>
      </section>
   </form>
</main>
<%@include file="../footer.jsp" %>
</body>
<script>
	// 제목 글자 수 유효성 검사
	function titleCheck(el){
		const MAX = 25;
		const titleCount = el.value.length;
		const data = document.getElementById('maxTitle');
		
		if(titleCount>=MAX){
			data.innerHTML = '제목은 20자 이내로 작성해주세요!';
		}else{
			data.innerHTML = '';
		}
		
	}
	// 장소 선택 안할 시 유효성 검사
	function locationCheck(){
		var location = document.studyCreateForm.study_addr.value;
		var MINTEXT = 70;
		
		var count = document.studyCreateForm.study_content.value.length;
	    if(count < MINTEXT){
	    	alert('스터디 소개를 조금 더 자세히 작성해주세요 (최소 70자 이상)');
	    	return false;
	    }
		
		if(location == null || location == ''){
			var tf = window.confirm('스터디 장소를 지정하지 않으시겠어요?');
			if(tf == true){
				document.studyCreateForm.study_location_lat.value=0.0;
				document.studyCreateForm.study_location_lng.value=0.0;
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}
   // 스터디 내용 글자수 제한 유효성 검사 
   function studyContentCheck(el){
      const MAX = 300;
      const count = el.value.length;
      const keynum = document.getElementById('keynum');
      
      keynum.textContent = count;
      
       if (count >= MAX) {
           keynum.style.color = 'red';
       } else {
           keynum.style.color = 'black';
       } 
   }
   // 파일 확장자 제한 유효성 검사
   function fileCheck(){
      console.log('test');
      var upload = document.studyCreateForm.rstudy_upload_img.value;
      var uploadAll = upload.split('.');
      
      if(!(uploadAll[1]=='jpg' || uploadAll[1]=='png')){
         alert('확장자를 .jpg 또는 .png로 제한하고 있습니다. 파일을 다시 선택해주세요!');
         document.studyCreateForm.rstudy_upload_img.value='';
      }
   }
   // 이전 날짜 제한 유효성 검사
   function dateCheck(){
      var selectDate = document.studyCreateForm.study_end_date.value;
      
      var selectDateAll = selectDate.split('-');
      
      var now = new Date();
      var nowYear = now.getFullYear();
      var nowMonth = now.getMonth()+1;
      var nowDate = now.getDate();
      
      if(selectDateAll[0]<nowYear){
         alert('현재 년도 이후로 선택하셔야 합니다.');
         document.studyCreateForm.study_end_date.value='';
      }else if(selectDateAll[1]<nowMonth){
         alert('현재 월 이후로 선택하셔야 합니다.');
         document.studyCreateForm.study_end_date.value='';
      }else if(selectDateAll[2]<nowDate){
         alert('현재 일 이후로 선택하셔야 합니다.');
         document.studyCreateForm.study_end_date.value='';
      }
   }
</script>
<script type="text/javascript" 
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bfd1692e45797ef0c18f5709f6bffce4&libraries=services&autoload=false"></script>

<script>
kakao.maps.load(function() {
    var mapContainer = document.getElementById('map'),
        mapOption = { 
            center: new kakao.maps.LatLng(37.55653185748646, 126.9195354118905), 
            level: 3 
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var marker = new kakao.maps.Marker({ position: map.getCenter() });
    marker.setMap(map);

    var geocoder = new kakao.maps.services.Geocoder();

    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
        var latlng = mouseEvent.latLng;
        marker.setPosition(latlng);

        var lat = latlng.getLat();
        var lng = latlng.getLng();
        
        // 인풋박스에 표시하기
        var inputbox = document.getElementById('study_address');
        var study_lat = document.getElementById('study_lat');
        var study_lng = document.getElementById('study_lng');
        
        study_lat.value = lat;
        study_lng.value = lng;

        geocoder.coord2Address(lng, lat, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var address = result[0].road_address
                    ? result[0].road_address.address_name
                    : result[0].address.address_name;
                inputbox.value = address;
            } else {
               inputbox.value = '주소를 가져오지 못했습니다.';
            }
        });
    });
});
</script>
</html>
