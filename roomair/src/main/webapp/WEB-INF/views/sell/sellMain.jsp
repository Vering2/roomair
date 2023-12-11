
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<title>sell/sellMain.jsp</title>

<!-- side.jsp css-->
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
<!-- 본문 css -->
<%-- <link href="${pageContext.request.contextPath }/resources/css/outProduct.css">
 --%>
<link href="${pageContext.request.contextPath }/resources/css/sell.css" rel="stylesheet" type="text/css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 엑셀 다운로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- 수주일자 기간선택 -->
<link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css">
<!-- 수주일자 기간선택 -->
<style>
/* 모달 스타일 */
.modal {
	display: none;
	position: absolute; /* position 속성을 absolute로 변경 */
	z-index: 1;
	background-color: transparent; /* 배경색을 투명으로 변경 */
}

.modal-content {
	font-size: 15px;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #888;
	position: fixed;
}

.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover {
	cursor: pointer;
}

table {
	border-collapse: collapse;
	width: 96%;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	text-align: center;
	border-right: 1px solid #D9D9D9;
	border-bottom: 1px solid #D9D9D9;
	margin-left: auto;
	margin-right: auto;
	margin-top: 10px;
}
</style>
</head>

<body>
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
	<!------------------------------------------------------- 사이드바 ---------------------------------------------------->
	<jsp:include page="../inc/side.jsp"></jsp:include>

	<!------------------------------------------------------- 본문 타이틀 ---------------------------------------------------->
	<div class="container">
		<h2>
			<a href="${pageContext.request.contextPath}/sell/sellMain" style="text-decoration: none; color: black;">수주 관리</a>
		</h2>

		<!------------------------------------------------------- 상단 검색란 ---------------------------------------------------->
		<form action="${pageContext.request.contextPath}/sell/sellMain" method="get" id="searchBox">
			<div id="searchform" style="border-radius: 5px;">

				<label>수주 코드</label> <input type="text" id="sellCode" name="sellCode" value="${sellDTO.sellCode}"> <label>거래처</label> <input type="text" id="sellclientCode9999" name="clientCode" value="${sellDTO.clientCode}" onclick=searchItem( 'sellclient','sellclientCode9999'); placeholder="거래처 코드" readonly> <input type="text" id="sellclientCompany9999" name="clientCompany" placeholder="거래처명" value="${sellDTO.clientCompany}" onclick=searchItem( 'sellclient','sellclientCode9999'); readonly> <label>제품</label> <input type="text" name="prodCode" id="prodCode9999" value="${sellDTO.prodCode}" onclick=searchItem( 'prod','prodCode9999'); placeholder="제품 코드" readonly> <input type="text" name="prodName" id="prodName9999" value="${sellDTO.prodName}" placeholder="제품명" readonly onclick="searchItem('prod','prodCode9999')"> <label for="startDate">수주 일자</label> <input type="text" id="sellDate" name="daterange1" value="${sellDTO.sellDate}" class="daterange"
					style="width: 180px;"
				> <label for="startDate">납기일자</label> <input type="text" id="sellDuedate" name="daterange2" value="${sellDTO.sellDuedate}" class="daterange" style="width: 180px;"> <input type="hidden" id="sellState" name="sellState" value="${sellDTO.sellState}"> <input type="submit" value="조회" id="searchButton" class="btn"> <input type="button" value="취소" id="resetButton" class="btn">

			</div>
			<br>
			<!------------------------------------------------------- 추가, 수정, 삭제 버튼 ---------------------------------------------------->
			<div id="sample">
				<div id="buttons">
					<input type="submit" class="buttons" value="전체" id="allButton"> <input type="submit" class="buttons" value="미출고" id="non_deliveryButton"> <input type="submit" class="buttons" value="중간납품" id="interim_deliveryButton"> <input type="submit" class="buttons" value="출고완료" id="deliveryButton">
				</div>

				<div class="buttons">


					<button style="display: none;" id="add" onclick="openSellAdd()" class="btn">추가</button>
					<button style="display: none;" id="delete" class="btn">삭제</button>
				</div>
				<!------------------------------------------------------- 수주 상태---------------------------------------------------->
			</div>
		</form>
		<div class="total-items">
			<div>
				<label>총 ${sellDTO.count}건</label>
			</div>
			<div class="PageSelect">
				<label for="perPageSelect" style="bottom: 2px;">항목 수 </label> <select id="perPageSelect" class="input_box" style="width: 100px; bottom: 2px;" onchange="applyFilters()" value="${sellDTO.pageSize}">
					<option value="10" ${sellDTO.pageSize == 10 ? 'selected' : ''}>10개씩</option>
					<option value="50" ${sellDTO.pageSize == 50 ? 'selected' : ''}>50개씩</option>
					<option value="100" ${sellDTO.pageSize == 100 ? 'selected' : ''}>100개씩</option>
					<option value="9999" ${sellDTO.pageSize == 9999 ? 'selected' : ''}>전체</option>
				</select>
			</div>
		</div>

		<!------------------------------------------------------- 수주 목록 ---------------------------------------------------->


		<form id="selltList">
			<div id="sellList">
				<table class="tg" id="sellTable" style="border-radius: 5px;">
					<thead>
						<tr>
							<td><input type="checkbox" id="select-list-all" name="select-list-all" data-group="select-list"></td>
							<td>처리 상태</td>
							<td>수주 코드</td>
							<td>거래처 코드</td>
							<td>제품 코드</td>
							<td>제품명</td>
							<td>제품 단가</td>
							<td>수주 수량</td>
							<td>수주 단가</td>
							<td>수주 일자</td>
							<td>납기 일자</td>
							<td>담당자</td>
							<td>비고</td>
						</tr>
					</thead>



					<tbody>
						<c:forEach var="sellDTO" items="${sellList}">
							<tr>
								<td><input type="checkbox" value="${sellDTO.sellCode}" name="selectedSellCode" data-group="select-list"></td>


								<td>${sellDTO.sellState}</td>
								<!-- 처리(출고)상태 -->

								<td onclick="openSellDetail('${sellDTO.sellCode}')" class="sellDetailLink">${sellDTO.sellCode}</td>
								<!-- 수주코드 -->

								<%-- <td>${sellDTO.clientCode}</td> --%>
								<!-- 거래처코드 -->
								<td style='cursor: pointer;' onclick="openModal(event)" id="${sellDTO.clientCode }" name="sellCode" value="${sellDTO.clientCode }">${sellDTO.clientCode }</td>


								<%-- <td>${sellDTO.prodCode}</td><!-- 제품코드 --> --%>
								<td style='cursor: pointer;' onclick="openModal(event)" id="${sellDTO.prodCode}" name="sellCode" value="${sellDTO.prodCode}">${sellDTO.prodCode}</td>

								<td>${sellDTO.prodName}</td>
								<!-- 제품명 -->

								<td><fmt:formatNumber value="${sellDTO.prodPrice}" pattern="###,###원" /></td>
								<!-- 제품단가 -->

								<td>${sellDTO.sellCount}개</td>
								<!-- 수주수량-->

								<td><fmt:formatNumber value="${sellDTO.sellPrice}" pattern="###,###원" /></td>
								<!-- 수주단가 -->

								<td>${sellDTO.sellDate}</td>
								<!-- 수주일자 -->

								<td>${sellDTO.sellDuedate}</td>
								<!-- 납기일자  -->

								<%-- <td>${sellDTO.sellEmpId}</td><!-- 수주담당직원 --> --%>
								<td style='cursor: pointer;' onclick="openModal(event)" id="${sellDTO.sellEmpId}" name="sellCode" value="${sellDTO.sellEmpId}">${sellDTO.sellEmpId}</td>



								<c:choose>
									<c:when test="${not empty sellDTO.sellMemo}">
										<td class="tg-llyw2"><a href="#" onclick="openSellMemo('${sellDTO.sellCode}'); return sellMemoClose();" style="color: #C63D2F; text-decoration: none;">보기</a></td>
									</c:when>
									<c:otherwise>
										<td class="tg-llyw2"><a href="#" onclick="addSellMemo('${sellDTO.sellCode}'); return sellMemoClose();" style="display: none; color: #384855; text-decoration: none;" class="memoAdd">입력</a></td>

									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>

		</form>



		<!------------------------------------------------- 페이징 ------------------------------------------>
		<div id="pagination" class="page_wrap">
			<input type="submit" id="exportButton" value="엑셀">
			<div class="page_nation">
				<c:if test="${sellDTO.startPage > sellDTO.pageBlock}">
					<a class="arrow prev" href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellDTO.startPage - sellDTO.pageBlock}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}" style="text-decoration: none; color: #5EC397;">◀</a>
				</c:if>


				<c:forEach var="i" begin="${sellDTO.startPage}" end="${sellDTO.endPage}" step="1">
					<c:choose>
						<c:when test="${i eq sellDTO.currentPage}">
							<a class="a active" href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}">${i}</a>
						</c:when>
						<c:otherwise>

							<a class="a" href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${sellDTO.endPage < sellDTO.pageCount}">
					<a class="arrow next" href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellDTO.startPage + sellDTO.pageBlock}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}" style="text-decoration: none; color: #5EC397;">▶</a>
				</c:if>
			</div>
		</div>
	</div>







	<!--################################################################ script ###################################################################-->



	<script type="text/javascript">

	 
	$(function() {
	    // 클래스로 daterangepicker 초기화
	    $('.daterange').daterangepicker({
	        autoUpdateInput: false,
	        locale: {
	            cancelLabel: 'Clear'
	        }
	    });

	    $('.daterange').on('apply.daterangepicker', function(ev, picker) {
	        $(this).val(picker.startDate.format('YYYY/MM/DD') + ' - ' + picker.endDate.format('YYYY/MM/DD'));
	    });

	    $('.daterange').on('cancel.daterangepicker', function(ev, picker) {
	        $(this).val('');
	    });

	    $('.cancelBtn').text('취소');
	    $('.applyBtn').text('적용');
	});

