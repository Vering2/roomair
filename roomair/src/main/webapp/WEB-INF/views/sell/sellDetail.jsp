<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/updateSellMemo.jsp</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">
<script>
$(document).ready(function () {
	//--------------------------------------------------- 페이지 권한 ----------------------
                
/*--------------------------------- 페이지 권한 ----------------------------------------  */
    var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
		
    if (team === "영업팀" || team === "관리자") {
		  
		$('#modify').show();
   }
  else if (team ===""){
	  window.close();
  }
  else{
	  
  }

});</script>
</head>

<!------------------------------------------------------ 본문 ---------------------------------------------------->
<body>
 <c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">
<div class="popupContainer" id="body">
<h1>수주 상세정보</h1>
<div class="horizontal-line"></div>
    <form action="${pageContext.request.contextPath}/sell/sellUpdatePro" id="popup" class="popup"  method="post" onsubmit="checkForm()" >
<label>수주 코드</label>
			
			<input type="text" style="width:130px;"name="sellCode" value="${sellDTO.sellCode}" readonly>
			<br>
			<label>처리 상태</label>
			<input type="text" name="sellState" value="${sellDTO.sellState}" readonly>
			<br>
			<label>거래처</label>
			<input type="text" name="clientCode" value="${sellDTO.clientCode}" readonly >
        	<input type="text" value="${sellDTO.clientCompany}" readonly >
			<br>
			<label>제품</label>
			<input type="text" name="prodCode" value="${sellDTO.prodCode}" readonly>
	      	<input type="text" name="prodName" value="${sellDTO.prodName}" readonly>
			<br>
			<label>제품 단가</label>
			<input type="text" name="prodPrice" value="${sellDTO.prodPrice}" readonly>원
			<br>
			<label>수주 수량</label>
			<input type="number" id="sellCount" name="sellCount" value="${sellDTO.sellCount}" readonly>개
			<br>
			<label>수주 단가</label>
			<input type="text" step="0.01" name="prodPrice" value="<fmt:formatNumber type="number" maxFractionDigits="2" value="${sellDTO.sellPrice}" pattern="###,###" />" id="calculateSellPrice" readonly/>
			<br>
			<label>수주 일자</label>
			<input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDate}"readonly>
			<br>
			<label>납기 일자</label>
			<input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDuedate}"readonly>
			<br>
			<label>담당자</label>
			<input type="text" name="sellEmpId" value="${sellDTO.sellEmpId}" readonly>
			<br>
			<label>비고</label>
			<br>
			<textarea id="sellMemo" readonly="readonly" style="width: 400px; height: 150px;">${sellDTO.sellMemo}</textarea>
			<br>
			<div class="btn">
			<c:if test="${sellDTO.sellState == '미출고'}">
				<button id="modify" class="modify-btn" style="display: none;" type="button" onclick="location.href='${pageContext.request.contextPath}/sell/sellUpdate?sellCode=${sellDTO.sellCode}'">수정</button>
			</c:if>
			<button type="button" onclick="window.close()" class="close-btn">닫기</button>
			</div>
	</form>

</div>
</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        
</c:choose>

<!--  ************************************************ javaScript *************************************************************-->

<!----------------------------------------------- 등록버튼 ---------------------------------------------->
 
<script type="text/javascript">


//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()


//팝업 창을 열어주는 함수
function openPopup(url) {
    var width = 500;
    var height = 500;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    var popupWindow = window.open(url, '_blank', "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
    popupWindow.focus();
}


// 초기화 함수
$(function() {
    // 현재 날짜를 가져오기
    var currentDate = new Date();
    
    // 날짜 형식 지정 (yy-mm-dd)
    var formattedDate = currentDate.getFullYear() + "-" +
                        ("0" + (currentDate.getMonth() + 1)).slice(-2) + "-" +
                        ("0" + currentDate.getDate()).slice(-2);

    // #sellDate 필드에 현재 날짜 설정
    $("#sellDate").val(formattedDate);
});
var today = new Date();
var dd = String(today.getDate() + 1).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
var yyyy = today.getFullYear();
var currentDateString = yyyy + '-' + mm + '-' + dd;
// 납품예정일 입력란
// var shipSdateInput = document.getElementById("shipSdate");
// 수주일자(오늘) 이후의 날짜만 선택할 수 있도록 Datepicker 설정
$(function() {
    $("#sellDuedate").datepicker({
        minDate: currentDateString, // 현재 날짜 이후로 설정
        dateFormat: "yy-mm-dd", // MySQL DATE 형식으로 출력
    });
});
//숫자를 ###,### 원 형식으로 포맷하는 함수
function formatCurrency(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

</script>


</body>
</html>