function accountModify(aidx){
	location.href='./accountModify.do?aidx='+aidx;
}

function accountDelete(aidx){
	if (confirm("거래처를 삭제하시겠습니까? \n삭제시 데이터는 복구되지 않습니다.")) {
	    location.href='./accountDelete.do?aidx='+aidx;
	} else {
	  return false;
	}
}

function page_go(n,search){
  var url ="./accountMain.do?pageno="+ n;
   if (search) {
	url+= "&search=" + encodeURIComponent(search);
		}
		location.href = url
}
	  
function sh(p){
	if(p==1){
		if(frm.search.value==""){
			alert("거래처명을 입력해 주세요.");
			frm.search.focus();
			return false;
		}
		else{
			frm.search.value = frm.search.value.replaceAll(" ", "");
			frm.search.value = frm.search.value.replace(/\s+/g, ''); 
			frm.method = "get";
			frm.action ="./accountMain.do?search=" + 1;
			frm.submit();
		}
	}
	else if(p==2){//전체리스트
			location.href='./accountMain.do'
   }
}	