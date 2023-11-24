<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/requirement.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">


<!-- /page content -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


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
<jsp:include page="../inc/side.jsp"></jsp:include>
<!-- page content -->
<div class="right_col">

	<h2 style="cursor: pointer; " onclick="location.href='${pageContext.request.contextPath}/workorder/workOrderList'">작업지시 관리</h2>

		
		<form method="get">
			<div class="searchform">
				<input type="hidden" name="input" id="input" value="${input }">
				<label>라인</label> <input type="text" name="search_line" id="search_line" class="input_box" placeholder="라인을 입력하세요." style="cursor: pointer;">
				<label>제품</label> <input type="text" name="search_prod" id="search_prod" class="input_box" placeholder="제품을 선택하세요." onclick="searchItem('prod','search_prod')" style="cursor: pointer;">
				<label>지시일자</label> 
						<input type="text" name="search_fromDate" id="search_fromDate" class="input_box" autocomplete="off" placeholder="기간을 선택하세요." style="cursor: pointer;">
						<label style="margin:0px"> ~ </label> 
						<input style="margin-left:" type="text" name="search_toDate" id="search_toDate" class="input_box" autocomplete="off" placeholder="기간을 선택하세요." style="cursor: pointer;"><br><br>
				<label><input style="width:70px" type="submit"  class="button" name="search_place" id="allButton" value="전체">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="oneButton" value="1차공정">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="twoButton" value="2차공정">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="threeButton" value="3차공정">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="finishButton" value="마감" ></label> 
				<div id="button">
			
				
			
		</div>
		</div>	
		</form>



	<div class="col-md-12">	
	<div style ="margin: 2% 0 0 0;"	>
	<div style="float:right;">
				    <!-- 버튼 제어 -->
						<button style="display: none;" id="add" class="button">추가</button>
						<button style="display: none;" id="modify" class="button">수정</button>
						<button style="display: none;" id="delete" class="button">삭제</button>
						<button style="display: none;" id="cancle" onclick="location.href='${pageContext.request.contextPath}/workorder/workOrderList'" id="cancle" class="button">취소</button>
						<button style="display: none;" type="submit" id="save" class="button">저장</button>
						</div>
						</div>
		<div class="x_panel">
		
				<div class="x_title">
				
					<label style="margin:0px">총 ${paging.total } 건</label>
					<div>
					<label for="perPageSelect" >항목 수:</label>
<select id="perPageSelect" class="input_box" style ="top:1.8px; width:100px; height:22px;" onchange="applyFilters()" value="${paging.cntPerPage}">
    <option value="10" ${paging.cntPerPage == 10 ? 'selected' : ''}>10개</option>
    <option value="50" ${paging.cntPerPage == 50 ? 'selected' : ''}>50개</option>
    <option value="100" ${paging.cntPerPage == 100 ? 'selected' : ''}>100개</option>
    <option value="9999" ${paging.cntPerPage == 9999 ? 'selected' : ''}>전체 보기</option>
</select>
					</div>
					
					
						</div>
					
				
					<script>
					
					</script>
					<!-- 버튼 제어 -->
					

				
				
<div class="x_content">
	<div class="table-responsive">
		<div class="table-wrapper" >

		<form id="fr">
			<input type="hidden" name="empId" value="${sessionScope.id.empId }">
			<table class="table table-striped jambo_table bulk_action" style="text-align-last:center;" id="data-table">
				<thead>
					<tr class="headings">
						<th>번호</th>
						<th>작업지시코드</th>
						<th>라인코드</th>
						<th>수주코드</th>
						<th>제품코드</th>
						<th>지시일</th>
						<th>지시수량</th>
						<th>담당자</th>
						<th>공정</th>
						<th>라인내역</th>
						<c:if test="${sessionScope.empDepartment eq '생산팀' || sessionScope.empDepartment eq '관리자'}">
							<th>마감</th>
						 </c:if>
					</tr>
				</thead>
				<tr style='display: none;'></tr>
				<c:forEach var="w" items="${workList }">
					<tr class="contents">
						<td></td>
						<td id="workCode">${w.workCode }</td>
						<td id="lineCode">${w.lineCode }</td>
						<td style='cursor: pointer;' onclick="openModal(event)" id="${w.sellCode }" name="sellCode" value="${w.sellCode}">${w.sellCode}</td>
						<td style='display: none;' id="${w.prodName }">${w.prodName }</td>
						<td style='cursor: pointer;' onclick="openModal(event)" id="${w.prodCode }" name="prodCode" value="${w.prodCode }">${w.prodCode }</td>
								
						<c:choose>
    <c:when test="${not empty w.workDatechange}">
        <td style="color: red;">${w.workDatechange}</td>
    </c:when>
    <c:otherwise>
        <td>${w.workDate}</td>
    </c:otherwise>
