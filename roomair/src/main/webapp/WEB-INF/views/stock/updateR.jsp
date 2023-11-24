<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 수정</title>

<link href="${pageContext.request.contextPath }/resources/css/stockupdate.css"
	rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
function closeWindow() {
    window.close();
}
</script>
	
<body>

<div class="container">
	<h2>재고 수정</h2>
	<hr>
<form  action="${pageContext.request.contextPath}/stock/updatePro" method="post">
   
            <div class="form-group">
			<p>유형</p>
			<input type="text" name="stockType" value="${stockDTO.stockType }" readonly>
			</div>
		    
		    <div class="form-group">
			<p>원자재 코드</p>
			<input type="text" name="rawCode" value="${stockDTO.rawCode }" readonly>
			</div>
			
			<div class="form-group">
			<p>창고 코드</p>
			<input type="text" name="whseCode" value="${stockDTO.whseCode }" readonly>
			</div>
			
			<div class="form-group">
			<p>재고 개수</p>
			<input type="number"   name="stockCount" min="0" value="${stockDTO.stockCount }">
			</div>
			
			<div class="form-group">
			<p>재고 비고</p>
			<input type="text" name="stockMemo" value="${stockDTO.stockMemo }">
			</div>
			
<div id="button">
<input type="submit" value="수정" >
<input type="button" value="닫기" onclick="closeWindow()">
</div>

</form>
</div>
</body>
</html>