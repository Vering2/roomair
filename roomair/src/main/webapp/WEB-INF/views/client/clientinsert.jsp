<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- sweetalert2 API 호출 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<style>
	body{
	background-color: #f5f6fa;
	}
	.clinentinsert{
	      text-align: center;
	}
	
	td{
	font-size:20px;
	}
	
	.clientType{
	width: 65px;
    height: 35px;
    margin-left: 10px;
	
	}
	
	.insertbox{
	width: 150px;
    margin-left: 10px;
    height: 20px;
	}
	.addbox{
	    background-color: whitesmoke;
    border: 1px solid;
    width: 100px;
    margin-left: 5px;
    height: 27px;
    border-radius: 5px;
	}
	
	.longbox{
	width: 270px;
    margin-left: 10px;
    height: 20px;
	
	}
	
	#btn{
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
    margin-right: 15px;
	
	}
	
	#closebtn{
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
    margin-right: 15px;
	
	}
	
	.footbtn{
	display: flex;
    justify-content: center;
    margin-top: 15px;
    
	}
	
	.headh2{
	text-align: center;
	}
	
	span{
	font-size:13px;
	font-weight: bold;
	color:red;
	}
	
	
	</style>
</head>
<body>
<body class="sb-nav-fixed">
<h2 class="headh2">
			거래처 등록
		</h2>
	<!-- 내용들어가는곳 -->
	<form action="${pageContext.request.contextPath}/client/insertPro"
		id="clientInsert" name="clientInsert" method="POST" enctype="multipart/form-data" >
      <table id="clientinsert">
		<!-- 거래처구분 -->
		<tr><td><label for="clientType_label"><b>구분</b> </label></td>
		<td><select id="clientType" name="clientType" class="clientType">
		    <option value="선택">선택</option>
			<option value="수주처">수주처</option>
			<option value="발주처">발주처</option>
		</select> <br> <span id="clientType_msg"></span>  </td></tr> 
	
		<!-- 거래처 코드 -->
		<tr><td> <label for="clientCode_label"><b>거래처코드</b></label>  </td>
		<td> <input type="text" name="clientCode" id="clientCode" readonly class="insertbox" required> 
		<span id="clientCode_msg"></span> </td> </tr>
	
			
			<!-- 거래처명 -->
			<tr><td> <label for="clientCompany_label"><b>거래처명</b> </label></td>
			<td><input type="text" name="clientCompany" id="clientCompany" class="insertbox"  required> 
	       	<span id="clientCompany_msg"></span></td></tr>
	

		<!-- 사업자번호 -->
		<tr><td> <label for="clientNumber_label"><b>사업자번호</b> </label> </td>
		 <td> <input type="text" name="clientNumber" id="clientNumber" class="insertbox" maxlength=12 required> 
		 <span id="clientNumber_msg"></span></td></tr> 
	

		<!-- 업태 -->
		<tr><td><label for="clientDetail_label"><b>업태</b> </label></td>
		<td> <input type="text" name="clientDetail" id="clientDetail" class="insertbox" maxlength="10" required >  <span id="clientDetail_msg"></span> </td></tr>
		 


		<!-- 거래처 대표자명 -->
		<tr><td> <label for="clientCeo_label"><b>대표자</b></label></td>
		 <td> <input type="text" name="clientCeo" id="clientCeo" class="insertbox"  maxlength="10" required> <span id="clientCeo_msg"></span></td></tr>
	

		<!-- 거래처담당자이름-->
		<tr><td> <label for="clientName_label"><b>거래담당자</b></label> </td>
		<td><input type="text" name="clientName" id="clientName" class="insertbox"  maxlength="10" required>  <span id="clientName_msg"></span> </td></tr>


		<!-- 주소 -->
		<tr><td><label for="clientAddress_label"><b>도로명주소</b></label></td>
		<td> <input type="text" id="sample4_roadAddress" placeholder="도로명주소"
			name="clientAddr1" readonly required class="insertbox" onclick="sample4_execDaumPostcode()" required></td></tr>
			<br>
		<tr><td><label for="clientAddress_label"><b>상세주소</b></label></td>
		<td> <input type="text" id="sample4_extraAddress" placeholder="상세주소" name="clientAddr2" size="60" required class="longbox" required>
	<span id="clientName_msg"></span>
		</td></tr>
		
	

		<!-- 거래처 번호 -->
		<tr><td><label for="clientTel"><b>거래처번호</b></label></td>
		<td> <input type="text" name="clientTel" id="clientTel" class="insertbox" maxlength="12" required > <span id="clientTel_msg"></span> </td></tr>
	

		<!-- 거래담당자 번호 -->
		<tr><td> <label for="clientPhone"><b>담당자번호</b></label></td>
		 <td> <input type="text" name="clientPhone" id="clientPhone" class="insertbox" maxlength="13" required> <span id="clientPhone_msg"></span>   </td></tr>
		  

		<!--  팩스번호 -->
		<tr><td> <label for="clientFax"><b>팩스번호</b></label> </td>
		<td><input type="text" name="clientFax" id="clientFax" class="insertbox"  maxlength="12"  required> <span id="clientFax_msg"></span>


		<!-- 거래처 이메일 -->
		<tr><td><label for="clientEmail"><b>이메일</b></label> </td>
		<td> <input type="text" name="clientEmail" id="clientEmail" class="insertbox" required>  <span id="clientEmail_msg"></span> </td></tr>
		
		<!--  비고 -->
		<tr><td><label for="clientMemo_label"><b>비고</b></label>  </td>
		<td> <input type="text" name="clientMemo" id="clientMemo" class="insertbox" > <span id="clientMemo_msg"></span>

		
     </table>
     <!-- 등록 버튼 -->
		<div class="footbtn">
			<input type="submit" id="btn" value="등록" class="subbtn">
			<button type="button" id="closebtn"> 닫기 </button>
		</div>
	</form>


	<script>