</c:choose>
						
						<td id="workAmount" >${w.workAmount }</td>
						<%-- <td>${w.workEmpId }</td> --%>
						<td style='cursor: pointer;' onclick="openModal(event)" id="${w.workEmpId }" name="workEmpId" value="${w.workEmpId }">${w.workEmpId}</td>	
						<td id="workProcess">${w.workProcess }</td>
						<td style='cursor: pointer; z-index: 10;' onclick="openModal(event)" id="${w.workInfo }" name="workInfo" value="${w.workInfo }">보기</td>
						<c:if test="${sessionScope.empDepartment eq '생산팀' || sessionScope.empDepartment eq '관리자'}">
							<td>
								<c:if test="${w.workProcess != '마감'}">
									<a name="magamBtn" class="magambutton" href="${pageContext.request.contextPath}/workorder/updateStatus?workCode=${w.workCode }&lineCode=${w.lineCode }&workProcess=${w.workProcess}&workInfo=${w.workInfo}&prodCode=${w.prodCode}">공정마감</a>
								</c:if>
							</td>
						</c:if>						
					</tr>
				</c:forEach>
			</table>
		</form>
		</div>
	</div>
</div>

	<div style="float:left;">
 
	<button id="excelDownload" class="button">엑셀</button>
	</div>	
	<script type="text/javascript">
	function applyFilters() {
        var perPageValue = document.getElementById("perPageSelect").value;
        var searchLine = "${search.search_line}";
        var fromDate = "${search.search_fromDate}";
        var toDate = "${search.search_toDate}";
        var place = "${search.search_place}";
        var prod = "${search.search_prod}";

        var url = '${pageContext.request.contextPath}/workorder/workOrderList?nowPage=1&cntPerPage=' + perPageValue +
            '&search_line=' + searchLine + '&search_fromDate=' + fromDate +
            '&search_toDate=' + toDate + '&search_place=' + place + '&search_prod=' + prod;

        // Redirect to the generated URL
        window.location.href = url;
    }
    

    // 페이지 로드 시 실행되는 함수
    
    $.noConflict();
