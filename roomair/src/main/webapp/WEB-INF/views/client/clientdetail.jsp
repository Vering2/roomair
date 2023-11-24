<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert2 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>

body{
background-color: #F5F6FA;

}

#clientDetail2{
display: flex;
    align-items: center;
    text-align: center;
    justify-content: center;
}

.headh{
text-align: center;
}

td {
margin-left : 50px;
margin-right : 15px;
font-size : 18px;
    text-align: center;
    font-weight: bold;

}


.upform{

height : 20px;
width: 200px;
}
.addres{
    background-color: white;
    width: 100px;
    height: 25px;
    border-radius: 5px;
    text-align: center;
    border: 1px solid black;
    margin-top: 5px;
}

.btngroup{
    align-items: center;
    justify-content: center;
    display: flex;
    margin-top: 15px;

}

.footbtn{
color: white;
    background-color: #9AC5F4;
    width: 70px;
    height: 30px;
    border-radius: 3px;
    border: 0;
    text-align: center;
    font: 500 15px/20px "Inter", sans-serif;
    font-weight: bold;
    cursor: pointer;
      margin-right: 10px;

}
.deletebtn{
color: white;
    background-color: #9AC5F4;
    width: 70px;
    height: 30px;
    border-radius: 3px;
    border: 0;
    text-align: center;
    font: 500 15px/20px "Inter", sans-serif;
    font-weight: bold;
    cursor: pointer;
  
}

span {

font-size : 14px;
font-weight: bold;
color : red;
}

</style>
</head>
<body>

<h2 class="headh">거래처 정보</h2>
<form id="clientsub">
<table id="clientDetail2">
<tr><td>구분</td><td><input type="text" id="clientType"  name="clientType" class="upform" value="${clientDTO.clientType}"></td></tr>
<tr><td>거래처코드</td><td><input type="text" id="clientCode" name="clientCode" value="${clientDTO.clientCode}" class="upform"></td></tr>
<tr><td>거래처명</td><td><input type="text" id="clientCompany" name="clientCompany" value="${clientDTO.clientCompany}" class="upform"><br><span id="clientCompany_msg"></span></td></tr>
<tr><td>사업자번호</td><td><input type="text" id="clientNumber" name="clientNumber" value="${clientDTO.clientNumber}" class="upform" maxlength="12"><br><span id="clientNumber_msg"></span></td></tr>
<tr><td>업태</td><td><input type="text"  id="clientDetail" name="clientDetail" value="${clientDTO.clientDetail}" class="upform" maxlength="10"><br><span id="clientDetail_msg"></span></td></tr>
<tr><td>대표자</td><td><input type="text" id ="clientCeo" name="clientCeo" value="${clientDTO.clientCeo}" class="upform"><br><span id="clientCeo_msg"></span></td></tr>
<tr><td>담당자</td><td><input type="text" id ="clientName" name="clientName" value="${clientDTO.clientName}" class="upform" ><br><span id="clientName_msg"></span></td></tr>  
<tr><td>거래처주소</td><td><input  type="text" id="sample4_roadAddress" placeholder="도로명주소"
			name="clientAddr1" value="${clientDTO.clientAddr1}" class="upform" readonly required onclick="sample4_execDaumPostcode()"   >  
	
			
			
          </td></tr>  
<tr><td>상세주소</td><td><input type="text" id="sample4_extraAddress" placeholder="상세주소"
			name="clientAddr2" size="60" value="${clientDTO.clientAddr2}" class="upform" required></td></tr>  
<tr><td>거래처번호</td><td><input type="text" id="clientTel" name="clientTel" value="${clientDTO.clientTel}" class="upform" maxlength="12"><br><span id="clientTel_msg"></span></td></tr>  
<tr><td>휴대폰번호</td><td><input type="tel" id="clientPhone" name="clientPhone" value="${clientDTO.clientPhone}" class="upform" maxlength="13"><br><span id="clientPhone_msg"></span></td></tr>  
<tr><td>팩스번호</td><td><input type="tel" id="clientFax" name="clientFax" value="${clientDTO.clientFax}" class="upform" maxlength="12"><br><span id="clientFax_msg"></span></td></tr>  
<tr><td>이메일</td><td><input type="email" id ="clientEmail" name="clientEmail" value="${clientDTO.clientEmail}" class="upform"><br><span id="clientEmail_msg"></span></td></tr>  
<tr><td>비고</td><td><input type="text"  id="clientMemo "name="clientMemo" value="${clientDTO.clientMemo}" class="upform"><br><span id="clientMemo_msg"></span></td></tr>  
<c:if test="${clientDTO.clientType eq '수주처'}">
    <tr>
        <td>매출액</td>
        <td>
            <c:choose>
                <c:when test="${clientDTO.clientSale eq 0}">
                    0
                </c:when>
                <c:otherwise>
                    ${clientDTO.clientSale}
                </c:otherwise>
            </c:choose>
        </td>
    </tr>  
