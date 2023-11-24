<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<!-- 			로고자리 -->
				<%-- 				<a href="${pageContext.request.contextPath }/main/calendar" style="font-size: 40px; padding: 30px;" >ROOMAIR</a> --%>
				<div id="logo">
					<a href="${pageContext.request.contextPath }/main/calendar"> <img
						src="${pageContext.request.contextPath }/resources/img/logo.png">
					</a>
				</div>
				<!-- 			로고자리 -->
				<p class="loginhi">${sessionScope.empId}님 안녕하세요</p>
			</div>
			<ul id="sideaccordion" class="sideaccordion">
				<li>
					<div class="sidelink">
						<i class="fa-solid fa-chart-simple"></i> 기준정보관리
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/requirement/reqDetail"
							class="sidea">소요량관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/product/list"
							class="sidea">품목관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/Rawmaterials/home"
							class="sidea">원자재관리</a></li>
					</ul>
				</li>
				<li>
					<div class="sidelink">
						<i class="fa-solid fa-bars"></i>생산관리
					</div>
					<ul class="submenu">

						<li><a
							href="${pageContext.request.contextPath }/workorder/workOrderList"
							class="sidea">작업지시관리</a></li>
						<li><a href="${pageContext.request.contextPath }/line/line"
							class="sidea">라인관리</a></li>
						<li><a href="${pageContext.request.contextPath }/perf/perf"
							class="sidea">생산실적관리</a></li>
					</ul>
				</li>
				<li>
					<div class="sidelink">
						<i class="fa-solid fa-warehouse"></i>자재관리<i
							class="fa-solid fa-angle-down"></i>
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/stock/listraw"
							class="sidea">재고관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/inMaterial/list"
							class="sidea">입고관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/outProduct/list"
							class="sidea">출고관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/Warehouse/list"
							class="sidea">창고관리</a></li>
					</ul>
				</li>
				<li>
					<div class="sidelink">
						<i class="fa-solid fa-pen"></i>영업관리
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath}/sell/sellMain"
							class="sidea">수주관리</a></li>
						<li><a
							href="${pageContext.request.contextPath}/OrderManagement/home"
							class="sidea">발주관리</a></li>
						<li><a
							href="${pageContext.request.contextPath}/client/client"
							class="sidea">거래처관리</a></li>
					</ul>
					<div class="sidelink">
						<i class="fa-solid fa-pen"></i>인사관리
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/employees/employees"
							class="sidea">사원관리</a></li>
					</ul>
				</li>
			</ul>
			<div class="logininfo" style="text-align: center;">
				<p>
					<a href="${pageContext.request.contextPath}/login/logout"
						style="color: #929FA8; text-decoration: none;">로그아웃</a>
				<p>
			</div>
		</div>





	</div>

	<script>
	  $(document).ready(function () {
            var bodyHeight = $("body").height();
            var sidebody = $('.sidebody');
            var sidebar = $('.sidebar');
            var scrollLimit = bodyHeight - sidebody.height(); 
            var screenHeight = window.innerHeight; // 현재 보고있는 화면의 높이
            
            if(scrollLimit <= 0){ // 음수면 움직임을 막기 위해서 0 초기화
            	scrollLimit = 0;
            }
            
            $('.sidebody').css('height', screenHeight + 'px'); // 사이드 바의 높이를 지정
            
			console.log("bodyHeight : "+bodyHeight);
			console.log("sidebar : "+sidebody.height());
			console.log("scrollLimit : "+scrollLimit);
            $(window).on('scroll', function () {
                var scrollTop = $(this).scrollTop();
                var newTop = scrollTop; // 상단에 고정

                // 스크롤을 scrollLimit 이하로 제한
                if (scrollTop > scrollLimit) {
                    newTop = scrollLimit;
                }

                sidebar.css('top', newTop + 'px');
            });
        });

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