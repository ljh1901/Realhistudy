<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function load(){
	var message="${msg}";
    if(message!="") {
		alert(message);
	}
}
</script>
<main>
<div>알림함</div>
<table>
<c:choose>
	<c:when test="${empty list }">
		<tr>
			<td>알림함이 비어있습니다.</td>
		</tr>		
	</c:when>
	<c:otherwise>
		<c:forEach var="dto" items="${list}">
            <tr>
                <td>${dto.n_type}</td>
                <td>${dto.n_title}</td>
                <td>${dto.n_content}</td>
                <td>${dto.n_date}</td>
                <td>${dto.n_read}</td>
            </tr>
        </c:forEach>
	</c:otherwise>
</c:choose>
</table>
</main>
