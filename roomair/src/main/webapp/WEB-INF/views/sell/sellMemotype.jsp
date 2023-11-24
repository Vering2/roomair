<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/SellMemoAdd.jsp</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">
<!---------------------------------------------- javascript ---------------------------------------------->

<script>
$(document).ready(function () {
	//--------------------------------------------------- 페이지 권한 ----------------------
                
/*--------------------------------- 페이지 권한 ----------------------------------------  */
    var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
		
    if (team === "" || (team !== "관리자" && team !== "영업팀")) {
        // 창을 닫습니다.
        window.close(); // 이 코드는 창을 닫으려고 시도합니다.
        // 또는 에러 페이지로 리디렉션할 수 있습니다.
        // window.location.href = "${pageContext.request.contextPath}/error";
    }
})
</script>

</head>
<%
String memotype = request.getParameter("memotype");

%>
<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>

<div class="popupContainer">

 <c:choose>
         <c:when test="${memotype == 'add'}">
            <h1>수주 비고 등록</h1>
    <div class="horizontal-line"></div>
     <form class="popup" method="post" action="${pageContext.request.contextPath}/sell/sellMemotypePro">
		<textarea id="sellMemo" style="width: 300px; height: 250px;" name="sellMemo"></textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		<div class="btn">
			<button class="add-btn" type="submit" >등록</button>		
			<button class="close-btn"type="button" onclick="window.close();">닫기</button>
		</div>
</form>
        </c:when>
        <c:otherwise>
            <h1>수주 비고 수정</h1>
    <div class="horizontal-line"></div>
        <form class="popup" method="post" action="${pageContext.request.contextPath}/sell/sellMemoUpdatePro">
		<textarea id="sellMemo" style="width: 300px; height: 250px;" name="sellMemo" >${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		
		<div class="btn">
			<button class="modify-btn"type="submit" >저장</button>		
			<button class="reset-btn"type="reset">취소</button>
        	<button class="close-btn"type="button" onclick="window.close();">닫기</button>
       	</div>
        </form>
            
        </c:otherwise>
    </c:choose>
    
   
</div>
</body>

</html>