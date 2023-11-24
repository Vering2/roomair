<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-labels"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
    <script src="https://kit.fontawesome.com/25ef23e806.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/perf.css">
	<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
	
	 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker.css"> 

<style>
/* 모달 스타일 */
.modal {
  display: none;
  position: absolute; /* position 속성을 absolute로 변경 */
  z-index: 1;
  background-color: transparent; /* 배경색을 투명으로 변경 */
}

.modal-content {
	    font-size: 15px;
    background-color: #fff;
    padding: 5px;
    border: 1px solid #888;
    position: fixed;
}

.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover {
  cursor: pointer;
}

table {
    border-collapse: collapse;
    width: 96%;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    border-right: 1px solid #D9D9D9;
    border-bottom: 1px solid #D9D9D9;
    margin-left: auto;
    margin-right: auto;
    margin-top: 10px;
}
</style>
	
</head>
<body>
<body>
<!-- 모달 대화상자 -->
	<div id="myModal" class="modal">
	  <div class="modal-content">
	    <div class="modal-header">
	      <span class="close" id="closeModal">&times;</span>
	    </div>
	    <div class="modal-body">
	      <p>모달 내용을 여기에 넣으세요</p>
	    </div>
	  </div>
	</div>
<jsp:include page="../inc/side.jsp"></jsp:include>

<!--  여기서부터 시작  -->
<div class="clientBody">
		<h1 class="toptitle">생산실적 관리</h1>


<div class="perfcd">
<form method ="get">
<div class="perfcd1">
<label> 라인코드:</label>  <input type="text" id="lineCode2" name="lineCode" onclick="" class="cdbox" value="라인코드" readonly> <label>제품코드:</label> <input type="text" id="prodCode2" name="prodCode" onclick="" placeholder="제품코드" class="cdbox" onclick="" readonly> <input type="submit" value="조회" class="subbtn">



</div>
<!-- <div class="perfcd1">
 실적일: <input type="text" id="workdate1" name="perfDate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="perfDate2" class="form-control" placeholder="날짜 선택" readonly>
</div>  -->

