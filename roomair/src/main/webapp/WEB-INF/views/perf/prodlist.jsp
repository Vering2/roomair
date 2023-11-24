<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>


        <table class="ct" id="ct">
		<thead>
			<tr class="cthead">
				<th>제품코드</th>
				<th>제품명</th>
				<th>제품단위</th>
				<th>용량</th>
				<th>향기종류</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="prodDTO" items="${prodlist}">
				<tr class="ctcontents">
					<td>${prodDTO.prodCode}</td>
					<td>${prodDTO.prodName}</td>
					<td>${prodDTO.prodUnit}</td>
					<td>${prodDTO.prodSize}</td>
					<td>${prodDTO.prodPerfume}</td>
					<td>${prodDTO.prodMemo}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>


<script>
$(document).ready(function() {
    $('.ctcontents').click(function() {
        var selectedLineCode = $(this).find('td:first-child').text(); // 첫 번째 열(라인코드 열)의 값을 가져옴
        opener.document.getElementById('prodCode2').value = selectedLineCode; // 라인 코드를 부모 JSP의 lineCode 입력 필드에 설정
        window.close(); // 자식 창 닫기
    });
});
</script>

</body>
</html>