jQuery(document).ready(function($){
    	
    	 var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
 		
		  if (team === "자재팀" || team === "관리자") {
			  $('#add').show();
				$('#modify').show();
				$('#delete').show();
		   }
		  else if (team ===""){
			  window.location.href = "${pageContext.request.contextPath}/login/logout";
		  }
    	 
		 
        
    	 $("[name='magamBtn']").on("click", function(event) {
    	        event.preventDefault(); // 기존 링크 동작을 막음

    	        // 링크의 href 속성값을 가져옴
    	        var url = $(this).attr("href");

    	        // AJAX 요청
    	        $.ajax({
    	            type: "GET", // 또는 "POST" - HTTP 요청 방식 선택
    	            url: url,
    	            dataType: "text",
    	            success: function(response) {
    	            	 if(response === "")
    	            		 {
    	            			Swal.fire({
    								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "사용가능한 라인이 없습니다"+ "</div>",
    								icon: 'info',
    								confirmButtonColor: '#9AC5F4',
    								width: '400px',
    							}).then((result) => {
    							    if (result.isConfirmed) {
    							        // 확인 버튼을 눌렀을 때 특정 주소로 이동
    							    	window.location.href = window.location.href;
    							    }
    							});
    	            		 
    	            		 }
    	            	 else{
    	            	 window.location.href = window.location.href;
    	            	 }
    	             },
    	             error: function(error) {
    	                 console.error("AJAX 요청 실패:", error);
    	                 // 실패에 대한 처리를 추가하세요.
    	             }
    	        });
    	    });
    	 
    	$('table tr').each(function(index){
    		var num = "<c:out value='${paging.nowPage}'/>";
    		var num2 = "<c:out value='${paging.cntPerPage}'/>";
    		$(this).find('td:first').text(((num-1)*num2) + index-1);
    		num3 = ((num-1)*num2) + index;
    	});
    	
		
    	var button = document.getElementById("allButton");
    	    <c:if test="${search.search_place == '1차공정'}">
    var button = document.getElementById("oneButton");
</c:if>
<c:if test="${search.search_place == '2차공정'}">
var button = document.getElementById("twoButton");
</c:if>
<c:if test="${search.search_place == '3차공정'}">
var button = document.getElementById("threeButton");
</c:if>
<c:if test="${search.search_place == '마감'}">
var button = document.getElementById("finishButton");
</c:if>
button.style.backgroundColor = "#4D4D4D";
});
    
  

		
		//엑셀
		const excelDownload = document.querySelector('#excelDownload');
		
		document.addEventListener('DOMContentLoaded', ()=> {
			excelDownload.addEventListener('click', exportExcel);
		});
		
		function exportExcel() {
			var searchLine = "${search.search_line}";
	        var fromDate = "${search.search_fromDate}";
	        var toDate = "${search.search_toDate}";
	        var place = "${search.search_place}";
	        var prod = "${search.search_prod}";
	     // 엑셀로 내보낼 데이터
		    var searchParams = {
		    		searchLine: searchLine,
		    		fromDate: fromDate,
		    		toDate: toDate,
		    		place: place, 
		    		prod: prod
		    };
		    console.log(searchParams);
	     	
		    $.ajax({
		        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		        url: "${pageContext.request.contextPath}/workorder/workOrderExcel", // 데이터를 가져올 URL 설정
		        data: JSON.stringify(searchParams), // 데이터를 JSON 문자열로 변환,
		        dataType: "json",
		        contentType: "application/json", // JSON 형식으로 요청을 전송
		        success: function (data) {
		        	// 데이터 가공
					var modifiedData = data.map(function (item) {
					    return {
					        '작업지시 코드': item.workCode,
					        '라인 코드': item.lineCode,
					        '수주 코드': item.sellCode,
					        '제품 코드': item.prodCode,
					        '지시일': item.workDate,
					        '지시 수정일': item.workDatechange,
					        '지시 수량':item.workAmount,
					        '담당자': item.workEmpId,
					        '공정': item.workProcess,
					        '마감': item.workProcess,
					        '라인내역': item.workInfo,
					    };
					});
		            
					// 열의 너비 설정
		            var colWidths = [
		            	{ wch: 15 }, // 작업지시 코드
		                { wch: 10 }, // 라인 코드
		                { wch: 15 }, // 수주 코드
		                { wch: 10 }, // 제품 코드
		                { wch: 10 }, // 지시일
		                { wch: 10 }, // 지시 수정일
		                { wch: 10 }, // 지시 수량
		                { wch: 10 }, // 담당자
		                { wch: 10 }, // 공정
		                { wch: 10 }, // 마감
		                { wch: 30 } // 라인내역
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
		            var fileName = 'workOrderList'+getToday()+'.xlsx';;
		            // Blob 파일을 다운로드
		            saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), fileName);
		        }
		    });
		}
		// ArrayBuffer 만들어주는 함수
		
		function s2ab(s) {
			var buf = new ArrayBuffer(s.length); // convert s to arrayBuffer
		    var view = new Uint8Array(buf); // create uint8array as viewer
		    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; // convert to octet
		    return buf;
		} //s2ab(s)
	</script>
	
	
	<div id="pagination" class="page_wrap">
			<div class="page_nation">
						<c:if test="${paging.startPage != 1 }">
							<a class="arrow prev" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">◀️</a>
						</c:if>
						
						
						<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
    <c:choose>
        <c:when test="${p eq paging.nowPage}">
            <a class="a active" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">${p}</a>
        </c:when>
        <c:otherwise>
            <a class="a" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">${p}</a>
        </c:otherwise>
    </c:choose>
