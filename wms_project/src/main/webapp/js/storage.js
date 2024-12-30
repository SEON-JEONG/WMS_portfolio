
var frm = document.getElementById('frm');

function insert12(){
	
	var scode = frm.scode.value;
	var sspot = frm.sspot.value;
	var sname = frm.sname.value;
	var spost = frm.spost.value;
	var saddress1 = frm.saddress1.value;
	var saddress2 = frm.saddress2.value;
	var smname = frm.smname.value;
	var smhp = frm.smhp.value;
	var mid = frm.mid.value;
	var sdeleted = frm.sdeleted.value;
	// 선택된 라디오 버튼의 값 가져오기
	var susel = document.querySelector('input[name="suse"]:checked').value; // 선택된 라디오 버튼의 값
	    var suse = parseInt(susel); // int로 변환하여 0 또는 1로 설정!

	    // suse를 폼에 설정
	    document.getElementById('suse').value = suse;

	
	if(sname === ""){
		alert("등록할 창고명을 입력해주세요.");
		frm.sname.focus();
		return;
	} else 
	if(saddress1 === ""){
		alert("창고 주소를 입력해주세요.");
		return;
	} else if(spost === ""){
		alert("상세주소를 입력해주세요.");
		return;
	} else if(saddress2 === ""){
		alert("상세주소를 입력해주세요.");
		frm.saddress2.focus();
		return;
	} else if(smname === ""){
		alert("담당자 이름을 입력해주세요.");
		frm.smname.focus();
		return;
	} else if(smhp === ""){
		alert("담당자 연락처를 입력해주세요.");
		frm.smhp.focus();
		return;
	} else if(!/^\d{10,11}$/.test(smhp)){
			alert("올바른 전화번호를 입력해주세요.");
			frm.smhp.focus();
			return;
		}
		 else {
				
		frm.action="/storageInsert.do";  // 폼 전송 URL 설정
		frm.submit(); // 폼 제출
	}
}

async function checkCode(scode){
	
	const a = await fetch(`/api/checkCode/${scode}`); // 서버에 요청
	const b = await a.json(); // JSON으로 변환하여 중복 여부를 얻음
	return b; // true 또는 false 반환
	
	
}

async function RandomCode() {
		var scode;
		var a = true;
				
		while (a) {		
		        scode = Math.floor(10000 + Math.random() * 90000); // 10000부터 99999 범위의 숫자 생성
		        a = await checkCode(scode); // 중복 체크
				
		    }
			
       document.getElementById('scode').value = scode;
	   
   }//창고 코드 만들기(랜덤함수이며 5글자 숫자)
   
   
   onload = function() {
        //scode 입력 필드가 존재하는지 확인
       if (location.pathname === '/storage/storageInsert.do') {
           RandomCode(); // scode 필드가 있을 때만 랜덤 코드 생성
       }
   };

   //수정시
   function validate1() {
       var sname = frm.sname.value.trim();
       var spost = frm.spost.value.trim();
       var saddress1 = frm.saddress1.value.trim();
       var saddress2 = frm.saddress2.value.trim();
       var smname = frm.smname.value.trim();
       var smhp = frm.smhp.value.trim();

       if (sname === "") {
           alert("창고명을 입력해주세요.");
           frm.sname.focus();
           return false;
       } 
       else if (saddress1 === "") {
           alert("창고 주소를 입력해주세요.");
           frm.saddress1.focus();
           return false;
       }
       else if (spost === "") {
           alert("우편번호를 입력해주세요.");
           frm.spost.focus();
           return false;
       } 
       else if (saddress2 === "") {
           alert("상세 주소를 입력해주세요.");
           frm.saddress2.focus();
           return false;
       }
      else if (smname === "") {
           alert("담당자명을 입력해주세요.");
           frm.smname.focus();
           return false;
       }
      else if (smhp === "") {
           alert("담당자 연락처를 입력해주세요.");
           frm.smhp.focus();
           return false;
       }
       else if (!/^\d{10,11}$/.test(smhp)) {
           alert("올바른 연락처를 입력해주세요. 숫자만 입력 가능합니다.");
           frm.smhp.focus();
           return false;
       }
	else{
       // 선택된 라디오 버튼의 값 (true/false)을 설정
       //var suse = (susel.value === 'true');
       //document.getElementById('suse').value = suse;
		
	  // console.log(suse);
       // 유효성 검사 통과 시 폼 제출 허용
       return true;
	   }
   }

