function logincheck(){
	if(f.mid.value==""){
		alert("아이디를 입력해주세요.");
		return false;
	}
	else if(f.mpass.value==""){
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	else{
		f.method="post";
		f.action="./wmsLoginok.do"
		return;
	}
}