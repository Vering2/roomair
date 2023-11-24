<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head> 
<meta charset="UTF-8">  
<title>Insert title here</title>

<!-- 엑셀 -->
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/Rawmaterials.css" rel="stylesheet" type="text/css">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 체크박스로 삭제
$(function(){
	var chkObj = document.getElementsByName("RowCheck");
	var rowCnt = chkObj.length;
			
	$("input[name='allCheck']").click(function(){
		var chk_listArr = $("input[name='RowCheck']");
		for (var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
		
	$("input[name='RowCheck']").click(function(){
		if($("input[name='RowCheck']:checked").length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}
		else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
});

//체크박스로 삭제
function deleteValue(){
	var url = "delete"; // Controller로 보내고자 하는 URL
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){ // 선택되어 있으면 배열에 값을 저장함
			valueArr.push(list[i].value);
		}
	}
	
	if (valueArr.length == 0){
		alert("선택된 발주가 없습니다.");
	}
	else{
		var chk = confirm("정말 삭제하시겠습니까?");
        if(chk) {				 
		    $.ajax({
			    url : url,             // 전송 URL
			    type : 'POST',         // GET or POST 방식
			    traditional : true,
			    data : {
			    valueArr : valueArr    // 보내고자 하는 data 변수설정
			    },
	    	    success: function(jdata){
	        	    if(jdata = 1) {
	        		    alert("삭제 성공");
	            	    location.replace("home")
	        	    }
	                else{
	            	    alert("삭제 실패");
	                }
	   		    }
		    });
        } else {
            alert("삭제 실패");
        }
	}
}

// insert 페이지 팝업창
function openPopup1() {
	var popupX = (window.screen.width/2) - (400/2);
	var popupY = (window.screen.height/2) - (820/2);
	const myWindow = window.open('${pageContext.request.contextPath}/OrderManagement/insert', "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=820,left=" + popupX + ",top=" + popupY);
	myWindow.focus();
}

// function openPopup1() {
//     window.open('${pageContext.request.contextPath}/OrderManagement/insert', '_blank', 'height=400,width=600');
// }


// detail 페이지 팝업창
function openPopup2(url) {	
	var popupX = (window.screen.width/2) - (400/2);
	var popupY = (window.screen.height/2) - (760/2);
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=760,left=" + popupX + ",top=" + popupY);
	myWindow.focus();
}

// selectclient 페이지 팝업창
function openPopup3() {
	var popupX = (window.screen.width/2) - (1700/2);
	var popupY = (window.screen.height/2) - (500/2);
	const myWindow = window.open("${pageContext.request.contextPath}/Rawmaterials/selectclient", "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=1700,height=500,left=" + popupX + ",top=" + popupY);
	myWindow.focus();
	// 팝업 창닫기 버튼 클릭시 창닫기
    popupWindow.onbeforeunload = function() {
        popupWindow.close();
    };
}

// 팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    }
});
</script>
</head>

<!-- body -->
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>

<div class="content">
<h2>발주 관리</h2>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/OrderManagement/home" method="get" id="searchBox">
<div id="searchForm" style="border-radius: 5px;">
<label>발주코드</label>		<input type="text" name="search1" placeholder="발주번호">
<label>품번</label>		<input type="text" name="search2" placeholder="품번">
<label>종류</label>		<select name="search3">
						<option value="">전체</option>
						<option value="향기">향기</option>
						<option value="용기">용기</option>
						<option value="스틱">스틱</option>
						<option value="라벨">라벨</option>
						<option value="포장재">포장재</option>
						</select>
<label>거래처코드</label>	<input type="text" name="search4" placeholder="거래처" id="pInput" onclick="openPopup3()">
<input type="text"  hidden name="search5" placeholder="거래처명" id="cCInput">
<input type="submit" value="조회" id="searchButton">
</div>

<!-- button -->
<div id="buttons">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '영업팀')}">
<input type="button" value="추가" onclick="openPopup1()" id="add">
<input type="button" value="삭제" onclick="deleteValue();" id="delete">
</c:if>
</div>
</form>

<div class="total-items">
<label>총 ${pageDTO.count}건</label>
</div>

<!-- table -->
<table class="tg" id="rawmaterialsList" style="border-radius: 5px;">
<thead>
<tr>
<td><input type="checkbox"></td>
<td>발주코드</td>
<td>품번</td>
<td>품명</td>
<td>종류</td>
<td>거래처코드</td>
<td>창고코드</td>
<td>재고수량</td>
<td>발주수량</td>
<td>매입단가</td>
<td>단가총계</td>
<td>발주신청일</td>
<td>발주상태</td>
<td>담당자</td>
</tr>
</thead>