</c:if>
</table>

<div class="btngroup">
<button type="button" value="닫기" id="closebtn" class="footbtn">닫기</button>
        <button type="button" value="수정" class="footbtn" id="updatesubmit"> 수정</button>
 <button type="button" class="deletebtn" onclick="clientdelete('${clientDTO.clientCompany}')">삭제</button>
</div>

</form>

			



<script>
function clientdelete(clientCompany) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        // 확인을 선택한 경우 삭제 요청을 보냅니다.
        $.ajax({
            url: '${pageContext.request.contextPath}/client/delete',
            type: 'GET',
            data: { clientCompany: clientCompany },
            success: function(response) {
                // 삭제 성공 시 SweetAlert2로 메시지 표시
                Swal.fire({
                    icon: 'success',
                    title: '삭제되었습니다!',
                    confirmButtonText: '확인'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 부모 창 새로고침
                        window.opener.location.reload();

                        // 현재 창 닫기
                        window.close();
                    }
                });
            },
            error: function(error) {
                // 삭제 실패 시 SweetAlert2로 오류 메시지 표시
                Swal.fire({
                    icon: 'error',
                    title: '삭제 실패!',
                    text: '서버와 통신 중 문제가 발생했습니다.',
                    confirmButtonText: '확인'
                });
            }
        });
    }
}

function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById("sample4_roadAddress").value = roadAddr;
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("clientAddr2").value = '';
            }
        }
    }).open();
}

$(document).ready(function() {
    $('#updatesubmit').click(function(event) {
        // 폼 데이터 수집
        var formData = new FormData($('#clientsub')[0]);

        // AJAX 요청 보내기
        $.ajax({
            url: '${pageContext.request.contextPath}/client_ajax/clientupdatePro',
            type: 'POST',
            data: formData,
            processData: false, // 데이터를 query string으로 변환하지 않음
            contentType: false, // Content-Type 헤더를 설정하지 않음
            success: function(response) {
                // 성공적으로 응답을 받았을 때 실행할 코드 작성
                console.log('서버 응답:', response);

                // SweetAlert2로 성공 메시지 표시
                Swal.fire({
                    icon: 'success',
                    title: '수정되었습니다!',
                    confirmButtonText: '확인'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 부모 창 다시 로드
                        window.opener.location.reload();

                        // 현재 창 닫기
                        window.close();
                    }
                });
            },
            error: function(error) {
                // 요청이 실패했을 때 실행할 코드 작성
                console.error('오류 발생:', error);

                // SweetAlert2로 오류 메시지 표시
                Swal.fire({
                    icon: 'error',
                    title: '오류 발생!',
                    text: '서버와 통신 중 문제가 발생했습니다.',
                    confirmButtonText: '확인'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 부모 창 다시 로드
                        window.opener.location.reload();

                        // 현재 창 닫기
                        window.close();
                    }
                });
            }
        });
    });
});

var koreanRegex = /^[가-힣]+$/; // 한글만 허용하는 정규식

var koreanEnglishRegex = /^[가-힣a-zA-Z]*$/;

// 이메일 정규식
var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

//지역번호 정규식
var localAreaCodes = /^(02|0[3-7]{1}[1-9]{1}|\d{3})$/;

// 휴대폰 번호 정규식 (숫자만 허용하는 가정)
    var phoneNumberRegex = /^(010|011|016|017|019)-\d{4}-\d{4}$/;

var businessNumberRegex = /^[\d-]+$/;

var clientNumberInput = document.getElementById("clientNumber");

clientNumberInput.addEventListener("input", function() {
    var clientNumber = this.value;
    // 숫자와 하이픈 이외의 문자 제거
    clientNumber = clientNumber.replace(/[^\d-]/g, '');

    // 하이픈 추가
    clientNumber = clientNumber.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');

    this.value = clientNumber;
});

document.getElementById("clientDetail").addEventListener("input", function(event) {
    var clientDetail = this.value;
    
    if (!koreanRegex.test(clientDetail)) {
        document.getElementById("clientDetail_msg").textContent = "한글만 입력하세요.";
        this.value = clientDetail.slice(0, -1); // 마지막 입력을 제거하여 올바른 입력 상태로 복원
        event.preventDefault(); // 입력 막기
    } else {
        document.getElementById("clientDetail_msg").textContent = "";
    }
});

