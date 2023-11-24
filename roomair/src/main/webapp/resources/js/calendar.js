
// 두 JSON 객체를 비교하여 변경 여부를 확인하는 함수
function jsonObjectsAreEqual(obj1, obj2) {
   // obj1 또는 obj2가 null 또는 undefined인 경우, 변경된 것으로 간주
  if (!obj1 || !obj2) {
    return false;
  }

  // JSON 객체의 길이가 다르면 변경된 것으로 간주
  if (Object.keys(obj1).length !== Object.keys(obj2).length) {
    return false;
  }

  // 각 항목을 비교
  for (var key in obj1) {
    if (!obj2.hasOwnProperty(key)) {
      // 두 번째 객체에 같은 키가 없으면 변경된 것으로 간주
      return false;
    }

    if (obj1[key].label !== obj2[key].label || obj1[key].data !== obj2[key].data) {
      // 레이블(label) 또는 데이터(data) 값 중 하나라도 다르면 변경된 것으로 간주
      return false;
    }
  }

  // 모든 비교를 통과하면 두 객체는 동일하다고 간주
  return true;
}

// 캘린더를 그리는 함수 
function initializeCalendar(calendarEvents, currentDate) {
	console.log(calendarEvents);
	console.log(currentDate);
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            start: 'prev next today',
            center: 'title',
            end: 'dayGridMonth,dayGridWeek'
        },
        titleFormat: function(date) {
            return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
        },
        initialDate: new Date(currentDate),
        droppable: true,
        editable: true,
        nowIndicator: true,
        locale: 'ko',
        events: calendarEvents,
        eventClick: function(info) {
            var title = info.event.title;
            
     		var eventDate = moment(info.event.start);
			var start = eventDate.format("YYYY-MM-DD");

//		    var start = info.event.start.toISOString().substring(0, 10);

		    var otherDate = info.event.extendedProps.otherDate;
		    var description = info.event.extendedProps.description;
		    
		    if (otherDate !== null) {
		        var message ='<div style="text-align:left; padding-left:10%;">' + title + '<br> 기간: ' + start + ' ~ ' + otherDate + '<br> 내용: ' + description + '</div>';
		    } else {
		        var message ='<div style="text-align:left; padding-left:10%;">' + title + '<br> 기간: ' + start + ' ~ ' + start + '<br> 내용: ' + description + '</div>';
		    }
		
		    Swal.fire({
		 	    html: message,
		        confirmButtonText: '확인'
		    });
        },
        // 아래의 eventContent와 eventDidMount 부분이 추가된 부분입니다.
        eventContent: function(arg) {
		    return {
		        html: arg.event.title // 이벤트의 제목만 표시
   			};
		},
    });
    calendar.render();
}


// 파이 차트를 그리는 함수
function createPieChart(data, chartId) {
  console.log(data); // 데이터가 어떻게 읽혀왔는지 확인

  var colors = ["#4b77a9", "#5f255f", "#d21243", "#ff5733", "#ffcc29", "#6bf178", "#854c6f", "#ff9933", "#6699cc", "#ff6666"];


    // 이전 차트를 제거합니다.
    var existingChart = Chart.getChart(chartId);
    if (existingChart) {
      existingChart.destroy();
    }

    var pie_ctx = document.getElementById(chartId).getContext("2d");

    var pie_data = {
      datasets: [
        {
          data: data.map(function (item) {
            return item.data;
          }),
          backgroundColor: colors.slice(0, data.length)
        }
      ],
      labels: data.map(function (item) {
        return item.label;
      }),
      borderColor: "#fff"
    };

    var pie_options = {
    	cutout: '30%', // 중앙 빈 원의 크기 (백분율로 설정)
      plugins: {
        tooltip: {
          titleFont: {
            size: 15
          },
          bodyFont: {
            size: 15
          },
          footerFont: {
            size: 15
          },
          mode: "nearest",
          intersect: true
        },
        datalabels: {
          formatter: function (value, context) {
            return Math.round(value / context.chart.getDatasetMeta(0).total * 100) + "%";
          },
          color: "#fff",
          anchor: "center",
          align: "start",
          offset: 0,
          font: {
            size: 15
          }
        },
        legend: {
          display: true,
          position: "bottom",
          labels: {
            font: {
              size: 13
            }
          }
        }
      },
      layout: {
    	padding: {
     		left: 0,
      		right: 0,
      		top: 0,
      		bottom: 0
    		}
  		}
    };

    new Chart(pie_ctx, {
      type: "pie",
      data: pie_data,
      options: pie_options,
      plugins: [ChartDataLabels]
    });
  
}


// bar형 차트 그리는 함수

function createBarChart(data, chartId) {
	var colors = [
    "#4b77a9", "#5f255f", "#d21243", "#ff5733", "#ffcc29", 
    "#6bf178", "#854c6f", "#ff9933", "#6699cc", "#ff6666", 
    "#00a8cc", "#ffae42", "#7c83fd", "#fa7e61", "#a95be8", 
    "#ffd700", "#4a90e2", "#ff6e40", "#93c6e0", "#5bc0de",
    "#ff99cc", "#00cc66", "#99ccff", "#ccff99", "#cc99ff",
    "#cc9966", "#6699ff", "#99ffcc", "#66cc99", "#ff6699"];
    
    var bar_ctx = document.getElementById(chartId).getContext('2d');

	// 이전 차트를 제거합니다.
    var existingChart = Chart.getChart(chartId);
    if (existingChart) {
      existingChart.destroy();
    }

	// JSON 형태의 데이터 배열에서 최대 값을 찾습니다.
	var maxDataValue = Math.max.apply(null, data.map(function (item) {
    					return item.data;
						}));
						
	var max = Math.ceil(maxDataValue * 1.2); // 최대 값을 1.2배로 설정					

	var stepSize = Math.ceil(maxDataValue / 10); // 원하는 눈금 간격 설정

    var bar_data = {
        datasets: [{
            data: data.map(function (item) {
                return item.data;
            }),
            backgroundColor: colors.slice(0, data.length)
        }],
        labels: data.map(function (item) {
        return item.label;
      }),
        borderColor: "#fff"
    };
    
	var bar_options = {
        plugins: {
            tooltip: {
                titleFont: {
                    size: 20
                },
                bodyFont: {
                    size: 20
                },
                footerFont: {
                    size: 20
                },
                mode: 'nearest',
                intersect: true
            },
            datalabels: {
                color: '#black',
                anchor: 'end',
                align: 'top',
                offset: 0,
                font: {
                    size: 15
                }
            },
            legend: {
                display: false
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                max: max,
                stepSize: stepSize
            },
            x: {}
        }
    };

	// 새로운 차트를 생성하고 이전 차트를 업데이트합니다.
  	 new Chart(bar_ctx, {
        type: 'bar',
        data: bar_data,
        options: bar_options,
        plugins: [ChartDataLabels]
    });
}



