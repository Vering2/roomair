<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가</title>

<link href="${pageContext.request.contextPath }/resources/css/warehousewrite.css" rel="stylesheet" type="text/css">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>

	<div class="container">
		<h2>창고 등록</h2>
		<hr>

		<form action="${pageContext.request.contextPath}/Warehouse/writePro " method="post">

			<div class="form-group">
				<p>창고코드</p>
				<input type="text" name="whseCode">
			</div>

			<div class="form-group">
				<p>창고이름</p>
				<input type="text" name="whseName">
			</div>

			<div class="form-group">
				<p>창고 타입</p>
				<select name="whseType">
					<option value="원자재">원자재</option>
					<option value="완제품">완제품</option>
				</select>
			</div>

			<div class="form-group">
				<p>창고 사용 상태</p>
				<select name="whseState">
					<option value="Y">Y</option>
					<option value="N">N</option>
				</select>
			</div>
			<div class="form-group">
				<p>창고 주소</p>
				<input type="text" id="sample4_roadAddress" name="whseAddr" onclick="sample4_execDaumPostcode()">
			</div>
			<div class="form-group">
				<p>창고 연락처</p>
				<input type="text" id="whseTel" name="whseTel" maxlength="13">
			</div>
			<span id="whseTelmsg"> </span>
			<div class="form-group">
				<p>창고 관리사원 아이디</p>
				<input type="text" name="whseEmpId">
			</div>
			<div class="form-group">
				<p>창고 비고</p>
				<input type="text" name="whseMemo">
			</div>
			<div id="button">
				<input type="submit" value="등록"> <input type="button" value="닫기" onclick="closeWindow()">
			</div>
		</form>
	</div>
	<script>
		function sample4_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수(팝업창에서 검색 결과 클릭했을 때의 주소)
							var extraRoadAddr = ''; // 참고 항목 변수( 상세주소)

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}
							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							/* document.getElementById('sample4_postcode').value = data.zonecode; */
							document.getElementById("sample4_roadAddress").value = roadAddr;

							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다. */
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;

							}

							document.getElementById("sample4_roadAddress")
									.focus();

						}
					}).open();
		}
		//닫기버튼 누르면 창 닫힘
		function closeWindow() {
			window.close();
		}

		// 휴대폰 번호 정규식 (숫자만 허용하는 가정)
		var phoneNumberRegex = /^(010|011|016|017|019)-\d{4}-\d{4}$/;

		document
				.getElementById("whseTel")
				.addEventListener(
						"input",
						function() {
							var whseTel = this.value;

							// 입력된 값에서 한글 제거
							whseTel = whseTel.replace(/[ㄱ-ㅎ가-힣]/g, '');

							whseTel = whseTel.replace(/[^\d-]/g, ''); // 숫자와 하이픈 이외의 모든 문자를 제거

							if (whseTel === "") {
								document.getElementById("whseTelmsg").textContent = ""; // 메시지 초기화
							} else if (!phoneNumberRegex.test(whseTel)) {
								document.getElementById("whseTelmsg").textContent = "올바른 휴대폰 번호를 입력하세요.";
							} else {
								document.getElementById("whseTelmsg").textContent = ""; // 메시지 초기화
							}

							this.value = whseTel;

						});
	</script>
</body>

</html>