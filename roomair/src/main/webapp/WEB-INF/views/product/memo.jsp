<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>

<body>
<!-- // <로그아웃 상태에서 주소접속 시 빈화면 출력 -->
<c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">
         
<div class="popupContainer">
    <h1>제품 비고</h1>
    <div class="horizontal-line"></div>
    <form class="popup">
		<textarea id="prodMemo" style="width: 350px; height: 250px;" readonly="readonly">${prodDTO.prodMemo}</textarea><br>
		<input type="hidden" name="ProdCode" value="${prodDTO.prodCode}" />
		
		<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
<button type="button" class="modify-btn" onclick="location.href='${pageContext.request.contextPath}/product/memotype?prodCode=${prodDTO.prodCode}&memotype=modify'">수정</button>

</c:if>
        <button type="button" class="close-btn" onclick="window.close()">닫기</button>
    </form>
</div>

<!-- // 로그아웃 상태에서 주소접속 시 빈화면 출력>	 -->
	</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        </c:choose>

</body>
</html>