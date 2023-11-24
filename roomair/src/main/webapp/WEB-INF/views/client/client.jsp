<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/client.css">
	<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>

<!--  여기서부터 시작  -->
<div class="clientBody">
		<h1 class="toptitle"> <a href="${pageContext.request.contextPath}/client/client" style=" text-decoration: none; color:black; font-weight: bold;" >거래처 관리</a></h1>


<form method ="GET">
	<div class="search">
		 <label class="searchlabel">거래처명&nbsp;&nbsp;</label><input type="text" id="clientCompany" name="clientCompany">
		  &nbsp;&nbsp; <input type="submit"  class="searchbtn" value="조회">
		
		</div>
	
	<div class="typetab">
	<input type="submit" id="clientType" name="clientType"  value= "전체">
	<input type="submit" id="clientType" name="clientType" value="수주처">
	<input type="submit" id="clientType" name="clientType" value="발주처">
	</div>
	</form>
	<!--  본문 내용  -->
	<div class="clientbody1">
	<div class="tableform"> 
	
			<div class="clienttotal">
			 <h2 class="h2class"> 총  ${pageDTO.count} 건 &nbsp;&nbsp;<span class="notificlient">* 거래처명을 클릭하면 상세하게 볼 수 있습니다.</span></h2>
			
			<div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="perfInsert()">
			</div>
			
			
			</div>
            
		<table class="ct" id="ct">
			<thead class="cthead">
				<tr>
					<th class="ctno"><label> 구분</label></th>
					<th class="ctno"><label>거래처코드</label></th>
					<th class="ctnum"><label> 거래처명</label></th>
					<th class="ctno"><label>사업자번호</label></th>
					<th class="ctno"><label>업태</label></th>
					<th class="ctno"><label>대표자</label></th>
					<th class="ctno"><label>담당자</label></th>
					<th class="ctno"><label>거래처주소</label></th>
					<th class="ctnum"><label>거래처번호</label></th>
					<th class="ctnum"><label>휴대폰번호</label></th>
					<th class="ctnum"><label>팩스번호</label></th>
					<th class="ctnum"><label>이메일</label></th>
					<th class="ctno"><label>비고</label></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="clientDTO" items="${clientList}">
					<tr>
						<td class="cttg">${clientDTO.clientType}</td>
						<td class="cttg">${clientDTO.clientCode}</td>
						<td class="cttg"
							 onclick="openClientDetail('${clientDTO.clientCompany}')" id="click">${clientDTO.clientCompany}</td>
						<td class="cttg">${clientDTO.clientNumber}</td>
						<td class="cttg">${clientDTO.clientDetail}</td>
						<td class="cttg">${clientDTO.clientCeo}</td>
						<td class="cttg">${clientDTO.clientName}</td>
						<td class="cttg">${clientDTO.aliasAddr1}</td>
						<td class="cttg">${clientDTO.clientTel}</td>
						<td class="cttg">${clientDTO.clientPhone}</td>
						<td class="cttg">${clientDTO.clientFax}</td>
						<td class="cttg">${clientDTO.clientEmail}</td>
						<td class="cttg">${clientDTO.aliasMemo}</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
		
		<div class="page"> <!--  페이징 영역 -->
				<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
					<a class="a" href="${pageContext.request.contextPath}/client/client?pageNum=${pageDTO.startPage - pageDTO.pageBlock}&clientCompany=${clientDTO.clientCompany}&clientType=${clientDTO.clientType}">Prev</a>
				</c:if>
				

				<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
					<a class="a" href="${pageContext.request.contextPath}/client/client?pageNum=${i}&clientCompany=${clientDTO.clientCompany}&clientType=${clientDTO.clientType}">${i}</a>
				</c:forEach>


				<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
					<a  class="a" href="${pageContext.request.contextPath}/client/client?pageNum=${pageDTO.startPage + pageDTO.pageBlock}&clientCompany=${clientDTO.clientCompany}&clientType=${clientDTO.clientType}">Next</a>
				</c:if>
				
			</div> <!--  페이징영역 -->
		
		</div> <!--  TABLE FORM -->
		
					

			</div> <!--  CLIENTBODY1 -->
			
			</div> <!--  CLIENTBODY -->
			

		<script>	
			function perfInsert() {
				window
						.open(
								'${pageContext.request.contextPath}/client/clientinsert',
								'_blank',
								'width=520px, height=700px, left=400px, top=200px');
			}
			
			// 클라이언트 회사 이름을 클릭했을 때 실행될 함수
		    function openClientDetail(clientCompany) {
		        var url = '${pageContext.request.contextPath}/client/clientdetail?clientCompany=' + clientCompany;
		        window.open(url, '_blank', 'width=470px, height=650px, left=600px, top=100px');
		    }
			
			
			
			
		</script>
</body>
</html>