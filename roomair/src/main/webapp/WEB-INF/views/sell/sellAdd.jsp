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
<div class="popupContainer" id="body">
<h1>수주 등록</h1>
<div class="horizontal-line"></div>
    <form action="${pageContext.request.contextPath}/sell/sellAddPro" id=sellAdd class="popup"  method="post"> <!-- onsubmit="checkForm()" --> 

       <!--  <label class="popupLabel">수주 코드 : </label>
      	<input type="text" id="sellCode" name="selCode" required="required" ><br> -->
      	
      	<div class="popupSerch">
        <label class="popupLabel">거래처</label>
        <input type="text" id="sellclientCode9999" name="clientCode" onclick=searchItem('sellclient','sellclientCode9999'); placeholder="거래처 코드" required="required">
        <input type="text" id="sellclientCompany9999" name="clientCompany" onclick=searchItem('sellclient','sellclientCode9999'); placeholder="거래처명"  required><br>
		</div>
		
		<div class="popupSerch">
 		<label class="popupLabel">제품</label>
 		<input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="제품 코드"  required>
		<input type="text" name="prodName" id="prodName9999" placeholder="제품명"  onclick="searchItem('prod','prodCode9999')" required><br>
		</div>
		
		<label class="popupLabel">제품 단가</label>
        <input type="text" name="prodPrice" id="prodPrice9999" onclick=searchItem('prod','prodPrice9999'); placeholder="제품 단가"  required>원<br>
        
        <label class="popupLabel">수주 수량</label>
        <input type="number" id="sellCount" name="sellCount" min="0" max="10000" step="5" placeholder="0"  required >개<br>

 	    <label class="popupLabel">수주 단가</label>
		<input type="text" id="sellPrice" min="0"  placeholder="수주 단가" value="${formattedSellPrice}" readonly="readonly" >원<br>    
     	
     	<label class="popupLabel">수주 일자</label>
        <input type="text" id="sellDate" name="sellDate"><br>
<!--         <input type="text" id="sellDate" name="sellDate" readonly><br> -->

        <label class="popupLabel">납기 일자</label>
        <input type="text" id="sellDuedate" name="sellDuedate"  placeholder="선택하세요" required><br>

        <label class="popupLabel">담당자</label>
        <input type="text" id="sellEmpId" name="sellEmpId" value="${sessionScope.empId}" readonly="readonly" ><br>

        <label class="popupLabel">비고</label><br>
        <textarea id="sellMemo" name="sellMemo" style="width: 300px; height: 150px;"></textarea><br>
		
		<br>
		<div class="btn">
        <button type="button" onclick="formCheck()" class="add-btn">등록</button>
        <button type="reset" class="reset-btn">취소</button>
        <button type="button" onclick="window.close()" class="close-btn">닫기</button>
    	</div>
	</form>

</div>
<!--  ************************************************ javaScript *************************************************************-->
<script type="text/javascript">

//----------------------------------------------------- 팝업 옵션 -------------------------------------------
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
$(document).ready(function() {
});

//--------------------------------------- 수주 수량 0일때 폼 안넘어가게 --------------------------
function formCheck() {
    if ($('#sellCount').val() == 0) {
        alert("수주 수량을 입력하세요.");
        return false; // 폼 제출 방지
    } else {
        $('#sellAdd').submit();    
    }
}
$(document).ready(function () {
		//--------------------------------------------------- 페이지 권한 ----------------------
	                
	/*--------------------------------- 페이지 권한 ----------------------------------------  */
        var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
 		
        if (team === "") {
        	 window.location.href = "${pageContext.request.contextPath}/login/login";

        }
        else if ((team !== "관리자" && team !== "영업팀")) {
       	 window.location.href = "${pageContext.request.contextPath}/main/calendar";

       }
	//---------------------------------------------- 수주 단가 계산 함수 -----------------------------------------
	// 제품 코드의 값이 변경이 될때 가격 자동 변경
    $(document).on('change', '#prodCode9999', function() {
    	console.log("change 이벤트");
        calculateSellPrice();
    });
});

// 수주단가 계산 함수(=제품단가*수주수량)
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
//----------------------------------------------- 수주 수량 입력 확인 ------------------------------------

//------------------------------------------------ 수주일자, 납기일자 함수 ---------------------------------
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



</script>


</body>
</html>