function searchBtn(){
	var search = document.querySelector('#search').value.trim();
	var part = document.querySelector('select[name="part"]').value;
	
	if(search == ""){
		if(part == "이름"){
			alert("이름을 입력해주세요.");
		}
		else if(part == "사원번호"){
			alert("사원번호를 입력해주세요.");
		}	
		else if(part == "연락처"){
			alert("연락처를 입력해주세요.");
		}
		return false;
	}
	search = search.replace(/\s+/g, '');
	if (search.length === 0) {
       alert("검색어를 다시 한 번 확인해주세요.");
       return false;
   	}
   		location.href = "./deliveryState.do?part=" + part +"&search="+search;
	
}


function page_go(n,search){
	var url ="./deliveryState.do?pageno="+ n;

	if (search) {
		url+= "&search=" + encodeURIComponent(search);
			}
			location.href = url
}



function allBtn(){
	location.href="/deliveryState/deliveryState.do";
}