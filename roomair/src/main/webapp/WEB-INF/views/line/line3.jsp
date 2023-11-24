<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
</head>

<script type="text/javascript">

window.onload = function(){
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;
    document.querySelector(".lineInsertDate").value = today;
}

$.ajax({
    url: '${pageContext.request.contextPath}/employees/empdropdown', // 서버로 요청을 보낼 URL을 수정해주세요.
    type: 'GET',
    success: function(data) {
        var dropdown = $('select[name="lineEmpId"]');
        dropdown.empty();
        $.each(data, function(key, entry) {
            if(entry.empId != 1) {
                var optionText = '사원번호=' + entry.empId + ', 사원이름=' + entry.empName;
                dropdown.append($('<option></option>').attr('value', entry.empId).text(optionText));
            }
        });
    }
});
</script>

<body>
<div class="container">
<h2>라인수정</h2>
<form action="${pageContext.request.contextPath}/line/updatePro" id="join" method="post">

<div class="form-group"><p>라인코드:</p><input type="text" name="lineCode" class="lineCode" value="${lineDTO.lineCode}"></div>
<div class="form-group"><p>라인명:</p><input type="text" name="lineName" class="lineName" value="${lineDTO.lineName}"></div>
<div class="form-group">
  <p>사용여부:</p>
  <select name="lineUse" class="lineUse select">
    <option value="미사용" ${lineDTO.lineUse == '미사용' ? 'selected' : ''}>미사용</option>
    <option value="사용" ${lineDTO.lineUse == '사용' ? 'selected' : ''}>사용</option>
    <option value="점검" ${lineDTO.lineUse == '점검' ? 'selected' : ''}>점검</option>
    <option value="고장" ${lineDTO.lineUse == '고장' ? 'selected' : ''}>고장</option>
  </select>
</div>
<div class="form-group"><p>등록자:</p><select name="lineEmpId" class="lineEmpId select"></select></div>
<div class="form-group"><p>등록일:</p><input type="date" name="lineInsertDate" class="lineInsertDate" value="${lineDTO.lineInsertDate}"></div>
<div class="form-group">
  <p>공정:</p>
  <select name="lineProcess" class="lineProcess select">
    <option value="1차공정" ${lineDTO.lineProcess == '1차공정' ? 'selected' : ''}>1차공정</option>
    <option value="2차공정" ${lineDTO.lineProcess == '2차공정' ? 'selected' : ''}>2차공정</option>
    <option value="3차공정" ${lineDTO.lineProcess == '3차공정' ? 'selected' : ''}>3차공정</option>
  </select>
</div>
<button onclick="save" id="save-button">수정하기</button>

</form>
</div>
</body>
</html>