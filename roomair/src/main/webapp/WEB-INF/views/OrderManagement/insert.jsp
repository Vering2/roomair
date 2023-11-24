<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<h2>발주 등록</h2>

<!-- form -->
<form action="${pageContext.request.contextPath}/OrderManagement/insertPro" method="post" onsubmit="return validateForm()">
<table>
<tr><td id="td1">품번</td><td id="tdup1"> 		<input type="text" name="rawCode" id="rCInput" readonly> <input type="button" value="목록" onclick="openPopup1()" id=btn3></td></tr>
<tr><td id="td1">품명</td><td id="tdup"> 		<input type="text" name="rawName" id="rNInput" readonly></td></tr>
<tr><td id="td1">종류</td><td id="tdup"> 		<input type="text" name="rawType" id="rTInput" readonly></td></tr>
<tr><td id="td1">매입단가</td><td id="tdup">		<input type="number" name="rawPrice" id="rPInput" readonly></td></tr>
<tr><td id="td1">단위</td><td id="tdup">  <input type="text" name="rawUnit" id="rUInput" readonly></td></tr>
<tr><td id="td1">창고코드</td><td id="tdup"> 		<input type="text" name="whseCode" id="wCInput" readonly></td></tr>
<tr><td id="td1">창고명</td><td id="tdup">		<input type="text" name="whseName" id="wNInput" readonly></td></tr>
<tr><td id="td1">재고량</td><td id="tdup">		<input type="text" name="stockCount" id="sCInput" readonly></td></tr>
<tr><td id="td1">거래처코드</td><td id="tdup1"> 		<input type="text" name="clientCode" id="pInput" readonly> <input type="button" value="목록" onclick="openPopup2()" id=btn3></td></tr>
<tr><td id="td1">거래처명</td><td id="tdup"> 		<input type="text" name="clientCompany" id="cCInput" readonly></td></tr>
<tr><td id="td1">발주수량</td><td id="tdup"> 		<input type="number" name="buyCount"></td></tr>
<tr><td id="td1">발주신청일</td><td id="tdup"> 	<input type="date" name="buyDate"></td></tr>
<tr><td id="td1">담당자</td><td id="tdup">		<input readonly type="text" name="buyEmpId" value="${sessionScope.empId}" id="empName9999"></td></tr>
<input hidden name="buyInstate" value="신청완료">
			
</table>
<!-- button -->
<div id="buttons">
<input type="submit" value="등록" id=btn1>
</div>
</form>
</div>

<!-- javascript --> 
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">



// 원자재목록 페이지 팝업창
function openPopup1() {
    var popupX = (window.screen.width / 2) - (1300 / 2);
    var popupY = (window.screen.height / 2) - (670 / 2);
    var url = 'selectrawmaterials';
    var popupFeatures = "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=1300,height=670,left=" + popupX + ",top=" + popupY;
    const newWindow = window.open(url, '_blank', popupFeatures); 
}

//거래처목록 페이지 팝업창
function openPopup2() {
    var popupX = (window.screen.width / 2) - (1700 / 2);
    var popupY = (window.screen.height / 2) - (500 / 2);
    var url = '../Rawmaterials/selectclient';
    var popupFeatures = "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=1700,height=500,left=" + popupX + ",top=" + popupY;
    const newWindow = window.open(url, '_blank', popupFeatures); 
}

// form 제출전 rawPrice 값을 float로 변환
$('form').on('submit', function(e) {
    e.preventDefault();
    var rawPrice = $('#rPInput').val();		  // rawPrice 값을 가져옴
    var rawPriceFloat = parseFloat(rawPrice); // rawPrice 값을 float으로 변환
    // NaN 체크 : parseFloat가 실패하면 NaN 반환
    if (isNaN(rawPriceFloat)) {
        alert('매입단가는 숫자여야 합니다.');
        return;
    }
    $('#rPInput').val(rawPriceFloat); // 변환된 rawPrice 값을 form에 다시 설정
    this.submit();					  // form 제출
});

function validateForm() {
    var inputs = document.getElementsByTagName('input');
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].value == '') {
            alert('모든 항목을 채워주세요.');
            return false;
        }
    }
    return true;
}
</script>
</body>
</html>