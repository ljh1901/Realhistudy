<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <!-- SEO -->
<title>${notice.notice_title} | Hi, Study</title>
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
<link rel="stylesheet" type="text/css" href="/histudy/css/inquiryDesign/inquiry.css">
    <style>
        .notice__detail__container { max-width: 900px; margin: 40px auto; padding: 40px; background: #fff; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
        .notice__detail__header { border-bottom: 2px solid #f1f5f9; padding-bottom: 20px; margin-bottom: 30px; }
        .notice__detail__title { font-size: 28px; font-weight: 800; color: #1e293b; margin-bottom: 15px; line-height: 1.4; }
        .notice__detail__meta { display: flex; gap: 20px; align-items: center; color: #64748b; font-size: 14px; }
        .notice__detail__content { min-height: 300px; line-height: 1.8; color: #334155; font-size: 16px; margin-bottom: 40px; white-space: pre-wrap; }
        .notice__attachment { background: #f8fafc; padding: 15px 20px; border-radius: 8px; border: 1px solid #e2e8f0; margin-bottom: 30px; display: flex; align-items: center; gap: 10px; }
        .notice__attachment a { color: #2563eb; text-decoration: none; font-weight: 600; }
        .notice__attachment a:hover { text-decoration: underline; }
        .notice__footer { display: flex; justify-content: center; border-top: 1px solid #f1f5f9; padding-top: 30px; }
        .btn__list { background: #1e293b; color: #fff; padding: 12px 30px; border-radius: 8px; font-weight: 600; cursor: pointer; border: none; transition: background 0.2s; }
        .btn__list:hover { background: #334155; }
    </style>
</head>
<body id="userNoticeDetail">

<%@include file="../header.jsp" %>

    <main class="inquiry__container">
        <div class="notice__detail__container">
            <div class="notice__detail__header">
                <div style="margin-bottom: 10px;">
                    <span class="badge inquiry__cat__item">${notice.notice_category_name}</span>
                </div>
                <h1 class="notice__detail__title">${notice.notice_title}</h1>
                <div class="notice__detail__meta">
                    <span><strong>작성일</strong> ${notice.notice_writedate}</span>
                    <span style="color: #cbd5e1;">|</span>
                    <span>Hi, Study 운영팀</span>
                </div>
            </div>

            <c:if test="${not empty notice.notice_file}">
                <div class="notice__attachment">
                    <span style="font-size: 18px;">📁</span>
                    <strong>첨부파일:</strong> 
                    <a href="upload/${notice.notice_file}" download>${notice.notice_file}</a>
                </div>
            </c:if>

            <div class="notice__detail__content">
                ${notice.notice_content}
            </div>

            <div class="notice__footer">
                <button type="button" class="btn__list" onclick="location.href='noticeList.do'">목록으로 돌아가기</button>
            </div>
        </div>
    </main>

<%@include file="../footer.jsp" %>

</body>
</html>