</script>

	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

	<script>
<!------------------------------------------------- 팝업창 옵션 ------------------------------------------>
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

//팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	
	
	var button = document.getElementById("allButton");
    <c:if test="${sellDTO.sellState == '미출고'}">
var button = document.getElementById("non_deliveryButton");
</c:if>
<c:if test="${sellDTO.sellState == '중간납품'}">
var button = document.getElementById("interim_deliveryButton");
</c:if>
<c:if test="${sellDTO.sellState == '출고완료'}">
var button = document.getElementById("deliveryButton");
</c:if>

button.style.backgroundColor = "#4D4D4D";

	/* var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    } */

$('#select-list-all').click(function() {
			var checkAll = $(this).is(":checked");
			
			if(checkAll) {
				$('input:checkbox').prop('checked', true);
			} else {
				$('input:checkbox').prop('checked', false);
			}
		});


<!--------------------------------------------------- 수주 삭제 ----------------------------------------->
$('#delete').click(function(event){	

		var checked = [];
		
		$('input[name=selectedSellCode]:checked').each(function(){
			checked.push($(this).val());
		});
		
		console.log(checked);
		
		if(checked.length > 0) {
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
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
					    url: "${pageContext.request.contextPath}/sell/delete",
					    type: "POST",
					    data: JSON.stringify(checked), // 데이터를 JSON 문자열로 변환
					    contentType: "application/json", // Content-Type 설정
					    dataType: "text",
					    success: function (response) {
					    	console.log(response); // 서버에서 반환한 응답을 콘솔에 출력
					        // 서버에서의 응답을 처리합니다.
					        // response 변수에 서버에서 반환한 문자열이 들어있습니다.
					        Swal.fire({
					            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + response + "</div>",
					            icon: 'success',
					            width: '300px',
					        }).then((result) => {
					            if (result.isConfirmed) {
					                location.reload();
					            }
					        });
					    },
					    error: function (response) {
					    	console.log(response); // 서버에서 반환한 응답을 콘솔에 출력
	                        Swal.fire({
	                            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "삭제 중 오류가 발생했습니다",
	                            icon: 'question',
	                            width: '300px',
	                        });
	                    }
					});
				  } else if (result.isDenied) {
						Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
						icon : 'error',
						width: '300px',
						});
			} // if(confirm)
		});		
			
		}// 체크 null
		else{
			Swal.fire({
				title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
				icon : 'warning',
				width: '300px',
				});
		}
}); 



});// end function
 
