<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<th>라인코드</th>
				<th>라인명</th>
				<th>사용상태</th>
				<th>공정등록자</th>
				<th>공정등록일</th>
				<th>공정</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="lineDTO" items="${linelist}">
				<tr class="ctcontents">
					<td>${lineDTO.lineCode}</td>
					<td>${lineDTO.lineName}</td>
					<td>${lineDTO.lineUse}</td>
					<td>${lineDTO.lineEmpId}</td>
					<td>${lineDTO.lineInsertDate}</td>
					<td>${lineDTO.lineProcess}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>

	<script>
		$(document)
				.ready(
						function() {
							$('.ctcontents')
									.click(
											function() {
												var selectedLineCode = $(this)
														.find('td:first-child')
														.text(); // 첫 번째 열(라인코드 열)의 값을 가져옴
												opener.document
														.getElementById('lineCode2').value = selectedLineCode; // 라인 코드를 부모 JSP의 lineCode 입력 필드에 설정
												window.close(); // 자식 창 닫기
											});
						});
	</script>



</body>
</html>