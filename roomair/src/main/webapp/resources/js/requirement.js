//input으로 바꾸기 
function inputCng(obj, type, name, value) {
	var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
	obj.html(inputBox);
} //inputCng	

// 팝업 옵션
const popupOpt = "top=60,left=140,width=777,height=677";
const popupOpt2 = "top=60,left=140,width=977,height=677";

//검색 팝업
	function openWindow(search, inputId) {
	 	var url = "${pageContext.request.contextPath}/workorder/search?type=" + search + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

//검색 팝업2
function openWindow2(search, inputId) {
	var url = "${pageContext.request.contextPath}/requirement/whsearch?type=" + search + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt2);
} //openWindow()

//추가 시 품번 검색 
function serchProd(inputId){
	openWindow("prod",inputId);
}

	//추가 시 원자재 검색 
function serchRaw(inputId){
	openWindow2("raw",inputId);
}
	
function submitForm() {
	  var isValid = true;

	  // 유효성 검사
	  $('#reqTable input[required]').each(function() {
	    if ($(this).val().trim() === '') {
	      isValid = false;
	      return false; // 유효성 검사 실패 시 반복문 종료
	    }
	  });

	  if (isValid) {
	    $('#fr').submit();
	  } else {
		 	 Swal.fire({
			title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
			icon: 'info',
			width: '300px',
		 });
	  }
	}
var counter = 0;

function deleteRow(button) {
	  var row1 = button.parentNode.parentNode;
	  row1.parentNode.removeChild(row1);
	  //counter--;
	}	