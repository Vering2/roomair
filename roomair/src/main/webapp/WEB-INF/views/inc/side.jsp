<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/25ef23e806.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="sidebar">
		<div class="sidebody">
			<div class="logininfo">
				<!------------------------------ 로고 ------------------------->
				<div id="logo">
					<a href="${pageContext.request.contextPath }/main/calendar"> 
					<%-- <img src="${pageContext.request.contextPath }/resources/img/blackLogo.png" id="logoImage"> --%>
					 <img src="${pageContext.request.contextPath }/resources/img/whiteLogo.png" id="logoImage"> 
					</a>
				</div>
			
				<!------------------------------ 사원 사진 ------------------------->
				<div class="profile-pic">
				<!-- 				파일 없으면 기본이미지 있으면 본인 이미지 -->
    <c:choose>
    <c:when test="${not empty sessionScope.empFile}">
        <img id="profilePic" src="${pageContext.request.contextPath}/resources/img/${sessionScope.empFile}">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/resources/img/default.jpg">
    </c:otherwise>
</c:choose>

</div>
				
				<!------------------------------ 로그인 이름 ------------------------->
				<p class="loginName"><span class="empId">${sessionScope.empName}</span> 님</p>

				
			</div>
			
			<!------------------------------ 목록 탭(기준정보 관리)------------------------->
			<ul id="sideaccordion" class="sideaccordion">
				<li>
					<div class="sidelink">
						 <i class="fa-solid fa-chart-simple"></i> 
						기준정보 관리
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/requirement/reqDetail"
							class="sidea">소요량 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/product/list"
							class="sidea">제품 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/Rawmaterials/home"
							class="sidea">원자재 관리</a></li>
					</ul>
				</li>
				<!------------------------------  목록 탭(생산 관리)------------------------->
				<li>
					<div class="sidelink">
					 <i class="fa-solid fa-bars"></i>
						생산 관리
					</div>
					<ul class="submenu">

						<li><a
							href="${pageContext.request.contextPath }/workorder/workOrderList"
							class="sidea">작업지시 관리</a></li>
						<li><a href="${pageContext.request.contextPath }/line/line"
							class="sidea">라인 관리</a></li>
						<li><a href="${pageContext.request.contextPath }/perf/perf"
							class="sidea">생산실적 관리</a></li>
					</ul>
				</li>
				<!------------------------------  목록 탭(자재 관리)------------------------->
				<li>
					<div class="sidelink">
						 <i class="fa-solid fa-warehouse"></i>
						자재 관리
						<!-- <i class="fa-solid fa-angle-down"></i> -->
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/stock/listraw"
							class="sidea">재고 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/inMaterial/list"
							class="sidea">입고 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/outProduct/list"
							class="sidea">출고 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/Warehouse/list"
							class="sidea">창고 관리</a></li>
					</ul>
				</li>
				<!------------------------------  목록 탭(영업 관리)------------------------->
				<li>
					<div class="sidelink">
						 <i class="fa-solid fa-pen"></i>
						 영업 관리
					</div>
					<ul class="submenu">
					<li><a
							href="${pageContext.request.contextPath}/client/client"
							class="sidea">거래처 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath}/sell/sellMain"
							class="sidea">수주 관리</a></li>
						<li><a
							href="${pageContext.request.contextPath}/OrderManagement/home"
							class="sidea">발주 관리</a></li>
						
					</ul>
				</li>
				<!------------------------------  목록 탭(인사 관리)------------------------->
				<li>
					<div class="sidelink">
						 <i class="fa-solid fa-pen"></i>
						인사 관리
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/employees/employees"
							class="sidea">사원 관리</a></li>
					</ul>
				</li>
			</ul>
			<div class="logoutDiv">
				
					<a href="${pageContext.request.contextPath}/login/logout" class="logout" >로그아웃</a>
				
			</div>
		</div>
		
	</div>
	
	
<!--#################################################### script #################################################  -->
	<script>
	
	window.onload = function() {
        var img = document.getElementById('profilePic');
        img.onerror = function() {
            this.src = '${pageContext.request.contextPath }/resources/img/default.jpg'; // 기본 이미지 경로
        }
    }
	
	   $(document).ready(function () {
	            var bodyHeight = $("body").height();
		   setTimeout(function() {
			    // 이 부분에 0.01초 후에 실행할 코드를 작성하세요.
	            var sidebody = $('.sidebody');
	            var sidebar = $('.sidebar');
	            var scrollLimit = bodyHeight - sidebody.height(); 
	            var screenHeight = window.innerHeight; // 현재 보고있는 화면의 높이
	            
	            if(scrollLimit <= 0){ // 음수면 움직임을 막기 위해서 0 초기화
	            	scrollLimit = 0;
	            }
				console.log("bodyHeight : "+bodyHeight);
				console.log("sidebar : "+sidebody.height());
				console.log("scrollLimit : "+scrollLimit);
	            
	            $('.sidebody').css('height', screenHeight + 'px'); // 사이드 바의 높이를 지정
	           
	            $(window).on('scroll', function () {
	                var scrollTop = $(this).scrollTop();
	                var newTop = scrollTop; // 상단에 고정
	
	                // 스크롤을 scrollLimit 이하로 제한
	                if (scrollTop > scrollLimit) {
	                    newTop = scrollLimit;
	                }
	
	                sidebar.css('top', newTop + 'px');
	            });
			}, 10); 
            
        }); 
       /*  $(document).ready(function () {
            var sidebody = $('.sidebody');
            var sidebar = $('.sidebar');
            var screenHeight = window.innerHeight; // 현재 보고 있는 화면의 높이
            var bodyHeight = $("body").height();

            if (bodyHeight < screenHeight) {
                sidebody.css('height', screenHeight + 'px');
                bodyHeight = screenHeight;
            }

            console.log("bodyHeight: " + bodyHeight);
            console.log("sidebar: " + sidebody.height());

            $(window).on('scroll', function () {
                var scrollTop = $(this).scrollTop();
                var newTop = scrollTop;

                sidebar.css('top', newTop + 'px');
            });
        }); */
 





    $(function () {
        var Accordion = function (el, multiple) {
            this.el = el || {};
            this.multiple = multiple || false;

            var links = this.el.find('.sidelink');
            links.on('click', {
                el: this.el,
                multiple: this.multiple
            }, this.dropdown)
        }

        Accordion.prototype.dropdown = function (e) {
            var $el = e.data.el;
            $this = $(this), $next = $this.next();

            $next.slideToggle();
            $this.parent().toggleClass('open');

            if (!e.data.multiple) {
                $el.find('.submenu').not($next).slideUp().parent()
                    .removeClass('open');
            }
        }

        var accordion = new Accordion($('#sideaccordion'), false);
    });
</script>
</body>
</html>