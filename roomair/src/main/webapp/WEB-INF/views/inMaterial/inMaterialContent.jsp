<%@page import="com.itwillbs.domain.InMaterialDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/outProductContent.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- SweetAlert  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<%
// 관리자 또는 자재팀 출고 상세 페이지 열람 가능 게시판 접근 가능
String department = "";
if (session.getAttribute("empDepartment") != null) {
	department = (String) session.getAttribute("empDepartment");
}

// 상수 정의
final String ADMIN_DEPARTMENT = "자재팀";
%>

<title>입고 상세 페이지</title>
</head>
<body>
	<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">

		<%
		InMaterialDTO inMaterialDTO;
		%>
		<h2>입고 상세정보</h2>
		<form action="${pageContext.request.contextPath}/inMaterial/inMaterialUpdate" id="updateForm" method="POST">
			<table>
				<tbody>
					<tr>
						<td class="tableHead">입고 코드</td>
						<td><input type="text" name="inNum" value="${inMaterialDTO.inNum }" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="tableHead">발주 코드</td>
						<td><input type="text" name="buyNum" value="${inMaterialDTO.buyNum}" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="tableHead">거래처 코드</td>
						<td><input type="text" name="clientCode" value="${inMaterialDTO.clientCode }" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="tableHead">거래처명</td>
						<td><input type="text" name="clientCompany" value="${inMaterialDTO.clientCompany }" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="tableHead">원자재 코드</td>
						<td><input type="text" name="rawCode" value="${inMaterialDTO.rawCode }" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="tableHead">원자재명</td>
						<td><input type="text" name="rawName" value="${inMaterialDTO.rawName }" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="tableHead">담당자</td>
						<c:if test="${inMaterialDTO.inEmpId == null}">
							<td><input type="hidden" name="inEmpId" value="${sessionScope.empId}" id="inEmpId" readonly="readonly"> <input type="text" name="inEmpId_1" value="${sessionScope.empId}" id="inEmpId_1" readonly="readonly" style="cursor: pointer;"></td>
						</c:if>
						<c:if test="${inMaterialDTO.inEmpId != null  }">
							<td><input type="hidden" name="inEmpId" value="${sessionScope.empId}" id="inEmpId" readonly="readonly"> <input type="text" name="inEmpId_2" value="${inMaterialDTO.inEmpId}" id="inEmpId_1" readonly="readonly" style="cursor: pointer;"></td>
						</c:if>
					</tr>
					<tr>
						<td class="tableHead">입고 상태</td>
						<td><input type="text" name="inState" value="${inMaterialDTO.inState }" readonly="readonly"></td>
					</tr>
					<tr>
						<fmt:formatNumber var="inPrice" value="${inMaterialDTO.inPrice }" pattern="###,###"></fmt:formatNumber>
						<td class="tableHead">총 입고가</td>
						<td><input type="hidden" name="inPrice" value="${inMaterialDTO.inPrice }"> <input type="text" name="inPriceFormat" value="${inPrice }원" readonly="readonly"></td>
					</tr>
				</tbody>
			</table>
			<br>
			<table class="outProductTable">
				<tr>
					<!-- 				<td class="tableHead" colspan="2">납품 예정일</td> -->
					<td class="tableHead" colspan="3">입고일</td>
					<td class="tableHead" colspan="3">재입고일</td>
					<!-- 				<td class="tableHead" colspan="2">입고 부족</td> -->
				</tr>
				<tr>
					<%-- 				<td colspan="2"><input type="text" name="sellDuedate" value="${inMaterialDTO.sellDuedate }" readonly="readonly"></td> --%>
					<td colspan="3"><input type="text" name="inDate" value="${inMaterialDTO.inDate }" readonly></td>
					<td colspan="3"><input type="text" name="inRedate" value="${inMaterialDTO.inRedate }" readonly></td>
					<%-- 				<td colspan="2"><input type="number" name="remainder" value="${inMaterialDTO.remainder }" readonly onchange="updateRemainder()"></td> --%>
				</tr>
				<tr>
					<td class="tableHead" colspan="3">총발주 개수</td>
					<td class="tableHead" colspan="3">남은 발주 개수</td>
				</tr>
				<tr>
					<td colspan="3"><input type="number" name="buyCount" value="${inMaterialDTO.buyCount }" readonly="readonly"></td>
					<td colspan="3"><input type="number" name="remainder" id="remainder" value="${inMaterialDTO.buyCount - inMaterialDTO.inCount}" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead" colspan="3">입고 개수</td>
					<td class="tableHead" colspan="3">재고 개수</td>
				</tr>
				<tr>
					<td colspan="3"><input type="hidden" id="initialInCount" value="${inMaterialDTO.inCount}"> <input type="number" name="inCount" value="${inMaterialDTO.inCount }" id="inputNum" autofocus="autofocus" min="${inMaterialDTO.inCount }" onchange="updateInventory()"></td>
					<td colspan="3"><input type="hidden" id="initialstockCount" value="${inMaterialDTO.stockCount}"> <input type="number" name="stockCount" value="${inMaterialDTO.stockCount }" min="0" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead" colspan="3">원자재 단가</td>
					<td class="tableHead" colspan="3">현재 입고가</td>
				</tr>
				<tr>
					<td colspan="3"><fmt:formatNumber var="rawPrice" value="${inMaterialDTO.rawPrice }" pattern="###,###.##"></fmt:formatNumber> <input type="hidden" name="rawPrice" value="${inMaterialDTO.rawPrice }"> <input type="text" name="rawPriceFormat" value="${rawPrice }원" readonly="readonly"></td>
					<td colspan="3">
						<%-- 				<fmt:formatNumber var="inPrice" value="${inMaterialDTO.inPrice }" pattern="###,###"></fmt:formatNumber> --%> <%-- 					<input type="hidden" name="inPrice" value="${inMaterialDTO.inPrice }"> --%> <%-- 					<input type="text" name="inPriceFormat" value="${inPrice }원" readonly="readonly" onchange="updateInventory2()"> --%> <input type="text" name="currentInPrice" value="" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="tableHead" colspan="6">비고</td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" name="inMemo" value="${inMaterialDTO.inMemo }" id="inputMemo" placeholder="비고 입력"></td>
				</tr>
			</table>


			<div id="buttons">
				<%-- 		<c:if test="${inMaterialDTO.inState != '입고완료' && inMaterialDTO.stockCount != 0 }"> --%>
				<!-- buyState가 필요한가? -->

				<c:if test="${inMaterialDTO.inState != '입고완료'}">
					<input type="button" id="updateButton" value="입고">
				</c:if>
				<input type="button" id="closeButton" value="닫기" onclick="window.close()">
			</div>
		</form>
	</c:if>

	<!-- 모달 대화상자 -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<span class="close" id="closeModal">&times;</span>
			</div>
			<div class="modal-body">
				<p>모달 내용을 여기에 넣으세요</p>
			</div>
		</div>
	</div>

	<script>
		  // 모달과 닫기 버튼 가져오기
		  var modal = document.getElementById('myModal');
		  var closeModal = document.getElementById('closeModal');
		
		  // 입력 요소 가져오기
		  var inputElement = document.getElementById('inEmpId_1');
		  var modalContent = document.querySelector('.modal-content');
		
		  inputElement.addEventListener('click', function(e) {
			  $.ajax({
			    type: "POST",
			    url: "${pageContext.request.contextPath}/outProduct/outProductEmpInfo",
			    data: { empId: $('#inEmpId_1').val() },
			    success: function(data) {
					
			      var empId = data.empId;
			      var empName = data.empName;
			      var empDepartment = data.empDepartment;
				  var empPosition = data.empPosition;
			      // 모달 내부에 데이터를 표시
			      var modalContent = document.querySelector('.modal-body');
			      modalContent.innerHTML = "직원 ID: " + empId + "<br>직원 이름: " + empName + "<br>부서: " + empDepartment+ "<br>직책: " + empPosition;

			      // 모달의 위치를 조정
			      var rect = inputElement.getBoundingClientRect();
			      var modalX = rect.left;
			      var modalY = rect.top + rect.height;
			      modal.style.left = modalX + 'px';
			      modal.style.top = modalY + 'px';

			      modal.style.display = 'block';
			    },
			    error: function(xhr, status, error) {
			      // 에러 처리
			      console.log("에러: " + error);
			    }
			  });
			});
		
		  // 닫기 버튼을 클릭하면 모달을 숨김
		  closeModal.addEventListener('click', function() {
		    modal.style.display = 'none';
		  });
		
		  // 모달 외부를 클릭하면 모달을 숨김
		  window.addEventListener('click', function(event) {
		    if (event.target != modal) {
		      modal.style.display = 'none';
		    }
		  });
