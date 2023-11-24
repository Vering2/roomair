<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<%-- <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css">
 --%>
<style type="text/css">
body {
	font-family: Arial, sans-serif;
	background-color: #F5F6FA;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-container {
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 20px;
	width: 500px;
	height: 480px;
}

h1 {
	color: black;
	margin-bottom: 20px;
}

.input-group {
	margin-bottom: 20px;
}

input[type="text"], input[type="password"] {
	width: 55%;
	padding: 10px;
	border-radius: 3px;
	outline: none;
	border: 1px solid #A6A6A6; /* 테두리 색 설정 */
	background-color: #FFFFFF; /* 배경색 설정 */
	font-size:20px; 
}

button {
	width:55%px !important ;
	height: 40px;
	background-color: #9AC5F4;
	color: white;
	border: none;
	border-radius: 3px;
	margin-top: 30px;
	margin-bottom: 10px;
	font-size:20px; 
	font-weight: bolder;
}

button:hover {
	background-color: #1D5D9B;
}
#logo{
	text-align: center;
	margin-top: 20px;
	margin-bottom:60px;
}
#logoImage{
	width: 300px; 
	display: inline-block;
}
</style>
</head>
<body>
	<div class="login-container">
	<div id="logo">
					
					<img src="${pageContext.request.contextPath }/resources/img/blackLogo.png" id="logoImage"> 
					
				</div>
		<h1>로그인</h1>
		<form action="${pageContext.request.contextPath}/login/loginPro" id="login" method="post">
			
			<div class="input-group">
				<input type="text" id="empId" name="empId" placeholder="아이디" required>
			</div>
	
			<div class="input-group">
				<input type="password" id="empPass" name="empPass" placeholder="비밀번호" required> 
				<%-- <input type="hidden" name="empName" value="${loginDTO.empName}" /> --%>
			</div>
		
			<button type="submit" style="width: 60%">로그인</button>
		</form>
	</div>
	
	
</body>
<script type="text/javascript">
/* $(document).ready(function(){
//		id="join" 폼을 전송했을때
	$('#login').submit(function(){

//      class="id"  value 비어있으면
		if($('.empId')!={loginDTO.empId}){
			// 아이디 입력하세요
			alert("계정 정보가 틀렸습니다");
			$('.empId').focus();
			//submit버튼이 동작하지 못하게 막음
			return false;
		}
	}); */

</script>

</html>
