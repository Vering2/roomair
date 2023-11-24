<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사관리</title>
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

//팝업창 중앙 생성 및 가로,세로 크기
function openCenteredWindow(url) {
    var width = 500;
    var height = 850;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2 - 50;
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
        alert("선택된 사원이 없습니다.");
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
                        location.replace("employees")
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
	
// 자식 팝업 창 닫고 부모창 새로 고침
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
<h2><a href="${pageContext.request.contextPath}/employees/employees" style=" text-decoration: none; color:black;">인사 관리</a></h2>

<div id="searchForm">
<form action="${pageContext.request.contextPath}/employees/employees" method="get" id="searchBox">
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
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">    
<!-- <input type="button" value="삭제" onclick="deleteValue();" id="btnSell"> -->
<button onclick="openCenteredWindow('employees2')" id="delete">추가</button>
<button onclick="deleteValue();" id="add">삭제</button>
</c:if>
</div>
</div>

<label>총 ${pageDTO.count}명</label>

<form id="selltList">
<div id="sellList">
    <table class="tg" id="employeeTable" style="border-radius: 5px;">

    <thead>
        <tr>
       
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">
            <th><input type="checkbox" id="checkAll"></th> 
            <th>사원번호</th>
            <th>비밀번호</th>
</c:if>
            <th>사원명</th>
            <th>부서</th>
            <th>직책</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>입사일자</th>
            <th>재직구분</th>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">            
</c:if>            
        </tr>
        </thead>
        <tbody>
<c:forEach var="employeesDTO" items="${employeesList }">

<tr onclick="if('${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}' === 'true') { openCenteredWindow('update?empId=${employeesDTO.empId}'); } else { event.preventDefault(); }">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">
    <td onclick="event.stopPropagation();"><input type="checkbox" class="rowCheck" name="rowCheck" value="${employeesDTO.empId}"></td>
    <td>${employeesDTO.empId}</td>
    <td>${employeesDTO.empPass}</td>
</c:if>
    <td>${employeesDTO.empName}</td>
    <td>${employeesDTO.empDepartment}</td>
    <td>${employeesDTO.empPosition}</td>
    <td>${employeesDTO.empEmail}</td>
    <td>${employeesDTO.empTel}</td>
    <td>${employeesDTO.empHiredate}</td>
    <td>${employeesDTO.empState}</td>
</tr>
</c:forEach> 
</tbody>   
    </table>
</div>    
</form>


<!-- 페이징 처리 -->
<div id="pagination" class="page_wrap">
<div class="page_nation">
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<c:choose>

<c:when test="${i eq pageDTO.currentPage}">
<a class="a active" href="${pageContext.request.contextPath}/employees/employees?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:when>

<c:otherwise>
<a class="a" href="${pageContext.request.contextPath}/employees/employees?pageNum=${i}&search=${pageDTO.search}">${i}</a>
</c:otherwise>

</c:choose>
</c:forEach>

</div>
</div>

</div>

</body>

</html>
