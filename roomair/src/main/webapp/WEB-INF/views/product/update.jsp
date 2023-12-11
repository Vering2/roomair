<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
<title>roomair</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 		추가안되면 사이드바에 있는 이거^때문임 -->

<link href="${pageContext.request.contextPath }/resources/css/productWrite.css" rel="stylesheet" type="text/css">

</head>
<body>
	<c:choose>
		<c:when test="${!(empty sessionScope.empDepartment)}">
			<div class="container">
				<h2>제품 수정</h2>
				<hr>
				<form action="${pageContext.request.contextPath}/product/updatePro" method="post">
					<div class="form-group">
						<p>제품 코드</p>
						<input type="text" name="prodCode" value="${prodDTO.prodCode}">
					</div>
					<div class="form-group">
						<p>제품명</p>
						<input type="text" name="prodName" value="${prodDTO.prodName}">
					</div>
					<div class="form-group">
						<p>제품 단위</p>
						<input type="text" name="prodUnit" value="${prodDTO.prodUnit}">
					</div>
					<div class="form-group">
						<p>용량(ml)</p>
						<input type="text" name="prodSize" value="${prodDTO.prodSize}" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
						<!--     정수 숫자만 입력 -->
					</div>
					<div class="form-group">
						<p>향기</p>
						<input type="text" name="prodPerfume" value="${prodDTO.prodPerfume}">
					</div>
					<div class="form-group">
						<p>거래처명</p>
						<input type="hidden" name="clientCode" id="sellclientCode9999" onclick="searchItem('sellclient','sellclientCode9999')" value="${prodDTO.clientCode}"> <input type="text" name="clientCompany" id="sellclientCompany9999" readonly onclick="searchItem('sellclient','sellclientCode9999')" style="cursor: pointer;" value="${prodDTO.clientCompany}">
						<%--     <input type="text" name="clientCode" value="${prodDTO.clientCode}" style="cursor: pointer;"> --%>
					</div>
					<div class="form-group">
						<p>창고명</p>
						<%--     <input type="text" name="whseCode" value="${prodDTO.whseCode}" style="cursor: pointer;"> --%>
						<input type="hidden" name="whseCode" id="whseCode9999" onclick="searchItem('whse','whseCode9999')" value="${prodDTO.whseCode}"> <input type="text" name="whseName" id="whseName9999" onclick="searchItem('whse','whseCode9999')" value="${prodDTO.whseName}" style="cursor: pointer;">
					</div>
					<div class="form-group">
						<p>매출 단가(원)</p>
						<input type="number" step="0.01" name="prodPrice" value="${prodDTO.prodPrice}" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); if(this.value.indexOf('.') !== -1){if(this.value.split('.')[1].length > 2){this.value = this.value.slice(0, -1)}};">
						<!--     소수점아래 두자리수까지 숫자만 입력 -->
					</div>
					<p class="memo">비고</p>
					<%--     <input type="text" name="prodMemo" value="${prodDTO.prodMemo}"> --%>
					<textarea name="prodMemo" class="prodMemo" rows="5" cols="">${prodDTO.prodMemo}</textarea>
					<div id="button">
						<input type="submit" value="수정"> <input type="button" value="닫기" onclick="closeWindow()">
					</div>
				</form>
			</div>

		</c:when>
		<c:otherwise>

			<input type="text" hidden="">

		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
		//--------------------------------------------------------------------------
		//팝업 옵션
		const popupOpt = "top=60,left=140,width=720,height=600";

		//검색 팝업
		function searchItem(type, inputId) {
			var url = "${pageContext.request.contextPath}/search/search?type="
					+ type + "&input=" + inputId;
			var popup = window.open(url, "", popupOpt);
		} //openWindow()
		//--------------------------------------------------------------------------
		//닫기버튼 누르면 창 닫힘
		function closeWindow() {
			window.close();
		}
		//--------------------------------------------------------------------------
		document
				.querySelector('form')
				.addEventListener(
						'submit',
						function(event) {
							const prodName = document
									.getElementsByName("prodName")[0].value;
							const prodUnit = document
									.getElementsByName("prodUnit")[0].value;
							const prodSize = document
									.getElementsByName("prodSize")[0].value;
							const prodPerfume = document
									.getElementsByName("prodPerfume")[0].value;
							const clientCompany = document
									.getElementsByName("clientCompany")[0].value;
							const whseName = document
									.getElementsByName("whseName")[0].value;
							const prodPrice = document
									.getElementsByName("prodPrice")[0].value;

							if (!prodName || !prodUnit || !prodSize
									|| !prodPerfume || !clientCompany
									|| !whseName || !prodPrice) {
								event.preventDefault();
								alert("모든 값을 입력해주세요.");
							}
						});
	</script>

</body>
</html>
