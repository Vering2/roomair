<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker.css"> 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/perfinsert.css"> 
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style>

table{
border: 1px solid rgba(221, 221, 221, 0.78);
    border-collapse: collapse;
    margin: 0 auto;
    color: #000000;
    width: 450px;
    max-width: 450px;
    font: 300 16px/16px "Inter", sans-serif;
    text-align: center;
    border-radius: 10px;

}

table th, table td {
	min-width: 100px;
	white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
	padding: 0 15px;
	border: none;
}


table th{
    background-color: rgba(94, 195, 151, 0.6);
    height: 30px;
    border: 1px solid rgba(221, 221, 221, 0.78);

}

table td{
min-width: 100px;
    white-space: nowrap;
    padding: 0 15px;
    height: 30px;
    border: 1px solid rgba(221, 221, 221, 0.78);
}

input[type="text"] {
    /* border: 1px solid #adb5bb; */
    /* border-radius: 5px; */
    border: none;
    width: 90%;
    height: 25px;
    font: 300 15px/15px "Inter", sans-serif;
    text-align: center;
    background-color: inherit;
    }
    
 #inputnum {
        border: 1px solid rgba(94, 195, 151, 1);
    border-radius: 5px;
    text-align: center;
    }
    
    input[type="number"]{
	border:none;
	width: 90%;
	height: 20px;
	font: 300 15px/15px "Inter", sans-serif;
	text-align: center;
	background-color: inherit;
}

.footerbtn{

    display: flex;
    justify-content: center;
    margin-top: 30px;
    
}
.h2head {
 text-align: center;

}

input[type="button"], input[type="submit"] {
    background-color: rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1);
    width: 100px;
    height: 30px;
    border-radius: 5px;
    color: #FFFFFF;
    border: 0;
    text-align: center;
    font: 300 18px/18px "Inter", sans-serif;
}

.cdbox{

width: 150px !important;
border: 1px solid black !important;
border-radius:  5px;
}

</style>

</head>
<body>
<div class="perfdetail">
<h1 class="perfinserthaed"> 생산실적 추가</h1>
<hr>



<form action="${pageContext.request.contextPath}/perf/perfinsertPro" id="perfinsert" method="POST">
 	<table>	 
 	<tbody>
				<tr>
				    <th> 실적코드</th>
				    <td><input type="text" id="perfCode" name="perfCode" readonly></td>
				    </tr>
				    
				    <tr>
					<th>작업지시코드</th><!-- worklist에서 받아옴 -->
					<td> <input type="text" id="workCode9999" name="workCode" readonly></td>
					</tr>
					
					<tr>
					<th>라인코드</th><!-- worklist에서 받아옴 -->
					<td ><input type="text" id="lineCode9999" name="lineCode" readonly></td> <!--  작업지시코드 -->
					</tr>
					
					<tr>
					<th> 제품코드 </th>
					<td ><input type="text" id="prodCode9999" name="prodCode" readonly></td> <!--  제품코드 -->
					</tr>
					
					<tr> 
					<th> 실적일 </th>
					<td ><input type="text" id="perfDate" name="perfDate" readonly></td> <!-- 실적일자(자동생성) -->			
					</tr>
					<tr>
					
					<th> 담당자 </th> <!--  세션으로 넘겨받음 -->
				<td ><input type="text" id="perfEmpId" name="perfEmpId" readonly ></td> <!--  담당자아이디(세션으로처리) -->
				</tr>
				</tbdoy>
				</table>
				<br>
				<table>
				 <tr>
    <th colspan=2>실적수</th>
    <th colspan=2>양품수</th>
    <th colspan=2 >불량수</th>

  </tr>
  <tr>
    <td colspan=2> <input type="number" id="perfAmount" name="perfAmount"> </td>
    <td  colspan=2> <input type="number" id="perfFair"  name="perfFair"> </td>
   <td  colspan=2> <input type="number" id="perfDefect"   name="perfDefect"></td>
  </tr>
  
  <tr>
  <th colspan=2> 불량사유 </th>
  <th colspan=2> 불량내역 </th>
    <th colspan=2> 비고 </th>
  
  </tr>
  
  <tr>
    <td  colspan=2><select id="perfDefectreason" name="perfDefectreason" >
	                    	    <option value="무결함">무결함</option>
		                      	<option value="파손">파손</option> <!-- 병깨짐 , 포장박스 꾸겨진거 등 -->
								<option value="누락">누락</option> <!--  포장 박스에 물건이 없다던가 포장이 안된다던가 -->
								<option value="기타">기타</option>
						       </select>        </td>
  <td colspan=2>   <input type="text" id="perfDefectmemo" name="perfDefectreasonmemo"></td>
  <td colspan=2><input type="text" id="perfmemo" name="perfmemo"></td>
  </tr>
