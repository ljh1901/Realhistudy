<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
window.onload = function() {
    var message = "${msg}";
    if(message && message !== "") {
        alert(message);
    }
};
function deleteNoti(n_idx) {
	fetch("deleteNoti.do?n_idx=" + n_idx)
    .then(res => res.text())
    .then(data=> {
        if(data.trim()==="success") {
        	var row = document.getElementById("row_" + n_idx);
            if(row) row.remove();
        } else {
            alert("삭제 실패");
        }
    })
    .catch(error => {
        console.error(error);
    });
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
            <tr id="row_${dto.n_idx}">
                <td>${dto.n_title}</td>
                <td>${dto.n_content}</td>
                <td>${dto.n_date}</td>
                <td style="text-align: right;">
                <a href="javascript:void(0);" onclick="deleteNoti('${dto.n_idx}')">
                <img src="mypage-img/trash-can.png" width="30">
                </a>
                    </td>
            </tr>
        </c:forEach>
	</c:otherwise>
</c:choose>
</table>
</main>
