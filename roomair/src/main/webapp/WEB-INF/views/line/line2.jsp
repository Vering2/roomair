<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.lineProcess').addEventListener('change', function() {
        var lineCode = document.querySelector('.lineCode');
        switch(this.value) {
            case '1차공정':
                lineCode.value = 'L10';
                break;
            case '2차공정':
                lineCode.value = 'L20';
                break;
            case '3차공정':
                lineCode.value = 'L30';
                break;
            default:
                lineCode.value = '';
        }
    });
});

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
<h2>라인등록</h2>
<form action="${pageContext.request.contextPath}/line/insertPro" id="join" method="post">

<div class="form-group"><p>라인코드:</p><input type="text" name="lineCode" class="lineCode" value="L10"></div>
<div class="form-group"><p>라인명:</p><input type="text" name="lineName" class="lineName"></div>
<div class="form-group"><p>사용여부:</p>
<select name="lineUse" class="lineUse select">
    <option value="미사용">미사용</option>
    <option value="사용">사용</option>
    <option value="점검">점검</option>
    <option value="고장">고장</option>
</select></div>
<div class="form-group"><p>등록자:</p><select name="lineEmpId" class="lineEmpId select"></select></div>
<div class="form-group"><p>등록일:</p><input type="date" name="lineInsertDate" class="lineInsertDate"></div>
<div class="form-group"><p>공정:</p>
<select name="lineProcess" class="lineProcess select">
<option value="1차공정">1차공정</option>
<option value="2차공정">2차공정</option>
<option value="3차공정">3차공정</option>
</select></div>
<button onclick="save" id="save-button">저장하기</button>

</form>
</div>
</body>
</html>