</script>
	<script type="text/javascript">
		var department = "<%=department%>";
		var ADMIN_DEPARTMENT = "<%=ADMIN_DEPARTMENT%>";
		console.log("직책 : "+department);
		if (department !== ADMIN_DEPARTMENT && department !== "관리자") {
		    // 세션 값이 허용되지 않는 경우 리다이렉트
		    window.opener.location.href = "<%=request.getContextPath()%>
		/main/calendar";
			window.close();
		}
	</script>

	<script type="text/javascript">
		// 		재고개수
		function updateInventory() {
			// 입고 개수와 재고 개수 입력란의 DOM 요소를 가져옵니다
			var inCountInput = document.querySelector('input[name="inCount"]');
			var stockCountInput = document
					.querySelector('input[name="stockCount"]');
			var remainder = document.querySelector('input[name="remainder"]');
			var buyCount = document.querySelector('input[name="buyCount"]');
			//입고단가 원자재단가
			var rawPrice = $
			{
				inMaterialDTO.rawPrice
			}
			;
			//현재 입고가
			var currentInPrice = document
					.querySelector('input[name="currentInPrice"]');

			// 현재 출력해야되는 재고값 계산
			var initialstockCount = parseInt(document
					.getElementById('initialstockCount').value, 10); //초기 재고값
			var initialInCount = parseInt(document
					.getElementById('initialInCount').value, 10); // 초기 입고값
			var inCount = parseInt(inCountInput.value, 10); // 현재값

			// 재고 입력란 업데이트
			stockCountInput.value = initialstockCount - initialInCount
					+ inCount;
			currentInPrice.value = formatCurrency(inCount * rawPrice) + '원';
			remainder.value = buyCount.value - inCount;
		}

		//숫자를 ###,### 원 형식으로 포맷하는 함수
		function formatCurrency(number) {
			return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		$(document)
				.ready(
						function() {

							updateInventory();

							// JavaScript로 max 속성을 설정
							var inCountInput = document
									.getElementById('inputNum');
							var stockCount = $
							{
								inMaterialDTO.stockCount
							}
							; // stockCount 값을 JSP 표현식으로 가져옴
							var buyCount = $
							{
								inMaterialDTO.buyCount
							}
							; // sellCount 값을 JSP 표현식으로 가져옴
							var inCount = $
							{
								inMaterialDTO.inCount
							}
							;

							var maxCount = buyCount;
							inCountInput.setAttribute('max', maxCount);

							document
									.getElementById("inputNum")
									.addEventListener(
											"keyup",
											function(event) {
												if (event.key === "Enter") {
													event.preventDefault();

													// 입력된 입고 개수 가져오기
													var inputCount = parseInt(inCountInput.value);

													// 만약 입력된 값이 max 값보다 크면 max 값으로 설정
													if (inputCount > maxCount) {
														inCountInput.value = maxCount;
													}

													// 여기에서 원하는 동작을 수행하세요.
													updateInventory();
												}
											});

							// "입고" 버튼 클릭 시 Ajax 요청을 보냅니다.
							$("#updateButton")
									.click(
											function() {
												// 폼 데이터를 수집
												var formData = $("#updateForm")
														.serialize();

												console.log("입력 받은 값 "
														+ inCountInput.value);
												console.log("서버에서 받아온 값 "
														+ inCount);
												if (inCount < inCountInput.value) {
													$
															.ajax({
																type : "POST",
																url : "${pageContext.request.contextPath}/inMaterial/inMaterialUpdate",
																data : formData,
																success : function(
																		response) {
																	console
																			.log(response);
																	if (response === 'success') {
																		Swal
																				.fire({
																					text : '입고 완료',
																					icon : 'success',
																					confirmButtonText : '확인',
																					onClose : reloadParentAndCurrentPage
																				// 확인 버튼을 누르면 새로고침 함수 호출
																				});
																	} else if (response === 'error1') {
																		Swal
																				.fire({
																					text : '입고 개수의 입력값이 잘못되었습니다.',
																					icon : 'warning',
																					confirmButtonText : '확인',
																					onClose : reloadParentAndCurrentPage
																				// 확인 버튼을 누르면 새로고침 함수 호출
																				});
																	}
																	// 					
																},
																error : function(
																		xhr,
																		status,
																		error) {
																	// 에러 처리
																	console
																			.log("에러: "
																					+ error);
																}
															});
												} else {
													console.log("이거 뭐지");
													Swal
															.fire({
																text : '입고 개수의 입력값이 잘못되었습니다.',
																icon : 'warning',
																confirmButtonText : '확인',
																onClose : reloadParentAndCurrentPage
															});
												}
											});//$("#updateButton").click(function() 
							// "닫기" 버튼 클릭 시 창을 닫습니다.
							$("#closeButton").click(function() {
								window.close();
							});
						});//documentready

		function reloadParentAndCurrentPage() {
			window.opener.location.reload(); // 부모 창 새로고침
			window.location.reload(); // 현재 창 새로고침
			window.close();
		}
	</script>
</body>
</html>