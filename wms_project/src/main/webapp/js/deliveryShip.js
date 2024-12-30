document.body.addEventListener('click', function(event) {
    // QR보기 버튼 클릭 시
    if (event.target && event.target.id.startsWith('showImageBtn_')) {
        event.preventDefault();
        // 고유한 aidx를 추출하여 해당 imageWrapper를 표시
        const aidx = event.target.id.split('_')[1]; // 'showImageBtn_' 뒤의 aidx 값 추출
        document.getElementById(`imageWrapper_${aidx}`).style.display = 'block'; // 이미지 보여주기
    }

    // 닫기 버튼 클릭 시
    if (event.target && event.target.id.startsWith('closeBtn_')) {
        event.preventDefault();
        // 고유한 aidx를 추출하여 해당 imageWrapper를 숨김
        const aidx = event.target.id.split('_')[1]; // 'closeBtn_' 뒤의 aidx 값 추출
        document.getElementById(`imageWrapper_${aidx}`).style.display = 'none'; // 이미지 숨기기
    }
});


/*
document.body.addEventListener('click', function(event) {
    if (event.target && event.target.id === 'showImageBtn') {
        event.preventDefault();
        document.getElementById('imageWrapper').style.display = 'block'; // 이미지 보여주기
    }

    if (event.target && event.target.id === 'closeBtn') {
        event.preventDefault();
        document.getElementById('imageWrapper').style.display = 'none'; // 이미지 닫기
    }
});
*/







function toggleSelectAll() {
        const selectAll = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.checkbox');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
    }

const checkboxes = document.querySelectorAll('.checkbox');
checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function() {
        const selectAll = document.getElementById('selectAll');
        const checkedCheckboxes = document.querySelectorAll('.checkbox:checked');

        if (checkedCheckboxes.length === checkboxes.length) {
            selectAll.checked = true; // 모든 체크박스가 체크되면 전체 체크박스도 체크
        } else {
            selectAll.checked = false; // 하나라도 체크가 해제되면 전체 체크박스 해제
        }
    });
});




function btn(a){
	
	var start = document.getElementById("start").value;
	var end = document.getElementById("end").value;
	var dcode = document.getElementById("dcode").value;
	console.log(a);
	
	// 오더 일자별 검색
	if(a == 1 ){
		if(start == ""){
			alert("검색하실 시작 날짜를 선택해주세요.");
			return false;
		}
		else if(end == ""){
			alert("검색하실 종료 날짜를 선택해주세요.");
			return false;
		}
		else if(start > end){
			alert("종료날짜보다 시작날짜가 더 클수 없습니다.");
		}
		else{
		//location.href = "/deliveryShip/deliveryShip.do?start="+start+"&end="+end;
			location.href = "/deliveryShip/deliveryShip.do?start="+start+"&end="+end;
		}				
	}
	
	if(a == 2 ){
		
		if(dcode == ""){
			alert("배송기사를 선택해주세요.")
		}
		else{
			location.href = "/deliveryShip/deliveryShip.do?dcode="+dcode;
		}
	}
}



function tracking(){
	
	var selectedAidxs = [];
	   document.querySelectorAll('.checkbox:checked').forEach(function(checkbox) {
	       selectedAidxs.push(checkbox.getAttribute('aidx'));
	   });
	   if (selectedAidxs.length === 0) {
	       alert("운송장번호 생성할 오더를 선택해주세요.");
	       return;
	   }
	   else{
	   var aidx = selectedAidxs.join(',');
	   document.getElementById('aidx').value = aidx;	
	   console.log(aidx);
		
	   f1.method ="post";
	   f1.action = "/deliveryShip/deliveryTracking.do?idx="+aidx;
	   f1.submit();

	   }

	      document.querySelectorAll('.checkbox').forEach(function(checkbox) {
	          checkbox.checked = false;
	      });
	      document.getElementById('selectAll').checked = false;
}


function qrmake(){
	
var selectedAidxs = [];
	   document.querySelectorAll('.checkbox:checked').forEach(function(checkbox) {
	       selectedAidxs.push(checkbox.getAttribute('aidx'));
	   });
	   
	   if (selectedAidxs.length === 0) {
	       alert("운송장번호 생성할 오더를 선택해주세요.");
	       return;
	   }
	   else{
	   var aidx = selectedAidxs.join(',');
	   document.getElementById('aidx').value = aidx;	
	   console.log(aidx);
		
	   f1.method ="post";
	   f1.action = "/deliveryShip/deliveryQr.do?idx="+aidx;
	   f1.submit();

	   }
	      document.querySelectorAll('.checkbox').forEach(function(checkbox) {
	          checkbox.checked = false;
	      });
	      document.getElementById('selectAll').checked = false;
}


function go_page(i, search){
    let url = "deliveryShip.do?pageno=" + i;

    location.href = url;
}