</c:forEach>
						<c:if test="${paging.endPage != paging.lastPage}">
							<a class="arrow next" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${paging.endPage + 1 }&cntPerPage=${paging.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">▶️</a>
						</c:if>
					</div>
			</div>
	
	
	
</div>

</div>

	
	
</div>
 <%
        // 세션에서 'empId' 속성을 가져와서 JavaScript 변수에 할당
        String empId = (String) session.getAttribute("empId");
    %>

    <!-- JavaScript 변수에 세션 'empId' 속성 값 할당 -->
    <script>
        var workEmpId = '<%= empId %>';
        // 이제 workEmpId 변수를 JavaScript 코드에서 사용할 수 있습니다.
    </script>
<script type="text/javascript">
	//========================= 함수, 상수 ==================================//
	// 팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

	//오늘 날짜 yyyy-mm-dd
	function getToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);

		return year + "-" + month + "-" + day;
	} //getToday()
	
	//날짜 + 시간 + 분 + 초 ==> 코드
	function codeCreation() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var time = ("0" + date.getHours()).slice(-2);
		var minute = ("0" + date.getMinutes()).slice(-2);
		var second = ("0" + date.getSeconds()).slice(-2);
		
		return year + month + day + time + minute + second;
	}
	
	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"8888' value='"+value+"' class='input-row'>";
		obj.html(inputBox);
	} //inputCng

	
	
	

	
	//========================= 함수, 상수 ==================================//
	
	//jQuery
	$(function() {
		const shortagemessage = ""
		
		

		/////////////// 추가 /////////////////////////////////////
		$('#add').click(function() {

			$('#modify').hide();
			$('#add').hide();
			$('#delete').hide();
			$('#cancle').show();
			$('#save').show();

			let today = getToday();

			
				
				var tbl = "<tr>";
				// 번호
				tbl += " <td style>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='workCode' id='workCode' readonly value='";
				tbl += "WO" + codeCreation();
				tbl += "' >";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='lineCode' id='lineCode8888' readonly >";
				tbl += " </td>";
				// 수주코드
				tbl += " <td>";
				tbl += "  <input type='text'  placeholder='수주코드를 선택하세요.' class='input-row' name='sellCode' id='sellCode8888' required readonly >";
				tbl += " </td>";
				// 제품명
				tbl += " <td style='display: none;'>";
				tbl += "  <input type='hidden' name='prodName' id='prodName8888'>";
				tbl += " </td>";
				// 제품코드
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='prodCode' id='prodCode8888' readonly>";
				tbl += " </td>";
				// 지시일
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='workDate' id='workDate' readonly value='";
				tbl += today;
				tbl += "' >";
				tbl += " </td>";
				// 지시수량
				tbl += " <td>";
				tbl += "  <input type='number' class='input-row' value='1' min='1' name='workAmount' id='workAmount8888' required >";
				tbl += " </td>";
				// 담당자
				tbl += " <td>";
				tbl += "  <input type='text' class='input-row' value='1' min='1' name='workEmpId' id='workEmpId8888' required value='<%= empId %>' >";
				tbl += " </td>";
				//공정
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' value='1차공정' readonly >";
				tbl += " </td>";
				//라인내역
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' value='' readonly >";
				tbl += " </td>";
				//마감
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' value='' readonly >";
				tbl += " </td>";
			
				$('table').append(tbl);
				var lineCode
				//1차공정공정 라인 중 사용 가능한 라인 입력
				$.ajax({
					url: "${pageContext.request.contextPath}/workorder/getLine",
					type: "post",
					dataType: "text",
					success: function(data) {
						$('#lineCode8888').val(data);
						lineCode = $('#lineCode8888').val();
						if (lineCode == ""){
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "사용가능한 라인이 없습니다"+ "</div>",
								icon: 'info',
								confirmButtonColor: '#9AC5F4',
								width: '400px',
							}).then((result) => {
							    if (result.isConfirmed) {
							        // 확인 버튼을 눌렀을 때 특정 주소로 이동
							    	window.location.href = window.location.href;
							    }
							});
						}
					}
				});
				
				
				
			
				$('#sellCode8888').click(function() {
					searchItem("sell", "sellCode8888");
				});
				
		

			// 저장 -> form 제출하고 저장함
			$('#save').click(function() {

				var prodName = $('#prodName8888').val();
				var prodCode = $('#prodCode8888').val();
				
				var sellCode = $('#sellCode8888').val();
				var workAmount = $('#workAmount8888').val();
				
				
			
					if (sellCode == "" || workAmount == "") {
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
								icon: 'info',
								confirmButtonColor: '#9AC5F4',
								width: '400px',
							})
						} else {
							$.ajax({
							    type: "GET",
							    url: "${pageContext.request.contextPath}/workorder/checkStock", // 서버의 컨트롤러 매핑 경로
							    data: {
							        prodCode: prodCode, // 완제품 코드
							        workAmount: workAmount // 지시수량
							    },
							    contentType : "application/json; charset=UTF-8",
								dataType : "json",
							    success: function(response) {
							        // 서버에서 받은 응답 처리
							        if (response.status === "success") {
							            // 성공적인 응답을 받은 경우
							            var shortages = response.data;
							            var shortagemessage = ""
							            for (var i = 0; i < shortages.length; i++) {
							                var shortage = shortages[i];
							                
							                shortagemessage += "부족한 원자재코드: " + shortage.rawCode + "\nㄴ부족한 수량: " + shortage.shortageAmount + "개\n";
							                
							            }
							            if(shortages == ""){
							            	$('#fr').attr("action", "${pageContext.request.contextPath}/workorder/add");
											$('#fr').attr("method", "post");
											$('#fr').submit();
							            	
							            }
							            else{
							            Swal.fire({
							                title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ shortagemessage + "재고가 부족합니다.\n발주등록 페이지로\n이동하시겠습니까?</div>",
							                icon: 'info',
							                showDenyButton: true,
							                confirmButtonColor: '#9AC5F4',
							                cancelButtonColor: '#73879C',
							                confirmButtonText: 'Yes',
							                width: '400px'
							            }).then((result) => {
							                // confirm => 예를 눌렀을 때
							                if (result.isConfirmed) {
							                    location.href = "${pageContext.request.contextPath}/OrderManagement/home";
							                } else {
							                    var url = new URL(window.location.href);
							                    var searchParams = new URLSearchParams(url.search);
							                    searchParams.delete("woInsert");
							                    var newUrl = url.origin + url.pathname;

							                    window.location.href = newUrl;
							                }
							            });
							            }
							           							            	

							        } else {
							            // 실패한 경우
							             alert("부족한 원자재 정보를 가져오는데 실패했습니다.");
							             
							        }
							    },
							    error: function() {
							        // Ajax 요청 실패 시 처리
							         alert("Ajax 요청에 실패했습니다.");
							    }
							});
						 }
					
				}); 
				//save
		}); //add click

		
		
		var isExecuted = false;
		/////////////// 수정 //////////////////////////////
		//수정버튼 클릭
		$('#modify').click(function() {
			Swal.fire({
				 title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "수정할 행을 선택해주세요"+ "</div>",
				  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
		  icon: 'info', // 아이콘! 느낌표 색? 표시?
	            confirmButtonColor: '#9AC5F4',
	         });		  
			$('#delete').hide();
			$('#modify').hide();
			$('#add').hide();
			$('#cancle').show();
			$('#save').show();

			//행 하나 클릭했을 때	
			//:not(:first-child)
			$('table tr').click(function() {

				//하나씩만 선택 가능
				if(!isExecuted) {
					isExecuted = true;
					
					$(this).addClass('selected');
					//작업지시 코드 저장
					let updateCode = $(this).find('#workCode').text().substring(0,16).trim();
					console.log(updateCode);
	
					var jsonData = {
						workCode : updateCode
					};
	
					var self = $(this);
	
					$.ajax({
						url : "${pageContext.request.contextPath}/workorder/detail",
						type : "post",
						contentType : "application/json; charset=UTF-8",
						dataType : "json",
						data : JSON.stringify(jsonData),
						success : function(data) {
							// alert("*** 아작스 성공 ***");
	
							var preVOs = [
									data.workCode,
									data.lineCode,
									data.sellCode,
									data.prodCode,
									data.prodName,
									data.workDate,
									data.workAmount,
									data.workEmpId,
									data.workProcess,
									"",
									""
								];
	
							var names = [
									"workCode",
									"lineCode",
									"sellCode",
									"prodCode",
									"prodName",
									"workDate",
									"workAmount",
									"workEmpId",
									"workProcess",
									"workInfo",
									"magam"
								];
	
							//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
							self.find('td').each(function(idx,item) {
	
								if (idx > 0) {
									inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
									
									//지시수량 제외하고 readonly 속성 부여
									$(this).find("input").each(function(){
										if($(this).attr("name") != "workAmount") {
											$(this).attr("readonly", true);
											$(this).attr("style","background-color:rgba(0, 0, 0, 0);");
										}
										else if($(this).attr("name") == "workAmount") {
											$(this).attr("type", "number");
											$(this).attr("min", "1");
											}
										
									}); //readonly
									
								} //라인코드부터 다 수정 가능하게
							}); // self.find(~~)
	
						},
						error : function(data) {
							alert("아작스 실패 ~~");
						}
					}); //ajax
	
					//저장버튼 -> form 제출
					$('#save').click(function() {

						var prodCode = $('#prodCode8888').val();
						var workAmount = $('#workAmount8888').val();
						if(workAmount <= 0){
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "1이상의 값을 입력해주세요"+ "</div>",
								icon: 'info',
								confirmButtonColor: '#9AC5F4',
								width: '400px',
							})
							}
						else{
							$.ajax({
							    type: "GET",
							    url: "${pageContext.request.contextPath}/workorder/checkStock", // 서버의 컨트롤러 매핑 경로
							    data: {
							        prodCode: prodCode, // 완제품 코드
							        workAmount: workAmount // 지시수량
							    },
							    contentType : "application/json; charset=UTF-8",
								dataType : "json",
							    success: function(response) {
							        // 서버에서 받은 응답 처리
							        if (response.status === "success") {
							            // 성공적인 응답을 받은 경우
							            var shortages = response.data;
							            var shortagemessage = ""
							            for (var i = 0; i < shortages.length; i++) {
							                var shortage = shortages[i];
							                
							                shortagemessage += "부족한 원자재코드: " + shortage.rawCode + "\nㄴ부족한 수량: " + shortage.shortageAmount + "개\n";
							                
							            }
							            if(shortages == ""){
							            	$('#fr').attr("action","${pageContext.request.contextPath}/workorder/modify");
											$('#fr').attr("method","post");
											$('#fr').submit();
							            	
							            }
							            else{
							            Swal.fire({
							                title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ shortagemessage + "재고가 부족합니다.\n발주등록 페이지로\n이동하시겠습니까?</div>",
							                icon: 'info',
							                showDenyButton: true,
							                confirmButtonColor: '#9AC5F4',
							                cancelButtonColor: '#73879C',
							                confirmButtonText: 'Yes',
							                width: '400px'
							            }).then((result) => {
							                // confirm => 예를 눌렀을 때
							                if (result.isConfirmed) {
							                    location.href = "${pageContext.request.contextPath}/OrderManagement/home";
							                } else {
							                    var url = new URL(window.location.href);
							                    var searchParams = new URLSearchParams(url.search);
							                    searchParams.delete("woInsert");
							                    var newUrl = url.origin + url.pathname;

							                    window.location.href = newUrl;
							                }
							            });
							            }
							           							            	

							        } else {
							            // 실패한 경우
							             alert("부족한 원자재 정보를 가져오는데 실패했습니다.");
							             
							        }
							    },
							    error: function() {
							        // Ajax 요청 실패 시 처리
							         alert("Ajax 요청에 실패했습니다.");
							    }
							});
							
						}
	 
						
	
					}); //save

				} //하나씩만 선택 가능
			

			}); //tr click

		}); //modify click

		
		
		/////////////// 삭제 //////////////////////////////
		$('#delete').click(function() {
			$('#delete').hide();
			$('#modify').hide();
			$('#add').hide();
			$('#cancle').show();
			$('#save').show();
	
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
				$('table tr').each(function() {
					var code = $(this).find('td:nth-child(2)').text().substring(0,16).trim();
	
					var tbl = "<input type='checkbox' name='selected' value='";
					tbl += code;
					tbl += "'>";
					
					$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
					$(this).find('td:first').html(tbl);
				});
				
				//전체선택
				$('#selectAll').click(function() {
					var checkAll = $(this).is(":checked");
					
					if (checkAll) {
						$('input:checkbox').prop('checked', true);
					} else {
						$('input:checkbox').prop('checked', false);
					}
				});
	
				//저장 -> 삭제
				$('#save').click(function() {
					
					var checked = [];
	
					$('input[name=selected]:checked').each(function() {
						console.log("check => " + $(this).val());
						checked.push($(this).val());
					});
					
// 					
					
	
					// alert창 꾸미기~
					if(checked.length > 0){
						
						Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
									  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
							  icon: 'info', // 아이콘! 느낌표 색? 표시?
							  showDenyButton: true,
							   confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정
  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
	 						  cancelButtonText: 'No', // cancel 버튼 텍스트 지정
							  width : '400px', // alert창 크기 조절
							  
							}).then((result) => {
						
						 /* confirm => 예 눌렀을 때  */
						  if (result.isConfirmed) {
							  
						  
							$.ajax({
		 						url: "${pageContext.request.contextPath}/workorder/delete",
		 						type: "POST",
		 						data: {checked : checked},
		 						dataType: "text",	
		 						success: function () {
		 							Swal.fire({
										  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
										  icon: 'success',
										  confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정

										  width : '400px',
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
										confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정

										width: '400px',
										});
									
								}
							});//ajax
							  } else if (result.isDenied) {
									Swal.fire({
									title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
									confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정
									  
									icon : 'error',
									width: '400px',
									});
						}// if(confirm)
					});		
							
					}// 체크OOO
					else{
						Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
							icon : 'warning',
							confirmButtonColor: '#9AC5F4',
							width: '400px',
							});
					}// 체크 XXX
		
				}); // save
				

			
		}); //delete click

		//============================ 버튼 구현 ====================================//

		//============================ 검색 =========================================//


		//지시일자 이날부터
		$('#search_fromDate').datepicker({
			showOn: 'focus',
			changeMonth:false,
			changeYear:false,
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			yearSuffix: '년',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			onSelect: function(date, inst) {
				$('#search_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
			}
		});
		
		//이날까지
		$('#search_toDate').datepicker({
			showOn: 'focus',
			changeMonth:false,
			changeYear:false,
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			yearSuffix: '년',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
		
		
		//검색 결과 없을 때
		if(Number($('#total').text())==0) {
			$('#searchCnt').html("검색 결과가 없습니다.");
		}
		
		//============================ 검색 =========================================//
		
		
		//작업지시코드 클릭시 상세조회
		
		
		
	}); //jQuery
	
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
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시

                  	
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
    		    var close1 = document.getElementById('closeModal');
    		    var modalContent = document.querySelector('.modal-body');
    		    
    		    modalContent.style.width = width + 'px';
    		    modal.style.width = (width + 20) + 'px'; // 20px는 여유 여백이라고 가정
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
  	              close1.style.float = 'right';
  	  	            
  	           
  	            
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
    	    
    		
    		/* window.addEventListener('click', function(event) {
    		    if (event.target != modal && !modal.contains(event.target)) {
    		        modal.style.display = 'none';
    		    }
    		}); */
     </script>
</body>
</html>