</form>
</div> <!--  perfcd -->

	

	
<!--  본문 내용  -->
	<div class="clientbody1">
	<div class="tableform"> 
			<div class="clienttotal">
			 <h2> 총 ${pageDTO.count} 건 </h2>
			
			</div>   <!--  생산실적 총:x건 라인-->
			<div class="total-items">
		 <div>
			 <label>총 ${sellDTO.count}건</label>
		 </div>
		 <div class="PageSelect">
 			<label for="perPageSelect" style ="bottom:2px;">항목 수 </label>
			<select id="perPageSelect" class="input_box" style ="width:100px; bottom:2px;" onchange="applyFilters()" value="${pageDTO.pageSize}">
			    <option value="10" ${pageDTO.pageSize == 10 ? 'selected' : ''}>10개씩</option>
			    <option value="50" ${pageDTO.pageSize == 50 ? 'selected' : ''}>50개씩</option>
			    <option value="100" ${pageDTO.pageSize == 100 ? 'selected' : ''}>100개씩</option>
			    <option value="9999" ${pageDTO.pageSize == 9999 ? 'selected' : ''}>전체</option>
			</select>
		</div>
	</div>

		 <table class="ct" id="ct" class="ctcl">	
			<thead>
				<tr class="cthead">
				    <th class="ctth">생산실적코드</th>
					<th class="ctth">작업지시코드</th>
					<th class="ctth">제품코드</th>
					<th class="ctth">실적일</th>
					<th class="ctth">실적수량</th>
					<th class="ctth">양품수</th>
					<th class="ctth">불량수</th>
					<th class="ctth">불량사유</th>
					<th class="ctth">현황</th> 
					
				</tr>
			</thead> 
		 <tbody>
				<c:forEach var="perfDTO" items="${perflist}">
					<tr class="ctcontents">	    
						<td class="cttg">${perfDTO.perfCode} <i class="fa-solid fa-magnifying-glass magnifier" data-perfcode="${perfDTO.perfCode}"></i></td>
						<%-- <td class="cttg">${perfDTO.workCode}</td> --%>
						<td style='cursor: pointer;' onclick="openModal(event)" id="${perfDTO.workCode }" name="sellCode" value="${perfDTO.workCode }">${perfDTO.workCode }</td>
						
						<%-- <td class="cttg">${perfDTO.prodCode}</td> --%>
						<td style='cursor: pointer;' onclick="openModal(event)" id="${perfDTO.prodCode }" name="sellCode" value="${perfDTO.prodCode }">${perfDTO.prodCode }</td>
						
						<td class="cttg">${perfDTO.perfDate}</td>
						<td class="cttg">${perfDTO.perfAmount}</td>
						<td class="cttg">${perfDTO.perfFair}</td>
						<td class="cttg">${perfDTO.perfDefect}</td>
						<td class="cttg">${perfDTO.perfDefectreason}</td>
						<td class="cttg">${perfDTO.workProcess}</td>				
					</tr>
					</c:forEach>
			</tbody> 

		</table>
		
		<div class="footlo">
		<div class="excel">

		 <button type="button" id="entrytable" class="entrytable" onclick="window.location.href='${pageContext.request.contextPath}/perf/perf?pageNum=1&endPage=100&lineCode=${perfDTO.lineCode}&prodCode=${clientDTO.prodCode}'">전체 보기</button>
		  <button type="button" id="exceldownload" class="exceldown" >액셀 다운 </button>
		  </div>
		  <div class="page"> <!--  페이징 영역 -->
				<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
					<a class="a" href="${pageContext.request.contextPath}/perf/perf?pageNum=${pageDTO.startPage - pageDTO.pageBlock}&lineCode=${perfDTO.lineCode}&prodCode=${clientDTO.prodCode}">Prev</a>
				</c:if>
				

				<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
					<a  class="a" href="${pageContext.request.contextPath}/perf/perf?pageNum=${i}&lineCode=${perfDTO.perfCode}&prodCode=${perfDTO.prodCode}">${i}</a>
				</c:forEach>


				<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
					<a class="a" href="${pageContext.request.contextPath}/perf/perf?pageNum=${pageDTO.startPage + pageDTO.pageBlock}&lineCode=${perfDTO.lineCode}&prodCode=${perfDTO.prodCode}">Next</a>
				</c:if>
				
			</div> <!--  페이징영역 -->
		 </div>
		 </div>
		 
		 	
		
		
		
		
		</div> <!--  TABLE FORM -->
		 
		 <div class="chart">
		 <h2> 생산실적 현황 </h2>
		 <div class="chartbody">
		 
		 <div class="chart1head">
		 <h2 class="labelhead"> 실적수</h2>
		 <div class="chart1">
		 <canvas id="donutChart" width="400px" height="400px"></canvas><!-- totalamount --> 
		 </div> <!--  chart1 -->
		 </div> <!-- chart1head -->
		 <div class="chart2">
		 <h2 class="labelhead"> 양품수 </h2>
		 <div class="chart2head">
		 <canvas id="donutChart2" width="600px" height="400px"></canvas> <!-- - totalfair -->
		 </div>
		 </div>
		 
		 <div class="chart3">
		 <h2 class="labelhaed"> 불량수</h2>
		 <div class="chart3haed">
		  <canvas id="donutChart3" width="400px" height="400px"></canvas> <!--  totaldefect -->
		 </div>
		</div>
		 


	
		 </div> <!--  chartbody -->
		 </div> <!--  chart -->

			
			</div> <!--  CLIENTBODY -->
			


