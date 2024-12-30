function deliveryInsert(){
	location.href='/deliveryList/deliveryInsert.jsp'
};

function deliveryModify(didx){
	location.href='/deliveryList/deliveryModify.do?didx='+didx;
};


function sh(type) {
    var spot = document.querySelector('select[name="spot"]').value;  // 소속
    var part = document.querySelector('select[name="part"]').value;  
    var search = document.querySelector('#search').value.trim();  
	
    if (type == 1) {
        if (spot === "전체") {
            window.location.href = './deliveryMain.do?spot=전체';
        } else {
            window.location.href = './deliveryMain.do?spot=' + spot;
        }
    }

    if (type == 2) {
        var mspot = '<%=sessionScope.mspot%>';
        var url = './deliveryMain.do?part=' + part;  
	
		var mspot2 = document.getElementById("mspot").value;
		console.log(mspot2);
        if (search === "") {
            if (part === "기사명") {
                alert("찾으실 기사명을 입력해 주세요.");
            } else if (part === "사원번호") {
                alert("찾으실 기사님의 사원번호를 입력해 주세요.");
            } else if (part === "연락처") {
                alert("찾으실 기사님의 연락처를 입력해 주세요.");
            }
            return false;  
        }
        search = search.replace(/\s+/g, ''); 
        if (search.length === 0) {
            alert("검색어를 다시 한 번 확인해주세요.");
            return false;
        }
        url += '&search=' + search;
        if (mspot2 === '본사') {
            window.location.href = url;
        } else {
            url += '&spot=' + mspot2;
            window.location.href = url;
        }
    }
}


function page_go(n,search){
	var url ="./deliveryMain.do?pageno="+ n;

	if (search) {
		url+= "&search=" + encodeURIComponent(search);
			}
			location.href = url
}

function approveCk(apck,a){
	var approve = apck.value;
	var idx = a;
	document.getElementById("dapprove").value = approve;
	document.getElementById("didx").value = idx
	f1.action = "/deliveryList/deliveryApprove.do";
	f1.method = "get";
	f1.submit();
}