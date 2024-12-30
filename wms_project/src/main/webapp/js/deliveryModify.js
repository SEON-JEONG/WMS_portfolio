var idCK = false;  
var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/;// 휴대폰 번호만
var nameReg = /^[가-힣]{2,4}$/;		//이름
var hpReg = /^\d{3}\d{4}\d{4}$|^\d{3}\d{3}\d{4}$|^\d{2}\d{4}\d{4}$|^\d{2}\d{3}\d{4}$|^\d{4}\d{4}$/;
var numReg = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
var faxReg = /^(?:\+82-\d{1,2}-\d{3,4}-\d{4}|\d{2,3}-\d{3,4}-\d{4})$/;
var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;	//메일
var pwReg = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;
var idReg = /^\d+$/;

	document.getElementById('showImageBtn').addEventListener('click', function(event) {
	    event.preventDefault(); 
	    document.getElementById('imageWrapper').style.display = 'block'; // 이미지 보여주기
	});

	document.getElementById('closeBtn').addEventListener('click', function() {
		event.preventDefault(); 
	    document.getElementById('imageWrapper').style.display = 'none';
	});

	document.getElementById('deleteBtn').addEventListener('click', function() {
	    document.getElementById('imageWrapper').style.display = 'none';
	    document.getElementById('showImageBtn').style.display = 'none';
	    document.getElementById('deleteBtn').style.display = 'none';
	    document.getElementById('dimgnm').style.display = 'block';
	});
	
	document.getElementById('showImageBtn').addEventListener('click', function() {
	    document.getElementById('imageWrapper').style.display = 'block';
	    document.getElementById('closeBtn').style.display = 'block';
	});
	
	document.getElementById('closeBtn').addEventListener('click', function() {
	    document.getElementById('imageWrapper').style.display = 'none';
	    document.getElementById('closeBtn').style.display = 'none';
	});
	
	document.getElementById('deleteBtn').addEventListener('click', function() {
	    document.getElementById('dimgnm').value = '';
	});

	document.getElementById('deleteBtn').addEventListener('click', function() {
	        alert("증명사진을 등록하지 않으면 배송 출고 시 \n해당 택배기사의 정보는 출력되지않습니다.");
	});

		
	function deliveryMain(){
		if(confirm("배송기사 수정을 취소하시겠습니까?")){
			
		location.href="/deliveryList/deliveryMain.do";
		}
		
	}
	
	
	document.querySelectorAll('#dimgnm').forEach(function(fileInput) {
	    fileInput.addEventListener('change', function(event) {
	        var file = event.target.files[0]; // 선택한 파일
	        if (file) {
	            var fileName = file.name;
	            var fileExtension = fileName.split('.').pop().toLowerCase(); // 파일 확장자

	            // 원하는 확장자만 허용 (예: jpg, png, gif)
	            var validExtensions = ['jpg', 'jpeg', 'png', 'gif'];

	            if (validExtensions.indexOf(fileExtension) === -1) {
	                alert('허용되지 않는 파일 형식입니다.\nJPG, PNG, GIF 파일만 업로드할 수 있습니다.');
	                event.target.value = ''; // 파일 선택 초기화
	            }
	        }
	    });
	});


	function deliverySubmit(didx) {

	    if(f1.dname.value == "") {
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
			
	        f1.method = "POST";
	        f1.action = "/deliveryList/deliveryModifyok.do?didx="+didx;
	        f1.submit();
		}
	}
