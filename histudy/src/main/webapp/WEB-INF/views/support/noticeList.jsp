<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
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
<link rel="stylesheet" type="text/css" href="/histudy/css/inquiryDesign/inquiry.css">
    <style>
        .notice__category__nav { margin-bottom: 25px; }
        .notice__category__list { display: flex; gap: 10px; list-style: none; padding: 0; }
        .notice__category__item { padding: 8px 16px; background: #eee; border-radius: 20px; cursor: pointer; font-size: 14px; }
        .notice__category__item.active { background: #1e293b; color: #fff; font-weight: bold; }
        .notice__title__link { text-decoration: none; color: #333; font-weight: 500; }
        .notice__title__link:hover { color: #2563eb; text-decoration: underline; }
    </style>
</head>
<body id="userNoticeList">

<%@include file="../header.jsp" %>

    <main class="inquiry__container">
        <div class="inquiry__header">
            <h1 class="inquiry__title">공지사항</h1>
        </div>

        <nav class="notice__category__nav">
            <ul class="notice__category__list">
                <li class="notice__category__item ${empty param.notice_category_idx ? 'active' : ''}" 
                    onclick="location.href='noticeList.do'">전체</li>
                <c:forEach var="cat" items="${noticeCategoryList}">
                    <li class="notice__category__item ${param.notice_category_idx == cat.notice_category_idx ? 'active' : ''}" 
                        onclick="location.href='noticeList.do?notice_category_idx=${cat.notice_category_idx}'">
                        ${cat.notice_category_name}
                    </li>
                </c:forEach>
            </ul>
        </nav>

        <table class="inquiry__list__table">
            <thead>
                <tr>
                    <th width="10%">번호</th>
                    <th width="15%">구분</th>
                    <th width="60%">제목</th>
                    <th width="15%">등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="notice" items="${noticeList}">
                    <tr>
                        <td align="center">${notice.notice_idx}</td>
                        <td align="center">
                            <span class="badge inquiry__cat__item">${notice.notice_category_name}</span>
                        </td>
                        <td style="text-align: left;">
                            <a href="noticeDetail.do?notice_idx=${notice.notice_idx}" class="notice__title__link">
                                ${notice.notice_title}
                            </a>
                        </td>
                        <td align="center">${notice.notice_writedate}</td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty noticeList}">
                    <tr>
                        <td colspan="4" align="center" class="inquiry__empty">등록된 공지사항이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </main>

<%@include file="../footer.jsp" %>

</body>
</html>