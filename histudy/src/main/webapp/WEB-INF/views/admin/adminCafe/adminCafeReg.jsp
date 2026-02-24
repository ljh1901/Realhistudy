<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디카페 입점 등록</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<style>
    /* 기존 스타일 유지 및 상세주소용 스타일 추가 */
    .adminCafe__container { width: 850px; margin: 40px auto; padding: 30px; background: #fff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
    .adminCafe__title h1 { font-size: 26px; color: #1e293b; border-left: 6px solid #4f46e5; padding-left: 15px; margin-bottom: 8px; }
    .adminCafe__table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .adminCafe__table th { background: #f8fafc; padding: 15px; border: 1px solid #e2e8f0; width: 160px; text-align: left; color: #475569; }
    .adminCafe__table td { padding: 12px; border: 1px solid #e2e8f0; }
    .adminCafe__input { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; font-size: 14px; }
    .adminCafe__input:read-only { background-color: #f1f5f9; color: #64748b; }
    .adminCafe__btns { text-align: center; margin-top: 35px; display: flex; justify-content: center; gap: 12px; }
    .btn-cafe-submit { background: #4f46e5; color: white; padding: 14px 40px; border: none; border-radius: 8px; cursor: pointer; font-weight: 600; }
    #map { border-radius: 8px; border: 1px solid #e2e8f0; margin: 15px 0; }
</style>
</head>
<body id="adminCafeWrite">

<div class="adminCafe__container">
    <div class="adminCafe__title">
        <h1>스터디카페 입점 등록</h1>
        <p>지도 클릭으로 위치를 지정하고 상세 주소를 입력하세요.</p>
    </div>

    <form action="adminCafeRegOk.do" method="post" name="cafeForm" onsubmit="return combineAddress()">
        <div id="map" style="width:100%; height:380px;"></div>

        <table class="adminCafe__table">
            <tr>
                <th>지점명</th>
                <td><input type="text" name="studycafe_name" class="adminCafe__input" placeholder="예: 하이스터디 강남점" required></td>
            </tr>
            <tr>
                <th>기본 주소</th>
                <td>
                    <input type="text" id="display_address" class="adminCafe__input" placeholder="지도에서 위치를 클릭하세요" readonly required>
                </td>
            </tr>
            <tr>
                <th>상세 주소</th>
                <td>
                    <input type="text" id="detail_address" class="adminCafe__input" placeholder="상세 주소를 입력하세요 (예: 5층 501호)">
                </td>
            </tr>
            
            <input type="hidden" id="studycafe_addr" name="studycafe_addr">

            <tr>
                <th>위도 (Lat)</th>
                <td><input type="text" id="study_lat" name="studycafe_lat" class="adminCafe__input" readonly required></td>
            </tr>
            <tr>
                <th>경도 (Lng)</th>
                <td><input type="text" id="study_lng" name="studycafe_lng" class="adminCafe__input" readonly required></td>
            </tr>
        </table>

        <div class="adminCafe__btns">
            <button type="submit" class="btn-cafe-submit">지점 등록하기</button>
            <button type="button" class="btn-cafe-cancel" onclick="history.back()" style="background:#94a3b8; color:white; padding:14px 40px; border:none; border-radius:8px; cursor:pointer;">취소</button>
        </div>
    </form>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cc8dabaa3a75dab670d03c068fae3a5d&libraries=services&autoload=false"></script>

<script>
// 폼 전송 전 주소 합치기 함수
function combineAddress() {
    const baseAddr = document.getElementById('display_address').value;
    const detailAddr = document.getElementById('detail_address').value;
    
    if(!baseAddr) {
        alert("지도에서 위치를 먼저 선택해주세요.");
        return false;
    }
    
    // 기본주소 + 상세주소를 합쳐서 hidden 필드에 넣음
    document.getElementById('studycafe_addr').value = baseAddr + " " + detailAddr;
    return true;
}

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

        document.getElementById('study_lat').value = latlng.getLat();
        document.getElementById('study_lng').value = latlng.getLng();

        geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var address = result[0].road_address
                    ? result[0].road_address.address_name
                    : result[0].address.address_name;
                document.getElementById('display_address').value = address;
            }
        });
    });
});
</script>

</body>
</html>