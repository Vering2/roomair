<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>


<link href="${pageContext.request.contextPath }/resources/css/requirement.css"
	rel="stylesheet" type="text/css">
<%-- <%@ include file="../include/header.jsp"%> --%>
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
	
<!-- 사이드바 -->
<title>requirement</title>
<%
String prodName = request.getParameter("prodName")!= null ? request.getParameter("prodName") : "";
String rawName = request.getParameter("rawName")!= null ? request.getParameter("rawName") : "";

%>
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
<!-- 사이드바 -->
<!-- page content -->
<div class="right_col">

	<h2 style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/requirement/reqDetail'">소요량 관리</h2>
	
		<form method="get">
			<div class="searchform">
				<label>소요코드</label> 
				<input class="input_box" type="text" name="reqCode" id="reqCode9999" onfocus="this.value='RQ'" placeholder="소요량코드를 입력하세요." value="${dto.reqCode }">
				<label>제품</label> 
				<input type="hidden"name="prodCode" id="prodCode9999" value="${dto.prodCode }">
				<input class="input_box" type="text" name="prodName" id="prodName9999" placeholder="제품을 선택하세요." value="<%=prodName %>" readonly onclick="searchItem('prod','prodCode9999')">
				<label>원자재</label>
				<input type="hidden" name="rawCode" id="rawCode9999"  value="${dto.rawCode }">
				<input class="input_box" type="text" name="rawName" id="rawName9999" placeholder="원자재를 선택하세요." value="<%=rawName %>" readonly onclick="searchItem('raw','rawCode9999')">
				<input style ="margin: 0 0 0 20px;" class="button" type="submit" value="조회">
			</div>
		</form>
	
	<div class="col-md-12">
	<div style ="margin: 2% 0 0 0;"	>
	<div style="float:right;">
						<button style="display: none;"class="button" id="add" >추가</button>
						<button style="display: none;"class="button" id="modify" >수정</button>
						<button style="display: none;"class="button" id="delete" >삭제</button>
						<button style="display: none;" id ="cancle" onclick="location.href='${pageContext.request.contextPath}/requirement/reqDetail'" class="button">취소</button>
						<input style="display: none;" class="button" type="submit" value="저장" id="save">
					</div>
					</div>		
		<div class="x_panel">
			
				<div class="x_title">
					<label style="margin:0px">총 ${paging.total} 건</label>
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
				
				
		
			
				<div class="table-wrapper" >
				<form id="fr" method="post">
					<table id="reqTable" class="table table-striped jambo_table bulk_action" style="text-align-last:center; ">
						<thead>
							<tr class="headings">
								<th>번호</th>
								<th>소요코드</th>
								<th style='display: none;'>품번</th>
								<th>제품코드</th>
								<th>원자재코드</th>
								<th>소요량</th>
								<th>비고</th>
								<th style='display: none;'></th>
							</tr>
						</thead>
							<tr style='display: none;'></tr>
						<c:forEach var="dto" items="${reqList}">
							<tr class="contents">
								<td></td>
								<td id="reqCode">${dto.reqCode }</td>
								<td style='display: none;'>${dto.prod.prodName }</td>
								<td style='cursor: pointer;' onclick="openModal(event)" id="${dto.prodCode }" name="prodCode" value="${dto.prodCode }">${dto.prodCode }</td>
								<td style='cursor: pointer;' onclick="openModal(event)" id="${dto.rawCode }" name="rawCode" value="${dto.rawCode }">${dto.rawCode }</td>
								<td>${dto.reqAmount }</td>
								<td>${dto.reqMemo }</td>
								<td id="rawCode" style='display: none;'>${dto.raw.rawName }</td>
							</tr>
						</c:forEach>
					</table>
					</form>
					</div>
				
				
				</div>
				</div>
				<div>
	<div style="float:left;">
	 
	<button id="excelDownload" class="button">엑셀</button>
	</div>	

		<div id="pagination" class="page_wrap">
			<div class="page_nation">
						<c:if test="${paging.startPage != 1 }">
							<a class="arrow prev" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">◀️</a>
						</c:if>
					
					
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
    <c:choose>
        <c:when test="${p eq paging.nowPage}">
            <a class="a active" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${p }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">${p }</a>
					 </c:when>
        <c:otherwise>
           <a class="a" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${p }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">${p }</a>
					 </c:otherwise>
    </c:choose>
</c:forEach>	<c:if test="${paging.endPage != paging.lastPage}">
							<a class="arrow next" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">▶️</a>
						</c:if>
			</div>
	</div>
	</div>
	</div>


</body>

