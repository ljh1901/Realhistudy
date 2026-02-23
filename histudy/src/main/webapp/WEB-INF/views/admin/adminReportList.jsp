<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통합 신고 관리 시스템</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="adminCheck.jsp" %>
<style>
    .report__container { padding: 30px; font-family: 'Pretendard', -apple-system, sans-serif; background-color: #f8fafc; min-height: 100vh; }
    .admin__title { font-size: 26px; color: #1e293b; margin-bottom: 30px; font-weight: 800; }

    /* 리스트 테이블 */
    .report__table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); overflow: hidden; }
    .report__table th { background: #f1f5f9; padding: 15px; border-bottom: 2px solid #e2e8f0; font-size: 14px; color: #475569; }
    .report__table td { padding: 15px; border-bottom: 1px solid #f1f5f9; text-align: center; color: #334155; }
    
    /* 상세 보기 섹션 */
    .report__detail__section {
        margin-top: 40px; padding: 30px; background: #fff;
        border: 1px solid #e2e8f0; border-radius: 16px; display: none;
        box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
    }
    .detail__header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px; }
    .detail__flex { display: flex; gap: 40px; }
    
    /* 이미지 박스 */
    .detail__photo__box { 
        flex: 1; min-width: 320px; background: #f8fafc; border-radius: 12px; 
        padding: 20px; border: 2px dashed #cbd5e1; display: flex; align-items: center; justify-content: center; position: relative;
    }
    .detail__photo__box img { max-width: 100%; max-height: 450px; border-radius: 8px; display: none; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
    .no__image__text { color: #94a3b8; font-size: 15px; }

    /* 정보 영역 */
    .detail__info { flex: 2; }
    .count__badge { background: #fee2e2; color: #ef4444; padding: 4px 12px; border-radius: 6px; font-weight: 700; margin-left: 10px; }
    .detail__content { 
        background: #f8fafc; padding: 25px; border-radius: 12px; border: 1px solid #e2e8f0;
        min-height: 180px; margin: 20px 0; white-space: pre-wrap; color: #1e293b; line-height: 1.7;
    }

    /* 버튼 및 배지 */
    .btn__group { display: flex; gap: 15px; margin-top: 30px; }
    .btn__link { background: #fff; color: #2563eb; border: 1px solid #2563eb; padding: 10px 20px; cursor: pointer; border-radius: 8px; font-weight: 600; transition: all 0.2s; }
    .btn__link:hover { background: #2563eb; color: #fff; }
    .btn__resolve { background: #0f172a; color: white; border: none; padding: 14px 28px; cursor: pointer; border-radius: 8px; font-weight: 700; flex: 1; }
    
    .badge { padding: 5px 14px; border-radius: 30px; font-size: 12px; font-weight: 700; text-transform: uppercase; }
    .type__user { background: #dbeafe; color: #1e40af; }
    .type__review { background: #fef3c7; color: #92400e; }
    .type__study { background: #dcfce7; color: #166534; }
    .clickable { cursor: pointer; color: #2563eb; font-weight: 700; text-decoration: underline; }
</style>
</head>
<body id="adminReportList">

    <div class="report__container"> 
        <div class="admin__header">
            <h1 class="admin__title">통합 신고 관리</h1>
        </div>

        <table class="report__table">
            <thead>
                <tr>
                    <th width="80">번호</th>
                    <th width="120">유형</th>
                    <th width="200">대상</th>
                    <th>신고 유형</th>
                    <th width="120">신고자</th>
                    <th width="100">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${reportList}">
                    <tr>
                        <td>${r.report_idx}</td>
                        <td><span class="badge type__${r.report_type}">${r.report_type}</span></td>
                        <td>
                            <span class="clickable" onclick="showReportDetail('${r.report_idx}', '${r.report_type}', '${r.target_idx}', `${r.report_content}`, '${r.report_photo}', '${r.report_status}', '${r.report_count}')">
                                ${r.report_type} #${r.target_idx}
                            </span>
                        </td>
                        <td style="text-align: left; padding-left: 20px;">
                            <div style="max-width:380px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${r.report_category}</div>
                        </td>
                        <td>${r.reporter_name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${r.report_status == '대기'}"><span style="color:#f59e0b; font-weight:800;">대기</span></c:when>
                                <c:otherwise><span style="color:#64748b;">${r.report_status}</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="reportDetailArea" class="report__detail__section">
            <div class="detail__header">
                <h2 style="margin:0; color:#0f172a;">신고 상세 정보 <small style="font-weight:400; color:#94a3b8;">(No.<span id="dispIdx"></span>)</small></h2>
                <button type="button" class="btn__link" onclick="goToTarget()">원본 게시물 확인 🔗</button>
            </div>
            
            <div class="detail__flex">
                <div class="detail__photo__box">
                    <span id="noImgText" class="no__image__text">증빙 사진이 없습니다.</span>
                    <img id="dispImg" src="" alt="증빙 사진">
                </div>
                
                <div class="detail__info">
                    <p style="margin-top:0; font-size: 16px;">
                        <strong>대상 분류:</strong> <span id="dispTypeBadge" class="badge"></span>
                        <strong style="margin-left:15px;">대상 ID:</strong> <span id="dispTargetIdx"></span>
                        <span id="countBadgeArea" class="count__badge">누적 완료: <span id="dispReportCount">0</span>회</span>
                    </p>
                    <p style="margin-bottom:0;"><strong>신고 사유 상세:</strong></p>
                    <div id="dispContent" class="detail__content"></div>
                    
                    <div id="reportBtnGroup" class="btn__group">
                        <button type="button" class="btn__resolve" onclick="submitProcess('완료')">처리 완료</button>
                        <button type="button" style="background:#f1f5f9; color:#475569; border:none; padding: 14px 28px; cursor:pointer; border-radius:8px; font-weight:700;" onclick="submitProcess('거절')">신고 거절</button>
                    </div>
                    <div id="statusMsg" style="display:none; margin-top:20px; padding: 15px; background:#f8fafc; border-radius:8px; text-align:center; color:#64748b; font-weight:700;">
                        이 신고 건은 이미 <span id="finalStatus"></span> 상태입니다.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let currentReport = { idx: '', type: '', targetIdx: '' };

        function showReportDetail(idx, type, targetIdx, content, photo, status, reportCount) {
            currentReport = { idx, type, targetIdx };
            document.getElementById('reportDetailArea').style.display = 'block';
            
            document.getElementById('dispIdx').innerText = idx;
            document.getElementById('dispTargetIdx').innerText = targetIdx;
            document.getElementById('dispContent').innerText = content;
            
            const countVal = reportCount || 0;
            document.getElementById('dispReportCount').innerText = countVal;
            
            const countBadge = document.getElementById('countBadgeArea');
            if(parseInt(countVal) >= 3) {
                countBadge.style.background = '#fecaca'; // 더 진한 빨강
            } else {
                countBadge.style.background = '#fee2e2';
            }
            
            const badge = document.getElementById('dispTypeBadge');
            badge.innerText = type;
            badge.className = 'badge type__' + type;

            const imgElement = document.getElementById('dispImg');
            const placeholder = document.getElementById('noImgText');
            
            imgElement.style.display = 'none'; 
            imgElement.onerror = null;

            if (photo && photo !== 'null' && photo.trim() !== '') {
                imgElement.src = 'upload/report/' + photo; 
                imgElement.onload = function() {
                    this.style.display = 'block';
                    placeholder.style.display = 'none';
                };
                imgElement.onerror = function() {
                    this.style.display = 'none';
                    placeholder.style.display = 'block';
                    placeholder.innerText = "이미지를 불러올 수 없습니다.";
                    this.onerror = null;
                };
            } else {
                imgElement.style.display = 'none';
                placeholder.style.display = 'block';
                placeholder.innerText = "증빙 사진이 없습니다.";
            }

            if(status === '대기') {
                document.getElementById('reportBtnGroup').style.display = 'flex';
                document.getElementById('statusMsg').style.display = 'none';
            } else {
                document.getElementById('reportBtnGroup').style.display = 'none';
                document.getElementById('statusMsg').style.display = 'block';
                document.getElementById('finalStatus').innerText = status;
            }

            document.getElementById('reportDetailArea').scrollIntoView({ behavior: 'smooth' });
        }

        function goToTarget() {
            let url = "";
            const tIdx = currentReport.targetIdx;
            if(currentReport.type === 'user') url = "adminUserDetail.do?user_idx=" + tIdx;
            else if(currentReport.type === 'review') url = "studycafeReview.do?review_idx=" + tIdx;
            else if(currentReport.type === 'study') url = "studyContent.do?study_idx=" + tIdx;
            
            if(url) window.open(url, '_blank');
        }

        function submitProcess(action) {
            const msg = action === '완료' ? "해당 신고를 '완료' 처리하시겠습니까?\n(누적 완료 횟수가 1 증가합니다.)" : "신고를 거절하시겠습니까?";
            if(confirm(msg)) {
                location.href = "adminReportProcess.do?report_idx=" + currentReport.idx + "&action=" + action;
            }
        }
    </script>
</body>
</html>