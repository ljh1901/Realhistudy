<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 관리</title>
<link rel="stylesheet" href="css/admin/admin_layout.css" type="text/css">
<%@ include file="../adminCheck.jsp" %>
</head>
<body id="adminInquiryList">

    <div class="inquiry__container">
        <div class="admin__header">
            <h1 class="admin__title">문의사항 관리</h1>
        </div>

        <div class="inquiry__category">
            <ul class="inquiry__category__list">
                <li class="inquiry__category__item ${empty param.category_idx || param.category_idx == 0 ? 'active' : ''}" 
                    onclick="location.href='adminInquiryList.do'">전체</li>
                <c:forEach var="cat" items="${categoryList}">
                    <li class="inquiry__category__item ${param.category_idx == cat.inquiry_category_idx ? 'active' : ''}" 
                        onclick="location.href='adminInquiryList.do?category_idx=${cat.inquiry_category_idx}'">
                        ${cat.inquiry_category_name}
                    </li>
                </c:forEach>
            </ul>
        </div>

        <table class="inquiry__list__table">
            <thead>
                <tr>
                    <th width="80">번호</th>
                    <th width="120">카테고리</th>
                    <th>제목</th>
                    <th width="120">작성자</th>
                    <th width="150">등록일</th>
                    <th width="100">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${inquiryList}">
                    <tr>
                        <td align="center">${dto.inquiry_idx}</td>
                        <td align="center">
                            <span class="badge inquiry__cat__item">${dto.inquiry_category_name}</span>
                        </td>
                        <td style="text-align: left; padding-left: 20px;">
                            <a href="adminInquiryDetail.do?inquiry_idx=${dto.inquiry_idx}" class="inquiry__link">
                                ${dto.inquiry_title}
                            </a>
                        </td>
                        <td align="center">${dto.user_name}</td>
                        <td align="center">${dto.inquiry_date}</td>
                        <td align="center">
                            <c:choose>
                                <c:when test="${dto.inquiry_status eq '대기'}">
                                    <span class="badge inquiry__status__ok__wait">답변대기</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge inquiry__status__ok">답변완료</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>	
                </c:forEach>
                
                <c:if test="${empty inquiryList}">
                    <tr>
                        <td colspan="6" align="center" style="padding: 80px 0; color: #64748b;">
                            등록된 문의사항이 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

</body>
</html>