<script type="text/javascript">
function getToday() {
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);

	return year + "-" + month + "-" + day;
} 
     // 페이지 로드 시 실행되는 함수
    $(document).ready(function () {
    		$('table tr').each(function(index){
    		var num = "<c:out value='${paging.nowPage}'/>";
    		var num2 = "<c:out value='${paging.cntPerPage}'/>";
    		$(this).find('td:first').text(((num-1)*num2) + index-1);
    		num3 = ((num-1)*num2) + index;
    	});
   
		//엑셀
			const excelDownload = document.querySelector('#excelDownload');
			excelDownload.addEventListener('click', exportExcel);
				function exportExcel() {
					// 엑셀로 내보낼 데이터
				    var searchParams = {
				        reqCode: $("#reqCode9999").val(),
				        prodCode: $("#prodCode9999").val(),
				        rawCode: $("#rawCode9999").val(),
				    };
					
				    $.ajax({
				        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
				        url: "${pageContext.request.contextPath}/requirement/reqExcel", // 데이터를 가져올 URL 설정
				        data: searchParams, // 검색 조건 데이터 전달
				        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
				        success: function (data) {
				        	console.log("ajax 성공 : " + data);
				        	var modifiedData = data.map(function (item) {
							    return {
							        '소요 코드': item.reqCode,
							        '제품 코드': item.prodCode,
							        '제품명': item.prodName,
							        '원자재 코드': item.rawCode,
							        '원자재명': item.rawName,
							        '소요량': item.reqAmount,
							        '비고': item.reqMemo
							    };
							});
							// 열의 너비 설정
				            var colWidths = [
				            	{ wch: 10 }, // 소요 코드
				                { wch: 10 }, // 제품 코드
				                { wch: 10 }, // 제품명
				                { wch: 10 }, // 원자재 코드
				                { wch: 10 }, // 원자재명
				                { wch: 10 }, // 소요량
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
				            var fileName = 'requirementList'+getToday()+'.xlsx';;
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
				}
	});
			</script>

<script type="text/javascript">
//
//input으로 바꾸기 
function inputCng(obj, type, name, value) {
	var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"8888' value='"+value+"' class='input-row'>";
	obj.html(inputBox);
} //inputCng	

// 팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()




function submitForm() {
    var isValid = true;

    // 유효성 검사
    $('#reqTable input[required]').each(function() {
        if ($(this).val().trim() === '') {
            isValid = false;
            return false; // 유효성 검사 실패 시 반복문 종료
        }
    });

    if (isValid) {
        // 폼 데이터를 직렬화
        var formData = $('#fr').serialize();

        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/requirement/reqAdd",
            data: formData,
            dataType: "text",
            success: function(response) {
                // 서버로부터 받은 응답 처리
                if (response === "존재") {
                    // 이미 존재하는 레코드일 때의 처리
                    Swal.fire({
                        title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "이미 존재하는 항목이 있습니다.",
                        confirmButtonColor: '#9AC5F4',
                        icon: 'success',
                        width: '400px',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });
                } else if (response === "성공") {
                    // 성공적으로 저장된 경우의 처리
                    location.reload();
                    // 여기에 필요한 추가 동작을 수행하세요.
                } else {
                    // 기타 응답에 대한 처리
                    console.error("알 수 없는 응답:", response);
                    // 실패에 대한 처리를 추가하세요.
                }
            },
            error: function(error) {
                // AJAX 요청 실패 시 처리
                console.error("AJAX 요청 실패:", error);
                // 실패에 대한 처리를 추가하세요.
            }
        });
    } else {
        Swal.fire({
            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요" + "</div>",
            confirmButtonColor: '#9AC5F4',
            icon: 'info',
            width: '400px',
        });
    }
}

var counter = 0;
var addcounter = 0;
var num3 = 0;

function deleteRow() {
	var table = document.getElementById('reqTable');
    var lastRowIndex = table.rows.length - 1; // 마지막 행의 인덱스
    
    if (counter > 0) {
        table.deleteRow(lastRowIndex); // 마지막 행 삭제
    } else {
        console.log("더 이상 삭제할 행이 없습니다.");
    }
	  counter--;
	}	
	
	
$(document).ready(function() {
	 var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
		
	  if (team === "생산팀" || team === "관리자") {
		  $('#add').show();
			$('#modify').show();
			$('#delete').show();
	   }
	  else if (team ===""){
		  window.location.href = "${pageContext.request.contextPath}/login/logout";
	  }
		
	// 추가 시 필요한 변수들

   
    var codeNum = 0;
	var reqCode = 0;
    // 추가 버튼 클릭 시 row 생성
   
    

    // 버튼 클릭시 addRow() 기능 불러오기
    $('#add').click(function() {
    	 
    	event.preventDefault();
    	$('#modify').hide();
		$('#delete').hide();
		$('#cancle').show();
		$('#save').show();
		
		$.ajax({
			  url: "${pageContext.request.contextPath}/requirement/reqCode",
			  method: "GET",
			  dataType: "text",
			  success: function(data) {
			    // Ajax 요청 안에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행
			    codeNum = data;
			    console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]
			    
			    // 변수에 할당된 데이터를 기반으로 추가 작업 수행
			    someFunction(codeNum);
			  }
			}); // ajax 끝

			function someFunction(data) {
				 codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
					 var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
					 var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
					 reqCode = codeNum.charAt(0) + codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
		             addRow();
		             counter++;
			} // someFunction(data)
		
			$('#save').click(function() {
			      submitForm();
			});
    });
    
    function addRow() {
    	addcounter = num3 + counter;
    	
        var row = '<tr>' +
        	'<td style="color: red;" onclick="deleteRow()">'+addcounter+'</td>' + 
        	'<input type="hidden"  name="reqs[' + counter + '].rawCode" id = "rawCode'+counter+'" required>' + 
            '<td><input type="text" style="background-color:rgba(0, 0, 0, 0);" name="reqs[' + counter + '].reqCode" " value="'+ reqCode +'" readonly required class="input-row"></td>' +
   
            '<input type="hidden" name="reqs[' + counter + '].prodCode" id= "prodCode'+counter+'">' +
            '<td><input type="text" name="reqs[' + counter + '].prod.prodName" id = "prodName'+counter+'" readonly onclick=searchItem("prod","prodCode'+counter+'"); placeholder="제품명을 선택하세요." class="input-row"></td>' +
            '<td><input type="text" name="reqs[' + counter + '].raw.rawName" id="rawName'+counter+'" readonly onclick=searchItem("raw","rawCode'+counter+'"); placeholder="원자재를 선택하세요." class="input-row"></td>' + 
            
            '<td><input type="number" name="reqs[' + counter + '].reqAmount" ide="reqAmoun'+counter+'" required class="input-row" value="1" min="1" placeholder="소요량을 선택하세요."></td>' +
            '<td><input type="text" name="reqs[' + counter + '].reqMemo" class="input-row" placeholder="비고를 입력하세요."></td>' +
            
            '</tr>';
            
        $('#reqTable').append(row);
        
    	 // 테이블이 많이 생성되면 스크롤바 생성
        var table = document.getElementById('reqTable');
        table.scrollTop = table.scrollHeight;
		
    }
    
    
    
    function padNumber(number, length) {
        var paddedNumber = number.toString();
        while (paddedNumber.length < length) {
            paddedNumber = "0" + paddedNumber;
        }
        return paddedNumber;
		 } // padNumber(number, length)
    
    // =============================================================================================================
	
	
	
	
	// 삭제 기능
	$('#delete').click(function(event){
		event.preventDefault();
		$('#delete').hide();
		$('#modify').hide();
		$('#add').hide();
		$('#cancle').show();
		$('#save').show();
		
		// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
		$('table tr').each(function(){
			var code = $(this).find('td:nth-child(2)').text();
			
			var tbl = "<input type='checkbox' name='selected' value='";
			tbl += code;
			tbl += "'>";
			
			$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
			$(this).find('td:first').html(tbl);
		});
		
		$('#selectAll').click(function() {
			var checkAll = $(this).is(":checked");
			
			if(checkAll) {
				$('input:checkbox').prop('checked', true);
			} else {
				$('input:checkbox').prop('checked', false);
			}
		});
		
		
		//저장 -> 삭제
		$('#save').click(function() {
			
			var checked = [];
			
			$('input[name=selected]:checked').each(function(){
				checked.push($(this).val());
			});
			
//				alert(checked);
			
			if(checked.length > 0) {
				Swal.fire({
					  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
							  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
					  icon: 'info', // 아이콘! 느낌표 색? 표시?
					  showDenyButton: true,
					  confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정
					  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
					  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
					  width : '400px', // alert창 크기 조절
					  
					}).then((result) => {
						
				
				 /* confirm => 예 눌렀을 때  */
				  if (result.isConfirmed) {
					  
				  
					$.ajax({
 						url: "${pageContext.request.contextPath}/requirement/requirementDelete",
 						type: "POST",
 						data: {checked : checked},
 						dataType: "text",	
 						success: function () {
 							Swal.fire({
								  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
								  confirmButtonColor: '#9AC5F4',
								  icon: 'success',
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
							icon : 'error',
							confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정
							  
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
	
		//취소 -> 리셋
		$('#cancle').click(function(){
			$('input:checkbox').prop('checked', false);
		});
		
	}); //delete click
	
	/////////////// 수정 //////////////////////////////
	var isExecuted = false;
	
	//수정버튼 클릭
	
	$('#modify').click(function() {
		
		event.preventDefault();
		$('#delete').hide();
		$('#modify').hide();
		$('#add').hide();
		$('#cancle').show();
		$('#save').show();
		
		Swal.fire({
			 title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "수정할 행을 선택해주세요"+ "</div>",
			  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
	  icon: 'info', // 아이콘! 느낌표 색? 표시?
            confirmButtonColor: '#9AC5F4',
         });

		//행 하나 클릭했을 때	
		$('table tr:not(:first-child)').click(function() {
			
			//하나씩만 선택 가능
			if(!isExecuted) {
				isExecuted = true;
						
				$(this).addClass('selected');
				//품목코드 저장
				let updateCode = $(this).find('#reqCode').text().trim();
				console.log(updateCode);

				var jsonData = {
					reqCode : updateCode
				};

				var self = $(this);

				$.ajax({
					url : "${pageContext.request.contextPath}/requirement/reqOne",
					type : "post",
					contentType : "application/json; charset=UTF-8",
					dataType : "json",
					data : JSON.stringify(jsonData),
					success : function(data) {
						var sum = 0;
						
						var preVOs = [
								data.reqCode,
								data.prodCode,
								data.prod.prodName,
								data.raw.rawName,
								data.reqAmount,
								data.reqMemo,
								data.rawCode
								];
						
					

						var names = [
								"reqCode",
								"prodCode",
								"prodName",
								"rawName",
								"reqAmount",
								"reqMemo",
								"rawCode" 
								];

						//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
						
						self.find('td').each(function(idx,item) {
							if (idx > 0) {
								inputCng($(this),"text",names[idx - 1],preVOs[idx - 1] );
							
								$(this).find("input").each(function(){
										if($(this).attr("name") == "reqCode") {
											$(this).attr("readonly", true);
											$(this).attr("style","background-color:rgba(0, 0, 0, 0);");
										}
										else if($(this).attr("name") == "reqAmount") {
											$(this).attr("type", "number");
											$(this).attr("min", "1");
											
										}
								});								


							} //라인코드부터 다 수정 가능하게

						}); // self.find(~~)
						  //품번 검색 
						$('#prodName8888').click(function(){
			                searchItem("prod", "prodCode8888");
			            });
						//품번 검색 팝업(raw)
						$('#rawName8888').click(function(){
			                searchItem("raw", "rawCode8888");
			            });
	},
					error : function(data) {
						alert("아작스 실패 ~~");
					}
				}); //ajax

				//저장버튼 -> form 제출
				$('#save').click(function() {
					var reqAmount = $('#reqAmount8888').val();
					if(reqAmount <= 0){
						Swal.fire({
							title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "1이상의 값을 입력해주세요"+ "</div>",
							icon: 'info',
							confirmButtonColor: '#9AC5F4',
							width: '400px',
						})}
					else{$('#fr').attr("action","${pageContext.request.contextPath}/requirement/reqModify");
					$('#fr').attr("method","post");
					$('#fr').submit();}

					

				}); //save

			} //하나씩만 선택 가능
				

		}); //tr click

	}); //modify click

    
});

</script>
<script type="text/javascript">
	function applyFilters() {
        var perPageValue = document.getElementById("perPageSelect").value;
        var reqCode = "${dto.reqCode}";
        var prodCode = "${dto.prodCode}";
        var rawCode = "${dto.rawCode}";

        var url = '${pageContext.request.contextPath}/requirement/reqDetail?nowPage=1&cntPerPage=' + perPageValue +
            '&reqCode=' + reqCode + '&prodCode=' + prodCode +
            '&rawCode=' + rawCode;

        // Redirect to the generated URL
        window.location.href = url;
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

    		    // 클릭 이벤트의 위치를 기반으로 모달 창 위치 설정
    		  
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
    	    
    		
    		/* window.addEventListener('click', function(event) {
    		    if (event.target != modal && !modal.contains(event.target)) {
    		        modal.style.display = 'none';
    		    }
    		}); */
    	 

    		
        
               
    </script>
</html>


<!-- /page content -->
<%-- <%@ include file="../include/footer.jsp"%> --%>