<!--------------------------------------------------- 수주 추가 ----------------------------------------->

function openSellAdd() {

    // 팝업 창 
    var popupWidth = 400;
    var popupHeight = 670;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';

    // selladd.jsp 파일을 팝업 창 오픈
    window.open( '${pageContext.request.contextPath}/sell/sellAdd','popupUrl', popupFeatures);
    
    function submitClose() {
        // 여기에 수주 등록 폼을 서버에 제출하는 코드를 추가하세요.
        
        // 폼을 제출한 후 창을 닫기 위해 아래 코드를 사용합니다.
        window.close();
    }
} 

<!--------------------------------------------------- 수주 상세정보 ----------------------------------------->
function openSellDetail(sellCode) {
	// 팝업 창 
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';
	
    window.open( '${pageContext.request.contextPath}/sell/sellDetail?sellCode='+sellCode,'popupUrl', popupFeatures);
	
    function submitClose() {
    	 window.close();
	
	}
}
<!--------------------------------------------------- 비고 보기 ----------------------------------------->

    function openSellMemo(sellCode) {
        // 팝업 창의 속성을 설정합니다.
        var popupWidth = 450;
        var popupHeight = 500;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                            ',left=' + left + ',top=' + top +
                            ',resizable=yes,scrollbars=yes';

        // 새 창을 열기 위한 URL 설정
        var url = '${pageContext.request.contextPath}/sell/sellMemo?sellCode=' + sellCode;

        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures);       
    }

