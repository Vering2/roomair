<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/sellMemo.jsp</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">
<script>
$(document).ready(function () {
         
/*--------------------------------- 페이지 권한 ----------------------------------------  */
    var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
    if (team === "영업팀" || team === "관리자") {
		  
			$('#modify').show();
	   }
	  else if (team ===""){
		  window.close();
	  }
	  else{
		  
	  }
})
</script>
</head>

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>
 <c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">
<div class="popupContainer">
    <h1>수주 비고</h1>
    <div class="horizontal-line"></div>
    <form class="popup">
		<textarea id="sellMemo" readonly="readonly" style="width: 300px; height: 250px;">${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		<div class="btn">
		<button class="modify-btn"style="display: none;" type="button" onclick="location.href='${pageContext.request.contextPath}/sell/sellMemotype?sellCode=${sellDTO.sellCode}&memotype=modify'" id="modify" >수정</button>
        <button class="close-btn"type="button" onclick="window.close()">닫기</button>
        </div>
    </form>
</div>
</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        
</c:choose>
<!---------------------------------------------- javascript ---------------------------------------------->




</body>
</html>