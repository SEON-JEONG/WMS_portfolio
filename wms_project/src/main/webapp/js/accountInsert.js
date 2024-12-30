var isIdChecked = false;  
var phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;// 휴대폰 번호만
var nameRegex = /^[가-힣]{2,4}$/;
var ahp_regex = /^\d{3}-\d{4}-\d{4}$|^\d{3}-\d{3}-\d{4}$|^\d{2}-\d{4}-\d{4}$|^\d{2}-\d{3}-\d{4}$|^\d{4}-\d{4}$/;
var anum_regex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
var afax_regex = /^(?:\+82-\d{1,2}-\d{3,4}-\d{4}|\d{2,3}-\d{3,4}-\d{4})$/;

	function company_check(){
		var acompany = document.getElementById("acompany");
		
		if(f1.acompany.value == ""){
			alert("거래처명을 입력해주세요.");
			f1.acompany.focus();
			return false;
		}
		else if(f1.acompany.value.length < 2){
			alert("옳바른 거래처명을 입력해주세요.");
			return false;
		}
		else{
			var data = f1.acompany.value.replaceAll(" ", "");
			
			if(data.length == 0){
				alert("정상적인 거래처명을 입력해주세요.");
				 id.value = null;
			}else{
				let http = new XMLHttpRequest();
				let result, count;
				http.onreadystatechange = function () {
					if (http.readyState == 4 && http.status == 200) {
	                   const responseArray = this.response.split(',');
	                   if (responseArray.length === 2) {
	                       result = responseArray[0].trim();  // 첫 번째 값
	                       count = responseArray[1].trim();   // 두 번째 값
						   count = (parseInt(count) + 1).toString().padStart(3, '0');
	                   } else {
	                       return;
	                   }
						if (result == "0") {
	                        alert("등록 가능한 거래처명 입니다.");
							f1.acode.value ="DE"+count;
	                        isIdChecked = true;  
							acompany.style.cursor = "pointer";   
	                        acompany.setAttribute("readonly", true);
	                    } else {
	                        alert("[ "+data+" ]"+" 의 거래처명은 이미 등록되어 있습니다.");
							f1.acompany.value = "";
	                        isIdChecked = false; 
							acompany.removeAttribute("readonly");
	                    }
	                }
	            };
	
	            http.open("post", "./companyck.do", true);  
	            http.setRequestHeader("content-type", "application/x-www-form-urlencoded");
	            http.send("acompany=" + data); 
	        }
	    }
	}
	
	function re_company(z) {
		var acompany = document.getElementById("acompany");
		var acode = document.getElementById("acode");
	   if(z.readOnly == true){
		if(confirm('거래처명을 수정 하시겠습니까?')){
			z.readOnly = false;
			acompany.value="";
			acode.value="";
			acompany.focus();
			acompany.style.cursor = "text";  
			isIdChecked = false;
			}
	   	}
	}

	function account_check(){
		
		if(f1.acompany.value == ""){
			alert("거래처명을 입력해주세요.");
			f1.acompany.focus();
			return false;
		}
		else if(!isIdChecked){
					alert("거래처명 중복체크을 해주세요.");
					return false;
				}
		else if(f1.aname.value == ""){
			alert("대표자명을 입력해주세요");
			f1.anme.value="";
			f1.aname.focus();
			return false;
		}
		else if(f1.aindustry.value == ""){
			alert("업태를 입력해주세요.");
			f1.aindustry.value="";
			f1.aindustry.focus();
			return false;
		}
		else if(f1.aname.value == ""){
			alert("대표자명을 입력해주세요.");
			f1.aname.value="";
			f1.aname.focus();
			return false;
		}
		else if (!nameRegex.test(f1.aname.value)) {
			 alert("대표자명은 한글로 2~4글자만 입력 가능합니다.");
			 //f1.aname.value = "";
			 f1.aname.focus();
			 return false;
		}
		else if(f1.ahp.value == ""){
			alert("대표번호를 입력해주세요.");
			//f1.ahp.focus();
			return false;
		}
		else if(!ahp_regex.test(f1.ahp.value)){
			alert("옳바르지 못한 전화번호 형태입니다.");
			f1.ahp.value="";
			f1.ahp.focus();
			return false;
		}

		else if(f1.anum.value==""){
			alert("사업자 번호를 입력해주세요.");
			f1.anum.focus();
			return false;
		}

		else if(!anum_regex.test(f1.anum.value)){
			alert("올바르지 않는 사업자 번호 입니다.");
			//f1.anum.value="";
			f1.anum.focus();
			return false;
		}

		else if(f1.atype.value==""){
			alert("종목을 입력해주세요");
			f1.atype.focus();
			return false;
		}
		else if(f1.afax.value == ""){
			alert("팩스번호를 입력해주세요.")
			f1.afax.value="";
			f1.afax.focus();
			return false;
				}
		else if(!afax_regex.test(f1.afax.value)){
			alert("올바르지 않는 팩스번호 입니다.")
			f1.afax.value="";
			f1.afax.focus();
			return false;
		}
		else if(f1.apost.value==""){
			alert("주소찾기를 통하여 주소를 입력해 주세요.");
			f1.apost.value="";
			f1.aroad.value="";
			return false;
		}
		else if(f1.aroad.value==""){
			alert("주소찾기를 통하여 주소를 입력해 주세요.");
			f1.apost.value="";
			f1.aroad.value="";
			return false;
		}
		else if(f1.addr.value==""){
			alert("상세주소를 입력해주세요.");
			f1.addr.value="";
		}
		else{
		f1.method="post";
		f1.action="/account/accountInsertok.do";
		f1.submit();
		}
	}
	
	
	var element_layer = document.getElementById('layer');
	function closeDaumPostcode() {
	    // iframe을 넣은 element를 안보이게 한다.
	    element_layer.style.display = 'none';
	}

	function sample2_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = ''; 
	            var extraAddr = ''; 

	            if (data.userSelectedType === 'R') { 
	                addr = data.roadAddress;
	            } else { 
	                addr = data.jibunAddress;
	            }
	            document.getElementById("apost").value = data.zonecode;
	            document.getElementById("aroad").value = addr;
	            document.getElementById("addr").focus();
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%',
	        maxSuggestItems : 5
	    }).embed(element_layer);
	    element_layer.style.display = 'block';
	    initLayerPosition();
	}

	function initLayerPosition(){
	    var width = 300; 
	    var height = 400;
	    var borderWidth = 1; 
	    element_layer.style.width = width + 'px';
	    element_layer.style.height = height + 'px';
	    element_layer.style.border = borderWidth + 'px solid';
	    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	}