</body>
<script> 
function applyFilters() {
    var perPageValue = document.getElementById("perPageSelect").value;
   
    var lineCode = "${perfDTO.lineCode}";
    var prodCode = "${perfDTO.prodCode}";

    var url = '${pageContext.request.contextPath}/perf/perf?pageNum=1&cntPerPage=' + perPageValue +
        '&lineCode=' + lineCode + '&prodCode=' + prodCode;

    // Redirect to the generated URL
    window.location.href = url;
}
$(document).ready(function() {
	

	
	
	
    // addButton 클릭 이벤트 처리
    $('#addButton').click(function() {
        window.open(
            '${pageContext.request.contextPath}/perf/perfinsert',
            '_blank',
            'width=600px, height=800px, left=200px, top=100px'
        );
    });

    // 돋보기 아이콘에 대한 클릭 이벤트 리스너 추가
    document.querySelectorAll('.magnifier').forEach(function(magnifier) {
        magnifier.addEventListener('click', function() {
            console.log("에러 발생!");
            // 선택한 실적 코드 가져오기
            var perfCode = this.getAttribute('data-perfcode');
        
            // 새 창을 열고 선택한 실적 코드를 URL 파라미터로 전달
            window.open('${pageContext.request.contextPath}/perf/detail?perfCode=' + perfCode, '_blank', 'width=700px,height=600px');
        });
    });
    
    $(document).ready(function() {
   	 // lineCode2 input box 클릭 이벤트 처리
       $('#lineCode2').click(function() {
       	console.log("라인코드 클릭");
           openLinePopup(); // 라인 팝업 열기
       });

       // prodCode2 input box 클릭 이벤트 처리
       $('#prodCode2').click(function() {
       	console.log("제품코드 클릭");
           openProductPopup(); // 제품 팝업 열기
       });
       
    // prodCode2 input box 클릭 이벤트 처리
       $('#workCode2').click(function() {
       	console.log("제품코드 클릭");
           openProductPopup(); // 제품 팝업 열기
       });
       
       function openLinePopup() {
           var popupUrl = '${pageContext.request.contextPath}/search/line?input=lineCode2';
           window.open(
               popupUrl,
               '_blank',
               'width=800px, height=800px, left=900px, top=100px'
           );
       }
       
    function openProductPopup() {
    	
        var popupUrl = '${pageContext.request.contextPath}/search/product?input=prodCode2';
        window.open(
            popupUrl,
            '_blank',
            'width=800px, height=800px, left=900px, top=100px'
        );
    }
    
    function openWorkOrderPopup() {
        var popupUrl = '${pageContext.request.contextPath}/search/openworklisti?input=workCode2';
        window.open(
            popupUrl,
            '_blank',
            'width=800px, height=800px, left=900px, top=100px'
        );
    }
    
    function selectLineCode(lineCode) {
        window.opener.setLineCodeAndClosePopup(lineCode2);
    }

    function selectProdCode(prodCode) {
        window.opener.setProdCodeAndClosePopup(prodCode2);
    }
    
    });
    

    // 라인 코드 리스트
    var lineCode = ["L101", "L102", "L103"];
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/perfajax/perfdonut",
        dataType: "json",
        contentType: "application/json", // 데이터 형식을 JSON으로 지정
        data: JSON.stringify(lineCode), // 라인 코드 리스트를 JSON 문자열로 변환하여 전송
        success: function(data) {
            console.log(data);
            console.log("데이터 받음: ", data); // 데이터를 로그에 출력

            // 파이차트 그리는 함수 호출 등으로 처리 가능
            // 도넛 차트 생성 및 표시
            var donutChartLabels = data.map(function(item) {
                return item.lineCode;
            });

            // 각 차트에 대한 라벨과 데이터 분리
            var donutChartLabels = data.map(function(item) {
                return item.lineCode;
            });

            var totalAmountData = data.map(function(item) {
                return item.totalAmount;
            });

            var totalFairData = data.map(function(item) {
                return item.totalFair;
            });

            var totalDefectData = data.map(function(item) {
                return item.totalDefect;
            });

            // 각 차트에 대한 도넛 차트 생성
            createDonutChart(totalAmountData, donutChartLabels, 'donutChart');
            createDonutChart(totalFairData, donutChartLabels, 'donutChart2');
            createDonutChart(totalDefectData, donutChartLabels, 'donutChart3');
        },
        error: function(error) {
            console.log("Error fetching data: " + error);
        }
    });
    


    // Chart.js를 사용하여 도넛 차트를 생성합니다.
    function createDonutChart(data, labels, chartId) {
        console.log("도넛 차트 데이터: ", data);
        console.log("도넛 차트 라벨: ", labels);
        console.log("도넛 차트 ID: ", chartId); // 이 줄을 추가하여 chartId 출력
          
        Chart.register(ChartDataLabels);
        var ctx = document.getElementById(chartId).getContext('2d');
        var totalValue = data.reduce((total, value) => total + value, 0);
        console.log("총합: ", totalValue.toFixed(2)); // totalValue를 로그로 출력합니다.

        var donutChart = new Chart(ctx, {
            type: 'doughnut', // 도넛 차트 유형을 설정합니다.
            data: {
                labels: labels, // 라벨 배열을 설정합니다.
                datasets: [{
                    data: data, // 차트 데이터 배열을 설정합니다.
                    backgroundColor: ['#36a2eb', '#ffb8c6', '#fbceb1'], // 차트 데이터에 대한 배경색을 설정합니다.
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: 120,
                chartArea: {
                    // 차트 영역 크기 조절
                    left: 50,
                    right: 50,
                    top: 50,
                    bottom: 50
                },
                animation: {
                    animateRotate: false,
                    animateScale: true
                },
                plugins: {
                    datalabels: {
                        color: 'white', // 데이터 레이블 텍스트 색상
                        font: {
                            size: 18, // 데이터 레이블 폰트 크기
                            weight: 'bold' // 데이터 레이블 폰트 굵기
                        }
                    }
                },
                tooltips: {
                    callbacks: {
                        label: function(context) {
                            var label = context.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += context.formattedValue;
                            return label;
                        }
                    },
                    position: 'top'
                },
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        });
    }
      
		//엑셀
			 const excelDownload = document.querySelector('#exceldownload');
					excelDownload.addEventListener('click', exportExcel);
					function exportExcel() {
					    // 1. 워크북 생성
					    var wb = XLSX.utils.book_new();
					    // 2. 워크시트 생성
					    var newWorksheet = excelHandler.getWorksheet();
					    // 3. 워크시트를 워크북에 추가
					    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
					    // 4. 엑셀 파일 생성
					    var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
					    // 5. 엑셀 파일 내보내기
					    saveAs(new Blob([s2ab(wbout)], { type: 'application/octet-stream' }), excelHandler.getExcelFileName());
					}

					// 현재 날짜를 가져오는 함수
					function getToday() {
						
					    var date = new Date();
					    var year = date.getFullYear();
					    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 맞춥니다.
					    var day = date.getDate().toString().padStart(2, '0'); // 일을 두 자리로 맞춥니다.
					    return year + month + day;
					}

			var excelHandler = {
			getExcelFileName : function() {
				return 'PerformanceList'+getToday()+'.xlsx'; //파일명
			},
			getSheetName : function() {
				return 'Performance Sheet'; //시트명
			},
			getExcelData : function() {
				return document.getElementById('ct'); //table id
			},
			getWorksheet : function() {
				return XLSX.utils.table_to_sheet(this.getExcelData());
			}
		} //excelHandler
			
			function s2ab(s) {
				
				var buf = new ArrayBuffer(s.length);  // s -> arrayBuffer
				var view = new Uint8Array(buf);  
				for(var i=0; i<s.length; i++) {
					view[i] = s.charCodeAt(i) & 0xFF;
				}
				return buf;
			}
	
    
    
   /*  $(function() {
        $("#workdate1").datepicker({
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            showMonthAfterYear: true,
            yearSuffix: '년',

            // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
            onSelect: function(selectedDate) {
                console.log("선택한 날짜: " + selectedDate);
            }
     
    }); // datekpicker1 끝
          
          
          $(function() {
              $("#workdate2").datepicker({
                  dateFormat: 'yy-mm-dd',
                  prevText: '이전 달',
                  nextText: '다음 달',
                  monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                  dayNames: ['일','월','화','수','목','금','토'],
                  dayNamesShort: ['일','월','화','수','목','금','토'],
                  dayNamesMin: ['일','월','화','수','목','금','토'],
                  showMonthAfterYear: true,
                  yearSuffix: '년',

                  // 데이트피커의 onSelect 이벤트 핸들러 설정
                  onSelect: function(selectedDate) {
                      // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
                      console.log("선택한 날짜: " + selectedDate);
                  }
              });
          }); // datepicker2 끝  */
   
   
});
</script>	
	</script>



	<script>
      //modal창에 열기 위한 이벤트 헨들러
        function openModal(event) {
        	  const clickedElementId = event.target.id;
            if(clickedElementId.startsWith("PR")){
            	//modal_ajax 
            	$.ajax({
            	  url : '${pageContext.request.contextPath}/KDMajax/modalprod',
            	  data: {prodCode:clickedElementId},
            	  type : 'GET',
            	  dataType:'json',
            	  success: function (json) {
                      if (json && typeof json === 'object') {
                    	  
                    	  var dataformat = {
					               
					            	"제품 이름:": json.prodName,
                      "제품 단위": json.prodUnit,
                      "용량": json.prodSize,
                      	"향기 종류": json.prodPerfume,
                      	"거래처 코드":json.clientCode,
                         "창고 코드": json.whseCode,
                         "매출 단가": json.prodPrice,
                          "제품 비고": json.prodMemo
					            };
					    	openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
                    	} else {
                    	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                    	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                    	}

                  }
              });	
            	

      	  }  else if(clickedElementId.startsWith("SL")){
              	//modal_ajax 
              	$.ajax({
              	  url : '${pageContext.request.contextPath}/KDMajax/modalsell',
              	  data: {sellCode:clickedElementId},
              	  type : 'GET',
              	  dataType:'json',
              	  success: function (json) {
                        if (json && typeof json === 'object') {
                        	// 값 할당
                        	 var dataformat = {
                        			
                        			 "수주 일자" :json.sellDate,
                                   	"납기 일자" :json.sellDuedate,
                                   	"관리 사원" :json.sellEmpId,
                                   	"수주 수량" :json.sellCount,
                                       "수주 단가" :json.sellPrice,
                                       "제품 코드" :json.prodCode,
                                       "제품 이름" :json.prodName,
                                       "수주 비고" :json.sellMemo,
                                       "출고 상태" :json.sellState,
                                       "거래처 이름" :json.clientCompany,
                                       "거래처 코드" :json.clientCode
					            };
					    	openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
                    	} else {
                      	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                      	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                      	}
                        }
                });	//기존 닫기 창 함수
               
        }   else if(clickedElementId.startsWith("WI")){
        	var result = clickedElementId.substring(clickedElementId.indexOf("WI") + 2);
          	var elementsStartingWithL = [];
// 문자열을 "L"로 분할하여 배열로 만들기
          	var elementss = result.split("L");
// 배열을 순회하며 "L"로 시작하는 부분을 찾아내어 새로운 배열에 저장
          	for (var i = 1; i < elementss.length; i++) {
          	    elementsStartingWithL.push("L" + elementss[i]);
          	}
          	var dataformat = {}; // 빈 객체 생성

          	for (var i = 0; i < elementsStartingWithL.length; i++) {
          	    var key = (i + 1) + "차 라인"; // 키 생성 (1차 라인, 2차 라인, ...)
          	    dataformat[key] = elementsStartingWithL[i]; // 객체에 속성 추가
          	} 
          	openModalWithData(event, dataformat, 200);
         
       
          	}
   
        else if(clickedElementId.startsWith("GL")||clickedElementId.startsWith("LB")||clickedElementId.startsWith("PC")||clickedElementId.startsWith("PE")||clickedElementId.startsWith("ST")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalraw',
          	  data: {rawCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	var dataformat = {			            	
"원자재 이름" :json.rawName,
	"원자재 종류" :json.rawType,
  	"원자재 단위" :json.rawUnit,
  	"원자재 가격" :json.rawPrice,
      "거래처 코드" :json.clientCode,
      "창고 코드" :json.whseCode,
      "원자재 비고" :json.rawMemo};
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시
                  	
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
        else if(clickedElementId.startsWith("CL")||clickedElementId.startsWith("OR")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalclient',
          	  data: {clientCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	var dataformat = {			            	
"이름" :json.clientCompany,
	"분류" :json.clientType,
  	"사업자번호" :json.clientNumber,
  	"상세분류" :json.clientDetail,
      "대표이름" :json.clientCeo,
      "담당자" :json.clientName,
      "주소" :json.clientAddr1,
      "상세주소" :json.clientAddr2,
      "대표 번호" :json.clientTel,
      "담당자 번호" :json.clientPhone,
      "팩스" :json.clientFax,
      "이메일" :json.clientEmail,
      "비고" :json.clientMemo
      };
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시

                  	
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
            
        else if(clickedElementId.startsWith("WH")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalwhse',
          	  data: {whseCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	var dataformat = {			            	

                    			"이름" :json.whseName,
                              	"타입" :json.whseType,
                              	"사용 상태" :json.whseState,
                              	"주소" :json.whseAddr,
                                  "연락처" :json.whseTel,
                                  "비고" :json.whseMemo,
                                  "제품 코드" :json.prodCode,
                                  "원자재 코드" :json.rawCode,
                                  "담당자" :json.whseEmpId
                                  };
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시

                  	
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
        else if(!isNaN(clickedElementId.charAt(0))){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalemp',
          	  data: {empId:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	
                    	var dataformat = {			            	
                    			"이름" :json.empName,
                              	"부서" :json.empDepartment,
                              	"직급" :json.empPosition,
                              	"이메일" :json.empEmail,
                                  "연락처" :json.empTel,
                                  "재직상태" :json.empState,
                                  "입사일" :json.empHiredate};
openModalWithData(event, dataformat, 200); // 데이터를 모달로 표시

                  	
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }  else if(clickedElementId.startsWith("WO")){
      	 
      	$.ajax({
      	  url : '${pageContext.request.contextPath}/KDMajax/modalworkorder',
      	  data: {workCode:clickedElementId},
      	  type : 'GET',
      	  dataType:'json',
      	  success: function (json) {
                if (json && typeof json === 'object') {               	// 값 할당
                	var dataformat = {	
                			"제품코드" :json.prodCode,
                	      	"수주코드" :json.sellCode,
                	      	"지시일" :json.workDate,
                	      	"라인코드" :json.lineCode,
                	          "지시수량" :json.workAmount,
                	          "작업지시자" :json.workEmpId,
                	          "추가지시일" :json.workDatechange,
                	          "라인내역" :json.workInfo};
                	openModalWithData(event, dataformat, 400);
	 	} else {
              	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
              	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
              	
              	}
                }
      	  });
    }//기존 닫기 창 함수
       
       
      } 
      
      function openModalWithData(event, data, width) {
    		    var modal = document.getElementById('myModal');
    		    var close1 = document.getElementById('closeModal');
    		    var modalContent = document.querySelector('.modal-body');
    		    
    		    modalContent.style.width = width + 'px';
    		    modal.style.width = (width + 20) + 'px'; // 20px는 여유 여백이라고 가정
    		    modalContent.innerHTML = ''; // 기존 내용 제거

    		    // 데이터를 HTML 표로 구성
    		    var tableHTML = '<table class="table">';
    		    for (var key in data) {
    		        if (data.hasOwnProperty(key)) {
    		            tableHTML += '<tr>';
    		            tableHTML += '<td>' + key + '</td>';
    		            tableHTML += '<td>' + data[key] + '</td>';
    		            tableHTML += '</tr>';
    		        }
    		    }
    		    tableHTML += '</table>';

    		    // 모달 내용에 HTML 표 추가
    		    modalContent.innerHTML = tableHTML;

    		 // 바디의 너비
    		    var bodyWidth = document.body.clientWidth;
  	          
  	          // 클릭 이벤트의 위치를 기반으로 모달 창 위치 설정
  	        
  	          modal.style.setProperty('display', 'block', 'important');
  	          if (event.clientX + window.scrollX + width >= bodyWidth) {
  	              modal.style.left = (event.clientX + window.scrollX - width) + 'px';
  	              close1.style.float = 'right';
  	  	            
  	           
  	            
  	          } else {
  	              modal.style.left = (event.clientX + window.scrollX) + 'px';
  	             
  	              close1.style.float = 'left';
  	  	            
  	            
  	          }
  	          modal.style.top = (event.clientY + window.scrollY) + 'px';
    		}


    		// 모달과 닫기 버튼 가져오기
    		var modal = document.getElementById('myModal');
    		var closeModal = document.getElementById('closeModal');

    		console.log(modal);
    	    // 닫기 버튼을 클릭하면 모달을 숨김
    		closeModal.addEventListener('click', function() {
    		    modal.style.display = 'none';
    		});
    		
    	    	
    		
    		/* window.addEventListener('click', function(event) {
    		    if (event.target != modal && !modal.contains(event.target)) {
    		        modal.style.display = 'none';
    		    }
    		}); */ 
     </script>		
</html>