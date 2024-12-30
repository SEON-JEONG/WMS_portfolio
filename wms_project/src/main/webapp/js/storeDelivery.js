function searchDate() {
    // 날짜 입력 필드의 값을 가져옵니다.
    const startDate = document.querySelector('input[type="date"]:nth-of-type(1)').value;
    const endDate = document.querySelector('input[type="date"]:nth-of-type(2)').value;

    // URL을 변경합니다. 필요한 경우 컨트롤러의 URL을 지정해 주세요.
    const url = `/storeDelivery/storeDelivery.do?startDate=${startDate}&endDate=${endDate}`;

    // 페이지를 해당 URL로 이동합니다.
    window.location.href = url;
}



function searchDate(radio) {
    // 날짜 입력 필드의 값을 가져옵니다.
    const startDate = document.querySelector('input[type="date"]:nth-of-type(1)').value;
    const endDate = document.querySelector('input[type="date"]:nth-of-type(2)').value;

    // URL을 변경합니다. 필요한 경우 컨트롤러의 URL을 지정해 주세요.
    const url = `/storeDelivery/storeDelivery.do?startDate=${startDate}&endDate=${endDate}&radio=${radio}`;

    // 페이지를 해당 URL로 이동합니다.
    window.location.href = url;
}

function useDeliverymen() {
    const checkboxes = document.getElementsByName('checkbox');
	var selectmen = document.getElementById("selectmen").value;
	const [dcode, dname, dspot] = selectmen.split(','); 
    const checked = [];

	
 	 
	 for (let i = 0; i < checkboxes.length; i++) {
	         if (checkboxes[i].checked) {
				 const aidx = checkboxes[i].value;
				 
				 // 체크박스 확인
				
			if (checkboxes[i].checked) {
	                 checked.push({ "aidx": aidx, "dcode" : dcode, "dname" : dname, "dspot" : dspot});
					 }
	             }
	         
	     }

	
    if (checked.length === 0) {
        alert('하나의 배송을 선택해주세요.');
        return false; // 체크된 제품이 없으면 제출하지 않음
    }
	
	var html;
	var data;
	   html = new XMLHttpRequest();
	   html.onreadystatechange = function(){
	      if(html.readyState==4 && html.status==200){
	      if(this.response=="ok"){
				alert("배송기사가 배정되었습니다.");
				window.location.href = "/storeDelivery/storeDelivery.do";
		  }
	            
	      }
	   }
	 
	   html.open("POST","/checkDeliverymen.do",true);
	   html.send(JSON.stringify(checked));
	   	
 }
 
 function DeleteDeliverymen(aidx){
	const data = [{"aidx": aidx}]; 

	var html;
	   html = new XMLHttpRequest();
	   html.onreadystatechange = function(){
	      if(html.readyState==4 && html.status==200){
	      if(this.response=="ok"){
				alert("삭제 되었습니다.");
				window.location.href = "/storeDelivery/storeDelivery.do";
		  }else{
	            alert("배송중인 주문건은 삭제가 불가능합니다.");
				window.location.href = "/storeDelivery/storeDelivery.do";
				
				}
	      }
	   }
	 
	   html.open("POST","/deleteDeliverymen.do",true);
	   html.send(JSON.stringify(data));
		
 }