<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>
<!-- // <로그아웃 상태에서 주소접속 시 빈화면 출력 -->
<c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">
<%
String memotype = request.getParameter("memotype");

%>
<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>

<div class="popupContainer">

 <c:choose>
         <c:when test="${memotype == 'add'}">
            <h1>제품 비고 등록</h1>
    <div class="horizontal-line"></div>
     <form class="popup" method="post" action="${pageContext.request.contextPath}/product/memotypePro">
		<textarea id="prodMemo" style="width: 350px; height: 250px;" name="prodMemo"></textarea><br>
		<input type="hidden" name="prodCode" value="${prodDTO.prodCode}" />
		<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
		<button type="submit" class="add-btn" >등록</button>		
		</c:if>
		<button type="button" class="close-btn" onclick="window.close();">닫기</button>
</form>
        </c:when>
        <c:otherwise>
            <h1>제품 비고 수정</h1>
    <div class="horizontal-line"></div>
        <form class="popup" method="post" action="${pageContext.request.contextPath}/product/memoUpdatePro">
		<textarea id="prodMemo" style="width: 350px; height: 250px;" name="prodMemo" >${prodDTO.prodMemo}</textarea><br>
		<input type="hidden" name="prodCode" value="${prodDTO.prodCode}" />
		<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
		<button type="submit" class="modify-btn">수정</button>
		</c:if>		
		<button type="reset" class="reset-btn">취소</button>
        <button type="button"class="close-btn" onclick="window.close();">닫기</button>
        </form>
            
        </c:otherwise>
    </c:choose>
    
   
</div>
<!-- // 로그아웃 상태에서 주소접속 시 빈화면 출력>	 -->
	</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        </c:choose>

<!---------------------------------------------- javascript ---------------------------------------------->
<script type="text/javascript">


</script>


</body>
</html>