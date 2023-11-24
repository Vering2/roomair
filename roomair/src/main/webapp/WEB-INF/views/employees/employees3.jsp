<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사수정</title>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
<h2>인사수정</h2>
<form action="${pageContext.request.contextPath}/employees/updatePro" id="join" method="post" enctype="multipart/form-data">

<div class="form-group"><p>사원번호</p><input type="text" name="empId" class="empId" value="${employeesDTO.empId}" readonly="readonly"></div>
<div class="form-group"><p>비밀번호</p><input type="password" name="empPass" class="empPass" value="${employeesDTO.empPass}"></div>
<div class="form-group"><p>사원명</p><input type="text" id="empName" name="empName" class="empName" value="${employeesDTO.empName}"></div>
<span id ="empNamemsg">  </span> 
<div class="form-group">
  <p>부서</p>
  <select name="empDepartment" class="empDepartment select">
    <option value="인사팀" ${employeesDTO.empDepartment == '인사팀' ? 'selected' : ''}>인사팀</option>
    <option value="영업팀" ${employeesDTO.empDepartment == '영업팀' ? 'selected' : ''}>영업팀</option>
    <option value="자재팀" ${employeesDTO.empDepartment == '자재팀' ? 'selected' : ''}>자재팀</option>
    <option value="생산팀" ${employeesDTO.empDepartment == '생산팀' ? 'selected' : ''}>생산팀</option>
  </select>
</div>
<div class="form-group">
  <p>직책</p>
  <select name="empPosition" class="empPosition select">
    <option value="사원" ${employeesDTO.empPosition == '사원' ? 'selected' : ''}>사원</option>
    <option value="선임" ${employeesDTO.empPosition == '선임' ? 'selected' : ''}>선임</option>
    <option value="책임" ${employeesDTO.empPosition == '책임' ? 'selected' : ''}>책임</option>
    <option value="수석" ${employeesDTO.empPosition == '수석' ? 'selected' : ''}>수석</option>
  </select>
</div>
<div class="form-group"><p>이메일</p><input type="email" id ="empEmail" name="empEmail" class="empEmail" value="${employeesDTO.empEmail}"></div>
                                                                <span id ="empEmailmsg">  </span> 
<div class="form-group"><p>전화번호</p><input type="text"  id ="empTel" name="empTel" class="empTel" placeholder="-없이 입력하세요." value="${employeesDTO.empTel}" maxlength=11></div>
                                                                  <span id ="empTelmsg">  </span> 
<div class="form-group"><p>입사일자</p><input type="date" name="empHiredate" class="empHiredate" value="${employeesDTO.empHiredate}"></div>
<div class="form-group">
  <p>재직구분</p>
  <select name="empState" class="empState select">
    <option value="재직" ${employeesDTO.empState == '재직' ? 'selected' : ''}>재직</option>
    <option value="휴직" ${employeesDTO.empState == '휴직' ? 'selected' : ''}>휴직</option>
    <option value="퇴사" ${employeesDTO.empState == '퇴사' ? 'selected' : ''}>퇴사</option>
  </select>
</div>
<div class="form-group">
    <p>프로필사진</p>
    <button id="upload-button" type="button">사진 변경</button>
    <button id="delete-button" type="button">사진 삭제</button>
<!--     새로운 파일, 미리보기 -->
    <input type="file" id="file" name="file" accept="image/*" onchange="previewImage()" style="display: none;" />
<!--     기존파일 -->
    <input type="hidden" id="oldfile" name="oldfile" value="${employeesDTO.empFile}">
</div>
<div class="form-group">
    <p></p>
    <c:choose>
    <c:when test="${employeesDTO.empFile != null}">
        <img src="${pageContext.request.contextPath}/resources/img/${employeesDTO.empFile}" id="preview" />
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/resources/img/default.jpg" id="preview" />
    </c:otherwise>
</c:choose>

</div>
<button id="save-button" onclick="save">저장하기</button>

</form>
</div>
<script>
document.getElementById('delete-button').addEventListener('click', function() {
//     사진 삭제 누르면 기본이미지 보여줌
    document.getElementById('preview').src = "${pageContext.request.contextPath}/resources/img/default.jpg";
    
    // 파일 입력 필드를 초기화합니다.
    document.getElementById('file').value = '';
    document.getElementById('oldfile').value = '';
});
// 파일 업로드 버튼 누르면 input file 클릭됨
document.getElementById('upload-button').addEventListener('click', function() {
    document.getElementById('file').click();
});
// 업로드된 파일 미리보기+버튼 숨기기
function previewImage() {
    var file = document.getElementById("file").files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
        document.getElementById("preview").src = reader.result;
    }

    if (file) {
        reader.readAsDataURL(file);
    } else {
        document.getElementById("preview").src = "";
    }
}


//////// 정규식 제어 
var koreanRegex = /^[가-힣]+$/; // 한글만 허용하는 정규식
     // 이메일 정규식
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

 // 휴대폰 번호 정규식 (숫자만 허용하는 가정)
    var phoneNumberRegex = /^(010|011|016|017|019)\d{8}$/;
    
