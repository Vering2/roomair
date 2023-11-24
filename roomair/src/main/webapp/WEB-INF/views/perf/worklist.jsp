<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

 <table class="ct" id="ct">
		<thead>
			<tr class="cthead">
				<th>작업지시코드</th>
				<th>라인코드</th>
				<th>수주코드</th>
				<th>제품코드</th>
				<th>작업지시일</th>
				<th>지시수량</th>
				<th>공정</th> <!--  lineprocess-->
			</tr>
		</thead>
		<tbody>
			<c:forEach var="workorderDTO" items="${worklist}">
				<tr class="ctcontents">
					<!-- 0 넘김--><td>${workorderDTO.workCode}</td>
					<!-- 1 넘김--><td>${workorderDTO.lineCode}</td>
					<!-- 2 안넘김--><td>${workorderDTO.sellCode}</td>
					<!-- 3 넘김--><td>${workorderDTO.prodCode}</td>
					<!-- 4 안넘김--><td>${workorderDTO.workDate}</td>
					<!-- 5 넘김--><td>${workorderDTO.workAmount}</td>
					<!-- 6 넘김--><td>${workorderDTO.workProcess}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	
	<script>
	
	$(document).ready(function() {
	    $('.ctcontents').click(function() {
	        var selectedRow = $(this);
	        var rowData = {
	        		    workCode: selectedRow.find('td:eq(0)').text(),
	        		    lineCode:selectedRow.find('td:eq(1)').text(),
	        		    prodCode: selectedRow.find('td:eq(3)').text(),
	        		    workAmount: selectedRow.find('td:eq(5)').text()
	        		   
	        };
	        window.opener.receiveSelectedLineData(JSON.stringify(rowData)); // JSON 형식으로 변환하여 부모 창의 함수 호출
	        window.close(); // 자식 창 닫기
	    });
	});
	
</script>



</body>
</html>