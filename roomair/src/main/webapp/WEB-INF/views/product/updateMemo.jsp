<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/updateSellMemo.jsp</title>
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>
<!-- // <로그아웃 상태에서 주소접속 시 빈화면 출력 -->
<c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">

<div class="popupContainer">
    <h1>수주 비고 수정</h1>
    <div class="horizontal-line"></div>
    <form class="popup" method="post" action="${pageContext.request.contextPath}/sell/sellMemoAddPro">
		<textarea id="sellMemo" style="width: 350px; height: 250px;" name="sellMemo" >${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		
		<button type="submit" class="modify-btn">수정</button>		
		<!-- <button type="reset">취소</button> -->
        <button type="button" class="close-btn" onclick="window.close();">닫기</button>
    </form>
</div>
<!---------------------------------------------- javascript ---------------------------------------------->

<!----------------------------------------------- 수정 버튼 ---------------------------------------------->

<!-- // 로그아웃 상태에서 주소접속 시 빈화면 출력>	 -->
	</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        </c:choose>

	


</body>
</html>