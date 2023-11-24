<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">


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
   background-color: #9AC5F4;
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
    width: 95%;
    height: 25px;
    font: 300 15px/15px "Inter", sans-serif;
    text-align: center;
    background-color: inherit;
    }
    
 .inputnum {
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
    color: white;
    background-color: #9AC5F4;
    width: 50px;
    height: 30px;
    border-radius: 3px;
    border: 0;
    text-align: center;
    font: 500 15px/20px "Inter", sans-serif;
    font-weight: bold;
    cursor: pointer;
    margin-right: 5px;
}

</style>

</head>
<body>
<h2 class="h2head"> 생산실적 내역 </h2>
<form id="detailform" >
<table>
<tbody>
  <tr>
    <th> 실적코드 </th> 
    <td class="tg-0lax" id="perfCodeDisplay" ><input type="text" name="perfCode" value="${perfDTO.perfCode}" readonly> </td>
    </tr>
    
    <tr>
    <th> 지시코드 </th> 
    <td><input type="text" name="workCode" value="${perfDTO.workCode}" readonly></td>
    </tr>
    <tr>
    <th> 라인정보 </th>
    <td><input type="text" name="lineCode" value="${perfDTO.workInfo}"readonly> </td>
    </tr>
    <tr>
    <th> 제품코드</th>
    <td><input type="text" name="prodCode" value="${perfDTO.prodCode}"readonly></td>
    </tr>
    
    <tr>
    <th> 지시일자 </th>
    <td> <input type="text" name="perfDate" value="${perfDTO.perfDate}"readonly> </td> 
    </tr>
    
    <tr>
    <th> 담당자 </th>
    <td><input type="text" name="perfEmpId" value="${sessionScope.empId}"></td>
    </tr>
    </tbody>
    </table>
    <br>
    
   <table id="tg">
  <tr>
    <th colspan=2>지시수량</th>
    <th colspan=2>양품수</th>
    <th colspan=2 >불량수</th>

  </tr>
  <tr>
    <td colspan=2> <input type="number" id="workAmount" class="inputnum"  name="workAmount" value="${perfDTO.workAmount}" readonly> </td>
    <td  colspan=2> <input type="number" id="perfFair" class="inputnum"  name="perfFair" value="${perfDTO.perfFair}"> </td>
   <td  colspan=2> <input type="number" id="perfDefect"   class="inputnum"  name="perfDefect" value="${perfDTO.perfDefect}" readonly></td>
  </tr>
  
  <tr>
  <th colspan=2> 불량사유 </th>
  <th colspan=2> 불량내역 </th>	
    <th colspan=2> 비고 </th>
  
  </tr>
  
  <tr>
    <td  colspan=2><select id="perfDefectreason" name="perfDefectreason">
	                    	    <option value="무결함">무결함</option>
		                      	<option value="파손">파손</option> <!-- 병깨짐 , 포장박스 꾸겨진거 등 -->
								<option value="누락">누락</option> <!--  포장 박스에 물건이 없다던가 포장이 안된다던가 -->
								<option value="기타">기타</option>
						       </select>        </td>
  <td colspan=2>   <input type="text" name="perfDefectreasonmemo" value="${perfDTO.perfDefectmemo}"></td>
  <td colspan=2><input type="text" name="perfmemo" value="${perfDTO.perfMemo}"></td>
  </tr>
</table>


<div class="footerbtn">
<div class="ftbtn">
<input type="button" class="okbtn" id="okbtn" value="확인">
	<c:if test="${sessionScope.empDepartment eq '생산팀' || sessionScope.empDepartment eq '관리자'}">
<input type="button" class="update2" id="update2" value="수정">
<input type="button" class="deletebtn" id="deletebtn" value="삭제">
</c:if>
</div>
</div>






