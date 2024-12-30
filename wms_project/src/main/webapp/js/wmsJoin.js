var isIdChecked = false;  
var idRegex = /^[a-z0-9]+$/;
var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}$/;  
var phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
var nameRegex = /^[가-힣]{2,4}$/;
var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;


document.addEventListener('DOMContentLoaded', function () {
    var mpart = document.getElementById('mpart');
    if (mpart) {
        mpart.addEventListener('change', function() {
            var mpartValue = this.value;
            var mspot = document.getElementById('mspot');
          
            if (mpartValue === '지점') {
                mspot.hidden = false; 
            } else {
                mspot.hidden = true; 
            }
        });
    }
});


function idcheck() {
	
    var id = document.getElementById("mid");
	

    if (f1.mid.value == "") {
        alert("아이디를 입력하세요");
        f1.mid.focus();
			}
			else if(f1.mid.value == ""){
					alert("아이디를 입력해주세요.");
					f1.mid.focus();
					return false;
			}
			else if(f1.mid.value=="admin"||f1.mid.value=="master"||f1.mid.value=="webmaster"||f1.mid.value=="administrator"|| f1.mid.value=="manager"){
					alert("＂"+f1.mid.value+"＂"+ "의 아이디는 사용이 불가능합니다.");
					f1.mid.value = "";
					f1.mid.focus();
					return false;
			}
			else if (f1.mid.value.length < 4) {
		        	alert("아이디는 최소 4자 이상이어야 합니다.");
					f1.mid.focus();
		        	return false;
		    }
			else if (!idRegex.test(f1.mid.value)) {
			       alert("아이디는 특수문자 및 대문자를 사용할수 없습니다.");
				   f1.mid.value = "";
				   f1.mid.focus();
			       return false;
    } else {
        var data = f1.mid.value.replaceAll(" ", "");

        if (data.length == 0) {
            alert("정상적인 아이디를 입력해주세요");
            id.value = null;
        } else {
            var http, result;  
            http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                
				if (http.readyState == 4 && http.status == 200) {
                    result = this.response;
                    
					if (result == "0") {
                        alert("사용가능한 아이디입니다.");
                        isIdChecked = true;  
                        mid.setAttribute("readonly", true);
                    } else {
                        alert("해당 아이디는 사용할 수 없습니다.");
						f1.mid.value = "";
                        isIdChecked = false;  
						mid.removeAttribute("readonly");
                    }
                    console.log(result);
                }
            };
            http.open("post", "./idcheck.do", true);  
            http.setRequestHeader("content-type", "application/x-www-form-urlencoded");
            http.send("mid=" + f1.mid.value);  
        }
    }
}

function part_click(){
	if(f1.mpart.value=="본사"){
		f1.mspot.value="N";
	}
}

function login_check(){
    var hp1 = document.getElementById("hp1");
    var hp2 = document.getElementById("hp2");
    var hp3 = document.getElementById("hp3");
    var repw = document.getElementById("repw");
	var password = f1.mpass.value;

   		if(f1.mpart.value == "지점"){
			
			if(f1.mspot.value == "N"){
			       alert("지점을 선택해 주세요.");
			       return false;
			}
		}
		else if(f1.mpart.value=="본사"){
					f1.mspot.value="N";
		}
		if(f1.mname.value == ""){
				alert("담당자명을 입력해 주세요");
				f1.mpass.value="";
				f1.mpass.focus();
				repw.value="";
				return false;
		}
		else if (!nameRegex.test(f1.mname.value)) {
				 alert("올바르지 않는 이름입니다. 다시 입력해 주세요.");
				 f1.mname.value = "";
				 f1.mname.focus();
				 f1.mpass.value="";
				 repw.value="";
				 return false;
		}		
		else if(f1.mjob.value == ""){
				alert("직책을 선택해 주세요.");
				f1.mpass.value="";
				repw.value="";
				return false;
		}
		else if(!isIdChecked){
				  alert("아이디 중복확인을 해주세요.");
				  f1.mpass.value="";
				  repw.value="";
				  return false;
		}
	    else if(f1.mpass.value == ""){
	        alert("비밀번호를 입력해 주세요");
			f1.mpass.focus();
	        return false;
    	}
	    else if (f1.mpass.value.length < 6) {
	        alert("비밀번호는 최소 6자 이상이어야 합니다.");
			f1.mpass.value="";
			f1.mpass.focus();
			repw.value="";
	        return false;
	    }
	    else if (!passwordRegex.test(password)) {
	        alert("비밀번호는 최소 6자 이상, 영문자와 숫자를 포함해야 합니다.");
			f1.mpass.value="";
			f1.mpass.focus();
			repw.value="";
	        return false;
	    }	
	    else if(f1.mpass.value != f1.repw.value){
	        alert("동일한 비밀번호를 입력해 주세요.");
			f1.mpass.value="";
			f1.mpass.focus();
			repw.value="";
	        return false;
	    }
	    else if(f1.memail.value == ""){
	        alert("이메일을 입력해 주세요.");
			f1.memail.focus();
			f1.mpass.value="";
			repw.value="";
	        return false;
	    }
	  	else if (!emailRegex.test(f1.memail.value)) {
	       alert("이메일 형식이 올바르지 않습니다.");
		   f1.memail.value ="";
		   f1.memail.focus();
		   f1.mpass.value="";
		   repw.value="";
	       return false;
	   	}
	    else if(hp1.value == "" || hp2.value == "" || hp3.value == ""){
	        alert("올바른 전화번호를 입력해 주세요.");
			hp2.value = "";
			hp3.value = "";
			f1.mpass.value="";
			repw.value="";
	        return false;
	    }
		
		if (!/^\d+$/.test(hp2.value) || !/^\d+$/.test(hp3.value)) {
		            alert("전화번호는 숫자만 입력 가능합니다.");
		            hp2.value = "";
		            hp3.value = "";
					f1.mpass.value="";
					repw.value="";
		            return false;
			}
	else{
	    f1.mhp.value = hp1.value + hp2.value +  hp3.value;
		f1.method="post";
		f1.action="./wmsJoinok.do";
	    f1.submit();
	}	
}