document.getElementById("empName").addEventListener("input", function() {
    var empName = this.value;
    
    // 숫자와 특수문자 제거
    empName = empName.replace(/[\d`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/g, '');
    
    if (empName === "") {
        document.getElementById("empNamemsg").textContent = ""; // 메시지 초기화
        document.getElementById("empNamemsg").style.position = "absolute"; // 메시지 숨기기
    } else if (!koreanRegex.test(empName)) {
        document.getElementById("empNamemsg").textContent = "올바른 한글 이름을 입력하세요.";
        document.getElementById("empNamemsg").style.position = "relative"; // 메시지 표시
    } else {
        document.getElementById("empNamemsg").textContent = ""; // 메시지 초기화
        document.getElementById("empNamemsg").style.position = "absolute"; // 메시지 숨기기
    }
    
    this.value = empName;
});


document.getElementById("empEmail").addEventListener("input", function() {
    var empEmail = this.value;
    
    empEmail = empEmail.replace(/[ㄱ-ㅎ가-힣]/g, '').replace(/[^a-zA-Z0-9.@]/g, '');

    if (empEmail === "") {
        document.getElementById("empEmailmsg").textContent = ""; // 메시지 초기화
        document.getElementById("empEmailmsg").style.position = "absolute"; // 메시지 숨기기
    } else if (!emailRegex.test(empEmail)) {
        document.getElementById("empEmailmsg").textContent = "올바른 이메일 주소를 입력하세요.";
        document.getElementById("empEmailmsg").style.position = "relative"; // 메시지 표시
    } else {
        document.getElementById("empEmailmsg").textContent = ""; // 메시지 초기화
        document.getElementById("empEmailmsg").style.position = "absolute"; // 메시지 숨기기
    }
 // 입력란에 업데이트된 값 설정
    this.value = empEmail;
});

document.getElementById("empTel").addEventListener("input", function() {
    var empTel = this.value;

    // 하이픈 제거
    empTel = empTel.replace(/-/g, '');

    // 숫자만 남기기
    empTel = empTel.replace(/[^\d]/g, '');

    if (empTel === "") {
        document.getElementById("empTelmsg").textContent = ""; // 메시지 초기화
        document.getElementById("empTelmsg").style.position = "absolute"; // 메시지 숨기기
    } else if (!phoneNumberRegex.test(empTel)) {
        document.getElementById("empTelmsg").textContent = "올바른 휴대폰 번호를 입력하세요.";
        document.getElementById("empTelmsg").style.position = "relative"; // 메시지 표시
    } else {
        document.getElementById("empTelmsg").textContent = ""; // 메시지 초기화
        document.getElementById("empTelmsg").style.position = "absolute"; // 메시지 숨기기
    }
    
 // 입력란에 업데이트된 값 설정 (하이픈이 없는 숫자만 남김)
    this.value = empTel;
 
});

var form = document.getElementById("join"); // 폼 엘리먼트의 ID를 지정해야 합니다.

form.addEventListener("submit", function(event) {
    var empName = document.getElementById("empName").value;
    var empEmail = document.getElementById("empEmail").value;
    var empTel = document.getElementById("empTel").value;

    // 이름 유효성 검사
    empName = empName.replace(/[\d`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/g, '');
    if (empName === "" || !koreanRegex.test(empName)) {
        document.getElementById("empNamemsg").textContent = "올바른 한글 이름을 입력하세요.";
        document.getElementById("empNamemsg").style.position = "relative"; // 메시지 표시
        event.preventDefault(); // 폼 제출을 막습니다.
        return;
    } else {
        document.getElementById("empNamemsg").textContent = ""; // 메시지 초기화
    }

    // 이메일 유효성 검사
    empEmail = empEmail.replace(/[ㄱ-ㅎ가-힣]/g, '').replace(/[^a-zA-Z0-9.@]/g, '');
    if (!emailRegex.test(empEmail)) {
        document.getElementById("empEmailmsg").textContent = "올바른 이메일 주소를 입력하세요.";
        document.getElementById("empEmailmsg").style.position = "relative"; // 메시지 표시
        event.preventDefault(); // 폼 제출을 막습니다.
        return;
    } else {
        document.getElementById("empEmailmsg").textContent = ""; // 메시지 초기화
    }

    // 휴대폰 번호 유효성 검사
    empTel = empTel.replace(/-/g, '');
    empTel = empTel.replace(/[^\d]/g, '');
    if (!phoneNumberRegex.test(empTel) || empTel.length !== 11) {
        document.getElementById("empTelmsg").textContent = "올바른 휴대폰 번호를 입력하세요.";
        document.getElementById("empTelmsg").style.position = "relative"; // 메시지 표시
        event.preventDefault(); // 폼 제출을 막습니다.
        return;
    } else {
        document.getElementById("empTelmsg").textContent = ""; // 메시지 초기화
    }
});


</script>
</body>
</html>