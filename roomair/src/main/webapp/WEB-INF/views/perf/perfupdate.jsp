<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
</head>
<body>
<form action="${pageContext.request.contextPath}/perf/updatePro" method="post" id="updateform">
 	<table class="ct" id="ct">	
			<thead>
				<tr class="cthead">
				    <th>생산실적코드</th>
					<th>작업지시코드</th><!-- worklist에서 받아옴 -->
					<th>제품코드</th><!-- worklist에서 받아옴 -->
					<th>라인코드</th><!-- worklist에서 받아옴 -->
					<th >실적일</th>
					<th> 담당자 </th>
					<th >실적수량</th><!-- worklist에서 받아옴 -->
					<th >양품수</th><!-- worklist에서 받아옴 -->
					<th >불량수</th>
					<th >불량사유</th>
					<th>불량사유(기타)</th>
					<th >비고</th>
					<th >현황</th> <!-- worklist에서 받아옴 -->
				</tr>
			</thead> 
			<tbody>
					<tr class="ctcontents">
					    <td ><input type="text" id="perfCode" name="perfCode" value="${perfDTO.perfCode}"></td> <!--  생산실적코드 -->
						<td ><input type="text" id="workCode" name="workCode" value="${perfDTO.workCode}"> </td> <!--  작업지시코드 -->
						<td ><input type="text" id="prodCode" name="prodCode" value="${perfDTO.prodCode}"> </td> <!--  제품코드 -->
						<td ><input type="text" id="lineCode" name="lineCode" value="${perfDTO.lineCode}"> </td> <!--  제품코드 -->
						<td ><input type="text" id="perfDate" name="perfDate" value="${perfDTO.perfDate}"> </td> <!-- 실적일자(자동생성) -->
						<td ><input type="text" id="perfEmpId" name="perfEmpId" value="${perfDTO.perfEmpId}"></td> <!--  담당자아이디 -->
				        <td ><input type="number" id="perfAmount" name="perfAmount" value= "${perfDTO.perfAmount}" required></td> <!-- 실적수량 -->
						<td ><input type="number" id="perfFair" name="perfFair" required value="${perfDTO.perfFair}"></td> <!-- 양품수-->
						<td ><input type="number" id="perfDefect" name="perfDefect" value="${perfDTO.perfDefect}"></td> <!-- 불량수 -->
						
						<td ><select id="perfDefectreason" name="perfDefectreason" value="${perfDTO.perfDefectreason}">
	                    	    <option value="무결함">무결함</option>
		                      	<option value="파손">파손</option> <!-- 병깨짐 , 포장박스 꾸겨진거 등 -->
								<option value="누락">누락</option> <!--  포장 박스에 물건이 없다던가 포장이 안된다던가 -->
								<option value="기타">기타</option>
						       </select>                                                          </td>  <!-- 불량사유 -->
						       
						<td ><input type="text" id="perfDefectmemo" name="perfDefectmemo"value="${perfDTO.perfDefectmemo}"></td>  <!--기타 불량사유 -->
						<td ><input type="text" id="perfMemo" name="perfMemo" value="${perfDTO.perfMemo}"></td> <!-- 비고 -->
						<td ><input type="text" id="lineProcess" name="perfStatus" value="${perfDTO.perfStatus}"></td> <!-- 라인상테 -->
					</tr>
			</tbody> 
			</table>
	<div class="fbtn">
<input type="submit" value="수정">
</div>		
</form>



<script>
$(document).ready(function() {
    $('#updateform').submit(function(event) {
        event.preventDefault(); // 폼 기본 제출 동작 중단
        
        // AJAX로 폼 데이터를 서버에 전송
        $.ajax({
            type: 'POST',
            url: $(this).attr('action'),
            data: $(this).serialize(), // 폼 데이터 직렬화하여 전송
            success: function(response) {
                if (response.success) {
                    // 성공 메시지를 SweetAlert2로 표시
                    Swal.fire({
                        title: '성공',
                        text: '수정이 성공적으로 완료되었습니다.',
                        icon: 'success'
                    }).then(function() {
                        // 페이지 새로고침
                        location.reload();
                    });
                } else {
                    // 실패 메시지를 SweetAlert2로 표시
                    Swal.fire({
                        title: '실패',
                        text: '수정에 실패하였습니다.',
                        icon: 'error'
                    });
                }
            }
        });
    });
});
</script>

</body>
</html>