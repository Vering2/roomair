<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/outProductContent.css"
	rel="stylesheet" type="text/css">
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

<title>출고 상세 페이지</title>
</head>
<body>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">

	<h2>출고 상세정보</h2>
	<form action="${pageContext.request.contextPath}/outProduct/outProductUpdate" id="updateForm" method="POST">
		<table>
			<tbody>
				<tr>
					<td class="tableHead">출고 코드</td>
					<td><input type="text" name="outCode" value="${outProductDTO.outCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead">수주 코드</td>
					<td><input type="text" name="sellCode" value="${outProductDTO.sellCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead">거래처 코드</td>
					<td><input type="text" name="clientCode" value="${outProductDTO.clientCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead">거래처명</td>
					<td><input type="text" name="clientCompany" value="${outProductDTO.clientCompany }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead">제품 코드</td>
					<td><input type="text" name="prodCode" value="${outProductDTO.prodCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead">제품명</td>
					<td><input type="text" name="prodName" value="${outProductDTO.prodName }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="tableHead">담당자</td>
					<c:if test="${outProductDTO.outEmpId == null}">
						<td>
							<input type="hidden" name="outEmpId" value="${sessionScope.empId}" id="outEmpId" readonly="readonly">
							<input type="text" name="outEmpId_1" value="${sessionScope.empId}" id="outEmpId_1" readonly="readonly" style="cursor:pointer;">
						</td>
					</c:if>
					<c:if test="${outProductDTO.outEmpId != null  }">
						<td>
							<input type="hidden" name="outEmpId" value="${sessionScope.empId}" id="outEmpId" readonly="readonly">
							<input type="text" name="outEmpId_2" value="${outProductDTO.outEmpId}" id="outEmpId_1" readonly="readonly" style="cursor:pointer;">
						</td>
					</c:if>
				</tr>
				<tr>
					<td class="tableHead">출고 상태</td>
					<td><input type="text" name="sellState" value="${outProductDTO.sellState }" readonly="readonly"></td>
				</tr>
				<tr>
					<fmt:formatNumber var="outPrice" value="${outProductDTO.outPrice }" pattern="###,###"></fmt:formatNumber>
					<td class="tableHead">총 출고가</td>
					<td>
						<input type="hidden" name="outPrice" value="${outProductDTO.outPrice }">
						<input type="text" name="outPriceFormat" value="${outPrice }원" readonly="readonly">
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="outProductTable">
			<tr>
				<td class="tableHead" colspan="2">납품 예정일</td>
				<td class="tableHead" colspan="2">출고일</td>
				<td class="tableHead" colspan="2">재출고일</td>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="sellDuedate" value="${outProductDTO.sellDuedate }" readonly="readonly"></td>
				<td colspan="2"><input type="text" name="outDate" value="${outProductDTO.outDate }" readonly="readonly"></td>
				<td colspan="2"><input type="text" name="outRedate" value="${outProductDTO.outRedate }" readonly="readonly"></td>
			</tr>
			<tr>
				<td class="tableHead" colspan="3">총 수주 개수</td>
				<td class="tableHead" colspan="3">남은 수주 개수</td>
			</tr>
			<tr> 
				<td colspan="3"><input type="number" name="sellCount" value="${outProductDTO.sellCount }" readonly="readonly"></td>
				<td colspan="3"><input type="number" name="remainder" id="remainder" value="${outProductDTO.sellCount - outProductDTO.outCount}" readonly="readonly"></td>
				
				
			</tr>
			<tr>
				<td class="tableHead" colspan="3">출고 개수</td>
				<td class="tableHead" colspan="3">재고 개수</td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="hidden" id="initialOutCount" value="${outProductDTO.outCount}">
					<c:if test="${outProductDTO.stockCount == null || outProductDTO.stockCount == 0}">
   						<input type="number" name="outCount" value="${outProductDTO.outCount}" id="inputNum" readonly="readonly">
					</c:if>
					<c:if test="${outProductDTO.stockCount != null && outProductDTO.stockCount > 0}">
    						<input type="number" name="outCount" value="${outProductDTO.outCount }" id="inputNum" autofocus="autofocus" min="${outProductDTO.outCount }" onchange="updateInventory()">
					</c:if>
				</td>
				<td colspan="3">
					<input type="hidden" id="initialstockCount" value="${outProductDTO.stockCount}">
					<input type="number" name="stockCount" value="${outProductDTO.stockCount }" min="0" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td class="tableHead" colspan="3">제품 단가</td>
				<td class="tableHead" colspan="3">현재 출고가</td>
			</tr>
			<tr>
				<td colspan="3">
				<fmt:formatNumber var="prodPrice" value="${outProductDTO.prodPrice }" pattern="###,###.##"></fmt:formatNumber>
					<input type="hidden" name="prodPrice" value="${outProductDTO.prodPrice }">
					<input type="text" name="prodPriceFormat" value="${prodPrice }원" readonly="readonly">
				</td>
				<td colspan="3">
					<input type="text" name="currentOutPrice" value="" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td class="tableHead" colspan="6">비고</td>
			</tr>
			<tr>
				<td colspan="6"><input type="text" name="outMemo" value="${outProductDTO.outMemo }" id="inputMemo" placeholder="비고 입력"></td>
			</tr>
		</table>
		<div id="buttons">
		<c:if test="${outProductDTO.sellState != '출고완료' && outProductDTO.stockCount != 0 }">
				<input type="button" id="updateButton" value="출고">
		</c:if>
			<input type="button" value="닫기" id="closeButton" onclick="window.close()">
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
		  var inputElement = document.getElementById('outEmpId_1');
		  var modalContent = document.querySelector('.modal-content');
		
		  inputElement.addEventListener('click', function(e) {
			  $.ajax({
			    type: "POST",
			    url: "${pageContext.request.contextPath}/outProduct/outProductEmpInfo",
			    data: { empId: $('#outEmpId_1').val() },
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
	
		var department = "<%= department %>";
		var ADMIN_DEPARTMENT = "<%= ADMIN_DEPARTMENT %>";
		if (department !== ADMIN_DEPARTMENT && department !== "관리자") {
		    // 세션 값이 허용되지 않는 경우 리다이렉트
		    window.opener.location.href = "<%= request.getContextPath() %>/main/calendar";
		    window.close();
		}
		 
	</script>
	
	<script type="text/javascript">
	
		function updateInventory() {
		    // 출고 개수와 재고 개수 입력란의 DOM 요소를 가져옵니다
		    var outCountInput = document.querySelector('input[name="outCount"]');
		    var stockCountInput = document.querySelector('input[name="stockCount"]');
		    var remainder = document.querySelector('input[name="remainder"]');
		    var sellCount = document.querySelector('input[name="sellCount"]');
		    // 납품 단가
		    var prodPrice = ${outProductDTO.prodPrice };
		    // 현재 출고가
		    var currentOutPrice = document.querySelector('input[name="currentOutPrice"]');
		    
		    // 현재 출력해야되는 재고값 계산
		    var initialstockCount = parseInt(document.getElementById('initialstockCount').value, 10);
		    var initialOutCount = parseInt(document.getElementById('initialOutCount').value, 10);
		    var outCount = parseInt(outCountInput.value, 10);
		    
		    // 재고 입력란 업데이트
		    stockCountInput.value = initialstockCount + initialOutCount - outCount;
		    currentOutPrice.value = formatCurrency(outCount * prodPrice) + '원';
		    remainder.value = sellCount.value - outCount;
		}
		
		
		//숫자를 ###,### 원 형식으로 포맷하는 함수
		function formatCurrency(number) {
		    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
		
		
		$(document).ready(function() {
			
			updateInventory();
			
			 // JavaScript로 max 속성을 설정
		    var outCountInput = document.getElementById('inputNum');
		    var stockCount = ${outProductDTO.stockCount}; // stockCount 값을 JSP 표현식으로 가져옴
		    var sellCount = ${outProductDTO.sellCount}; // sellCount 값을 JSP 표현식으로 가져옴
			var outCount = ${outProductDTO.outCount};
			
			// maxCount 값을 설정할 때 Math.min 함수를 사용하여 더 작은 값을 선택
		    var maxCount = Math.min(sellCount, outCount + stockCount);
		    outCountInput.setAttribute('max', maxCount);
		
		    
		    document.getElementById("inputNum").addEventListener("keyup", function(event) {
				if (event.key === "Enter") {
			        event.preventDefault();

			        // 입력된 출고 개수 가져오기
			        var inputCount = parseInt(outCountInput.value);


			        // 만약 입력된 값이 max 값보다 크면 max 값으로 설정
			        if (inputCount > maxCount) {
			        	outCountInput.value = maxCount;
			        }

			        // 여기에서 원하는 동작을 수행하세요.
			        updateInventory();
			    }
			});
		    
		  
		    
			
			// "출고" 버튼 클릭 시 Ajax 요청을 보냅니다.
			$("#updateButton").click(function() {
				// 폼 데이터를 수집
				var formData = $("#updateForm").serialize();
				
				console.log("입력 받은 값 "+outCountInput.value);
				console.log("서버에서 받아온 값 "+outCount);
				if(outCount < outCountInput.value){
					$.ajax({
						type: "POST",
						url: "${pageContext.request.contextPath}/outProduct/outProductUpdate",
						data: formData,
						success: function(response) {
							console.log(response);
							if(response === 'success'){
			                    Swal.fire({
			                        text: '출고 완료',
			                        icon: 'success',
			                        confirmButtonText: '확인',
			                        onClose: reloadParentAndCurrentPage // 확인 버튼을 누르면 새로고침 함수 호출
			                    });
			                } else if(response === 'error1') {
			                    Swal.fire({
			                        text: '출고 개수의 입력값이 잘못되었습니다.',
			                        icon: 'warning',
			                        confirmButtonText: '확인',
			                        onClose: reloadParentAndCurrentPage // 확인 버튼을 누르면 새로고침 함수 호출
			                    });
			                } else if(response === 'error2') {
			                    Swal.fire({
			                        text: '재고가 충분하지 않습니다.',
			                        icon: 'warning',
			                        confirmButtonText: '확인',
			                        onClose: reloadParentAndCurrentPage // 확인 버튼을 누르면 새로고침 함수 호출
			                    });
			                }
						},
						error: function(xhr, status, error) {
							// 에러 처리
							console.log("에러: " + error);
						}
					});
				}else {
					console.log("이거 뭐지");
					 Swal.fire({
	                        text: '출고 개수의 입력값이 잘못되었습니다.',
	                        icon: 'warning',
	                        confirmButtonText: '확인',
	                        onClose: reloadParentAndCurrentPage
	                    });
				}
			});

			// "닫기" 버튼 클릭 시 창을 닫습니다.
			$("#closeButton").click(function() {
				window.close();
			});
		});
		
		function reloadParentAndCurrentPage() {
		    window.opener.location.reload(); // 부모 창 새로고침
		    window.location.reload(); // 현재 창 새로고침
		    window.close();
		}
		
	</script>
</body>
</html>