</table>
	
			<div class="footerbtn">
			<input type="submit" id="btn" class="btn" value="등록">
			<input type="button" id="closebtn" class="btn" value="닫기">
			</div>
</form>
</div>

  <script>
  var currentDate = new Date();
  var currentYear = currentDate.getFullYear();
  var currentMonth = currentDate.getMonth();
  var currentDateVal = currentDate.getDate();

  $(function() {
      $("#workdate1").datepicker({
          dateFormat: 'yy-mm-dd',
          prevText: '이전 달',
          nextText: '다음 달',
          monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          dayNames: ['일','월','화','수','목','금','토'],
          dayNamesShort: ['일','월','화','수','목','금','토'],
          dayNamesMin: ['일','월','화','수','목','금','토'],
          showMonthAfterYear: true,
          yearSuffix: '년',
          minDate: new Date(currentYear, currentMonth, currentDateVal), // 현재 날짜부터 선택 가능
          // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
          onSelect: function(selectedDate) {
              console.log("선택한 날짜: " + selectedDate);
          }
      });
  }); // datekpicker1 끝
        
        
        $(function() {
            $("#workdate2").datepicker({
                dateFormat: 'yy-mm-dd',
                prevText: '이전 달',
                nextText: '다음 달',
                monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                dayNames: ['일','월','화','수','목','금','토'],
                dayNamesShort: ['일','월','화','수','목','금','토'],
                dayNamesMin: ['일','월','화','수','목','금','토'],
                showMonthAfterYear: true,
                yearSuffix: '년',
                minDate: new Date(currentYear, currentMonth, currentDateVal), // 현재 날짜부터 선택 가능
                // 데이트피커의 onSelect 이벤트 핸들러 설정
                onSelect: function(selectedDate) {
                    // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
                    console.log("선택한 날짜: " + selectedDate);
                }
            });
        }); // datepicker2 끝 
        
        $(document).ready(function() {
        	 // lineCode2 input box 클릭 이벤트 처리
         /*    $('#lineCode9999').click(function() {
            	console.log("라인코드 클릭");
                openLinePopup(); // 라인 팝업 열기
            });

            // prodCode2 input box 클릭 이벤트 처리
            $('#prodCode9999').click(function() {
            	console.log("제품코드 클릭");
                openProductPopup(); // 제품 팝업 열기
            }); */
            
            // workCode input box 클릭 이벤트 처리
            $('#workCode9999').click(function() {	
            	console.log("워크코드  클릭");
                openWorkOrderPopup(); // 제품 팝업 열기
            });
            
    
    });
        
        
       

      /*   function openLinePopup() {
            var popupUrl = '${pageContext.request.contextPath}/search/line?input=lineCode9999';
            window.open(
                popupUrl,
                '_blank',
                'width=800px, height=800px, left=900px, top=100px'
            );
        }

        function openProductPopup() {
        	
            var popupUrl = '${pageContext.request.contextPath}/search/product?input=prodCode9999';
            window.open(
                popupUrl,
                '_blank',
                'width=800px, height=800px, left=900px, top=100px'
            );
        } */
        
        function openWorkOrderPopup() {
            var popupUrl = '${pageContext.request.contextPath}/search/openworklist?input=workCode9999';
            window.open(
                popupUrl,
                '_blank',
                'width=1100px, height=800px, left=900px, top=100px'
            );
        }
       /*  
        function selectLineCode(lineCode) {
            window.opener.setLineCodeAndClosePopup(lineCode9999);
        }

        function selectProdCode(prodCode) {
            window.opener.setProdCodeAndClosePopup(prodCode9999);
        }
        
        
        
        function selectWorkCode(workCode) {
            window.opener.setWorkCodeAndClosePopup(workCode9999);
        }
         */
      /*  /*  function receiveSelectedLineData(data) {
            var parsedData = JSON.parse(data); // JSON 문자열 파싱
            document.getElementById('workCode').value = parsedData.workCode; //지시코드
            document.getElementById('lineCode').value = parsedData.lineCode; //지시코드
            document.getElementById('prodCode').value = parsedData.prodCode; //제품코드
            document.getElementById('perfAmount').value = parsedData.workAmount;//지시수량
          

             
        } */ // 라인코드 , 라인코드  값 받아오기 제어 끝********************************** */
        
        // 실적코드 자동생성 제어 ******************************
        $(document).ready(function() {
            // perfinsert 창이 열릴 때 PF년도월일시분초 값을 자동으로 생성
            var currentDate = new Date();
            var pfCode = 'PF' +
                currentDate.getFullYear() +
                padNumber(currentDate.getMonth() + 1) +
                padNumber(currentDate.getDate()) +
                padNumber(currentDate.getHours()) +
                padNumber(currentDate.getMinutes()) +
                padNumber(currentDate.getSeconds());

            // 생성된 PF 코드를 perfCode input box에 설정
            $('#perfCode').val(pfCode);
            
         // 현재 날짜를 yyyy-mm-dd 형식으로 생성
            var formattedDate = currentDate.getFullYear() + '-' + padNumber(currentDate.getMonth() + 1) + '-' + padNumber(currentDate.getDate());

            // 생성된 날짜를 perfDate input box에 설정
            $('#perfDate').val(formattedDate);
            
        }); 

        // 숫자를 두 자리로 만들어주는 함수
        function padNumber(number) {
            if (number < 10) {
                return '0' + number;
            }
            return number;
        } // 실적코드 자동생산 제어 끝 *************************************
        
      // 지시수량 양품수 불량수 제어 ********************************
        var perfDefectInput = document.getElementById("perfDefect");
        var perfFairInput = document.getElementById("perfFair");
        var perfAmountInput = document.getElementById("perfAmount");
        
        perfDefectInput.addEventListener('input', updateTotal);
        perfFairInput.addEventListener('input', updateTotal);
        perfAmountInput.addEventListener('input', updateTotal);
        
        function updateTotal() {
            var perfAmount = parseInt(perfAmountInput.value, 10); // 지시수량(실적수량)을 가져옴
            var defectCount = parseInt(perfDefectInput.value, 10) || 0; // 불량품 수를 가져오고, 값이 없으면 0으로 간주
            var fairCount = parseInt(perfFairInput.value, 10) || 0; // 양품 수를 가져오고, 값이 없으면 0으로 간주

            var total = defectCount + fairCount; // 양품수와 불량품수를 더함

            if (total > perfAmount) {
                if (fairCount > perfAmount && defectCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '양품수와 불량품수의 합은 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfDefectInput.value = ''; // 불량수 초기화
                    perfFairInput.value = ''; // 양품수 초기화
                } else if (fairCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '양품수는 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfFairInput.value = ''; // 양품수 초기화
                } else if (defectCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '불량품수는 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfDefectInput.value = ''; // 불량수 초기화
                } else  {
                	console.log("total: " + total);
                    console.log("perfAmount: " + perfAmount);
                    Swal.fire({
                        title: '입력 오류',
                        text: '양품수와 불량품수의 합이 ' + perfAmount + ' 보다 작습니다.',
                        icon: 'error'
                    });
                    perfDefectInput.value = ''; // 불량수 초기화
                    perfFairInput.value = ''; // 양품수 초기화
                    }
            }  
        }// 지시수량 양품수 불량수 제어 끝 ********************************
        
        
        
        
     // 불량사유 선택 상자
        var defectReasonSelect = document.getElementById("perfDefectreason");

        // 기타 불량사유 입력란
        var defectMemoInput = document.getElementById("perfDefectmemo");

        // 불량사유가 변경될 때 호출되는 함수
        function handleDefectReasonChange() {
            // 선택된 불량사유 값 가져오기
            var selectedValue = defectReasonSelect.value;

            // 불량사유가 "무결함"인 경우 기타 불량사유 입력란 비활성화 및 배경색 회색으로 설정
            if (selectedValue === "무결함") {
                defectMemoInput.disabled = true; // 입력란 비활성화
                defectMemoInput.style.backgroundColor = "#dddddd"; // 배경색 회색으로 설정
            } else {
                defectMemoInput.disabled = false; // 입력란 활성화
                defectMemoInput.style.backgroundColor = "white"; // 배경색을 기본 색상으로 설정
            }
        }

        // 불량사유 선택 상자의 변경 이벤트에 handleDefectReasonChange 함수 연결
        defectReasonSelect.addEventListener("change", handleDefectReasonChange);

        // 페이지 로드 시 초기 상태 설정을 위해 한 번 호출
        handleDefectReasonChange();
        
        //불량사유 제어 끝 ***********************************************
        
    document.getElementById("perfinsert").addEventListener("submit", function(event) {
    // 이벤트 기본 동작(폼 제출)을 중단하여 자바스크립트 코드를 실행
    event.preventDefault();
    
    // 불량수가 비어있을 경우 0으로 설정
    setDefaultDefectValue();

    // 여기에 폼 데이터를 서버로 전송하는 코드를 추가할 수 있습니다.
    $.post("${pageContext.request.contextPath}/perfajax/ajaxinsert", $("#perfinsert").serialize(), function(response) {
        // 서버 응답에 대한 처리 코드
        if (response.success) {
        	console.log("등록 성공"); // 디버깅 메시지
            // 서버 요청이 성공적으로 처리되었을 때 Swal.fire 코드를 실행
            Swal.fire({
                title: '등록이 완료되었습니다.',
                text: '성공적으로 등록되었습니다.',
                icon: 'success'
            });
        } else {
        	   console.log("등록 실패"); // 디버깅 메시지
            // 서버 요청이 실패했을 때의 처리 코드
            // 실패 메시지를 표시하거나 사용자에게 알림을 주는 등의 작업을 수행할 수 있습니다.
            Swal.fire({
                title: '등록 실패',
                text: '등록에 실패하였습니다.',
                icon: 'error'
            });
        }
    });
});

