<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>

<meta charset="UTF-8"> 
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/Rawmaterials.css" rel="stylesheet" type="text/css">
</head>

<!-- body -->
<body>
<div class="content">
<h2>원자재</h2>

<input id="rCInput" type="hidden">
<input id="rNInput" type="hidden">
<input id="rTInput" type="hidden">
<input id="rPInput" type="hidden">
<input id="wCInput" type="hidden">
<input id="wNInput" type="hidden">
<input id="sCInput" type="hidden">
<input id="rUInput" type="hidden">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 자식에서 부모페이지로 값 넣기
function setParentText(){
	opener.document.getElementById("rCInput").value = document.getElementById("rCInput").value;
	opener.document.getElementById("rNInput").value = document.getElementById("rNInput").value;
	opener.document.getElementById("rTInput").value = document.getElementById("rTInput").value;
	opener.document.getElementById("rPInput").value = document.getElementById("rPInput").value;
	opener.document.getElementById("wCInput").value = document.getElementById("wCInput").value;
	opener.document.getElementById("wNInput").value = document.getElementById("wNInput").value;
	opener.document.getElementById("sCInput").value = document.getElementById("sCInput").value;
	opener.document.getElementById("rUInput").value = document.getElementById("rUInput").value;
	window.close();
}

// memo 페이지 팝업창
function openPopup4(rawCode) {
    var popupX = (window.screen.width / 2) - (450 / 2);
    var popupY = (window.screen.height / 2) - (420 / 2);
    var url = '${pageContext.request.contextPath}/Rawmaterials/memo?rawCode=' + rawCode;
    var popupFeatures = "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=450,height=420,left=" + popupX + ",top=" + popupY;
    const newWindow = window.open(url, '_blank', popupFeatures); 
}
</script>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/OrderManagement/selectrawmaterials" method="get" id="searchBox">
<div id="searchForm" style="border-radius: 5px;">
<label>원자재코드</label>	<input type="text" name="search1" placeholder="원자재코드">
<label>원자재명</label>	<input type="text" name="search2" placeholder="원자재명">
<label>종류</label>		<select name="search3">
		<option value="">전체</option>
		<option value="향기">향기</option>
		<option value="용기">용기</option>
		<option value="스틱">스틱</option>
		<option value="라벨">라벨</option>
		<option value="포장재">포장재</option>
		</select>
<label>거래처</label>	<input type="text" name="search4" placeholder="거래처" onclick="openPopup3()">
<input type="submit" value="조회" id="searchButton">
</div>
</form>
<br>

<!-- table -->
<table class="tg" id="rawmaterialsList" style="border-radius: 5px;">
<thead>
<tr>
<td>번호</td>
<td>원자재코드</td>
<td>원자재명</td>
<td>종류</td>
<td>단위</td>
<td>매입단가</td>
<!-- <td>거래처</td> -->
<td>창고코드</td>
<td>창고명</td>
<td>재고수량</td>
<td>비고</td>
</tr>
</thead>

<tbody>
<c:forEach var="rawmaterialsDTO" items="${rawmaterialsList}">
<tr onclick="if(event.target.tagName!='A')
{document.getElementById('rCInput').value = '${rawmaterialsDTO.rawCode}';
document.getElementById('rNInput').value = '${rawmaterialsDTO.rawName}';
document.getElementById('rTInput').value = '${rawmaterialsDTO.rawType}';
document.getElementById('rPInput').value = '${rawmaterialsDTO.rawPrice}';
document.getElementById('wCInput').value = '${rawmaterialsDTO.whseCode}';
document.getElementById('wNInput').value = '${rawmaterialsDTO.whseName}';
document.getElementById('sCInput').value = '${rawmaterialsDTO.stockCount}';
document.getElementById('rUInput').value = '${rawmaterialsDTO.rawUnit}';
setParentText();}">
<td>${rawmaterialsDTO.rawNum}</td>
<td>${rawmaterialsDTO.rawCode}</td>
<td>${rawmaterialsDTO.rawName}</td>
<td>${rawmaterialsDTO.rawType}</td>
<td>${rawmaterialsDTO.rawUnit}</td>
<td>${rawmaterialsDTO.rawPrice}</td>
<%-- <td>${rawmaterialsDTO.clientCode}</td> --%>
<td>${rawmaterialsDTO.whseCode}</td>
<td>${rawmaterialsDTO.whseName}</td>
<td>${rawmaterialsDTO.stockCount}</td>
<!-- 비고기능 -->
<td><c:choose>
<c:when test="${not empty rawmaterialsDTO.rawMemo}">
<a href="#" onclick="openPopup4('${rawmaterialsDTO.rawCode}');" style="color:black;">[보기]</a>
</c:when>
<c:otherwise>
<c:set var="rawMemo" value="" />
</c:otherwise>
</c:choose></td>

</tr>
</c:forEach>
</tbody>
</table>

<!-- 페이징처리 -->
<div id="pagination" class="page_wrap">
<div class="page_nation">
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/OrderManagement/selectrawmaterials?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>
</div>
</div>
</div>

</body>
</html>