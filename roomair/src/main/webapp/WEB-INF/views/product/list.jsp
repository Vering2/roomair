<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/product.css" rel="stylesheet" type="text/css">

<%
//관리자 또는 자재팀 출고 상세 페이지 열람 가능 게시판 접근 가능 (권한)
String department = "";
if (session.getAttribute("empDepartment") != null) {
	department = (String) session.getAttribute("empDepartment");
}

//상수 정의
final String ADMIN_DEPARTMENT = "자재팀";
%>

<head>



<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
<title>roomair</title>

<!-- 모달창 script -->
<script>
      //modal창에 열기 위한 이벤트 헨들러
        function openModal(e) {
        	
        	//modal창의 id 값 할당
            const myModal = document.getElementById("myModal");
           const elements = [];
            for (let i = 1; i <= 10; i++) {
                elements[i] ='element' + i;
            }
        	//클릭한 요소의 name의 속성 값을 가져와서 clickedElementName변수에 저장한다
        	//즉 이 부분은 클릭한 요소의 name속성을 추출하는 역할
        	// "getBoundingClientRect()" 메서드를 사용하여 클릭한 요소의 화면 좌표 정보를 가져옵니다.
        	// 이 정보는 모달 창의 위치를 설정하는 데 사용됩니다.           
            /* const clickedElementValue = e.getAttribute("name"); */
        	
        	//클릭한 요소의 좌표정보 
            const rect = e.getBoundingClientRect();
           
            
        	// 클릭한 요소의 오른쪽 아래 모서리의 화면 좌표를 "x"와 "y" 변수에 저장합니다.
        	// 이것은 모달 창을 클릭한 요소의 위치에 배치하는 데 사용됩니다.
            var xr = rect.right;
            var xl = rect.left;
            var yt = rect.top;
            var yb = rect.bottom; 
            var xg = (xr-xl)/2;
            var yg = (yt-yb)/2;
            var x =  xl+xg;
            var y = yb+yg;
           
            //클릭후에 모달창을 생성하는 위치를 조정
            myModal.style.left = x + "px";
            myModal.style.top = y + "px";
            myModal.style.display = "block";
            
            // modalContent를 초기화 (이전 내용 지우기)
            myModal.innerHTML = "";
           
            //닫기
            myModal.innerHTML = `<span id="closeModalButton" style="cursor: pointer;">닫기</span><br>`;
            const clickedElementId = e.getAttribute("id");
            if(clickedElementId.startsWith("PR")){
            	//modal_ajax 
            	$.ajax({
            	  url : '${pageContext.request.contextPath}/KDMajax/modalprod',
            	  data: {prodCode:clickedElementId},
            	  type : 'GET',
            	  dataType:'json',
            	  success: function (json) {
                      if (json && typeof json === 'object') {
                    	  
                    	// 값 할당
                    	addInput("제품 이름:", elements[0],json.prodName);
            	addInput("제품 단위:", elements[1],json.prodUnit);
            	addInput("용량:", elements[2],json.prodSize);
            	addInput("향기 종류:", elements[3],json.prodPerfume);
            	addInput("거래처 코드:", elements[4],json.whseCode);
                addInput("창고 코드:", elements[5],json.whseCode);
                addInput("매출 단가:", elements[6],json.prodPrice);
                addInput("제품 비고:", elements[7],json.prodMemo);
                    	} else {
                    	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                    	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                    	}

                  }
              });	
            	

      	  }  else if(clickedElementId.startsWith("SL")){
              	//modal_ajax 
              	$.ajax({
              	  url : '${pageContext.request.contextPath}/KDMajax/modalsell',
              	  data: {whseCode:clickedElementId},
              	  type : 'GET',
              	  dataType:'json',
              	  success: function (json) {
                        if (json && typeof json === 'object') {
                        	// 값 할당
                        	

                      	addInput("수주 일자:", elements[0],json.sellDate);
              	addInput("납기 일자:", elements[1],json.sellDuedate);
              	addInput("관리 사원:", elements[2],json.sellEmpId);
              	addInput("수주 수량:", elements[3],json.sellCount);
                  addInput("수주 단가:", elements[4],json.sellPrice);
                  addInput("제품 코드:", elements[5],json.prodCode);
                  addInput("제품 이름:", elements[6],json.prodName);
                  addInput("수주 비고:", elements[7],json.sellMemo);
                  addInput("출고 상태:", elements[8],json.sellState);
                  addInput("거래처 이름:", elements[9],json.clientCompany);
                  addInput("거래처 코드:", elements[10],json.whseCode);
                      	} else {
                      	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                      	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                      	}
                        }
                });	//기존 닫기 창 함수
               
        }  else if(clickedElementId.startsWith("WI")){
        	
        	var result = clickedElementId.substring(clickedElementId.indexOf("WI") + 2);
          	 	
          	
          	var elementsStartingWithL = [];

          	// 문자열을 "L"로 분할하여 배열로 만들기
          	var elementss = result.split("L");

          	// 배열을 순회하며 "L"로 시작하는 부분을 찾아내어 새로운 배열에 저장
          	for (var i = 1; i < elementss.length; i++) {
          	    elementsStartingWithL.push("L" + elementss[i]);
          	}
          
          	for (var i = 0; i < elementsStartingWithL.length; i++) {
          	    var label = (i + 1) + "차";
          	    addInput(label, elements[i], elementsStartingWithL[i]);
          	}
                  
            
           
    }
        else if(clickedElementId.startsWith("GL")||clickedElementId.startsWith("LB")||clickedElementId.startsWith("PC")||clickedElementId.startsWith("PE")||clickedElementId.startsWith("ST")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalraw',
          	  data: {rawCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                  	addInput("원자재 이름:", elements[0],json.rawName);
          	addInput("원자재 종류:", elements[1],json.rawType);
          	addInput("원자재 단위:", elements[2],json.rawUnit);
          	addInput("원자재 가격:", elements[3],json.rawPrice);
              addInput("거래처 코드:", elements[4],json.whseCode);
              addInput("창고 코드:", elements[5],json.whseCode);
              addInput("원자재 비고:", elements[6],json.rawMemo);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
        else if(clickedElementId.startsWith("CL")||clickedElementId.startsWith("OR")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalclient',
          	  data: {clientCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	

                  	addInput("이름:", elements[0],json.clientCompany);
          	addInput("분류:", elements[1],json.clientType);
          	addInput("사업자번호:", elements[2],json.clientNumber);
          	addInput("상세분류:", elements[3],json.clientDetail);
              addInput("대표이름:", elements[4],json.clientCeo);
              addInput("담당자:", elements[5],json.clientName);
              addInput("주소:", elements[6],json.clientAddr1);
              addInput("상세주소:", elements[7],json.clientAddr2);
              addInput("대표 번호:", elements[8],json.clientTel);
              addInput("담당자 번호:", elements[9],json.clientPhone);
              addInput("팩스:", elements[10],json.clientFax);
              addInput("이메일:", elements[11],json.clientEmail);
              addInput("비고:", elements[12],json.clientMemo);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
            
        else if(clickedElementId.startsWith("WH")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalwhse',
          	  data: {whseCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	

                  	addInput("이름:", elements[0],json.whseName);
          	addInput("타입:", elements[1],json.whseType);
          	addInput("사용 상태", elements[2],json.whseState);
          	addInput("주소:", elements[3],json.whseAddr);
              addInput("연락처:", elements[4],json.whseTel);
              addInput("비고:", elements[5],json.whseMemo);
              addInput("제품 코드:", elements[6],json.prodCode);
              addInput("원자재 코드:", elements[7],json.rawCode);
              addInput("담당자:", elements[8],json.whseEmpId);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
            
            
            
            //ajax
            closeModalButton.addEventListener("click", function (e) {
          	    if (e.target === closeModalButton) {
          	        myModal.style.display = "none";
          	    }
          	});
      }    
            //input시 동적으로 생성하기 위한 함수
            function addInput(label, id, value) {
                const div = document.createElement("div");
                const input = document.createElement("input");
                div.style.display = "flex";
                div.style.justifyContent = "flex-end";
                input.type = "text";
                input.id = id;
                input.value = value; // 값을 설정
                input.size = 9;
                input.readOnly = true;
                div.appendChild(document.createTextNode(label));
                div.appendChild(input);
                myModal.appendChild(div);
            }
          	
        
               
    </script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- <script src="../resources/js/scripts.js"></script> -->

<!-- <script src="../resources/js/productList_im.js"></script> -->
<!-- 		추가안되면 사이드바에 있는 이거^때문임 -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

</head>


<body>
	<!-- 모달창 -->
	<div id="myModal" style="display: none; position: absolute; background-color: #fff; border: 1px solid #000; padding: 10px; z-index: 1;"></div>
	<!-- 모달창 -->
	<c:choose>
		<c:when test="${!(empty sessionScope.empDepartment)}">
			<!-- 사이드바 -->
			<jsp:include page="../inc/side.jsp"></jsp:include>
			<!-- 사이드바 -->

			<div class="container">

				<h2>제품 관리</h2>
				<div id="searchform">
					<form action="${pageContext.request.contextPath}/product/list" method="get" id="selectedProId">
						<label>제품 코드</label> <input type="text" placeholder="제품코드" name="prodCode" id="prodCode" value="${prodDTO.prodCode }"> <label>제품명</label> <input type="text" placeholder="제품명" name="prodName" id="prodName" value="${prodDTO.prodName }"> <label>거래처명</label> <input type="text" name="clientCompany" id="sellclientCompany9999" value="${prodDTO.clientCompany }" readonly placeholder="거래처명" onclick="searchItem('sellclient','sellwhseCode9999')" style="cursor: pointer !important;">
						<!--         <input type="text" placeholder="거래처를 선택하세요." name="a3"> -->
						<button type="submit">조회</button>
					</form>
				</div>
				<%--     <form action="${pageContext.request.contextPath}/product/write" method="post"> --%>
				<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
					<div class="buttons">
						<button id="add" onclick="openPopup1('${pageContext.request.contextPath}/product/write')">추가</button>
						<!-- 			<button id="modify">수정</button> -->
						<!--     <button id="delete" onclick="deleteSelectedProducts()">삭제</button> -->
						<button id="delete">삭제</button>
						<!-- 			<button id="cancel">취소</button> -->
						<!-- 			<button id="save">저장</button> -->
						<!-- 				<button id="excelDownload" class="buttons">엑셀⬇</button> -->
					</div>
				</c:if>

				<label style="padding-left: 1%;" id="listCount">총 ${pageDTO.count}건</label>

				<form id="productList">
					<div id="productList">
						<table class="tab" id="productTable">
							<thead>
								<tr>
									<!-- 체크박스 열 추가 -->
									<th><input type="checkbox" id="select-list-all" name="select-list-all" data-group="select-list"></th>
									<th>제품 코드</th>
									<th>제품명</th>
									<th>제품 단위</th>
									<th>용량</th>
									<th>향기 종류</th>
									<th>거래처 코드</th>
									<th>창고 코드</th>
									<th>매출 단가</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="prodDTO" items="${prodList}">
									<tr>
										<td><input type="checkbox" id="select-list" value="${prodDTO.prodCode}" name="selectedProId" data-group="select-list"></td>
										<!-- 체크박스 열 -->

										<td>
											<!-- 								<a href="#" --> <%-- 									onclick="openPopup2('${pageContext.request.contextPath}/product/update?prodCode=${prodDTO.prodCode}')"> --%> <%-- 									${prodDTO.prodCode}</a> --%> <c:choose>
												<c:when test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
													<a href="#" onclick="openPopup2('${pageContext.request.contextPath}/product/update?prodCode=${prodDTO.prodCode}')"> ${prodDTO.prodCode} </a>
												</c:when>
												<c:otherwise>
        ${prodDTO.prodCode}
    </c:otherwise>
											</c:choose> <%--                 ${prodDTO.prodCode} --%>
										</td>
										<td>${prodDTO.prodName}</td>
										<td id="prodUnit">${prodDTO.prodUnit}</td>
										<td id="prodSize">${prodDTO.prodSize}ml</td>
										<td id="prodPerfume">${prodDTO.prodPerfume}</td>
										<%-- <td id="clientCompany">${prodDTO.clientCompany}</td> --%>
										<td><label style='cursor: pointer;' onclick="openModal(this)" id="${prodDTO.clientCode }" name="clientCode" value="${prodDTO.clientCode}">${prodDTO.clientCode}</label></td>
										<%-- <td id="clientName">${prodDTO.clientName}</td> --%>
										<td><label style='cursor: pointer;' onclick="openModal(this)" id="${prodDTO.whseCode }" name="whseCode" value="${prodDTO.whseCode}">${prodDTO.whseCode}</label></td>
										<td id="prodPrice"><fmt:formatNumber>${prodDTO.prodPrice}</fmt:formatNumber>원</td>
										<c:choose>
											<c:when test="${not empty prodDTO.prodMemo}">
												<td class="tg-llyw2"><a href="#" onclick="openProdMemo('${prodDTO.prodCode}'); return prodMemoClose();" style="color: red;">[보기]</a></td>
											</c:when>
											<c:otherwise>

												<td class="tg-llyw2"><a href="#" onclick="addProdMemo('${prodDTO.prodCode}'); return prodMemoClose();" style="color: #384855;">[입력]</a></td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>
					<div class="page">
						<!-- 				<button id="exportButton" class="buttons">엑셀</button> -->
						<input type="button" id="exportButton" class="buttons" value="엑셀">
						<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
							<a href="${pageContext.request.contextPath}/product/list?pageNum=${pageDTO.startPage - pageDTO.pageBlock}&prodCode=${prodDTO.prodCode}&prodName=${prodDTO.prodName}&clientCompany=${prodDTO.clientCompany}">Prev</a>
						</c:if>

						<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
							<a href="${pageContext.request.contextPath}/product/list?pageNum=${i}&prodCode=${prodDTO.prodCode}&prodName=${prodDTO.prodName}&clientCompany=${prodDTO.clientCompany}">${i}</a>
						</c:forEach>


						<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
							<a href="${pageContext.request.contextPath}/product/list?pageNum=${pageDTO.startPage + pageDTO.pageBlock}&prodCode=${prodDTO.prodCode}&prodName=${prodDTO.prodName}&clientCompany=${prodDTO.clientCompany}">Next</a>
						</c:if>
					</div>

				</form>
			</div>
		</c:when>
		<c:otherwise>

			<input type="text" hidden="">

		</c:otherwise>
	</c:choose>
	<script>

var contextPath = "${pageContext.request.contextPath}";
// 권한
var department = "<%=department%>";
var ADMIN_DEPARTMENT = "<%=ADMIN_DEPARTMENT%>";

<!-------------------------- 목록 전체선택 -------------------------->


// thead의 체크박스를 클릭했을때 전체체크가되게끔 이벤트를 발생시킨다

$(document).ready(function() {
$('#select-list-all').click(function() {
			var checkAll = $(this).is(":checked");
			
			if(checkAll) {
				$('input:checkbox').prop('checked', true);
			} else {
				$('input:checkbox').prop('checked', false);
			}
		});
		
//삭제 버튼 누를 시 실행되는 함수
$('#delete').click(function(event){	
	
		
		var checked = [];
		
		$('input[name=selectedProId]:checked').each(function(){
			checked.push($(this).val());
		});
		
//			alert(checked);
		
		if(checked.length > 0) {
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
						  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
				  icon: 'info', // 아이콘! 느낌표 색? 표시?
				  showDenyButton: true,
				  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
				  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
				  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//					  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
				  width : '300px', // alert창 크기 조절
				  
				}).then((result) => {
			
			 /* confirm => 예 눌렀을 때  */
			  if (result.isConfirmed) {
				  
			  
				$.ajax({
						url: "${pageContext.request.contextPath}/product/delete",
						type: "POST",
						data: {checked : checked},
						dataType: "text",	
						success: function () {
							Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
							  icon: 'success',
							  width : '300px',
							}).then((result) => {
							  if (result.isConfirmed) {
							    location.reload();
							  }
							});
					},
					error: function () {
						Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
							icon : 'question',
							width: '300px',
							});
						
					}
				});//ajax
				  } else if (result.isDenied) {
						Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
						icon : 'error',
						width: '300px',
						});
			}// if(confirm)
		});		
				
		}// 체크OOO
		else{
			Swal.fire({
				title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
				icon : 'warning',
				width: '300px',
				});
		}
		
		// endAJAX(물품 삭제)
	 // end 정규식검사

}); 
//
});// end function



