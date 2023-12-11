<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
function openPopup2() {
    var popupX = (window.screen.width / 2) - (1500 / 2);
    var popupY = (window.screen.height / 2) - (680 / 2);
    var url = 'selectwarehouse';
    var popupFeatures = "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=1500,height=680,left=" + popupX + ",top=" + popupY;
    const newWindow = window.open(url, '_blank', popupFeatures); 
}
</script>
</head>

<!-- body -->
<body>
	<div class="content">
		<h2>수정하기</h2>

		<!-- from -->
		<form action="${pageContext.request.contextPath}/Rawmaterials/updatePro" method="post">

			<!-- table -->
			<table>
				<tr>
					<td id="td1">원자재코드</td>
					<td id="tdup"><input type="text" name="rawCode" value="${rawmaterialsDTO.rawCode}" readonly></td>
				</tr>
				<tr>
					<td id="td1">원자재명</td>
					<td id="tdup"><input type="text" name="rawName" value="${rawmaterialsDTO.rawName}"></td>
				</tr>
				<tr>
					<td id="td1">종류</td>
					<td id="tdup"><input type="text" name="rawType" value="${rawmaterialsDTO.rawType}" readonly></td>
				</tr>
				<tr>
					<td id="td1">단위</td>
					<td id="tdup"><input type="text" name="rawUnit" value="${rawmaterialsDTO.rawUnit}"></td>
				</tr>
				<tr>
					<td id="td1">매입단가</td>
					<td id="tdup"><input type="text" name="rawPrice" value="${rawmaterialsDTO.rawPrice}"></td>
				</tr>
				<tr>
					<td id="td1">창고코드</td>
					<td id="tdup1"><input type="text" name="whseCode" id="pInput2" value="${rawmaterialsDTO.whseCode}" readonly> <input type="button" value="목록" onclick="openPopup2()" id=btn3></td>
				</tr>
				<tr>
					<td id="td1">비고</td>
					<td id="tdup"><textarea name="rawMemo" rows="10" cols="15">${rawmaterialsDTO.rawMemo}</textarea></td>
				</tr>
			</table>

			<!-- button -->
			<div id="buttons">
				<input type="submit" value="수정" id=btn1>
			</div>
		</form>
	</div>

</body>
</html>