var idCK = false;  
var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/;
var nameReg = /^[가-힣]{2,4}$/;
var hpReg = /^\d{3}\d{4}\d{4}$|^\d{3}\d{3}\d{4}$|^\d{2}\d{4}\d{4}$|^\d{2}\d{3}\d{4}$|^\d{4}\d{4}$/;
var numReg = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
var faxReg = /^(?:\+82-\d{1,2}-\d{3,4}-\d{4}|\d{2,3}-\d{3,4}-\d{4})$/;
var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;	
var pwReg = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
var idReg = /^\d+$/;

function deliveryMain(){
	location.href="/deliveryList/deliveryMain.do";
	
}

document.getElementById('dimgnm').addEventListener('change', function(event) {
    var fileInput = event.target;
    var file = fileInput.files[0];
    if (file) {
      var fileName = file.name;
      var fileExtension = fileName.split('.').pop().toLowerCase(); 
      var validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      if (validExtensions.indexOf(fileExtension) === -1) {
        alert('허용되지 않는 파일 형식입니다.\nJPG, PNG, GIF 파일만 업로드할 수 있습니다.');
        fileInput.value = ''; // 파일 선택 초기화
      }
    }
  });


  
 function codeCk(){
	let http = new XMLHttpRequest();
	let ctn = "";
	http.onreadystatechange = function(){
		if(http.readyState == 4 && http.status == 200){	
			ctn = http.responseText.trim();
			console.log(ctn);
			
			if(f1.dcode.value == ""){
				ctn = (parseInt(ctn)+1).toString().padStart(10,'0');
				f1.dcode.value="M"+ctn;
				idCK = true;
			}
			else{
				alert("이미 코드가 생성되었습니다.")
				return false;
			}
 		}
	}
	
		http.open("get","./deliveryCode.do", true);
		http.setRequestHeader("content-type", "application/x-www-form-urlencoded");
 		http.send();
} 


function deliverySubmit() {
    var id1 = document.getElementById("id1");
    var id2 = document.getElementById("id2");

if(f1.dspot.value == ""){
		alert('비정상적인 접근입니다. 로그인 페이지로 이동합니다.');
		location.href = '/deliveryList/deliveryMain.do';
		return false;
	}
	else if(f1.dcode.value == ""){
		alert("사원번호를 생성해 주세요.");
		return false;
	}
	else if(idCK == false){
		alert("사원번호를 생성해 주세요.");
		return false;	
	}
	else if(f1.dcode.value == ""){
		alert("사원번호를 생성해 주세요.");
		return false;
	}
    else if(f1.dname.value == "") {
        alert("이름을 입력해 주세요.");
        f1.dname.focus();
        return false;
    }
    else if(!nameReg.test(f1.dname.value)) {
        alert("올바르지 않는 이름입니다. 다시 입력해 주세요.");
        f1.dname.focus();
        return false;
    }
    else if(f1.dpass.value == "") {
        alert("패스워드를 입력해 주세요.");
        f1.dpass.focus();
        return false;
    }
    else if(f1.dpass.value.length < 6) { // 비밀번호 길이 체크 수정
        alert("비밀번호는 최소 6자 이상이어야 합니다.");
        f1.dpass.value = "";
        f1.dpass.focus();
        return false;
    }
    else if(!pwReg.test(f1.dpass.value)) {
        alert("비밀번호는 최소 6자 이상, 영문자와 숫자를 포함해야합니다.");
        f1.dpass.value = "";
        f1.dpass.focus();
        return false;
    }
    else if(f1.dpass.value != f1.dpassCk.value) {
        alert("동일한 비밀번호를 입력해 주세요.");
        f1.dpass.value = "";
        f1.dpassCk.value = "";
        f1.dpass.focus();
        return false;
    }
    else if(f1.demail.value == "") {
        alert("이메일을 입력해 주세요");
        f1.demail.focus();
        return false;
    }
    else if(!emailReg.test(f1.demail.value)) {
        alert("이메일 형식이 올바르지 않습니다.");
        f1.demail.value = "";
        f1.demail.focus();
        return false;
    }
    else if(id1.value == "") {
        alert("주민등록 번호를 입력해주세요");
        id1.value = "";			
        id2.value = "";
        f1.didnum.value = "";
        id1.focus();
        return false;			
    }
    else if(id1.value.length < 6) { 
        alert("주민등록 번호를 입력해주세요");
        id1.value = "";			
        id2.value = "";
        f1.didnum.value = "";
        id1.focus();
        return false;			
    }
    else if(id2.value == "") {
        alert("주민등록 번호를 입력해주세요");
        id1.value = "";			
        id2.value = "";
        f1.didnum.value = "";
        id1.focus();
        return false;			
    }
    else if(!idReg.test(id1.value)) {
        alert("주민등록 번호는 숫자만 입력 가능합니다.");
        id1.value = "";			
        id2.value = "";
        f1.didnum.value = "";
        id1.focus();
        return false;		
    }
    else if(!idReg.test(id2.value)) {
        alert("주민등록 번호는 숫자만 입력 가능합니다.");
        id1.value = "";			
        id2.value = "";
        f1.didnum.value = "";
        id1.focus();
        return false;		
    }
    else if(f1.dhp.value == "") {
        alert("전화번호를 입력해 주세요.");
        f1.dhp.focus();
        return false;
    }
    else if(!hpReg.test(f1.dhp.value)) {
        alert("올바른 전화번호를 입력해 주세요.");
        f1.dhp.value = "";
        f1.dhp.focus();
        return false;
    }
	else{
		
		if(f1.dimgnmf.value == "") { // else if로 수정
		     alert("증명사진을 등록하지 않으면 배송 출고 시 \n해당 택배기사의 정보는 출력되지않습니다.");
			 if (confirm("사진을 추가하시겠습니까?")) {
			       return false;
			}
			else{
			}
		  }
		f1.didnum.value = id1.value + "-" + id2.value;
        f1.method = "POST";
        f1.action = "/deliveryList/deliveryInsertok.do";
        f1.submit();
	}
}