<!--------------------------------------------------- 비고 추가 ----------------------------------------->

    function addSellMemo(sellCode) {
        // 팝업 창의 속성을 설정합니다.
        var popupWidth = 450;
        var popupHeight = 500;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                            ',left=' + left + ',top=' + top +
                            ',resizable=yes,scrollbars=yes';

        // 새 창을 열기 위한 URL 설정
        var url = '${pageContext.request.contextPath}/sell/sellMemotype?sellCode=' + sellCode+'&memotype=add';
        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures); 
    }
    

    
    $(document).ready(function () {
    	<!--------------------------------------------------- 페이지 권한 ----------------------------------------->
    	var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
			
		  if (team === "영업팀" || team === "관리자") {
			  $('#add').show();
				
				$('#delete').show();
				$('.memoAdd').show();
				
		   }
		  else if (team ===""){
			  window.location.href = "${pageContext.request.contextPath}/login/logout";
		  }
    	
		  var myButton = document.getElementById('delete');

		  myButton.addEventListener('click', function(event) {
		      event.preventDefault(); // 기본 동작인 폼 제출을 막음
		      // 원하는 동작 수행
		  });
		  
		  var myButton1 = document.getElementById('add');

		  myButton1.addEventListener('click', function(event) {
		      event.preventDefault(); // 기본 동작인 폼 제출을 막음
		      // 원하는 동작 수행
		  });
		    
		  <!--------------------------------------------------- 엑셀 다운로드 ----------------------------------------->

	  });
    
   <!--------------------------------------------------- 상단 조건 검색 ----------------------------------------->
 document.addEventListener('DOMContentLoaded', function () {
	    var allButton = document.getElementById('allButton');
	    var nonDeliveryButton = document.getElementById('non_deliveryButton');
	    var interimDeliveryButton = document.getElementById('interim_deliveryButton');
	    var deliveryButton = document.getElementById('deliveryButton');
	    var sellStateInput = document.querySelector('input[name="sellState"]');
	  
	    allButton.addEventListener('click', function () {
	        // 전체 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "";
// 	        $('#selectedProId').submit();
	    });

	    nonDeliveryButton.addEventListener('click', function () {
	        // 미출고 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "미출고";
// 	        $('#selectedProId').submit();
	    });

	    interimDeliveryButton.addEventListener('click', function () {
	        // 중간납품 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "중간납품";
// 	        $('#selectedProId').submit();
	    });

	    deliveryButton.addEventListener('click', function () {
	        // 출고완료 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "출고완료";
// 	        $('#selectedProId').submit();
	    });
	});
 
