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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

// 팝업옵션
const popupOpt = "top=60,left=140,width=720,height=600";

// 검색팝업
function searchItem(type, inputId, type2) {
	var url = "${pageContext.request.contextPath}/search/emp?type=" + type + "&input=" + inputId + "&type2=" + type2;
	var popup = window.open(url, "", popupOpt);
}
</script>
</head>

<!-- body -->
<body>
<div class="content">
<h2>수정하기</h2>

<!-- from -->
<form action="${pageContext.request.contextPath}/OrderManagement/updatePro" method="post">

<!-- table -->
<table>
<tr><td id="td1">발주코드</td>
	<td id="tdup"><input type="text" name="buyNum" value="${ordermanagementDTO.buyNum}" readonly></td></tr>
<tr><td id="td1">품번</td>
    <td id="tdup"><input type="text" name="rawCode" value="${ordermanagementDTO.rawCode}" readonly></td></tr>
<tr><td id="td1">품명</td>
    <td id="tdup"><input type="text" name="rawName" value="${ordermanagementDTO.rawName}" readonly></td></tr>
<tr><td id="td1">종류</td>
    <td id="tdup"><input type="text" name="rawType" value="${ordermanagementDTO.rawType}" readonly></td></tr>
<tr><td id="td1">거래처코드</td>
    <td id="tdup"><input type="text" name="clientCode" value="${ordermanagementDTO.clientCode}" readonly></td></tr>
<tr><td id="td1">재고수량</td>
    <td id="tdup"><input type="text" name="whseCount" value="${ordermanagementDTO.stockCount}" readonly></td></tr>
<tr><td id="td1">발주수량</td>
    <td id="tdup"><input type="text" name="buyCount" value="${ordermanagementDTO.buyCount}"></td></tr>
<tr><td id="td1">매입단가</td>
    <td id="tdup"><input type="text" name="rawPrice" value="${ordermanagementDTO.rawPrice}" readonly></td></tr>
<tr><td id="td1">발주신청일</td>
    <td id="tdup"><input type="date" name="buyDate" value="${ordermanagementDTO.buyDate}"></td></tr>
<tr><td id="td1">담당자</td>
    <td id="tdup"><input id="empName9999" onclick="searchItem('emp','empId9999','영업팀')" type="text" name="buyEmpId" value="${ordermanagementDTO.buyEmpId}" readonly></td></tr>
<tr><td id="td1">발주상태</td>
    <td id="tdup"><input type="radio" name="buyInstate" value="신청완료" checked>신청완료
				  <input type="radio" name="buyInstate" value="발주완료">발주완료</td></tr>
</table>

<!-- button -->
<div id="buttons">
<input type="submit" value="수정" id=btn1>
</div>
</form>
</div>

</body>
</html>