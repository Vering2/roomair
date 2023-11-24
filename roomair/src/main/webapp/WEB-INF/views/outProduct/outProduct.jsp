<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/outProduct.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- SheetJS CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<!-- FileSaver.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
<!-- SweetAlert  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<%
String empId = "";
if (session.getAttribute("empId") != null) {
	empId = (String) session.getAttribute("empId");
}
%>


<title>출고 페이지</title>
</head>
<body>
	<!-- 사이드바 -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<!-- 사이드바 -->
	<div id="con">
		<h2><a href="${pageContext.request.contextPath}/outProduct/list" style=" text-decoration: none; color:black;">출고 관리</a></h2>
<!-- 		<hr> -->
		<div id="searchForm">
				<label>출고 코드 </label><input type="text" name="outCode" id="outCode">
				<label>제품명 </label><input type="text" name="prodName" id="prodName9999" placeholder="제품명" onclick="searchItem('prod','prodCode9999')" readonly="readonly">
				<label>거래처명 </label><input type="text" name="clientCompany" id="sellclientCompany9999" placeholder="거래처명" onclick="searchItem('sellclient','sellclientCode9999')" readonly="readonly">
				<input type="button" value="조회" id="searchButton">
				<input type="button" value="초기화" id="resetButton">
		</div>
<!-- 		<hr> -->
		<div id="buttons">
			<input type="button" class="buttons highlighted" value="전체" id="allButton">
    		<input type="button" class="buttons " value="미출고" id="non_deliveryButton">
    		<input type="button" class="buttons " value="중간납품" id="interim_deliveryButton">
    		<input type="button" class="buttons " value="출고완료" id="deliveryButton">
    		
		</div>
<!-- 		<h3 style="padding-left:2%"><small id="listCount">총 3건</small></h3> -->
		<label style="padding-left:2%" id="listCount">총 3건</label>
		<div id="outProductList">
			<table>
				<thead>
					<tr>
						<td>출고 코드</td>
						<td>수주 코드</td>
						<td>거래처 코드</td>
<!-- 						<th>거래처명</th> -->
						<td>제품 코드</td>
