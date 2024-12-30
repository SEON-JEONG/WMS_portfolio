//paletteMain.jsp - 파렛트 리스트 페이지 관련 javascript

//검색 버튼 클릭 시
function searchPalette(){
    var search = frm.search;
    if(search.value == ""){
        alert("검색할 파렛트명을 입력해주세요");
        search.focus();
    }
    else {
    		//검색어를 입력한 경우
    		search = search.value.trim();
    		search = search.replaceAll(" ", "");

    		if(search.length == 0){
    			alert("검색어를 다시 한 번 확인해주세요.");
    			search.focus();
    		}
    		else {
    			frm.method="get";
    			frm.action="../palette/paletteMain.do";
    			frm.submit();
    		}
    	}
}

//전체 버튼 클릭 시
function searchAllPalette(){
    location.href="../palette/paletteMain.do";
}

//수정 버튼 클릭 시
function modify_palette(pidx){
    console.log(pidx);
    location.href="/palette/paletteModify.do?pidx=" + pidx;
}

//삭제 버튼 클릭 시
function delete_palette(pidx){
    if(confirm("해당 게시물을 삭제하시겠습니까?\n삭제된 데이터는 복구하지 못합니다.")){
        const form = document.createElement("form");
        form.method="post";
        form.action="../palette/palette_delete.do";

        const input = document.createElement("input");
        input.type="hidden";
        input.name="pidx";
        input.value=pidx;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
}



//paletteInsert.jsp - 파렛트 등록 페이지 관련 javascript

//파렛트명 중복체크 검사
var pnameCheck = false; //중복체크 버튼 클릭 유무

function pname_validate(){
    var pname = frm.pname;
    if(pname.value == ""){
        alert("등록할 파렛트 이름을 먼저 입력해주세요.");
    }else{
        //등록할 파렛트 이름 입력 시
        pname = pname.value.replaceAll(" ", "");
        if(pname.length == 0){
            alert("입력하신 파렛트 이름을 다시 확인해주세요.");
        }else {
            //http : 전송하는 값, result : Back-end에서 받은 응답을 저장하는 값
            var http, result;
            http = new XMLHttpRequest();
            http.onreadystatechange = function(){
                if(http.readyState == 4 && http.status == 200){
                    result = this.response;
                    if(result == "0"){
                        pnameCheck = true;
                        alert("등록 가능한 파렛트입니다.");
                        frm.pname.readOnly = true;
                    } else {
                        alert("해당 파렛트는 이미 등록되어 있습니다.\n새로운 파렛트명을 입력해주세요");
                    }
                }
            }
        }
        http.open("post", "../palette/pnameCheckOk.do", true);
        http.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        http.send("pname=" + pname);
    }
}

//팔레트 등록 유효성 검사
function complete_insert(){
    var pname = frm.pname;
    var pcode = frm.pcode;
    var psize = frm.psize;
    var pcolor = frm.pcolor;
    var pusing = frm.pusing;

    if(pname.value == ""){
        alert("등록할 파렛트 명을 입력하셔야 합니다.");
        pname.focus();
    } else if(pcode.value == ""){
        alert("등록할 파렛트의 코드를 입력하셔야 합니다.");
        pcode.focus();
    } else if(psize.value == ""){
        alert("등록할 파렛트의 사이즈를 입력하셔야 합니다.");
        psize.focus();
    } else if(pcolor.value == ""){
        alert("등록할 파렛트의 색상을 지정해주셔야 합니다.");
        pcolor.focus();
    } else if(pusing.value == ""){
        alert("사용 유/무를 선택하셔야 합니다.");
        pusing.focus();
    } else {
        if(!pnameCheck){
            alert("파렛트명 중복 확인을 해주세요.");
        }
        else{
            const pnamePattern = /^[A-Za-z]-\d+$/;  //파렛트명 : 알파벳-숫자 형식
            const pcodePattern = /^P\d{4}$/;        //파렛트코드 : P + 숫자 4개 형식
            if(!pnamePattern.test(pname.value)){
                alert("파렛트명은 '알파벳-숫자' 형식으로 입력하셔야 합니다.\n예) T-12");
                pname.readOnly = false;
                pname.focus();
            }else if(!pcodePattern.test(pcode.value)){
                alert("파렛트 코드는 'P'와 숫자 4개를 입력하셔야 합니다.\n예) P0001");
                pcode.readOnly = false;
                pcode.focus();
            }else {
                frm.method="post";
                frm.action="/palette/palette_insertok.do";
                frm.submit();
            }
        }
    }
}

//신규 팔레트 등록 취소
function cancel_insert(){
    if(confirm("해당 입력하신 데이터는 모두 삭제됩니다. 취소하시겠습니까?")){
        frm.reset();
        location.href="../palette/paletteMain.do";
    }
}

///paletteModify.jsp - 파렛트 수정 페이지 관련 javascript

//사용중 -> 미사용중으로 체크 변경 시
document.addEventListener('DOMContentLoaded', function () {
    const radioY = document.querySelector('input[name="pusing"][value="Y"]');
    const radioN = document.querySelector('input[name="pusing"][value="N"]');
    if (radioN) { // radioN이 존재할 경우에만 이벤트 리스너 추가
        radioN.addEventListener('change', function () {
            if (radioN.checked) {
                alert("해당 파렛트 미사용 시 재고 관련 사항의 제약을 받습니다.");
            }
        });
    }
});


//내용 수정한 팔레트 수정완료 버튼
function complete_modify(){
    var psize = frm.psize;
    var pcolor = frm.pcolor;
    var pusing = frm.pusing;
    console.log(pusing);
    if(psize.value == ""){
        alert("수정하실 파렛트의 사이즈를 입력해주세요.");
        psize.focus();
    } else if(pcolor.value == ""){
        alert("수정하실 파렛트의 색상을 선택해주세요.");
        pcolor.focus();
    } else {
        console.log(frm.pidx.value);
        frm.method="post";
        frm.action="/palette/palette_modifyok.do";
        frm.submit();
    }

}

//팔레트 수정 취소
function cancel_modify(){
    if(confirm("해당 입력하신 데이터는 모두 삭제됩니다. 취소하시겠습니까?")){
            frm.reset();
            location.href="../palette/paletteMain.do";
        }
}

//페이징 - 해당 페이지 이동
function go_page(i, search){
    let url = "paletteMain.do?pageno=" + i;
    if(search){
        url += "&search=" + encodeURIComponent(search);
    }
    location.href = url;
}




