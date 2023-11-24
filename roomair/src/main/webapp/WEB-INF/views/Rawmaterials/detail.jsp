<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/Rawmaterialspop.css" rel="stylesheet" type="text/css">

<!-- javascript --> 
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// update 페이지 팝업창
function openPopup1(rawCode) {
	var popupWidth = 450;
	var popupHeight = 660;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	var popupY = (window.screen.height / 2) - (popupHeight / 2);
	var url = '${pageContext.request.contextPath}/Rawmaterials/update?rawCode=' + rawCode;  
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=" + popupWidth + ",height=" + popupHeight + ",left=" + popupX + ",top=" + popupY);
	myWindow.focus();
	myWindow.resizeTo(popupWidth, popupHeight); // 팝업창 크기조정
	myWindow.moveTo(popupX, popupY); // 팝업창 위치조정
}
</script>
</head>

<!-- body -->
<body>
<div class="content">
<h2>상세보기</h2>

<!-- table -->
<table>
<tr><td id="td1">원자재코드</td>	<td id="td21">${rawmaterialsDTO.rawCode}</td></tr>
<tr><td id="td1">원자재명</td>		<td id="td22">${rawmaterialsDTO.rawName}</td></tr>
<tr><td id="td1">종류</td>		<td id="td21">${rawmaterialsDTO.rawType}</td></tr>
<tr><td id="td1">단위</td>		<td id="td22">${rawmaterialsDTO.rawUnit}</td></tr>
<tr><td id="td1">매입단가</td>		<td id="td21">${rawmaterialsDTO.rawPrice}</td></tr>
<tr><td id="td1">창고명</td>		<td id="td22">${rawmaterialsDTO.whseCode}</td></tr>
<tr><td id="td1">비고</td>		<td id="td21">${rawmaterialsDTO.rawMemo}</td></tr>
</table>

<!-- button -->
<div id="buttons">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자')}">
<input type="button" value="수정" onclick="openPopup1('${rawmaterialsDTO.rawCode}');" id=btn1>
</c:if>
<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/Rawmaterials/home'" id=btn2>
</div>
</div>

</body>
</html>