function back1(){
	if(confirm("입력된 내용은 모두 삭제 됩니다. 취소 하시겠습니까?")){
		frm.reset();
		location.href="/storage/storageMain.do";
	}
}

// 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('spost').value = data.zonecode;
                document.getElementById("saddress1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("saddress2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
	
	
/////////////////////////////////////////////////////////////////
//main

function searchall1(){
						
			var mspot = frm.mspot.value;
			console.log("mspot value:", mspot);
	       //frm.method = "get"; // 폼 메서드 설정
	       //frm.action = "/storage/storageMain.do"; // 폼 액션 설정
	       // 폼을 body에 추가
	       // 폼 제출
	       //frm.submit();	  	
		   var url = "/storage/storageMain.do?mspot=" + encodeURIComponent(mspot);
		   window.location.href = url; // URL로 이동
}

function search1(){
	var search = document.getElementById("searchKeyword").value.trim();
	if (search === "") {
	        alert("검색어를 입력하세요");
	        return false;
	}else {
		 
		var url = "/storage/storageMain.do?search=" + encodeURIComponent(search);
		window.location.href = url;
		return false;
		     // 폼 제출
		  }
		
	
}

function RadioClick(radio){
	if(frm.suse[1].checked==true){
		alert("미사용중으로 변경시 재고 입고, 출고가 적용되지 않습니다.")
	}
	console.log("선택된 값: ", radio.value);
	/*
	if(radio.value === "false"){
	alert("미사용중으로 변경시 재고 입고, 출고가 적용되지 않습니다.");
	}
	    console.log("선택된 값: ", radio.value);
	*/

}

function deleteStorage(scode) {
	if (confirm("입력된 내용은 모두 삭제 됩니다. 취소 하시겠습니까?")) {
	       $.ajax({
	           url: '/storageDelete.do',
	           type: 'POST',
	           data: { scode: scode }, // 다른 데이터도 포함할 수 있음
	           success: function() {
	               location.reload();
	           },
	           error: function() {
	               alert("삭제에 실패했습니다.");
	           }
	       });
	   }
}

//////////////////////////////////////////////////////////////////////////////
//Instore

document.getElementById("storage").addEventListener("change", function () {
    const storage = this.options[this.selectedIndex];
    const sname = storage.value; // 창고명
    const scode = storage.getAttribute("data-scode"); // 창고코드
	

	// 클릭한 행의 인덱스 가져오기
	const selectedRow = document.querySelector('.row1.selected');
	
	
	if (selectedRow) {
	const rowIndex = selectedRow.getAttribute('data-index'); // 선택된 행의 인덱스
    // 창고명 및 창고코드 필드에 값 설정
	// 선택된 행에서 sname 및 scode 필드 찾기
	       const snameInput = selectedRow.querySelector('input[name="sname"]');
	       const scodeInput = selectedRow.querySelector('input[name="scode"]');
		   
		   // 창고명 및 창고코드 필드에 값 설정
		           snameInput.value = sname;
		           scodeInput.value = scode;				   	        
	}else {
            // 선택된 행이 없을 경우 첫 번째 행에 값 설정
			const firstRow = document.querySelector('.row1');
			const snameInput = firstRow.querySelector('input[name="sname"]');
			const scodeInput = firstRow.querySelector('input[name="scode"]');
			snameInput.value = sname; // 첫 번째 행에 창고명 설정
			       scodeInput.value = scode; // 첫 번째 행에 창고코드 설정
			       // 읽기 전용 설정
					      
        }
		
		
});

// 파렛트 선택 시 이벤트 처리
document.getElementById("palette").addEventListener("change", function () {
    const pname = this.value; // 파렛트 이름
	const selectedRow = document.querySelector('.row1.selected');

	if (selectedRow) {
		// 선택된 행에서 pname 필드 찾기
		        const pnameInput = selectedRow.querySelector('input[name="pname"]');
				// 파렛트 이름 필드에 값 설정
				pnameInput.value = pname;				       
	}else {
        // 선택된 행이 없을 경우 첫 번째 행에 값 설정
		const firstRow = document.querySelector('.row1'); // 첫 번째 행 선택
		const pnameInput = firstRow.querySelector('input[name="pname"]');

		 pnameInput.value = pname; // 첫 번째 행에 파렛트 이름 설정		
		 
        }
});

// 각 행 클릭 이벤트
    document.querySelectorAll('.row1').forEach(row => {
        row.addEventListener('click', function () {
            // 이전에 선택된 행의 스타일 초기화
            document.querySelectorAll('.row1').forEach(item => {
                item.classList.remove('selected'); // 선택 해제
            });
            // 현재 클릭한 행 선택
            this.classList.add('selected'); // 선택 스타일 추가
        });
    });

// 거래처 이름 입력 이벤트 처리
document.querySelectorAll('input[name^="acompany"]').forEach(input => {
    input.addEventListener("input", function () {
		const selectedRow = this.closest('.row1'); // 현재 입력 필드의 부모 행 찾기
		const acompany = this.value.trim(); // 입력된 거래처 이름
		const acodeInput = selectedRow.querySelector('input[name="acode"]'); // 해당 거래처 코드 입력 필드 필드
    if (acompany !== "") {
        // AJAX 요청
        fetch(`/account/getAccountCode?acompany=${encodeURIComponent(acompany)}`)
            .then(response => {
               if (!response.ok) {
               throw new Error("네트워크 응답 실패");
                }
                return response.text();
            })
            .then(acode => {
                acodeInput.value = acode; // 거래처 코드 입력
			
            })
            .catch(error => {
                console.error("오류 발생:", error);
                acodeInput.value = ""; // 오류 시 빈 값 처리
            });
    } else {
        acodeInput.value = ""; // 입력값이 비어 있을 경우 초기화
    }
	});
});

//입고버튼 클릭시
function insertstore() {
// 각 입력 필드를 배열로 가져오기
var acompany = document.getElementsByName("acompany");
var acode = document.getElementsByName("acode");
var pdcode = document.getElementsByName("pdcode");
var pdname = document.getElementsByName("pdname");
var pdamount = document.getElementsByName("pdamount");
var sname = document.getElementsByName("sname");
var scode = document.getElementsByName("scode");
var pname = document.getElementsByName("pname");
var pddate = document.getElementsByName("pddate");
var mspot = document.getElementById("mspot").value;
let rowFull = false; // 최소한 하나의 유효한 행이 있는지 체크
let rowEmpty = false; // 유효하지 않은 행이 있는지 체크
const insert= [];
console.log(mspot);
	
		for (let i = 0; i < acompany.length; i++) {
			
			var acompanyVal = acompany[i].value;
			var acodeVal = acode[i].value;
			var pdcodeVal = pdcode[i].value;
			var pdnameVal = pdname[i].value;
			var pdamountVal = pdamount[i].value;
			var snameVal = sname[i].value;
			var scodeVal = scode[i].value;
			var pnameVal = pname[i].value;
			var pddateVal = pddate[i].value;
			
			if(acompanyVal){
			insert.push({"acompany":acompanyVal,
				"acode":acodeVal,
				"pdcode":pdcodeVal,
				"pdname":pdnameVal,
				"pdamount":pdamountVal,
				"sname":snameVal,
				"scode":scodeVal,
				"pname":pnameVal,
				"pddate":pddateVal,
				"mspot":mspot});	
								
			}	        						
	        // 모든 필드가 채워진 경우
	        if (acompanyVal && acodeVal && pdcodeVal && pdnameVal && pdamountVal && snameVal && scodeVal && pnameVal && pddateVal) {
	            rowFull = true; // 유효한 행이 있음
	        }
	        // 하나라도 비어 있는 경우
	        else if (acompanyVal || acodeVal || pdcodeVal || pdnameVal || pdamountVal || snameVal || scodeVal || pnameVal || pddateVal) {
	            rowEmpty = true; // 유효하지 않은 행이 있음
	        }
	    }

	    // 유효하지 않은 행이 있을 경우 경고 메시지 표시
	    if (rowEmpty) {
	        alert("입고 양식에 맞춰서 작성해주세요.");
	        return false;
	    }

	    // 최소 하나의 유효한 행이 있을 경우 폼 제출
	    if (!rowFull) {
			alert("최소 한 행의 데이터를 입력해야 합니다.");
						return false; // 함수 종료
		
	    }
		
			var html;
			var data;
			   html = new XMLHttpRequest();
			   html.onreadystatechange = function(){
			      if(html.readyState==4 && html.status==200){
			      if(this.response=="ok"){
						alert("정상적으로 이동이 완료 되었습니다.");
						window.location.reload();
				  }
			            
			      }
			   }
			   console.log(JSON.stringify(insert));
			   html.open("POST","/storage/insertStore.do",true);
			   html.send(JSON.stringify(insert));
			  
		

}



// 현재 날짜를 'YYYY-MM-DD' 형식으로 반환하는 함수
function getCurrentDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// 각 acode 입력 필드에 대해 이벤트 리스너 등록
document.querySelectorAll('input[name^="acompany"]').forEach(input => {
    input.addEventListener('input', function() {
		const selectedRow = this.closest('.row1'); // 현재 입력 필드의 부모 행 찾기
		const pddateField = selectedRow.querySelector('input[name="pddate"]'); // 해당 행의 pddate 입력 필드
        if (this.value) { // acode에 값이 있는 경우
            pddateField.value = getCurrentDate(); // 현재 날짜 설정
        } else { // acode에 값이 없는 경우
            pddateField.value = ''; // pddate 비우기
        }
    });
});		


//////////////////////////////////////////////////////////////////
//창고에서 창고로 물건 수량 옮기기

function collectCheckedData() {
    const checkboxes = document.getElementsByName('checkbox');
	const quantities = document.getElementsByName('quantity');
	var tostoercode = document.getElementById("storageto").value; 
	var tostoername = document.getElementById("hiddenStoragename").value;
	//var fromstoercode = document.getElementById("selectstorage").value;
    const checked = [];
	let empty = false;
	let nocheck = false;
	
	
	console.log(tostoercode);
	console.log(tostoername);
	//console.log(fromstoercode);
  	
	 
	 for (let i = 0; i < checkboxes.length; i++) {
	         if (checkboxes[i].checked) {
	             const quantity = quantities[i].value; // 수량 값 가져오기
				 const pdidx = checkboxes[i].value;
				 
				 // 체크박스 확인
				      if (!checkboxes[i].checked && quantity) {
				          alert('먼저 이동할 상품을 체크해주세요.'); // 체크박스가 체크되어 있지 않으면 경고
				          quantities[i].value = ''; // 수량 입력란 비우기
				          nocheck = true; // 체크되지 않은 상태 기록
				      } else if (checkboxes[i].checked) {
	             if (quantity) {
	                 checked.push({ "pdidx": pdidx, "quantity": quantity, "instorename" : tostoername, "instorecode": tostoercode });
					 }
	             } else {
	                 empty = true; // 수량이 비어있는 경우
	             }
	         }
	     }

	if (tostoercode === ""){
		alert('물건을 이동할 창고를 선택해주세요.');
		return false; // 체크된 제품이 없으면 제출하지 않음		
	}
            
	if(empty){		
		alert('수량을 입력해주세요.'); // 수량이 비어있으면 경고
	  return false; // 수량이 없는 경우 제출하지 않음
	}
	
	if(nocheck){
		alert('체크박스에 체크가 되어있는지 확인해주세요.');
		return false;
	}
 

    if (checked.length === 0) {
        alert('하나의 제품을 선택해주세요.');
        return false; // 체크된 제품이 없으면 제출하지 않음
    }
	
	var html;
	var data;
	   html = new XMLHttpRequest();
	   html.onreadystatechange = function(){
	      if(html.readyState==4 && html.status==200){
	      if(this.response=="ok"){
				alert("정상적으로 이동이 완료 되었습니다.");
				window.location.href = "/storage/storageList.do";
		  }
	            
	      }
	   }
	   //console.log(JSON.stringify(checked));
	   html.open("POST","/storage/moveProduct.do",true);
	   html.send(JSON.stringify(checked));
	   //html.send(JSON.stringify(checked));
	

  // return true;  // 데이터 수집이 완료되면 폼 제출 허용
 }

function handleFile(e) {
	
   const file = e.target.files[0];
   const reader = new FileReader();

   reader.onload = (evt) => {
     const bstr = evt.target.result;
     const wb = XLSX.read(bstr, { type: 'binary' });
     const wsname = wb.SheetNames[0];
     const ws = wb.Sheets[wsname];
     const data = XLSX.utils.sheet_to_json(ws, { header: 1 }); // header: 1은 첫 번째 행을 헤더로 사용
	 var mspot = document.getElementById("mspot").value;
	 const headers = data[0];
	         const insert = [];
			 const storageOptions = Array.from(document.getElementById('storage').options).map(option => option.value).filter(value => value !== "");
			 const paletteOptions = Array.from(document.getElementById('palette').options).map(option => option.value).filter(value => value !== "");

	         for (let i = 1; i < data.length; i++) {
	             const row = data[i];
				 if (row.length !== headers.length) {			              
				                     alert(`엑셀 파일 형식이 올바르지 않습니다. 확인해주세요.`);
				                     return;
				                 }
				const sname = row[5];
				const pname = row[7];
				
				if (!storageOptions.includes(sname)) {
				                    alert(`${i + 2}번째 행의 창고 "${sname}"이(가) 가용 가능하지 않습니다.`);
				                    document.getElementById("excelFile").value = "";
				                    return;
				                }

				                if (!paletteOptions.includes(pname)) {
				                    alert(`${i + 2}번째 행의 파렛트 "${pname}"이(가) 가용 가능하지 않습니다.`);
				                    document.getElementById("excelFile").value = "";
				                    return;
				                }
				                 if(row[4] && isNaN(row[4])){
				                    alert("수량은 숫자로 입력해야 합니다.")
				                    return;
				                }
	             if (row.length === headers.length) {
	                 const rowData = {
	                     "acompany": row[0],
	                     "acode": row[1],
	                     "pdname": row[2],
	                     "pdcode": row[3],
	                     "pdamount": row[4],
	                     "sname": sname,
	                     "scode": row[6],
	                     "pname": pname,
	                     "pddate": row[8],
						 "mspot" : mspot
	                 };
	                 insert.push(rowData);
	             }
	         }

	         console.log(insert); // 변환된 데이터 출력
			 document.getElementById("Button").onclick = function() {
			             insertstoreExcel(insert); // 배열을 인자로 전달
			document.getElementById("excelFile").value = "";		
			         };
	     };

	// "거래처명" => pname
   reader.readAsBinaryString(file);

 }
 
 //엑셀파일 등록 후 입고 버튼을 눌렀을 때 작동되는 함수
 function insertstoreExcel(insert){
	

	
				var html;
				var data;
				   html = new XMLHttpRequest();
				   html.onreadystatechange = function(){
				      if(html.readyState==4 && html.status==200){
				      if(this.response=="ok"){
							alert("정상적으로 이동이 완료 되었습니다.");
							window.location.href = "/storage/storageList.do";
					  }
				            
				      }
				   }
				   
				   html.open("POST","/storage/insertStore.do",true);
				   html.send(JSON.stringify(insert));
	
 }

 /////////////////////////////////////////////////////////////////////////////////
 //팔레트 재고 이동 부분
 
 function paletteTo1() {
	const selectElement = document.getElementById('paletteTo');
     // 선택된 값 가져오기
     const selectedValue = selectElement.value;
     const [sname, pname] = selectedValue.split(',');
	 

     // URL 설정
     const url = `/storage/storagePalette.do?sname=${encodeURIComponent(sname)}&pname=${encodeURIComponent(pname)}`;

     // GET 요청
     window.location.href = url; // 페이지 이동
 }

 function paletteMove() {
     const checkboxes = document.getElementsByName('checkbox');
 	 const quantities = document.getElementsByName('quantity');
	 const selectElement = document.getElementById('paletteFrom');
	     // 선택된 값 가져오기
	 const selectedValue = selectElement.value;
	 const [pname2, pcode2] = selectedValue.split(',');
	  
     const checked = [];
 	let empty = false;
 	let nocheck = false;
   	
 	 
 	 for (let i = 0; i < checkboxes.length; i++) {
 	         if (checkboxes[i].checked) {
 	             const quantity = quantities[i].value; // 수량 값 가져오기
 				 const pdidx = checkboxes[i].value;
 				 
 				 // 체크박스 확인
 				      if (!checkboxes[i].checked && quantity) {
 				          alert('먼저 이동할 상품을 체크해주세요.'); // 체크박스가 체크되어 있지 않으면 경고
 				          quantities[i].value = ''; // 수량 입력란 비우기
 				          nocheck = true; // 체크되지 않은 상태 기록
 				      } else if (checkboxes[i].checked) {
 	             if (quantity) {
 	                 checked.push({ "pdidx": pdidx, "quantity": quantity, "instorepalette": pname2, "instorepcode": pcode2 });
 					 }
 	             } else {
 	                 empty = true; // 수량이 비어있는 경우
 	             }
 	         }
 	     }

 	if (selectedValue === ""){
 		alert('물건을 이동할 팔레트를 선택해주세요.');
 		return false; // 체크된 제품이 없으면 제출하지 않음		
 	}
             
 	if(empty){		
 		alert('수량을 입력해주세요.'); // 수량이 비어있으면 경고
 	  return false; // 수량이 없는 경우 제출하지 않음
 	}
 	
 	if(nocheck){
 		alert('체크박스에 체크가 되어있는지 확인해주세요.');
 		return false;
 	}
  

     if (checked.length === 0) {
         alert('하나의 제품을 선택해주세요.');
         return false; // 체크된 제품이 없으면 제출하지 않음
     }
 	
 	var html;
 	var data;
 	   html = new XMLHttpRequest();
 	   html.onreadystatechange = function(){
 	      if(html.readyState==4 && html.status==200){
 	      if(this.response=="ok"){
 				alert("정상적으로 이동이 완료 되었습니다.");
 				window.location.href = "/storage/storagePalette.do";
 		  }
 	            
 	      }
 	   }
 	   //console.log(JSON.stringify(checked));
 	   html.open("POST","/storage/movePalette.do",true);
 	   html.send(JSON.stringify(checked));
 	   //html.send(JSON.stringify(checked));
 	

   // return true;  // 데이터 수집이 완료되면 폼 제출 허용
  }


