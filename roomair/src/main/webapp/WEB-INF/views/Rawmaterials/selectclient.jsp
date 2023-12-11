<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<h2>거래처</h2>

		<input id="cInput" type="hidden"> <input id="cCInput" type="hidden">

		<!-- javascript -->
		<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
		<script type="text/javascript">

// 자식에서 부모페이지로 값 넣기
function setParentText(){
	opener.document.getElementById("pInput").value = document.getElementById("cInput").value
	opener.document.getElementById("cCInput").value = document.getElementById("cCInput").value
	window.close();
}

//memo 페이지 팝업창
function openPopup4(clientCode) {
    var popupX = (window.screen.width / 2) - (450 / 2);
    var popupY = (window.screen.height / 2) - (420 / 2);
    var url = '${pageContext.request.contextPath}/Rawmaterials/memo2?clientCode=' + clientCode;
    var popupFeatures = "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=450,height=420,left=" + popupX + ",top=" + popupY;
    const newWindow = window.open(url, '_blank', popupFeatures); 
}
</script>

		<!-- form(검색) -->
		<form action="${pageContext.request.contextPath}/Rawmaterials/selectclient" method="get" id="searchBox">
			<div id="searchForm" style="border-radius: 5px;">
				<label>거래처코드</label> <input type="text" name="search1" placeholder="거래처코드"> <label>거래처명</label> <input type="text" name="search2" placeholder="거래처명"> <label>담당자</label> <input type="text" name="search3" placeholder="담당자"> <input type="submit" value="조회" id="searchButton">
			</div>
		</form>
		<br>

		<!-- table -->
		<table class="tg" id="rawmaterialsList" style="border-radius: 5px;">
			<thead>
				<tr>
					<td>구분</td>
					<td>거래처코드</td>
					<td>거래처명</td>
					<td>사업자번호</td>
					<td>업태</td>
					<td>대표자</td>
					<td>담당자</td>
					<td>거래처주소</td>
					<td>상세주소</td>
					<td>거래처번호</td>
					<td>휴대폰번호</td>
					<td>팩스번호</td>
					<td>이메일</td>
					<td>비고</td>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="clientDTO" items="${clientList}">
					<tr onclick="if(event.target.tagName!='A')
{document.getElementById('cInput').value = '${clientDTO.clientCode}'; document.getElementById('cCInput').value = '${clientDTO.clientCompany}';
setParentText();}">
						<td>${clientDTO.clientType}</td>
						<td>${clientDTO.clientCode}</td>
						<td>${clientDTO.clientCompany}</td>
						<td>${clientDTO.clientNumber}</td>
						<td>${clientDTO.clientDetail}</td>
						<td>${clientDTO.clientCeo}</td>
						<td>${clientDTO.clientName}</td>
						<td>${clientDTO.clientAddr1}</td>
						<td>${clientDTO.clientAddr2}</td>
						<td>${clientDTO.clientTel}</td>
						<td>${clientDTO.clientPhone}</td>
						<td>${clientDTO.clientFax}</td>
						<td>${clientDTO.clientEmail}</td>

						<!-- 비고기능 -->
						<td><c:choose>
								<c:when test="${not empty clientDTO.clientMemo}">
									<a href="#" onclick="openPopup4('${clientDTO.clientCode}');" style="color: black;">[보기]</a>
								</c:when>
								<c:otherwise>
									<c:set var="clientMemo" value="" />
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
					<a href="${pageContext.request.contextPath}/Rawmaterials/selectclient?pageNum=${i}&search1=${pageDTO.search1}">${i}</a>
				</c:forEach>
			</div>
		</div>
	</div>

</body>
</html>