//-------------------------------------------------- 검색 초기화 -----------------------------------
 $("#resetButton").click(function () {
 	$(".buttons").removeClass("highlighted");

     // 클릭한 버튼에 "highlighted" 클래스 추가
     $("#allButton").addClass("highlighted");
 	
     sellStateButton2 = "전체";
 	sellStateButton1 = sellStateButton2;
     
 	$("#sellCode").val('');
 	$("#sellclientCode9999").val('');
 	$("#sellclientCompany9999").val('');
 	$("#prodCode9999").val('');
 	$("#prodName9999").val('');
 	$("#sellDate").val('');
 	$("#sellDuedate").val('');
    $("#sellState").val('');
     firstLoadSellList();
 });
//----------------------------------- 페이지 항목 수 설정 -----------------------------------
 function applyFilters() {
        var perPageValue = document.getElementById("perPageSelect").value;
        var sellCode = "${sellDTO.sellCode}";
        var prodCode = "${sellDTO.prodCode}";
        var clientCode = "${sellDTO.clientCode}";
        var sellDate = "${sellDTO.sellDate}";
        var sellDuedate = "${sellDTO.sellDuedate}";
        var sellState = "${sellDTO.sellState}";

        var url = '${pageContext.request.contextPath}/sell/sellMain?pageNum=1&cntPerPage=' + perPageValue +
            '&sellCode=' + sellCode + '&prodCode=' + prodCode +
            '&clientCode=' + clientCode + '&sellDate=' + sellDate + '&sellDuedate=' + sellDuedate + '&sellState' + sellState;

        // Redirect to the generated URL
        window.location.href = url;
    }

	//엑셀
	// 버튼 클릭 시 실행
	// 클라이언트에서 서버로 데이터 요청
	document.getElementById('exportButton').addEventListener('click', function () {
		
			// 엑셀로 내보낼 데이터
		   var searchParams = {
				 sellCode: $("#sellCode").val(),
				 prodCode: $("#prodCode9999").val(),
				 clientCode: $("#sellclientCode9999").val(),
				 daterange1: $("#sellDate").val(),
				 daterange2: $("#sellDuedate").val(),
				 sellState: $("#sellState").val()			   
			};
		
		    $.ajax({
		        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		        url: "${pageContext.request.contextPath}/sell/excel", // 데이터를 가져올 URL 설정
		        data: searchParams, // 검색 조건 데이터 전달
		        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		        success: function (data) {
		            // 데이터 가공
					var modifiedData = data.map(function (item) {
					    return {
					        '처리 상태': item.sellState,
					        '수주 코드': item.sellCode,
					        '거래처 코드': item.clientCode,
					        '거래처명': item.clientCompany,
					        '제품 코드': item.prodCode,
					        '제품명': item.prodName,
					        '제품 단가': item.prodPrice,
					        '수주 수량': item.sellCount,
					        '수주 단가':item.sellPrice,
					        '수주 일자': item.sellDate,
					        '납기 일자': item.sellDuedate,
					        '담당자': item.sellEmpId,
					        '비고': item.sellMemo
					    };
					});
		            
					// 열의 너비 설정
		            var colWidths = [
					    { wch: 10 }, // 처리 상태
					    { wch: 15 }, // 수주 코드
					    { wch: 15 }, // 거래처 코드
					    { wch: 15 }, // 거래처명
					    { wch: 15 }, // 제품 코드
					    { wch: 15 }, // 제품명
					    { wch: 15 }, // 제품 단가
					    { wch: 10 }, // 수주 수량
					    { wch: 10 }, // 수주 단가
					    { wch: 15 }, // 수주 일자
					    { wch: 15 }, // 납기 일자
					    { wch: 10 }, // 담당자
					    { wch: 20 }  // 비고
					];
					
		            // 새 워크북을 생성
		            var wb = XLSX.utils.book_new();
		            // JSON 데이터를 워크시트로 변환
		            var ws = XLSX.utils.json_to_sheet(modifiedData);
		            // 열 너비 지정
		            ws['!cols'] = colWidths;
		            // 워크북에 워크시트 추가
		            XLSX.utils.book_append_sheet(wb, ws, "데이터 시트");
		            // Blob 형태로 워크북 생성
		            var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
		            // 파일 이름 설정 (원하는 파일 이름으로 변경)
		            var fileName = "sell.xlsx";
		            // Blob 파일을 다운로드
		            saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), fileName);
		        }
		    });
		
	});
	
	// ArrayBuffer 만들어주는 함수
	function s2ab(s) {
	    var buf = new ArrayBuffer(s.length); // convert s to arrayBuffer
	    var view = new Uint8Array(buf); // create uint8array as viewer
	    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; // convert to octet
	    return buf;
	}
	
