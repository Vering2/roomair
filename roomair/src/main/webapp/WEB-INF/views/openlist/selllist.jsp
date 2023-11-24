<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


<!-- <link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet"> -->
<link href="${pageContext.request.contextPath }/resources/css/requirement.css"
	rel="stylesheet" type="text/css">

<!-- 폰트 -->

<script>
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		
		var isPop = urlParams.get("input");
		
		if(isPop==="null") {
			isPop = null;
		}
		
		$('#pagination a').each(function(){
			
	   		var prHref = $(this).attr("href");
	   		
	   		var newHref = prHref + "&input=" + isPop;
	   			$(this).attr("href", newHref);
				
		}); //페이징 요소	
				
		$('#input').val(isPop);
   			
   		if(isPop) {
        		
       		$('table tr').click(function(){
       			$(this).css('background', '#ccc');
        			
       			var clientCompany = $(this).find('#clientCompany').text();
     			var sellCode = $(this).find('#sellCode').text();
     			var prodName = $(this).find('#prodName').text();
     			var prodCode = $(this).find('#prodCode').text();
     			var workAmount = $(this).find('#workAmount').text();
     			var sellCount = $(this).find('#sellCount').text();
     			
     			
     			var number = isPop.match(/\d+/);
     			if(number !=null){
     			$('#sellCode'+number, opener.document).val(sellCode);
     			$('#clientCompany'+number, opener.document).val(clientCompany);
     			$('#prodName'+number, opener.document).val(prodName);
     			$('#prodCode'+number, opener.document).val(prodCode);
     			$('#workAmount'+number, opener.document).val(workAmount);
     			$('#sellCount'+number, opener.document).val(sellCount);
     			
     			} else {
     			$('#sellCode8888', opener.document).val(sellCode);
     			$('#clientCompany8888', opener.document).val(clientCompany);
     			$('#workAmount8888', opener.document).val(workAmount);
     			$('#sellCount8888', opener.document).val(sellCount);
     			}
     			
         		window.close();
         	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
    	} else {
    		console.log("팝업아님");
    	} //if(팝업으로 열었을 때)
    		
	} //popUp()
		//jQuery
        $(document).ready(function() {
        	
        	popUp();
        	
        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			var num = "<c:out value='${paging.nowPage}'/>";
    			var num2 = "<c:out value='${paging.cntPerPage}'/>";
    			$(this).find('td:first').text(((num-1)*num2) + index);
    		});
             
        });
    </script>
   

   
   
<!-- page content -->
<body>
<div class="right_col">

	<h1 style="margin-left: 1%;">수주 목록</h1>
	
	
	<form method="get">
		<fieldset>
       		
       		<input type="hidden" name="input" id="input" value="${input }">   		

       		<label>코드&nbsp;</label>
        	<input style="width:175; font: 500 15px/15px 'Inter', sans-serif;" class="input_box" type="text" name="sellCode" id="searchCode" onfocus="this.value='SL'" placeholder="코드를 입력하세요."> &nbsp;&nbsp;
        	<label>거래처&nbsp;</label>
        	<input style="width:175; font: 500 15px/15px 'Inter', sans-serif;" class="input_box" type="text" name="clientCompany" id="searchName"  placeholder="거래처를 입력하세요."> &nbsp;&nbsp;
        	
        	<input type="submit" class="button" value="조회">

		</fieldset>
	</form>




	<div class="x_panel">
	
			<div class="x_title" style="width:680;">
				<h2><small> 총 ${paging.total} 건</small></h2>
				
			</div>
			
		<form id="fr" method="post">
		<!-- 버튼 제어 -->
		
		<div class="x_content">
			<div class="table-responsive">
				<div class="table-wrapper" >
<%-- 		완제품 목록 총 ${paging.total}건 --%>
		<table id="sellTable"
		class="table table-striped jambo_table bulk_action" style="text-align-last:center;">
			<thead>
				<tr class="headings">
					<th>번호</th>
					<th>코드</th>
					<th>거래처</th>
					<th>제품</th>
					<th>수주수량</th>
					<th>최소지시수량</th>
					<th style='display: none;'></th>
					
				</tr>
			</thead>
			
			
			<c:forEach var="dto" items="${sellList}">
					<tr style="font: 500 20px/20px 'Inter', sans-serif;">
						<td></td>
						<td id="sellCode">${dto.sellCode }</td>
         			    <td id="clientCompany">${dto.clientCompany }</td>
						<td id="prodName">${dto.prodName }</td>
						<td id="sellCount">${dto.sellCount}</td>
						
            <c:set var="difference" value="${dto.sellCount - dto.stockCount}" />
            <c:choose>
                <c:when test="${difference > 0}">
                     <td id="workAmount">${difference}</td>
                </c:when>
                <c:otherwise>
                    <td id="workAmount">0</td>
                </c:otherwise>
            </c:choose>
						<td style='display: none;' id="prodCode">${dto.prodCode }</td>
					</tr>
			</c:forEach>
		</table>
		</div>
		</div>
		</div>
	</form>
	
	<!-- //////////////////////////////////////////////////////////////////////// -->

</div>

</div>

<div id="pagination" class="page_wrap" >
			<div class="page_nation" style="text-align: center; font-size: 0; position: absolute; bottom: 1%; right: 1%;">
						<c:if test="${paging.startPage != 1 }">
							<a class="arrow prev" href="${pageContext.request.contextPath}/search/sell?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&clientCompany=${dto.clientCompany }&sellCode=${dto.sellCode }">◀️</a>
						</c:if>
					
						<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
							
								<c:choose>
        <c:when test="${p eq paging.nowPage}">
            			<a class="active" href="${pageContext.request.contextPath}/search/sell?nowPage=${p }&cntPerPage=${paging.cntPerPage}&clientCompany=${dto.clientCompany }&sellCode=${dto.sellCode }">${p }</a>
					 </c:when>
        <c:otherwise>
           			<a class="a" href="${pageContext.request.contextPath}/search/sell?nowPage=${p }&cntPerPage=${paging.cntPerPage}&clientCompany=${dto.clientCompany }&sellCode=${dto.sellCode }">${p }</a>
					 </c:otherwise>
    </c:choose>
							
							
							
						</c:forEach>
					
						<c:if test="${paging.endPage != paging.lastPage}">
							<a class="arrow next" href="${pageContext.request.contextPath}/search/sell?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&clientCompany=${dto.clientCompany }&sellCode=${dto.sellCode }">▶️</a>
						</c:if>
					</div>
			</div>
</body>
