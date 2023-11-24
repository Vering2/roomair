<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인관리</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/employees.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById('checkAll').addEventListener('click', function() {
        var checkboxes = document.querySelectorAll('input.rowCheck');
        for (var checkbox of checkboxes) {
            checkbox.checked = this.checked;
        }
    });
});

function openCenteredWindow(url) {
    var width = 460;
    var height = 550;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2 - 50; // 화면 중앙보다 조금 더 위로 올립니다.
    window.open(url, '_blank', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
}

//체크박스 선택/해제
$(function(){
   var chkObj = document.getElementsByName("rowCheck");
   var rowCnt = chkObj.length;
         
   $("input[name='allCheck']").click(function(){
      var chk_listArr = $("input[name='rowCheck']");
      for (var i=0; i<chk_listArr.length; i++){
         chk_listArr[i].checked = this.checked;
      }
   });
      
   $("input[name='rowCheck']").click(function(){
      if($("input[name='rowCheck']:checked").length == rowCnt){
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
    var list = $("input[name='rowCheck']");

    for(var i = 0; i < list.length; i++){
        if(list[i].checked){ // 선택되어 있으면 배열에 값을 저장함
            valueArr.push(list[i].value);
        }
    }

    if (valueArr.length == 0){
        alert("선택된 라인이 없습니다.");
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
                        location.replace("line")
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
	
	// 페이지 로드 후 스크립트 실행
	$(document).ready(function() {
	    var refreshAndClose = true; // refreshAndClose 값을 변수로 설정

	    if (refreshAndClose) {
	        window.opener.location.reload(); // 부모창 새로 고침
	        window.close(); // 현재 창 닫기
	    }
	});
</script>

</head>

<body>
<jsp:include page="../inc/side.jsp"></jsp:include>
<div class="container">
<h2><a href="${pageContext.request.contextPath}/line/line" style=" text-decoration: none; color:black;">라인 관리</a></h2>

<div id="searchForm">
<form action="${pageContext.request.contextPath}/line/line" method="get" id="searchBox">
<div id="searchform" style="border-radius: 5px;">
<label>통합 검색</label><input type="text" name="search">
<input type="submit" value="조회" id="searchButton">
</div>
</form>
</div>

<div id="sample">

<div id="buttons">
</div>

<div class="buttons">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}">
<!-- <input type="button" value="삭제" onclick="deleteValue();" id="btnSell"> -->
<button onclick="deleteValue();" id="add">삭제</button>
<button onclick="openCenteredWindow('line2')" id="delete">등록</button>
</c:if>
</div>
</div>

<label>총 ${pageDTO.count}건</label>

<form id="selltList">
<div id="sellList">
<table class="tg" id="lineTable" style="border-radius: 5px;">

<thead>
<tr>
<th><input type="checkbox" id="checkAll"></th> 
<th>라인코드</th>
<th>라인명</th>
<th>사용여부</th>
<th>등록자</th>
<th>등록일</th>
<th>공정</th>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}">
</c:if>
</tr>
</thead>
<tbody>
<c:forEach var="lineDTO" items="${lineList }">
<tr onclick="if('${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}' === 'true') { openCenteredWindow('update?lineCode=${lineDTO.lineCode}'); } else { event.preventDefault(); }">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}">
    <td onclick="event.stopPropagation();"><input type="checkbox" class="rowCheck" name="rowCheck" value="${lineDTO.lineCode}"></td>
    </c:if>
    <td>${lineDTO.lineCode}</td>
    <td>${lineDTO.lineName}</td>
    <td>${lineDTO.lineUse}</td>
    <td>${lineDTO.lineEmpId} ${lineDTO.empName}</td>
    <td>${lineDTO.lineInsertDate}</td>
    <td>${lineDTO.lineProcess}</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</form>

<%-- <c:forEach var="i" begin="${pageDTO.startPage}"  --%>
<%--                    end="${pageDTO.endPage}" step="1"> --%>
<%-- <a class="a" href="${pageContext.request.contextPath}/line/line?pageNum=${i}&search=${pageDTO.search}">${i}</a>  --%>
<%-- </c:forEach> --%>

<!-- 페이징 처리 -->
<div id="pagination" class="page_wrap">
<div class="page_nation">
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<c:choose>

<c:when test="${i eq pageDTO.currentPage}">
<a class="a active" href="${pageContext.request.contextPath}/line/line?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:when>

<c:otherwise>
<a class="a" href="${pageContext.request.contextPath}/line/line?pageNum=${i}&search=${pageDTO.search}">${i}</a>
</c:otherwise>

</c:choose>
</c:forEach>

</div>
</div>
</div>
</body>
</html>