document.getElementById("clientCeo").addEventListener("input", function(event) {
    var clientCeo = this.value;
    
    if (!koreanEnglishRegex.test(clientCeo)) {
        document.getElementById("clientCeo_msg").textContent = "한글 또는 영어만 입력하세요.";
        this.value = clientCeo.slice(0, -1); // 마지막 입력을 제거하여 올바른 입력 상태로 복원
        event.preventDefault(); // 입력 막기
    } else {
        document.getElementById("clientCeo_msg").textContent = "";
    }
});

document.getElementById("clientName").addEventListener("input", function(event) {
    var clientName = this.value;
    
    if (!koreanEnglishRegex.test(clientName)) {
        document.getElementById("clientName_msg").textContent = "한글 또는 영어만 입력하세요.";
        this.value = clientName.slice(0, -1); // 마지막 입력을 제거하여 올바른 입력 상태로 복원
        event.preventDefault(); // 입력 막기
    } else {
        document.getElementById("clientName_msg").textContent = "";
    }
});



document.getElementById("clientTel").addEventListener("input", function() {
    var clientTel = this.value;
    // 숫자만 남기기
    clientTel = clientTel.replace(/[^\d]/g, '');

    if (clientTel === "") {
        document.getElementById("clientTel_msg").textContent = ""; // 메시지 초기화
    } else if (!localAreaCodes.test(clientTel.substring(0, 3))) {
        document.getElementById("clientTel_msg").textContent = "올바른 지역번호를 입력하세요.";
    } else if (!/^(\d{2,3})(\d{3,4})(\d{4})$/.test(clientTel)) {
        document.getElementById("clientTel_msg").textContent = "올바른 거래처 번호를 입력하세요.";
    } else {
        document.getElementById("clientTel_msg").textContent = ""; // 메시지 초기화
    }
    
    // 하이픈 추가
    clientTel = clientTel.replace(/(\d{2,3})(\d{3,4})(\d{4})/, '$1-$2-$3');

    this.value = clientTel;
});
document.getElementById("clientPhone").addEventListener("input", function() {
    var clientPhone = this.value;

    // 숫자와 하이픈 이외의 문자 제거
    clientPhone = clientPhone.replace(/[^\d-]/g, '');

    // 하이픈이 연속으로 나오는 경우 하나로 변경
    clientPhone = clientPhone.replace(/-{2,}/g, '-');

    // 하이픈이 끝이나서 시작하는 경우 제거
    clientPhone = clientPhone.replace(/^-|-$/g, '');

    // 숫자가 3자리 이상이면서 11자리 이하일 때 하이픈 추가
    if (clientPhone.length >= 3 && clientPhone.length <= 11) {
    	   clientPhone = clientPhone.replace(/^(\d{3})(\d{4})(\d{4})$/, '$1-$2-$3');
    }

    this.value = clientPhone;

    if (!phoneNumberRegex.test(clientPhone)) {
        document.getElementById("clientPhone_msg").textContent = "올바른 담당자번호를 입력하세요.";
    } else {
        document.getElementById("clientPhone_msg").textContent = "";
    }
});


document.getElementById("clientFax").addEventListener("input", function() {
    var clientFax = this.value;
    // 숫자만 남기기
    clientFax = clientFax.replace(/[^\d]/g, '');

    if (clientFax === "") {
        document.getElementById("clientFax_msg").textContent = ""; // 메시지 초기화
    } else if (!localAreaCodes.test(clientFax.substring(0, 3))) {
        document.getElementById("clientFax_msg").textContent = "올바른 지역번호를 입력하세요.";
    } else if (!/^(\d{2,3})(\d{3,4})(\d{4})$/.test(clientFax)) {
        document.getElementById("clientFax_msg").textContent = "올바른 거래처 번호를 입력하세요.";
    } else {
        document.getElementById("clientFax_msg").textContent = ""; // 메시지 초기화
    }
    
    // 하이픈 추가
    clientFax = clientFax.replace(/(\d{2,3})(\d{3,4})(\d{4})/, '$1-$2-$3');

    this.value = clientFax;
});




var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

document.getElementById("clientEmail").addEventListener("input", function() {
    var clientEmail = this.value;
    
    if (!emailRegex.test(clientEmail)) {
        document.getElementById("clientEmail_msg").textContent = "올바른 이메일 주소를 입력하세요.";
    } else {
        document.getElementById("clientEmail_msg").textContent = "";
    }
});

var closeButton = document.getElementById("closebtn");

closeButton.addEventListener("click", function() {
    window.close(); // 현재 창을 닫음
});




</script>



</body>
</html>
