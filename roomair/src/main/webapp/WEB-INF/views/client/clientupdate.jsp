<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

<form action ="${pageContext.request.contextPath}/client/clientupdatePro" id="updateform" method="POST">
<h1>
			<b>거래처 등록</b>
		</h1>

		<br>
		
		<!-- 거래처 코드 -->
		<label for="clientCode_label"><b>거래처코드</b></label> <input type="text"
			name="clientCode" id="clientCode" value="${clientDTO.clientCode}" readonly> <br> <span
			id="clientCode_msg"></span> <br>

		<!-- 거래처명 -->
		<label for="clientCompany_label"><b>거래처명</b> </label> <input
			type="text" name="clientCompany" id="clientCompany" value="${clientDTO.clientCompany}"> <br>
		<span id="clientCompany_msg"></span> <br>

		<!-- 사업자번호 -->
		<label for="clientNumber_label"><b>사업자번호</b> </label> <input
			type="text" name="clientNumber" id="clientNumber" value="${clientDTO.clientNumber}"> <br>
		<span id="clientNumber_msg"></span> <br>

		<!-- 업태 -->
		<label for="clientDetail_label"><b>업태</b> </label> <input type="text"
			name="clientDetail" id="clientDetail" value="${clientDTO.clientDetail}"> <br> <span
			id="clientDetail_msg"></span> <br>

		<!-- 거래처 대표자명 -->
		<label for="clientCeo_label"><b>대표자</b></label> <input type="text"
			name="clientCeo" id="clientCeo" value="${clientDTO.clientCeo}"> <br> <span
			id="clientCeo_msg"></span> <br>

		<!-- 거래처담당자이름-->
		<label for="clientName_label"><b>거래담당자</b></label> <input type="text"
			name="clientName" id="clientName" value="${clientDTO.clientName}"> <br> <span
			id="clientName_msg"></span> <br>

		<!-- 주소 -->
		<label for="clientAddress_label"><b>도로명주소</b></label> <input
			type="text" id="sample4_roadAddress" placeholder="도로명주소"
			name="clientAddr1" value="${clientDTO.clientAddr1}" readonly required> <input type="button"
			onclick="sample4_execDaumPostcode()" value="우편번호 찾기" required><br>
		<input type="text" id="sample4_extraAddress" placeholder="상세주소"
			name="clientAddr2" size="60" value="${clientDTO.clientAddr2}"required><br>



		<!-- 거래처 번호 -->
		<label for="clientTel"><b>거래처번호</b></label> <input type="text"
			name="clientTel" id="clientTel" value="${clientDTO.clientTel}"> <br> <span
			id="clientTel_msg"></span> <br>

		<!-- 거래담당자 번호 -->
		<label for="clientPhone"><b>담당자번호</b></label> <input type="text"
			name="clientPhone" id="clientPhone" value="${clientDTO.clientPhone}"> <br> <span
			id="clientPhone_msg"></span> <br>

		<!--  팩스번호 -->
		<label for="clientFax"><b>팩스자번호</b></label> <input type="text"
			name="clientFax" id="clientFax" value="${clientDTO.clientFax}"> <br> <span
			id="clientFax_msg"></span> <br>


		<!-- 거래처 이메일 -->
		<label for="clientEmail"><b>이메일</b></label> <input type="text"
			name="clientEmail" id="clientEmail" value="${clientDTO.clientEmail}"> <br> <span
			id="clientEmail_msg"></span> <br> 
			
			<label for="clientMemo_label"><b>비고</b> </label> 
			<input type="text" name="clientMemo" id="clientMemo" value="${clientDTO.clientMemo}"> <br>
		    <span id="clientMemo_msg"></span> <br>

		<!-- 등록 버튼 -->
		<div id="updatebtn">
			<input type="submit" id="btn" value="수정">
		</div>

</form>
<script>
document.getElementById("updateform").addEventListener("submit", function(event) {
    event.preventDefault(); // 폼 제출 방지
    
    // FormData 객체를 사용하여 폼 데이터를 가져옴
    var formData = new FormData(document.getElementById("updateform"));
    
    // Ajax로 서버에 데이터를 전송
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "${pageContext.request.contextPath}/client/clientupdatePro", true);
    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
        		if(xhr.status == 200) {
        	
        	alert("수정이 완료되었습니다.");
            window.close();
            window.opener.location.reload(); // 수정이 완료되면 부모창(호출한 페이지) 새로고침 
        } else {
        	consol.error("서버응답오류:", xhr.status);
        	}
        }
    };
    
     xhr.send(formData);
});

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
</script>
</body>
</html>