</script>
	<script>
      //modal창에 열기 위한 이벤트 헨들러
        function openModal(event) {
        	  const clickedElementId = event.target.id;
            if(clickedElementId.startsWith("PR")){
            	//modal_ajax 
            	$.ajax({
            	  url : '${pageContext.request.contextPath}/KDMajax/modalprod',
            	  data: {prodCode:clickedElementId},
            	  type : 'GET',
            	  dataType:'json',
            	  success: function (json) {
                      if (json && typeof json === 'object') {
                    	  
                    	  var dataformat = {
					               
					            	"제품 이름:": json.prodName,
                      "제품 단위": json.prodUnit,
                      "용량": json.prodSize,
                      	"향기 종류": json.prodPerfume,
                      	"거래처 코드":json.clientCode,
                         "창고 코드": json.whseCode,
                         "매출 단가": json.prodPrice,
                          "제품 비고": json.prodMemo
					            };
					    	openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
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
              	  data: {sellCode:clickedElementId},
              	  type : 'GET',
              	  dataType:'json',
              	  success: function (json) {
                        if (json && typeof json === 'object') {
                        	// 값 할당
                        	 var dataformat = {
                        			
                        			 "수주 일자" :json.sellDate,
                                   	"납기 일자" :json.sellDuedate,
                                   	"관리 사원" :json.sellEmpId,
                                   	"수주 수량" :json.sellCount,
                                       "수주 단가" :json.sellPrice,
                                       "제품 코드" :json.prodCode,
                                       "제품 이름" :json.prodName,
                                       "수주 비고" :json.sellMemo,
                                       "출고 상태" :json.sellState,
                                       "거래처 이름" :json.clientCompany,
                                       "거래처 코드" :json.clientCode
					            };
					    	openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
                    	} else {
                      	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                      	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                      	}
                        }
                });	//기존 닫기 창 함수
               
        }   else if(clickedElementId.startsWith("WI")){
        	var result = clickedElementId.substring(clickedElementId.indexOf("WI") + 2);
          	var elementsStartingWithL = [];
// 문자열을 "L"로 분할하여 배열로 만들기
          	var elementss = result.split("L");
// 배열을 순회하며 "L"로 시작하는 부분을 찾아내어 새로운 배열에 저장
          	for (var i = 1; i < elementss.length; i++) {
          	    elementsStartingWithL.push("L" + elementss[i]);
          	}
          	var dataformat = {}; // 빈 객체 생성

          	for (var i = 0; i < elementsStartingWithL.length; i++) {
          	    var key = (i + 1) + "차 라인"; // 키 생성 (1차 라인, 2차 라인, ...)
          	    dataformat[key] = elementsStartingWithL[i]; // 객체에 속성 추가
          	} 
          	openModalWithData(event, dataformat, 200);
         
       
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
                    	var dataformat = {			            	
"원자재 이름" :json.rawName,
	"원자재 종류" :json.rawType,
  	"원자재 단위" :json.rawUnit,
  	"원자재 가격" :json.rawPrice,
      "거래처 코드" :json.clientCode,
      "창고 코드" :json.whseCode,
      "원자재 비고" :json.rawMemo};
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
                  	
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
                    	var dataformat = {			            	
"이름" :json.clientCompany,
	"분류" :json.clientType,
  	"사업자번호" :json.clientNumber,
  	"상세분류" :json.clientDetail,
      "대표이름" :json.clientCeo,
      "담당자" :json.clientName,
      "주소" :json.clientAddr1,
      "상세주소" :json.clientAddr2,
      "대표 번호" :json.clientTel,
      "담당자 번호" :json.clientPhone,
      "팩스" :json.clientFax,
      "이메일" :json.clientEmail,
      "비고" :json.clientMemo
      };
openModalWithData(event, dataformat, 400); // 데이터를 모달로 표시

                  	
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
                    	var dataformat = {			            	

                    			"이름" :json.whseName,
                              	"타입" :json.whseType,
                              	"사용 상태" :json.whseState,
                              	"주소" :json.whseAddr,
                                  "연락처" :json.whseTel,
                                  "비고" :json.whseMemo,
                                  "제품 코드" :json.prodCode,
                                  "원자재 코드" :json.rawCode,
                                  "담당자" :json.whseEmpId
                                  };
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시

                  	
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
        else if(!isNaN(clickedElementId.charAt(0))){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalemp',
          	  data: {empId:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	
                    	var dataformat = {			            	
                    			"이름" :json.empName,
                              	"부서" :json.empDepartment,
                              	"직급" :json.empPosition,
                              	"이메일" :json.empEmail,
                                  "연락처" :json.empTel,
                                  "재직상태" :json.empState,
                                  "입사일" :json.empHiredate};
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시

                  	
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }  else if(clickedElementId.startsWith("WO")){
      	 
      	$.ajax({
      	  url : '${pageContext.request.contextPath}/KDMajax/modalworkorder',
      	  data: {workCode:clickedElementId},
      	  type : 'GET',
      	  dataType:'json',
      	  success: function (json) {
                if (json && typeof json === 'object') {               	// 값 할당
                	var dataformat = {	
                			"제품코드" :json.prodCode,
                	      	"수주코드" :json.sellCode,
                	      	"지시일" :json.workDate,
                	      	"라인코드" :json.lineCode,
                	          "지시수량" :json.workAmount,
                	          "작업지시자" :json.workEmpId,
                	          "추가지시일" :json.workDatechange,
                	          "라인내역" :json.workInfo};
                	openModalWithData(event, dataformat, 200);
	 	} else {
              	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
              	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
              	
              	}
                }
      	  });
    }//기존 닫기 창 함수
       
       
      } 
      
        function openModalWithData(event, data, width) {
            var modal = document.getElementById('myModal');
            var modalContent = document.querySelector('.modal-body');
            
            modalContent.style.width = Math.abs(width) + 'px';
            modal.style.width = (Math.abs(width) + 20) + 'px'; // 20px는 여유 여백이라고 가정
            modalContent.innerHTML = ''; // 기존 내용 제거

            // 데이터를 HTML 표로 구성
            var tableHTML = '<table class="table">';
            for (var key in data) {
                if (data.hasOwnProperty(key)) {
                    tableHTML += '<tr>';
                    tableHTML += '<td>' + key + '</td>';
                    tableHTML += '<td>' + data[key] + '</td>';
                    tableHTML += '</tr>';
                }
            }
            tableHTML += '</table>';

            // 모달 내용에 HTML 표 추가
            modalContent.innerHTML = tableHTML;
         // 바디의 너비
	          var bodyWidth = document.body.clientWidth;
	          
	          // 클릭 이벤트의 위치를 기반으로 모달 창 위치 설정
	        
	          modal.style.setProperty('display', 'block', 'important');
	          if (event.clientX + window.scrollX + width >= bodyWidth) {
	              modal.style.left = (event.clientX + window.scrollX - width) + 'px';
	           
	            
	          } else {
	              modal.style.left = (event.clientX + window.scrollX) + 'px';
	            close1.style.float = 'left';
	            
	             }
	          modal.style.top = (event.clientY + window.scrollY) + 'px';

        }


    		// 모달과 닫기 버튼 가져오기
    		var modal = document.getElementById('myModal');
    		var closeModal = document.getElementById('closeModal');

    		console.log(modal);
    	    // 닫기 버튼을 클릭하면 모달을 숨김
    		closeModal.addEventListener('click', function() {
    		    modal.style.display = 'none';
    		});
    	   
    	 
 </script>

</body>
</html>