<tbody>
<c:forEach var="ordermanagementDTO" items="${ordermanagementList}">
<tr>
<td><input type="checkbox" name="RowCheck" value="${ordermanagementDTO.buyNum}"></td>
<td><a href="#" onclick="openPopup2('${pageContext.request.contextPath}/OrderManagement/detail?buyNum=${ordermanagementDTO.buyNum}')" style="text-decoration: none; color: black;">${ordermanagementDTO.buyNum}</a></td>
<td>${ordermanagementDTO.rawCode}</td>
<td>${ordermanagementDTO.rawName}</td>
<td>${ordermanagementDTO.rawType}</td>
<td>${ordermanagementDTO.clientCode}</td>
<td>${ordermanagementDTO.whseCode}</td>
<td><c:choose>
<c:when test="${ordermanagementDTO.stockCount < 500}">
<span style="color:red;" data-title="500개 미만입니다">${ordermanagementDTO.stockCount}</span>
</c:when>
<c:otherwise>
${ordermanagementDTO.stockCount}
</c:otherwise>
</c:choose></td>
<td>${ordermanagementDTO.buyCount}</td>
<td>${ordermanagementDTO.rawPrice}</td>
<td>${ordermanagementDTO.rawPrice * ordermanagementDTO.buyCount}</td>
<td>${ordermanagementDTO.buyDate}</td>
<td><c:choose>
<c:when test="${ordermanagementDTO.buyInstate == '신청완료'}">
<span style="color:red;">${ordermanagementDTO.buyInstate}</span>
</c:when>
<c:otherwise>
${ordermanagementDTO.buyInstate}
</c:otherwise>
</c:choose></td>
<td>${ordermanagementDTO.buyEmpId}</td>
</tr>
</c:forEach>
</tbody>
</table>

<!-- button -->
<div id="pagination" class="page_wrap2">
<div id="excel">
<button class="excelbtn" id="excelDownload">엑셀</button>
<button class="excelbtn" onclick="window.location.href='${pageContext.request.contextPath}/OrderManagement/download'">전체</button>
</div>

<!-- 페이징처리 -->
<div class="page_nation">
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/OrderManagement/home?pageNum=${i}&search1=${pageDTO.search1}&search2=${pageDTO.search2}&search3=${pageDTO.search3}&search4=${pageDTO.search4}">${i}</a> 
</c:forEach>
</div>
</div>
</div>

<!-- javascript -->
<script type="text/javascript">

// 엑셀
// function getToday() {
// 	var date = new Date();
// 	var year = date.getFullYear();
// 	var month = ("0" + (1 + date.getMonth())).slice(-2);
// 	var day = ("0" + date.getDate()).slice(-2);
// 	return year + "-" + month + "-" + day;
// }

// const excelDownload = document.querySelector('#excelDownload');

document.addEventListener('DOMContentLoaded', ()=> {
	excelDownload.addEventListener('click', exportExcel);
});

function exportExcel() {
    // 1.workbook 생성
    var wb = XLSX.utils.book_new();
    // 2.시트 만들기
    var newWorksheet = excelHandler.getWorksheet();
    // 3.workbook에 새로 만든 워크시트에 이름을 주고 붙이기
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
    // 4.엑셀파일 만들기
    var wbout = XLSX.write(wb, {bookType:'xlsx', type:'binary'});
    // 5.엑셀파일 내보내기
    saveAs(new Blob([s2ab(wbout)], {type:"application/octet-stream"}), excelHandler.getExcelFileName());
}

var excelHandler = {
    getExcelFileName : function() {
     	// return 'rawmaterialsList'+getToday()+'.xlsx'; 파일명
        return 'rawmaterials.xlsx';
    },
    getSheetName : function() {
        return 'rawmaterials'; // 시트명
    },
    getExcelData : function() {
        return document.getElementById('rawmaterialsList'); // table id
    },
    getWorksheet : function() {
        return XLSX.utils.table_to_sheet(this.getExcelData());
    }
}

function s2ab(s) {
    var buf = new ArrayBuffer(s.length); // s -> arrayBuffer
    var view = new Uint8Array(buf);  
    for(var i=0; i<s.length; i++) {
        view[i] = s.charCodeAt(i) & 0xFF;
    }
    return buf;
}
</script>
</body>
</html>