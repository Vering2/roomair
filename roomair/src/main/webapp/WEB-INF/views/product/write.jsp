<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>roomair</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 		추가안되면 사이드바에 있는 이거^때문임 -->
<link
	href="${pageContext.request.contextPath }/resources/css/productWrite.css"
	rel="stylesheet" type="text/css">

</head>
<body>
<!-- // <로그아웃 상태에서 주소접속 시 빈화면 출력 -->
<c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">
<div class="container"> 
    <h2>제품 추가</h2>
    <hr>
    <form action="${pageContext.request.contextPath}/product/writePro" method="post">
    
    <div class="form-group">
    <p>제품 코드</p>
    <input type="text" name="prodCode" value="${prodDTO.prodCode }" readonly="readonly">
    </div>
    <div class="form-group">
    <p>제품명</p>
    <input type="text" name="prodName" placeholder="제품명을 입력해 주세요">
    </div>
    <div class="form-group">
    <p>제품 단위</p>
    <input type="text" name="prodUnit"  placeholder="제품 단위를 입력해 주세요." value="EA">
    </div>
    <div class="form-group">
    <p>용량(ml)</p>
    <input type="text" name="prodSize"  placeholder="용량을 입력해 주세요."
    oninput="this.value = this.value.replace(/[^0-9]/g, '')">
    <!--     정수 숫자만 입력 -->
    </div>
    <div class="form-group">
    <p>향기</p>
    <input type="text" name="prodPerfume"  placeholder="향기를 입력해 주세요.">
    </div>
    <div class="form-group">
    <p>거래처명</p>
    <input type="hidden" name="clientCode" id="sellclientCode9999" onclick="searchItem('sellclient','sellclientCode9999')" >
    <input type="text" name="clientCompany" id="sellclientCompany9999"  readonly
    	onclick="searchItem('sellclient','sellclientCode9999')"
    	 placeholder="거래처를 선택해 주세요."
    	 style="cursor: pointer;">
    </div>
    <div class="form-group">
    <p>창고명</p>
    <input type="hidden" name="whseCode" id="whseCode9999" onclick="searchItem('whse','whseCode9999')">
    <input type="text" name="whseName" id="whseName9999"  placeholder="창고를 선택해 주세요."
    onclick="searchItem('whse','whseCode9999')"
    style="cursor: pointer;" readonly>
    </div>
    <div class="form-group">
    <p>매출 단가(원)</p>
    <input type="number" step="0.01" name="prodPrice" placeholder="매출 단가를 입력해 주세요."
    oninput="this.value = this.value.replace(/[^0-9.]/g, ''); if(this.value.indexOf('.') !== -1){if(this.value.split('.')[1].length > 2){this.value = this.value.slice(0, -1)}};">
<!--     소수점아래 두자리수까지 숫자입력 -->
    </div>
    <p class="memo">비고</p>
     <textarea name="prodMemo" class="prodMemo" placeholder="비고를 입력해 주세요." rows="5" cols=""></textarea>
    <div id="button">
    <input type="submit" value="확인">
    <input type="button" value="닫기" onclick="closeWindow()">
    </div>
    </form>
</div>

<!-- // 로그아웃 상태에서 주소접속 시 빈화면 출력>	 -->
	</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        </c:choose>

<script type="text/javascript">


$(document).ready(function() {
    $('#prodCode9999').click(function(){
           $.ajax({
               url: "${pageContext.request.contextPath}/product/prodCode",
               method: "GET",
               dataType: "text",
               success: function(data) {
                   // Ajax 요청에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행
                   codeNum = data;
                   console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]

                   // 변수에 할당된 데이터를 기반으로 추가 작업 수행
                   someFunction(codeNum);
               }
           }); // ajax 끝 */

           function someFunction(data) {
                codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
                    var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
                    var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
                    prodCode = codeNum.charAt(0) + codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
                    counter++;
           } // someFunction(data)

           document.getElementById("prodCode").textContent = prodCode;
	});
    
    
	
});//ready

//--------------------------------------------------------------------------
// 팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()
//--------------------------------------------------------------------------
//닫기버튼 누르면 창 닫힘
		  function closeWindow() {
        window.close();
    }

//--------------------------------------------------------------------------
//창뜨면 제품명에 포커스
document.addEventListener('DOMContentLoaded', function() {
        document.getElementsByName("prodName")[0].focus();
    });
    
 //모든 값 입력해야함
  document.querySelector('form').addEventListener('submit', function(event) {
        const prodName = document.getElementsByName("prodName")[0].value;
        const prodUnit = document.getElementsByName("prodUnit")[0].value;
        const prodSize = document.getElementsByName("prodSize")[0].value;
        const prodPerfume = document.getElementsByName("prodPerfume")[0].value;
        const clientCompany = document.getElementsByName("clientCompany")[0].value;
        const whseName = document.getElementsByName("whseName")[0].value;
        const prodPrice = document.getElementsByName("prodPrice")[0].value;

        if (!prodName || !prodUnit || !prodSize || !prodPerfume || !clientCompany || !whseName || !prodPrice) {
            event.preventDefault();
            alert("모든 값을 입력해주세요.");
        }
    });

</script>
</body>
</html>