</form>
<script>
window.onload = function() {
    var defectReasonSelect = document.getElementById("perfDefectreason");
    var defectMemoInput = document.querySelector('input[name="perfDefectreasonmemo"]');
    var workAmountInput = document.getElementById("workAmount");
    var perfFairInput = document.getElementById("perfFair");
    var perfDefectInput = document.getElementById("perfDefect");
    var updateProUrl = "${pageContext.request.contextPath}/perfajax/updatePro";
    var updateButton = document.getElementById("update2");

    $('#deletebtn').click(function() {
        var perfCode = $('#perfCodeDisplay').text();
        // 서버로 perfCode 값을 전송하여 해당 행을 삭제
        $.post("${pageContext.request.contextPath}/perfajax/delete", {
            perfCode: perfCode
        })
        .done(function(response) {
            // 성공 응답을 받은 경우
            Swal.fire({
                title: '삭제 성공',
                text: '성공적으로 삭제되었습니다.',
                icon: 'success'
            }).then(function() {
                location.reload(); // 페이지 새로고침
                window.opener.location.reload(); // 부모 창 새로고침
            });
        })
        .fail(function(response) {
            // 실패 응답을 받은 경우
            Swal.fire({
                title: '삭제 실패',
                text: '삭제에 실패하였습니다.',
                icon: 'error'
            });
        });
    });

 // 서버에서 받아온 불량사유 값을 자바스크립트 변수에 할당한 예시
    var selectedValueFromServer = "${perfDTO.perfDefectreason}"; // 서버에서 받아온 불량사유 값

    // 불량사유 select 요소에 대한 change 이벤트 핸들러
    defectReasonSelect.addEventListener('change', handleChangeEvent);

    // 초기화 시 서버에서 받아온 불량사유 값으로 select 요소를 설정합니다
    defectReasonSelect.value = selectedValueFromServer;

    //change 이벤트 핸들러 함수
    function handleChangeEvent() {
        if (defectReasonSelect.value === "무결함") {
            defectMemoInput.disabled = true;
            defectMemoInput.style.backgroundColor = "#eeeeee"; // 회색 배경색 설정
            defectMemoInput.value = ""; // 불량기타입력칸 내용 초기화
            
            // 불량수 값을 0으로 설정
            perfDefectInput.value = 0;
            
        } else {
            defectMemoInput.disabled = false;
            defectMemoInput.style.backgroundColor = ""; // 기본 배경색으로 설정 (비활성화 해제)
        }
    }
    
    //////////////////////////////////////// 양품수 불량수 입력 제어 
    
    perfFairInput.addEventListener("input", calculateDefect);

    function calculateDefect() {
        var workAmount = parseInt(workAmountInput.value) || 0;
        var perfFair = parseInt(perfFairInput.value) || 0;
        var perfDefect = Math.max(0, workAmount - perfFair); // 음수인 경우 0으로 처리
        
     // 양품수가 지시수량을 초과하는 경우 지시수량으로 설정하고 불량수 계산
        if (perfFair > workAmount) {
            perfFairInput.value = workAmount;
            var perfDefect = 0; // 양품수가 지시수량을 초과하면 불량수는 0
        } else {
            var perfDefect = workAmount - perfFair; // 불량수 계산
        }
        
        
        
     // 불량수 업데이트
        perfDefectInput.value = perfDefect;

        // 불량수가 0 이상이면 불량사유 입력을 활성화하고, 0일 경우 무결함으로 설정하고 불량내역을 비활성화합니다.
        if (perfDefect > 0) {
            defectReasonSelect.disabled = false;
            defectMemoInput.disabled = false;
            defectMemoInput.style.backgroundColor = "";
        } else {
            defectReasonSelect.value = '무결함';
            defectMemoInput.disabled = true;
            defectMemoInput.style.backgroundColor = "#eeeeee";
            defectMemoInput.value = "";
            defectReasonSelect.disabled = true;
        }
        
     // 불량수가 0 이상이면서 1 이상이면 무결함 옵션을 숨깁니다.
        if (perfDefect >= 1) {
            var option = defectReasonSelect.querySelector('option[value="무결함"]');
            if (option) {
                option.style.display = 'none';
            }
        } else {
            // 불량수가 0이면 무결함 옵션을 다시 보이게 합니다.
            var option = defectReasonSelect.querySelector('option[value="무결함"]');
            if (option) {
                option.style.display = 'block';
            }
        }
     
     

        // 에러 메시지를 표시합니다. (양품수와 불량품수의 합이 0 이상, 지시수량 이하이어야 합니다.)
        if (perfFair < 0 || perfFair > workAmount) {
            Swal.fire({
                title: '입력 오류',
                text: '양품수와 불량품수의 합은 0 이상, 지시수량 이하이어야 합니다.',
                icon: 'error'
            });
        }
    }
    
 // 초기화 시 계산을 위해 한 번 호출합니다.
    calculateDefect();

 //////////////////////////////////////////////////
    updateButton.addEventListener("click", function(event) {
        // 폼 데이터를 가져오는 코드 (예: FormData 객체 사용)
        var formData = $("#detailform").serialize();
        console.log(formData);

        // 서버로 데이터를 전송하고 응답을 받는 코드 (jQuery AJAX 사용)
        $.ajax({
            type: "POST", // 또는 "GET" 등 HTTP 요청 메서드 선택
            url: updateProUrl, // 서버 엔드포인트 URL 설정
            data: formData, // 폼 데이터 전송
            success: function(response) {
                console.log("ajax 왔다감");
                // 서버 응답이 성공인 경우
                if (response === 'true') {
                    Swal.fire({
                        title: '수정 성공',
                        text: '성공적으로 수정되었습니다.',
                        icon: 'success'
                    }).then(function() {
                        // 성공 메시지를 표시한 후 추가적인 동작을 수행하려면 이 부분에 코드를 작성합니다.
                        // 예: 페이지 리로드, 다른 동작 수행 등
                    });
                }
            },
            error: function(xhr, status, error) {
                // 서버 응답이 실패인 경우
                Swal.fire({
                    title: '수정 실패',
                    text: '수정에 실패하였습니다.',
                    icon: 'error'
                });
            }
        });
    });
};
</script>

</body>
</html>