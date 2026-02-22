<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
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
                <a href="javascript:void(0);" onclick="if(confirm('알림을 삭제하시겠습니까?')){ fetch('deleteNoti.do?n_idx=${dto.n_idx}').then(r=>r.text()).then(d=>{if(d.trim()==='success'){var row=document.getElementById('row_${dto.n_idx}');if(row)row.remove();}else{alert('삭제 실패');}}).catch(e=>console.error(e)); }">
                <img src="mypage-img/trash-can.png" width="30">
            </a>
                    </td>
            </tr>
        </c:forEach>
   </c:otherwise>
</c:choose>
</table>
</main>
