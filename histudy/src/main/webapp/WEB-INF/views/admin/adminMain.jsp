<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>관리자 메인</title>
    <link rel="stylesheet" href="css/admin_layout.css" type="text/css">
</head>
<body>
<form>
    <section class="admin">
        <ul class="admin__menu"> <li>대시보드</li>
            <li class="admin__menu__item">
                <a href="adminCafeList.do" target="contentFrame">스터디카페 관리</a>
            </li>    
            <li class="admin__menu__item">
                <a href="adminStudyList.do" target="contentFrame">스터디모임 관리</a>
            </li>
            <li class="admin__menu__item">
                <a href="adminUserList.do" target="contentFrame">회원 관리</a>
            </li>
            <li class="admin__menu__item">
                <a href="adminNotice.do" target="contentFrame">공지사항</a>
            </li>
            <li class="admin__menu__item">
                <a href="adminInquiryList.do" target="contentFrame">문의사항 관리</a>
            </li>
            <li class="admin__menu__item">
                <a href="adminFaqForm.do" target="contentFrame">자주 묻는 질문 관리</a>
            </li>
            <li class="admin__menu__item">
                <a href="adminReportList.do" target="contentFrame">신고 관리</a>
            </li>
        </ul>

        <fieldset class="admin__menu__field">
            <iframe name="contentFrame" src="adminCafeList.do"></iframe>
        </fieldset>
    </section>
</form>
</body>
</html>