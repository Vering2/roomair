<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/sellAdd</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>

</head>

<!------------------------------------------------------ 본문 ---------------------------------------------------->
<body>
<div class="popupContainer">
<h1>수주 정보 수정</h1>
<div class="horizontal-line"></div>
    <form action="${pageContext.request.contextPath}/sell/sellUpdatePro" id="sellUpdate" class="popup"  method="post"  >

       	<label class="popupLabel">수주 코드</label>
      	<input style="width:130px;" type="text" id="sellCode" name="sellCode" value="${sellDTO.sellCode}" readonly ><br> 
      	
      	<div class="popupSerch">
        <label class="popupLabel">거래처</label>
        <input type="text" id="clientCode9999" name="clientCode"  value="${sellDTO.clientCode}" onclick=searchItem('client','clientCode9999'); required>
        <input type="text" id="clientCompany9999" name="clientCompany" value="${sellDTO.clientCompany}" onclick=searchItem('client','clientCode9999');  required><br>
		</div>
		
		<div class="popupSerch">
 		<label class="popupLabel">제품</label>
 		<input type="text" name="prodCode" id="prodCode9999" value="${sellDTO.prodCode}" onclick=searchItem('prod','prodCode9999'); required>
		<input type="text" name="prodName" id="prodName9999" value="${sellDTO.prodName}" readonly onclick="searchItem('prod','prodCode9999')" required><br>
		</div>
		
		<label class="popupLabel">제품 단가</label>
        <input type="text" name="prodPrice" id="prodPrice9999" value="${sellDTO.prodPrice}" onclick=searchItem('prod','prodPrice9999'); readonly>원<br>
        
        <label class="popupLabel">수주 수량</label>
        <input type="number" id="sellCount" name="sellCount" min="0" max="10000" step="5" value="${sellDTO.sellCount}" onchange="calculateSellPrice()" required>개<br>

 	    <label class="popupLabel">수주 단가</label>
		<input type="text" id="sellPrice" min="0" value="${formattedSellPrice}" readonly>원<br>    
		
    	<label class="popupLabel">수주 일자</label>
        <input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDate}" readonly><br>
        
        <label class="popupLabel">납기 일자</label>
        <input type="text" id="sellDuedate" value="${sellDTO.sellDuedate}" name="sellDuedate" required><br>

        <label class="popupLabel">담당자</label>
        <input type="text" id="sellEmpId" name="sellEmpId" value="${sessionScope.empId}" readonly="readonly" ><br>

        <label class="popupLabel">비고</label><br>
        <textarea id="sellMemo" name="sellMemo" style="width: 400px; height: 150px;">${sellDTO.sellMemo}</textarea><br>
		
		<br>
		<div class="btn">
       		<button class="add-btn" type="button" onclick="formCheck()" >등록</button>
        	<button class="reset-btn" type="reset">취소</button>
        	<button class="close-btn" type="button" onclick="window.close()">닫기</button>
    	</div>
	</form>

</div>



<!--  ************************************************ javaScript *************************************************************-->



<script type="text/javascript">


  $(document).ready(function () {
	//--------------------------------------------------- 페이지 권한 ----------------------
                var team = "${sessionScope.empDepartment}";

                if (team === "" || (team !== "관리자" && team !== "영업팀")) {
                    // 창을 닫습니다.
                    window.close(); // 이 코드는 창을 닫으려고 시도합니다.
                    // 또는 에러 페이지로 리디렉션할 수 있습니다.
                    // window.location.href = "${pageContext.request.contextPath}/error";
                }
   //--------------------------------------------------- 제품가격에 따라 수주가격 자동 변경  ----------------------
// 제품 코드의 값이 변경이 될때 가격 변경
    $(document).on('change', '#prodCode9999', function() {
    	console.log("change 이벤트");
        calculateSellPrice();
    });
});

//--------------------------------------------------- 팝업옵션 ----------------------
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


//--------------------------------------------------- 수주가격 구하는 함수 (=제품가격*수주수량) ----------------------
function calculateSellPrice() {
  	var prodPriceInput = document.getElementById('prodPrice9999').value;
    var sellCountInput = document.getElementById('sellCount').value;

 	// 입력 값을 정리하여 정수로 변환
    var prodPrice = parseInt(prodPriceInput.replace(/[^\d.]/g, ''), 10);
    var sellCount = parseInt(sellCountInput, 10);
	
    var sellPrice = prodPrice * sellCount;
    
    console.log(sellPrice);
    if (!isNaN(sellPrice)) {
        document.getElementById('sellPrice').value = formatCurrency(sellPrice);
    } else {
        document.getElementById('sellPrice').value = '';
    }
}
//숫자를 ###,### 원 형식으로 포맷하는 함수
function formatCurrency(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// 이벤트 리스너 등록
document.getElementById('sellCount').addEventListener('input', calculateSellPrice);
document.getElementById('prodPrice9999').addEventListener('input', calculateSellPrice);

// 초기화 함수
calculateSellPrice();

//--------------------------------------------------- 납기 일자 ----------------------------
$(function() {
    $("#sellDate").datepicker
});

// 수주일자(오늘) 이후의 날짜만 선택할 수 있도록 Datepicker 설정
$(function() {
    $("#sellDuedate").datepicker({ //납기일자는
        minDate: "#sellDate", // 수주일자 이후로만 설정가능
        dateFormat: "yy-mm-dd", // MySQL DATE 형식으로 출력
    });
});


//--------------------------------------- 수주 수량 0일때 폼 안넘어가게 --------------------------
function formCheck() {
    if ($('#sellCount').val() == 0) {
        alert("수주 수량을 입력하세요.");
        return false; // 폼 제출 방지
    } else {
        $('#sellUpdate').submit();    
    }
}
</script>


</body>
</html>