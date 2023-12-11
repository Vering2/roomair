<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/Rawmaterialspop.css" rel="stylesheet" type="text/css">
</head>

<!-- body -->
<body>
	<div class="content">
		<h2>원자재 추가</h2>

		<!-- form -->
		<form action="${pageContext.request.contextPath}/Rawmaterials/insertPro" method="post">
			<table>
				<tr>
					<td id="td1">종류</td>
					<td id="tdup"><select name="rawType" onchange="updateRawCode()">
							<option value="">전체</option>
							<option value="향기">향기</option>
							<option value="용기">용기</option>
							<option value="스틱">스틱</option>
							<option value="라벨">라벨</option>
							<option value="포장재">포장재</option>
					</select></td>
				</tr>
				<tr>
					<td id="td1">원자재코드</td>
					<td id="tdup"><input type="text" name="rawCode" id="rawCodeField" readonly="readonly" required></td>
				</tr>
				<tr>
					<td id="td1">원자재명</td>
					<td id="tdup"><input type="text" name="rawName" required></td>
				</tr>
				<tr>
					<td id="td1">단위</td>
					<td id="tdup"><input type="text" name="rawUnit" value="EA"></td>
				</tr>
				<tr>
					<td id="td1">매입단가</td>
					<td id="tdup"><input type="number" name="rawPrice" required></td>
				</tr>
				<tr>
					<td id="td1">창고코드</td>
					<td id="tdup1"><input type="text" name="whseCode" id="pInput2" readonly="readonly" required> <input type="button" value="목록" onclick="openPopup2()" id=btn3></td>
				</tr>
				<tr>
					<td id="td1">비고</td>
					<td id="tdup"><input type="text" name="rawMemo"></td>
				</tr>
			</table>

			<!-- button -->
			<div id="buttons">
				<input type="submit" value="추가" id=btn1>
			</div>
		</form>
	</div>

	<!-- javascript -->
	<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript">

// 참고사이트
// https://inpa.tistory.com/entry/JS-%F0%9F%93%9A-%EB%B6%80%EB%AA%A8%EC%B0%BD-%E2%9E%9C-%EC%9E%90%EC%8B%9D%EC%B0%BD%EC%9D%
// 98-%EA%B0%92-%EC%A0%84%EB%8B%AC#%EC%9E%90%EC%8B%9D%EC%B0%BD%EC%97%90%EC%84%9C_%EB%B6%80%EB%AA%A8%EC%B0%BD%EC%9C%BC%EB%A1
// %9C_%EA%B0%92_%EC%A0%84%EB%8B%AC%ED%95%98%EA%B8%B0

let openWin;

function openPopup2() {
    var popupX = (window.screen.width / 2) - (1500 / 2);
    var popupY = (window.screen.height / 2) - (680 / 2);
    var url = 'selectwarehouse';
    var popupFeatures = "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=1500,height=680,left=" + popupX + ",top=" + popupY;
    const newWindow = window.open(url, '_blank', popupFeatures); 
}

// 종류 선택하면 자동으로 원자재코드 값 생성
function updateRawCode() {
    const rawTypeField = document.querySelector('select[name="rawType"]');
    const rawCodeField = document.querySelector('#rawCodeField');
    
    if (rawTypeField.value === "향기") {
        rawCodeField.value = "PE" + (${PEcount}+1);
    } else if (rawTypeField.value === "용기") {
        rawCodeField.value = "GL" + (${GLcount}+1);
    } else if (rawTypeField.value === "스틱") {
        rawCodeField.value = "ST" + (${STcount}+1);
    } else if (rawTypeField.value === "라벨") {
        rawCodeField.value = "LB" + (${LBcount}+1);
    } else if (rawTypeField.value === "포장재") {
        rawCodeField.value = "PC" + (${PCcount}+1);
    } else {
        rawCodeField.value = "";
    }
}
</script>
</body>
</html>