$(document).ready(function() {

//전역변수 선언
//var selectedDept = '';
// var currentDate = new Date();

 $('#clientType').on('change', function() {
        var selectedType = $(this).val(); // 현재 선택된 값 가져오기
        console.log("Selected Type: " + selectedType);
        generateClientCode(selectedType); // generateClientCode 함수 호출
    });
 
 function generateClientCode(selectedType) {
    $.ajax({
        url: "${pageContext.request.contextPath}/client/getclientCode", // 서버 측 스크립트 경로
        method: "GET",
        dataType: "text",
        data: { clientType : selectedType },
        success: function(data) {
        	console.log("반환된 거래처코드: " + data);
        	var typeCode = data.substring(0, 2);
            var num = parseInt(data.substring(2));
            // 번호에 1을 더하고 세 자리로 패딩
            var paddedNum = (num + 1).toString().padStart(3, '0');
            // 타입 식별자와 번호 합치기
            var clientCode = typeCode + paddedNum;

            document.getElementById("clientCode").value = clientCode;
        },
        error: function(xhr, status, error) {
            console.error("Ajax 요청 에러:", error);
        }
    });
} 


     

  	//서브밋 제어
    $('#clientInsert').submit(function(event) {
    	
        	if($('#clientType').val() == ""){
    		$('#clientType_msg').css('color','red');
    		$('#clientType_msg').html("거래처구분을 선택하십시오."); 
    		$('#clientType').focus();
    		return false;
    	}
    	
    	if($('#clientCode').val() == ""){
    		$('#clientCode').css('color','red');
    		$('#clientCode_msg').html("거래처코드를 입력하세요.");
    		$('#clientCode').focus();
    		return false;
    	}
    	
    	if($('#clientCompany').val() == ""){
    		$('#clientCompany_msg').css('color','red');
    		$('#clientCompany_msg').html("거래처명을 입력하세요.");  
    		$('#clientCompany').focus();
    		return false;
    	}
    	
    	if($('#clientNumber').val() == ""){
    		$('#clientNumber_msg').css('color','red');
    		$('#clientNumber_msg').html("사업자번호를 입력하십시오.");
    		$('#clientNumber').focus();
    		return false;
    	}
    	
    	if($('#clientDetail').val() == ""){
    		$('#clientDetail_msg').css('color','red');
    		$('#clientDetail_msg').html("업태를 입력하세요.");
    		$('#clientDetail').focus();
    		return false;
    	}
    	
    	if($('#clientCeo').val() == ""){
    		$('#clientCeo_msg').css('color','red');
    		$('#clientCeo_msg').html("대표자명을 입력하세요.");
    		$('#clientCeo').focus();
    		return false;
    	}
    	
    	if($('#clientName').val() == ""){
    		$('#clientName_msg').css('color','red');
    		$('#clientName_msg').html("전화번호를 입력하세요.");
    		$('#clientName').focus();
    		return false;
    	}
    	
    	
    	if($('#clientTel').val() == ""){
    		$('#clientTel_msg').css('color','red');
    		$('#clientTel_msg').html("거래처 전화번호를 입력하세요."); 
    		$('#clientTel').focus();
    		return false;
    	}
    	
    	if($('#clientPhone').val() == ""){
    		$('#clientPhone_msg').css('color','red');
    		$('#clientPhone_msg').html("거래처 담당 직원 번호를 입력하세요."); 
    		$('#clientPhone').focus();
    		return false;
    	}
    	
    	if($('#clientFax').val() == ""){
    		$('#clientFax_msg').css('color','red');
    		$('#clientFax_msg').html("거래처 팩스번호를 입력하세요."); 
    		$('#clientFax').focus();
    		return false;
    	}
    	
    	
    	if($('#clientEmail').val() == ""){
    		$('#clientEmail_msg').css('color','red');
    		$('#clientEmail_msg').html("거래처 이메일을 입력하세요.");
    		return false;
    	}
    	
    	  // 다입력되었다면 AJAX 폼태그 데이터 제출시작
    //	 event.preventDefault(); // 기본 폼 제출 동작을 막음  
    		
    	 // 폼 데이터 객체생성
    	  var formData = new FormData(this);
         
         $.ajax({
             type: "POST",
             url: "${pageContext.request.contextPath}/client_ajax/insertPro",
             data: formData,
             contentType: false, // 멀티파트를 처리하기위해 객체를 직렬화하지 않고 직접 AJAX 통신할 수 있도록 설정하기 위해 form 타입을 멀티파트폼 설정
             processData: false, 
             success: function (response) {
            	 
            	 const result = $.trim(response);
            	 
                 if (result === "true") {
                	 Swal.fire('거래처가 추가 되었습니다.', '성공', 'success').then(result => {
					 	if(result.isConfirmed)
						// 완료 창을 닫으면 부모창 새로고침
						window.opener.location.reload();
						window.close(); // 성공 시 창 닫기
					 });
                 } else {
                	 Swal.fire('거래처 추가를 실패했습니다.', '실패', 'error');
                 }
             },
             error: function () {
            	 Swal.fire('서버통신에 문제가 발생했습니다.', '실패', 'error');
             }
         });
         
         event.preventDefault(); // 기본 폼 제출 동작을 막음 
    	
    
    });//submit기능 제어 끝
    
    
    
    
    
    
}); //$(document).ready(function() 끝
		
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


</script>

	<script>

	// 도로명주소 받아오는 api
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수(팝업창에서 검색 결과 클릭했을 때의 주소)
            var extraRoadAddr = ''; // 참고 항목 변수( 상세주소)

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }                
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            /* document.getElementById('sample4_postcode').value = data.zonecode; */
            document.getElementById("sample4_roadAddress").value = roadAddr;
            /* document.getElementById("sample4_jibunAddress").value = data.jibunAddress; */
     
           /*  document.getElementById("sample4_engAddress").value = data.addressEnglish; */
           
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                
            } else {
                document.getElementById("clientAddr2").value = '';
            }

         /*    var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다. */
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
              /*   guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block'; */

            } /* else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            }  */ /* else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            } */  // 나머진 안쓸거기 때문에 필요없음.
            
            document.getElementById("sample4_extraAddress").focus(); 
          
        }
    }).open();
    
    // 다시 여기서부터 시작 
    
}
	
//"닫기" 버튼 클릭 이벤트 처리
document.getElementById("closebtn").addEventListener("click", function() {
	console.log("닫기");
    // 창을 닫는 동작을 수행할 수 있습니다.
    window.close();
});

</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
</body>
</html>