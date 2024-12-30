
var frm = document.createElement("form");

function getFormInfo() {
    var a = document.getElementById("searchKeyword").value.trim();
	var urlcheck = window.location.search;
	var urlarr1 = urlcheck.split("&part1=");
	frm.innerHTML = "";
	var pg = "";
	if(urlarr1[0] == ""){
		pg = 1;
	}
	else{
		var urlarr2 = urlarr1[0].split("?pageno=");
		pg = urlarr2[1];
	}
	
    if (a === "") {
        alert("검색어를 입력하세요!!");
        return false;
    } else {
        // 검색어를 비우기
        //document.getElementById("searchKeyword").value = "";
		
		frm.innerHTML = "<input type='hidden' name='pageno' value='"+pg+"'>"; // 이전 필드 제거
        // 새로운 폼 요소 생성
       
        frm.method = "get"; // 폼 메서드 설정
        frm.action = "/config/configMain.do"; // 폼 액션 설정

        // 소속 (part1) 필드 추가
        var part1 = document.createElement("input");
        part1.type = "hidden"; // 숨겨진 입력 필드로 설정
        part1.name = "part1"; // 이름 설정
        part1.value = document.getElementById("part1").value; // 값 설정
        frm.appendChild(part1);

        // 검색형식 (part2) 필드 추가
        var part2 = document.createElement("input");
        part2.type = "hidden"; // 숨겨진 입력 필드로 설정
        part2.name = "part2"; // 이름 설정
        part2.value = document.getElementById("part2").value; // 값 설정
        frm.appendChild(part2);

        // 검색어 필드 추가
        var search = document.createElement("input");
        search.type = "hidden"; // 숨겨진 입력 필드로 설정
        search.name = "search"; // 이름 설정
        search.value = a; // 값 설정
        frm.appendChild(search);

        // 폼을 body에 추가
        document.body.appendChild(frm);

        // 폼 제출
        frm.submit();
    }
}

function searchall(){
	//document.getElementById("searchKeyword").value = "";
		
			frm.innerHTML = ""; // 이전 필드 제거
	
	       frm.method = "get"; // 폼 메서드 설정
	       frm.action = "/config/configMain.do"; // 폼 액션 설정
		 
	       // 폼을 body에 추가
	       document.body.appendChild(frm);

	       // 폼 제출
	       frm.submit();
	  	
}

function change4(mid){
			if (mid == 1){
				alert("관리자 상태는 수정할 수 없습니다.")
				return;
				
			}
			
			frm.innerHTML = ""; // 이전 필드 제거
	
		   frm.method = "POST"; // 폼 메서드 설정
	       frm.action = "/config/update.do"; // 폼 액션 설정

	       // 소속 (part3) 필드 추가
	       var part3 = document.getElementById("part3_"+mid);
		   var part3go = document.createElement("input");
		   part3go.type = "hidden"; // 숨겨진 입력 필드로 설정
		   part3go.name = "part3"; // 이름 설정
		   part3go.value = part3.value;		   	      // 숨겨진 입력 필드로 설정
		   frm.appendChild(part3go);
		   
		   var midx = document.createElement("input");
		       midx.type = "hidden"; // 숨겨진 입력 필드로 설정
		       midx.name = "midx"; // 이름 설정
		       midx.value = mid // midx 값 설정
		       frm.appendChild(midx);
		
		   document.body.appendChild(frm);
		   frm.submit();
}