// "닫기" 버튼 클릭 이벤트 처리
document.getElementById("closebtn").addEventListener("click", function() {
	console.log("닫기");
    // 창을 닫는 동작을 수행할 수 있습니다.
    window.close();
});
    
    // 불량수 값이 비어있을 경우 0으로 설정하는 함수 실적수량 35 양품수가 35일경우 굳이 0을 입력할 필요가 없을 때 쓰기 위해서 사용
    function setDefaultDefectValue() {
        var perfDefectInput = document.getElementById("perfDefect");
        if (perfDefectInput.value === "") {
            perfDefectInput.value = "0"; // 또는 perfDefectInput.value = 0; (문자열이 아닌 정수로 설정)
        }
    }
    
 // 각 입력 필드의 DOM 요소를 가져옵니다.
    var perfAmountInput = document.getElementById("perfAmount");
    var perfFairInput = document.getElementById("perfFair");
    var perfDefectInput = document.getElementById("perfDefect");

    // 각 입력 필드에 대한 input 이벤트 리스너를 추가합니다.
    perfAmountInput.addEventListener("input", calculateDefect);
    perfFairInput.addEventListener("input", calculateDefect);

    function calculateDefect() {
        // 지시수량과 양품수 값을 가져옵니다.
        var perfAmount = parseInt(perfAmountInput.value) || 0;
        var perfFair = parseInt(perfFairInput.value) || 0;
        
        // 불량수를 계산합니다.
        var perfDefect = perfAmount - perfFair;
        
        // 계산된 불량수를 불량수 입력 필드에 자동으로 채웁니다.
        perfDefectInput.value = perfDefect;
    }
        
    </script>
</body>
</html>