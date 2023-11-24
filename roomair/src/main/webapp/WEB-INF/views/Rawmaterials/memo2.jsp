<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/Rawmaterialspop.css" rel="stylesheet" type="text/css">
</head>

<!-- body -->
<body>
<div class="memo-content">
<h2>비고</h2>

<!-- form -->
<form id="memo2">
<textarea id="clientMemo" readonly="readonly" style="width:350px; height:250px;">${clientDTO.clientMemo}</textarea><br>
<input type="hidden" name="clientCode" value="${clientDTO.clientCode}"/>

<!-- button -->
<div id="buttons">
<button type="button" onclick="window.close()" id=btn2>닫기</button>
</div>
</form>
</div>

</body>
</html>