<!-- 						<th>제품명</th> -->
						<td>주문 수량</td>
						<td>출고 수량</td>
						<td>재고 수량</td>
						<td>납품가</td>
						<td>납품 예정일</td>
						<td>출고 날짜</td>
						<td>담당자</td>
						<td>출고 여부</td>
						<td>상세정보</td>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
		<div id="paging">
			<input type="button" value="엑셀" id="exportButton">
   			<ul id="paging_ul">
    		</ul>
		</div>
	</div>
	
	
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
	
		<script type="text/javascript">
			var empId = "<%= empId %>";
		    if (empId == '') {
		   		window.location.href = "<%= request.getContextPath() %>/login/login";
		    }
		    
		    
		    var sellStateButton1 = "전체";
		    $(document).ready(function () {
		        var sellStateButton2 = "전체"
		    	// 페이지 로드 시 초기 게시판 데이터를 가져오기 위한 함수 호출
		        firstLoadOutProductList();
				
		        
		    	
		        // 검색 버튼 클릭 시 게시판 데이터를 검색하여 업데이트
		        $("#searchButton").click(function () {
		        	// 검색 조건을 가져오기 (이 부분을 필요에 따라 구현)
		        	$(".buttons").removeClass("highlighted");

			        // 클릭한 버튼에 "highlighted" 클래스 추가
			        $("#allButton").addClass("highlighted");
			        
		        	sellStateButton2 = "검색";
		        	sellStateButton1 = sellStateButton2;
		        	
			        var searchParams = {
			            outCode: $("#outCode").val(),
			            prodName: $("#prodName9999").val(),
			            clientCompany: $("#clientCompany9999").val(),
			            sellState: sellStateButton2,
			        };
					console.log(searchParams);
		            loadOutProductList(searchParams);
		        });
		        
		        // 취소 리셋 버튼을 누르면 검색창들의 값을 다 지운다
		        $("#resetButton").click(function () {
		        	$(".buttons").removeClass("highlighted");

			        // 클릭한 버튼에 "highlighted" 클래스 추가
			        $("#allButton").addClass("highlighted");
		        	
			        sellStateButton2 = "전체";
		        	sellStateButton1 = sellStateButton2;
			        
		        	$("#outCode").val('');
	                $("#prodName9999").val('');
	                $("#clientCompany9999").val('');
	                
	                firstLoadOutProductList();
		        });
		        
		        
				
		    	// Enter 키 이벤트를 감지할 input 요소에 이벤트 리스너 등록
		        $("#outCode, #prodName9999, #clientCompany9999").on('keydown', function (e) {
		            if (e.key === 'Enter') {
		                e.preventDefault(); // 엔터 키 기본 동작을 막음 (폼 제출 방지)
		                $("#searchButton").click(); // 검색 버튼 클릭
		            }
		        });
		        
		    	
		     // 버튼 클릭 시 클래스를 관리
		        $(".buttons").click(function () {
		          // 모든 버튼의 "highlighted" 클래스 제거
		          $(".buttons").removeClass("highlighted");

		          // 클릭한 버튼에 "highlighted" 클래스 추가
		          $(this).addClass("highlighted");
		        });
		        
		     	// 전체 버튼 클릭 시
		        $("#allButton").click(function () {
		            // 전체 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "총검색";
		        	sellStateButton1 = sellStateButton2;
		        	
		            // 검색 조건을 설정하고 전체 목록을 가져오도록 수정
		            var searchParams = {
		            	outCode: $("#outCode").val(),
					    prodName: $("#prodName9999").val(),
					    clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 전체 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		     	// 미출고 버튼 클릭 시
		        $("#non_deliveryButton").click(function () {
		            // 미출고 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "미출고";
		        	sellStateButton1 = sellStateButton2;
		            // 검색 조건을 설정하고 미출고 목록을 가져오도록 수정
		            var searchParams = {
		                outCode: $("#outCode").val(),
		                prodName: $("#prodName9999").val(),
		                clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 미출고 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		     	// 중간납품 버튼 클릭 시
		        $("#interim_deliveryButton").click(function () {
		            // 중간납품 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "중간납품";
		        	sellStateButton1 = sellStateButton2;
		            // 검색 조건을 설정하고 중간납품 목록을 가져오도록 수정
		            var searchParams = {
		                outCode: $("#outCode").val(),
		                prodName: $("#prodName9999").val(),
		                clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 중간납품 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		     	// 출고완료 버튼 클릭 시
		        $("#deliveryButton").click(function () {
		            // 출고완료 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "출고완료";
		        	sellStateButton1 = sellStateButton2;
		            // 검색 조건을 설정하고 출고완료 목록을 가져오도록 수정
		            var searchParams = {
		                outCode: $("#outCode").val(),
		                prodName: $("#prodName9999").val(),
		                clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 출고완료 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		    });
		
	// 	    처음 게시판 데이터를 서버에서 비동기적으로 가져오는 함수
		    function firstLoadOutProductList() {
		    	 var searchParams = {
	                outCode: $("#outCode").val(),
	                prodName: $("#prodName9999").val(),
	                clientCompany: $("#clientCompany9999").val(),
	                sellState: "전체"
	            };
				
		        $.ajax({
		            type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		            url: "${pageContext.request.contextPath}/outProduct/listSearch", // 데이터를 가져올 URL 설정
		            data: searchParams, // 검색 조건 데이터 전달
		            dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		            success: function (data) {
		                // 서버로부터 데이터를 성공적으로 가져왔을 때 실행되는 콜백 함수
		                // 데이터를 사용하여 게시판 업데이트
		                updateOutProductList(data);
		            },
		            error: function (error) {
		                // 데이터 가져오기 실패 시 실행되는 콜백 함수
		                console.error("Error fetching data: " + error);
		            }
		        });
		    }
		    
	// 	    게시판 데이터를 서버에서 비동기적으로 가져오는 함수
		    function loadOutProductList(searchParams) {
		    	
		        $.ajax({
		            type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		            url: "${pageContext.request.contextPath}/outProduct/listSearch", // 데이터를 가져올 URL 설정
		            data: searchParams, // 검색 조건 데이터 전달
		            dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		            success: function (data) {
		                // 서버로부터 데이터를 성공적으로 가져왔을 때 실행되는 콜백 함수
		                // 데이터를 사용하여 게시판 업데이트
		                updateOutProductList(data);
		            },
		            error: function (error) {
		                // 데이터 가져오기 실패 시 실행되는 콜백 함수
		                console.error("Error fetching data: " + error);
		            }
		        });
		    }
		
		    // 게시판을 업데이트하는 함수
		    function updateOutProductList(data) {
		        // 서버에서 받은 데이터를 사용하여 게시판 업데이트 (이 부분을 필요에 따라 구현)
		
		        // 예제: 테이블의 tbody를 비우고 새로운 데이터로 채우기
		        var tbody = $("#outProductList tbody");
		        tbody.empty(); // 기존 데이터를 비웁니다.
		
		        // 데이터를 반복하여 새로운 행을 생성합니다.
		        for (var i = 0; i < data.length; i++) {
		        	// 리스트를 출력하는 조건부분
	        		if(i < data.length-1){
	        			
			            var row = $("<tr>");
			            row.append("<td>" + (data[i].outCode ? data[i].outCode : '-') + "</td>");
			            row.append("<td>" + (data[i].sellCode ? data[i].sellCode : '-') + "</td>");
			            row.append("<td onclick='getInfo(event, \"" + (data[i].clientCode ? data[i].clientCode : '-') + "\")' style='cursor:pointer;'>" + (data[i].clientCode ? data[i].clientCode : '-') + "</td>");
// 			            row.append("<td onclick='getInfo(event, \"" + (data[i].clientCode ? data[i].clientCode : '-') + "\")'>" + (data[i].clientCode ? data[i].clientCode : '-') + "</td>");
// 			            row.append("<td onclick='getInfo(\"" + (data[i].clientCode ? data[i].clientCode : '-') + "\")'>" + (data[i].clientCode ? data[i].clientCode : '-') + "</td>");
// 			            row.append("<td onclick="getInfo(data[i].clientCode ? data[i].clientCode : '-')">" + (data[i].clientCode ? data[i].clientCode : '-') + "</td>");
// 			            row.append("<td>" + (data[i].clientCompany ? data[i].clientCompany : '-') + "</td>");
			         	row.append("<td onclick='getInfo(event, \"" + (data[i].prodCode ? data[i].prodCode : '-') + "\")' style='cursor:pointer;'>" + (data[i].prodCode ? data[i].prodCode : '-') + "</td>");
// 			         	row.append("<td onclick='getInfo(\"" + (data[i].prodCode ? data[i].prodCode : '-') + "\")'>" + (data[i].prodCode ? data[i].prodCode : '-') + "</td>");
// 			            row.append("<td onclick="getInfo(data[i].prodCode ? data[i].prodCode : '-')">" + (data[i].prodCode ? data[i].prodCode : '-') + "</td>");
// 			            row.append("<td>" + (data[i].prodName ? data[i].prodName : '-') + "</td>");
			            row.append("<td>" + (data[i].sellCount ? data[i].sellCount : '-') + "</td>");
			            row.append("<td>" + (data[i].outCount ? data[i].outCount : '-') + "</td>");
			            row.append("<td>" + (data[i].stockCount ? data[i].stockCount : '-') + "</td>");
			            row.append("<td>" + (data[i].outPrice ? formatCurrency(data[i].outPrice) : '-') + "</td>");
			            row.append("<td>" + (data[i].sellDuedate ? data[i].sellDuedate : '-') + "</td>");
			            row.append("<td>" + (data[i].outDate ? data[i].outDate : '-') + "</td>");
			            row.append("<td>" + (data[i].outEmpId ? data[i].outEmpId : '-') + "</td>");
			            row.append("<td>" + (data[i].sellState ? data[i].sellState : '-') + "</td>");
		

			            
			            // 상세정보 버튼 추가 
			            var contextPath = "${pageContext.request.contextPath}";
		  				var outCode = data[i].outCode;
		               
		  				(function(outCode) {
		  			        var button = $("<input type='button' value='상세정보'>");
		  			        button.click(function () {
		  			            // 버튼 클릭 시 처리할 동작을 여기에 추가
		  			            window.open(contextPath + "/outProduct/outProductContent?outCode=" + outCode, "출고 상세정보", "width=500,height=730,toolbar=no,location=no,resizable=yes");
		  			        });
		
		  			        // 버튼을 새로운 <td> 요소 내에 추가하고, 그 <td>를 행에 추가
		  			        var buttonCell = $("<td>").append(button);
		  			        row.append(buttonCell);
		  			    })(data[i].outCode);
		            //	tbody에 행을 추가합니다.
		            	tbody.append(row);
	        		}else if(i == data.length-1){// 마지막에 페이징 처리데이터가 들어가있다
		        		// 마지막 행은 페이징 정보를 추가합니다.
		        		var outCode = data[i].outCode;			//검색한 출고번호
			            var prodName = data[i].prodName;			//검색한 상품이름
			            var clientCompany = data[i].clientCompany; //검색한 거래처이름
			            var sellState = data[i].sellState;		  //검색한 출고 상태
		        		var prev = data[i].startPage - data[i].pageBlock;
		        		var next = data[i].startPage + data[i].pageBlock;
		        		var currentPage = data[i].currentPage;
		        		
		        		var listCountElement = document.getElementById("listCount");
		        		listCountElement.textContent = "총 " + data[i].count + "건"; // 내용을 원하는 형식으로 변경
		        		
		        		var pagingUL = $("#paging_ul");
		        		pagingUL.empty(); // 기존 페이징 데이터를 비웁니다.

		        		if (data[i].startPage > data[i].pageBlock) {
		        		    var prevLink = $("<a href='javascript:void(0);'><</a>");
		        		    var prevListItem = $("<li>").append(prevLink);
		        		    prevListItem.click(function() {
		        		        loadPage(outCode, prodName, clientCompany, prev);
		        		    });
		        		    pagingUL.append(prevListItem); // 'Prev' 링크를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
		        		}

		        		for (let page = data[i].startPage; page <= data[i].endPage; page++) {
		        		    let pageLink = $("<a href='javascript:void(0);'>" + page + "</a>");
		        		    var pageListItem = $("<li>").append(pageLink);
		        		    
// 		        		    // 현재 페이지 표시
// 		        		    if (page === currentPage) {
// 		        		        pageLink.addClass("current-page"); 
// 		        		    }
		        		    
		        		    pageListItem.click(function() {
		        		        loadPage(outCode, prodName, clientCompany, page);
		        		    });
		        		 	// 현재 페이지 표시
		        		    if (page === currentPage) {
						        pageListItem.attr("id", "current-page");
						    }
		        		    
		        		    pagingUL.append(pageListItem); // 각 페이지 번호를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
		        		}

		        		if (data[i].endPage < data[i].pageCount) {
		        		    var nextLink = $("<a href='javascript:void(0);'>></a>");
		        		    var nextListItem = $("<li>").append(nextLink);
		        		    nextListItem.click(function() {
		        		        loadPage(outCode, prodName, clientCompany, next);
		        		    });
		        		    pagingUL.append(nextListItem); // 'Next' 링크를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
		        		}


		               
		        	}
		        	
		        }
	
		    }
		    function loadPage(outCode, prodName, clientCompany, page) {
		    	console.log(outCode);
		    	console.log(sellStateButton1);
		    	console.log(prodName);
		    	console.log(clientCompany);
		    	console.log(page);
		    	
		        var searchParams = {
		            outCode: outCode,
		            prodName: prodName,
		            clientCompany: clientCompany,
		            pageNum: page,
		            sellState: sellStateButton1,
		        };
		        loadOutProductList(searchParams);
		    }
		    
		 	// 숫자를 ###,### 원 형식으로 포맷하는 함수
		    function formatCurrency(number) {
		        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원';
		    }
		 	
		 // 팝업 옵션
		    const popupOpt = "top=60,left=140,width=720,height=600";

		    //검색 팝업
		    	function searchItem(type, inputId) {
		    	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
		    	var popup = window.open(url, "", popupOpt);
		    } //openWindow()
		 	

		//엑셀
		// 버튼 클릭 시 실행
		// 클라이언트에서 서버로 데이터 요청
		document.getElementById('exportButton').addEventListener('click', function () {
			
				// 엑셀로 내보낼 데이터
			    var searchParams = {
			        outCode: $("#outCode").val(),
			        prodName: $("#prodName9999").val(),
			        clientCompany: $("#clientCompany9999").val(),
			        sellState: sellStateButton1 // 전체 조건 추가
			    };
			
			    $.ajax({
			        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
			        url: "${pageContext.request.contextPath}/outProduct/excel", // 데이터를 가져올 URL 설정
			        data: searchParams, // 검색 조건 데이터 전달
			        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
			        success: function (data) {
			            // 데이터 가공
						var modifiedData = data.map(function (item) {
						    return {
						        '출고 코드': item.outCode,
						        '수주 코드': item.sellCode,
						        '거래처 코드': item.clientCode,
						        '거래처명': item.clientCompany,
						        '제품 코드': item.prodCode,
						        '제품명': item.prodName,
						        '담당자': item.outEmpId,
						        '총 출고가':item.outPrice,
						        '출고 상태': item.sellState,
						        '납품 예정일': item.sellDuedate,
						        '출고일': item.outDate,
						        '재출고일': item.outRedate,
						        '납품 개수': item.sellCount,
						        '남은 납품 개수': item.sellCount - item.outCount,
						        '출고 개수': item.outCount,
						        '재고 개수': item.stockCount,
						        '납품 단가': item.prodPrice,
						        '현재 출고가': item.prodPrice * item.outCount,
						        '비고': item.outMemo
						    };
						});
			            
						// 열의 너비 설정
			            var colWidths = [
			            	{ wch: 15 }, // 출고 코드
			                { wch: 15 }, // 수주 코드
			                { wch: 10 }, // 거래처 코드
			                { wch: 12 }, // 거래처명
			                { wch: 10 }, // 제품 코드
			                { wch: 10 }, // 제품명
			                { wch: 10 }, // 담당자
			                { wch: 15 }, // 총 출고가
			                { wch: 10 }, // 출고 상태
			                { wch: 15 }, // 납품 예정일
			                { wch: 15 }, // 출고일
			                { wch: 15 }, // 재출고일
			                { wch: 10 }, // 납품 개수
			                { wch: 10 }, // 남은 납품 개수
			                { wch: 10 }, // 출고 개수
			                { wch: 10 }, // 재고 개수
			                { wch: 10 }, // 납품 단가
			                { wch: 15 }, // 현재 출고가
			                { wch: 20 } // 비고
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
			            var fileName = "OutProduct.xlsx";
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
		
		function getInfo(event, data) {
		    // 만약 data가 "-"로 시작하지 않으면 Ajax 호출 수행
		    if (data.charAt(0) !== '-') {
		        if (data.startsWith("PR")) {
		            // prodCode로 시작하는 경우의 처리
		            // Ajax 호출 등을 수행
		            console.log("Ajax 호출: " + data);
		            $.ajax({
			           	type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
					    url: "${pageContext.request.contextPath}/outProduct/productInfo", // 데이터를 가져올 URL 설정
					    data: {data : data}, // 검색 조건 데이터 전달
					    dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
					    success: function (response) {
					    	console.log(response);
					    	var dataformat = {
					                '제품 코드': response.prodCode,
					                '제품 이름': response.prodName,
					                '단위': response.prodUnit,
					                '용량': response.prodSize,
					                '향 종류': response.prodPerfume,
					                '단가': response.prodPrice,
					            };
					    	openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
					    }
		            });
		        } else if (data.startsWith("CL")) {
		            // clientCode로 시작하는 경우의 처리
		            // Ajax 호출 등을 수행
		            console.log("Ajax 호출: " + data);
		            $.ajax({
			           	type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
					    url: "${pageContext.request.contextPath}/outProduct/clientInfo", // 데이터를 가져올 URL 설정
					    data: {data : data}, // 검색 조건 데이터 전달
					    dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
					    success: function (response) {
					    	console.log(response);
					    	var dataformat = {
					                '거래처 코드': response.clientCode,
					                '거래처명': response.clientCompany,
					                '대표명': response.clientCeo,
					                '담당자명': response.clientName,
					                '전화번호': response.clientTel,
					                '폰번호': response.clientPhone,
					                '팩스번호': response.clientFax,
					                '이메일': response.clientEmail,
					            };
					    	openModalWithData(event, dataformat, 300); // 데이터를 모달로 표시
					    }
		            });
		        } else {
		            // 다른 경우의 처리
		            console.log("다른 경우의 처리");
		            Swal.fire({
	                    text: '잘못된 데이터 입니다.',
	                    icon: 'warning',
	                    confirmButtonText: '확인',
	                });
		        }
		    } else {
		    	Swal.fire({
                    text: '없는 데이터 입니다.',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
		    }

		}
		
		function openModalWithData(event, data, width) {
		    var modal = document.getElementById('myModal');
		    var modalContent = document.querySelector('.modal-body');
		    
		    modalContent.style.width = Math.abs(width) + 'px'; // 절대값
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
		
		// 모달 외부를 클릭하면 모달을 숨김
		window.addEventListener('click', function(event) {
			if (event.target != modal) {
				modal.style.display = 'none';
			}
		});
		// 모달 내부 클릭시 닫기 x
		modal.addEventListener('click', function(event) {
		    event.stopPropagation(); // 모달 내부 클릭 이벤트 중지
		});
	</script>
	

</body>
</html>