// function openAdd() {
//     var url = "${pageContext.request.contextPath}/product/write";
//     var newWindow = window.open(url, "_blank");
//     newWindow.focus();
//   }
//update 페이지 팝업창
function openPopup2(url) {
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=700");
	myWindow.moveTo(0, 0);
	myWindow.focus();
	}
//추가 페이지 팝업창
function openPopup1(url) {
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=700");
	myWindow.moveTo(0, 0);
	myWindow.focus();
}

//팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    }
});



//--------------------------------------------------------------------------
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()


//버튼 클릭 시 실행
// 클라이언트에서 서버로 데이터 요청
		document.getElementById('exportButton').addEventListener('click', function () {
			if (!(department !== ADMIN_DEPARTMENT && department !== "관리자")) {	
			// 엑셀로 내보낼 데이터
		    var searchParams = {
		    		prodCode : $("#prodCode").val(),
					prodName : $("#prodName").val(),
					clientCompany : $("#sellclientCompany9999").val(),
		    };
		
		    $.ajax({
		        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		        url: "${pageContext.request.contextPath}/product/getExcel", // 데이터를 가져올 URL 설정
		        data: searchParams, // 검색 조건 데이터 전달
		        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		        success: function (data) {
		            // 데이터 가공
					var modifiedData = data.map(function (item) {
					    return {
					        '제품 코드': item.prodCode,
					        '제품명': item.prodName,
					        '제품단위': item.prodUnit,
					        '용량': item.prodSize,
					        '향기 종류': item.prodPerfum,
					        '거래처명': item.clientCompany,
					        '창고명': item.whseName,
					        '매출 단가': item.prodPrice,
					        '비고': item.prodMemo,
					    };
					});
		            // 새 워크북을 생성
		            var wb = XLSX.utils.book_new();
		            // JSON 데이터를 워크시트로 변환
		            var ws = XLSX.utils.json_to_sheet(modifiedData);
		            // 워크북에 워크시트 추가
		            XLSX.utils.book_append_sheet(wb, ws, "데이터 시트");
		            // Blob 형태로 워크북 생성
		            var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
		            // 파일 이름 설정 (원하는 파일 이름으로 변경)
		            var fileName = "InMaterial.xlsx";
		            // Blob 파일을 다운로드
		            saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), fileName);
		        }
		    });
			}else {
				 Swal.fire({
                     text: '자재팀만 가능',
                     icon: 'warning',
                     confirmButtonText: '확인',
                 });
			}
		});
		
		// ArrayBuffer 만들어주는 함수
		function s2ab(s) {
		    var buf = new ArrayBuffer(s.length); // convert s to arrayBuffer
		    var view = new Uint8Array(buf); // create uint8array as viewer
		    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; // convert to octet
		    return buf;
		}	
 
//   <!--------------------------------------------------- 비고 보기 ----------------------------------------->

  function openProdMemo(prodCode) {
      // 팝업 창의 속성을 설정합니다.
      var popupWidth = 450;
      var popupHeight = 500;
      var left = (window.innerWidth - popupWidth) / 2;
      var top = (window.innerHeight - popupHeight) / 2;
      var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                          ',left=' + left + ',top=' + top +
                          ',resizable=yes,scrollbars=yes';

      // 새 창을 열기 위한 URL 설정
      var url = '${pageContext.request.contextPath}/product/memo?prodCode=' + prodCode;

      // 팝업 창을 열고 속성 설정
      var newWindow = window.open(url, '_blank', popupFeatures);       
  }
  
  <!--------------------------------------------------- 비고 추가 ----------------------------------------->

  function addProdMemo(prodCode) {
      // 팝업 창의 속성을 설정합니다.
      var popupWidth = 450;
      var popupHeight = 500;
      var left = (window.innerWidth - popupWidth) / 2;
      var top = (window.innerHeight - popupHeight) / 2;
      var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                          ',left=' + left + ',top=' + top +
                          ',resizable=yes,scrollbars=yes';

      // 새 창을 열기 위한 URL 설정
      var url = '${pageContext.request.contextPath}/product/memotype?prodCode=' + prodCode+'&memotype=add';
      // 팝업 창을 열고 속성 설정
      var newWindow = window.open(url, '_blank', popupFeatures); 
  }
  
// 숫자를 ###,### 원 형식으로 포맷하는 함수
// 	function formatCurrency(number) {
// 		return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
// 				+ '원';
// 	}
// function formatCurrency(number) {
//     return parseFloat(number).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + '원';
// }

</script>

</body>
</html>
